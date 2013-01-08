package k.feedback;

import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.jdbc.core.JdbcTemplate;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSON;

public class Service {
	
	final static int PAGE_QTY = 15;//每页展示的记录数
	
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	//初始化数据库表结构
	public void initDB(){
		//drop table
		this.jdbcTemplate.execute("drop table IF EXISTS feedback");
		this.jdbcTemplate.execute("drop table IF EXISTS app");
		this.jdbcTemplate.execute("drop table IF EXISTS emp");
		System.out.println("table drop ok");
		
		StringBuilder emp = new StringBuilder();
		emp.append(" CREATE TABLE emp(                              ");
		emp.append("     emp_id           INT       AUTO_INCREMENT, ");
		emp.append("     emp_email        VARCHAR(128),             ");
		emp.append("     emp_login_pwd    VARCHAR(40),             ");
		emp.append("     cdate            TIMESTAMP,                ");
		emp.append("     PRIMARY KEY (emp_id)                       ");
		emp.append(" )ENGINE=MYISAM                                 ");

		StringBuilder app = new StringBuilder();
		app.append(" CREATE TABLE app(                                ");
		app.append("     app_id       INT             AUTO_INCREMENT, ");
		app.append("     emp_id       INT,                            ");
		app.append("     app_name     VARCHAR(255),                   ");
		app.append("     app_desc     VARCHAR(255),                   ");
		app.append("     app_token    VARCHAR(40),                   ");
		app.append("     app_feedback_qty    INT,                   ");
		app.append("     cdate        TIMESTAMP,                      ");
		app.append("     PRIMARY KEY (app_id)                         ");
		app.append(" )ENGINE=MYISAM                                   ");

		StringBuilder feedback = new StringBuilder();
		feedback.append(" CREATE TABLE feedback(					  ");
		feedback.append("     feedback_id      INT    AUTO_INCREMENT, ");
		feedback.append("     emp_id           INT,                   ");
		feedback.append("     app_id           INT,                   ");
		feedback.append("     feedback_time    TIMESTAMP,             ");
		feedback.append("     feedback_info    TEXT,         		  ");
		feedback.append("     PRIMARY KEY (feedback_id)               ");
		feedback.append(" )ENGINE=MYISAM                              ");

		String alter1 = "ALTER TABLE app ADD CONSTRAINT Refemp1 FOREIGN KEY (emp_id) REFERENCES emp(emp_id)";
		String alter2 = "ALTER TABLE feedback ADD CONSTRAINT Refemp2 FOREIGN KEY (emp_id) REFERENCES emp(emp_id)";
		String alter3 = "ALTER TABLE feedback ADD CONSTRAINT Refapp3 FOREIGN KEY (app_id) REFERENCES app(app_id)";

		String createIndex4Emp = "create unique index idx_email_pwd on emp(emp_email,emp_login_pwd)";
		String createIndex4App = "create unique index idx_token on app(app_token)";
		
		this.jdbcTemplate.execute(emp.toString());
		System.out.println("emp table created");
		this.jdbcTemplate.execute(app.toString());
		System.out.println("app table created");
		this.jdbcTemplate.execute(feedback.toString());
		System.out.println("feedback table created");
		this.jdbcTemplate.execute(alter1);
		this.jdbcTemplate.execute(alter2);
		this.jdbcTemplate.execute(alter3);
		System.out.println("alter ok");
		this.jdbcTemplate.execute(createIndex4Emp);
		this.jdbcTemplate.execute(createIndex4App);
		//创建默认账户
		this.jdbcTemplate.update("INSERT INTO emp(emp_id,emp_email, emp_login_pwd ) values(1,?,?)","kzhou.hrb@gmail.com",encodeByMd5("111111"));
		System.out.println("kFeedback default user create ok");
		//创建默认app
		this.jdbcTemplate.update("INSERT INTO app(app_id, emp_id, app_name, app_desc, app_token, app_feedback_qty)	VALUES (1, 1, 'kFeedback-云反馈', '把你的产品反馈信息放在云上进行统一管理', 'kFeedback', 0)");
		System.out.println("kFeedback default app create ok");
		System.out.println("kFeedback db create ok");
	}
	
	//开发者注册
	public int reg(String email,String pwd){
		//check email is exist
		int rv = this.jdbcTemplate.queryForInt("select count(*) from emp where emp_email = ?",email);
		if(rv == 0){
			final String sql = "INSERT INTO emp(emp_email, emp_login_pwd ) values(?,?)";
			return this.jdbcTemplate.update(sql,email,encodeByMd5(pwd));
		}else{
			return -999;
		}
	}
	//开发者修改密码
	public void updPwd(String empId,String newPwd){
		final String sql = "update emp set emp_login_pwd = ? where emp_id = ?";
		this.jdbcTemplate.update(sql,encodeByMd5(newPwd),empId);
	}
	//登录
	public String login(String email,String pwd){
		final String sql = "select convert(emp_id,char) as emp_id,emp_email from emp where emp_email = ? and emp_login_pwd = ?";
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			map = this.jdbcTemplate.queryForMap(sql,email,encodeByMd5(pwd));
			map.put("result", "1");
			return JSON.toJSONString(map);
		} catch (Exception e) {
			map.put("result", "0");
			return JSON.toJSONString(map);
		}
	}
	//忘记密码
	public int forgetPwd(String email){
		int rv = this.jdbcTemplate.queryForInt("select count(*) from emp where emp_email = ?",email);
		if(rv > 0){
			//get new pwd
			String newPwd = this.getAppToken();
			//upd emp pwd
			this.jdbcTemplate.update("update emp set emp_login_pwd = ? where emp_email = ?",encodeByMd5(newPwd),email);
			//send new pwd to email box
			StringBuilder msg = new StringBuilder();
			msg.append("您好，您的kFeedback新密码为：").append(newPwd).append("\n\n").append("请重新登录；http://kfeedback.cloudfoundry.com");
			this.sendEmail("来自kFeedback的密码重置邮件", email, msg.toString());
			return 1;//成功
		}else{
			return 0;
		}
	}
	//新增产品-strings[0],strings[1],strings[2]=emp_id,app_name,app_desc
	public void insApp(String...strings){
		final String sql = "INSERT INTO app (emp_id, app_name, app_desc,app_feedback_qty, app_token) values(?,?,?,0,?)";
		this.jdbcTemplate.update(sql,strings[0],strings[1],strings[2],getAppToken());
	}
	//删除产品
	public void delApp(String appId){
		this.jdbcTemplate.update("delete from feedback where app_id = ?",appId);
		this.jdbcTemplate.update("delete from app where app_id = ?",appId);
	}
	//修改产品-strings[0],strings[1],strings[2]=app_name,app_desc,app_id
	public void updApp(String...strings){
		final String sql = "update app set app_name=?,app_desc=? where app_id = ?";
		this.jdbcTemplate.update(sql,strings[0],strings[1],strings[2]);
	}
	//查询产品
	public String getApp(String empId){
		if(empId.equals("1")){
			return JSON.toJSONString(this.jdbcTemplate.queryForList("select convert(app_id,char) as app_id,convert(emp_id,char) as emp_id,app_name,app_desc,app_token,convert(app_feedback_qty,char) as app_feedback_qty,convert(DATE_FORMAT(cdate,'%Y-%m-%d'),char) as cdate from app where emp_id = ?",empId));
		}else{
			return JSON.toJSONString(this.jdbcTemplate.queryForList("select convert(app_id,char) as app_id,convert(emp_id,char) as emp_id,app_name,app_desc,app_token,convert(app_feedback_qty,char) as app_feedback_qty,convert(DATE_FORMAT(cdate,'%Y-%m-%d'),char) as cdate from app where app_id = 1 union all select convert(app_id,char) as app_id,convert(emp_id,char) as emp_id,app_name,app_desc,app_token,convert(app_feedback_qty,char) as app_feedback_qty,convert(DATE_FORMAT(cdate,'%Y-%m-%d'),char) as cdate from app where emp_id = ?",empId));
		}
	}
	//根据app_token反查app_id
	private Map<String,Object> getAppIdByToken(String token){
		return this.jdbcTemplate.queryForMap("select convert(a.emp_id,char) as emp_id,convert(a.app_id,char) as app_id,e.emp_email,a.app_name from app a,emp e where a.emp_id = e.emp_id and a.app_token = ?",token);
	}
	//根据产品查询反馈信息
	public String getFeedback(String appId){
		final String sql = "select convert(feedback_id,char) as feedback_id,convert(DATE_FORMAT(feedback_time,'%Y-%m-%d %H:%i:%s'),char) as feedback_time,feedback_info from feedback where app_id = ? order by feedback_time";
		return JSON.toJSONString(this.jdbcTemplate.queryForList(sql,appId));
	}
	//删除反馈信息
	public void delFeedback(String feedbackId){
		this.jdbcTemplate.update("delete from feedback where feedback_id = ?",feedbackId);
	}
	
	//开放api
	//新增反馈-strings[0],strings[1]]=app_token,feedback_info
	public void insFeedback(String...strings){
		Map<String,Object> map = getAppIdByToken(strings[0]);
		String appId = map.get("app_id").toString();
		final String sql = "INSERT INTO feedback (emp_id, app_id, feedback_info) values(?,?,?)";
		this.jdbcTemplate.update(sql,map.get("emp_id"),appId,strings[1]);
		int feedbackQty = this.jdbcTemplate.queryForInt("select count(*) from feedback where app_id = ?",appId);
		this.jdbcTemplate.update("update app set app_feedback_qty=? where app_id = ?",feedbackQty,appId);
		//send email to app creator
//		StringBuilder msgTitle = new StringBuilder();
//		msgTitle.append("[来自kFeedback]:您的<").append(map.get("app_name").toString()).append(">App收到了新的反馈信息");
//		StringBuilder msg = new StringBuilder();
//		msg.append("[来自kFeedback]:您的<").append(map.get("app_name").toString()).append(">App收到了新的反馈信息").append("\n\n");
//		msg.append("新的反馈信息为：\n\n");
//		msg.append("TA说：  ").append(strings[1]).append("\n\n").append("请访问；http://kfeedback.cloudfoundry.com").append("\n\n");
//		this.sendEmail(msgTitle.toString(), map.get("emp_email").toString(), msg.toString());
	}
	//开发api end
	
	
	//MD5
	private String encodeByMd5(String str) {
		MessageDigest md5;
		try {
			md5 = MessageDigest.getInstance("MD5");
			BASE64Encoder base64en = new BASE64Encoder();
			return base64en.encode(md5.digest(str.getBytes("utf-8")));
		} catch (Exception e) {
			return str;
		}
	}
	//UUID
	public String getAppToken(){
		return System.currentTimeMillis()+"";
	}
	
	/**
	 * 发送电子邮件
	 * @param title
	 * @param emailAddr
	 * @param msg
	 * @throws EmailException
	 */
	public void sendEmail(String title,String emailAddr,String msg){
		try {
			Email email = new SimpleEmail();
			email.setHostName("smtp.163.com");
			email.setAuthentication("kfeedback", "itsm,1234");
			email.setFrom("kfeedback@163.com");
			email.setSubject(title);
			email.setCharset("utf8");
			email.setMsg(msg);
			email.addTo(emailAddr);
			email.send();
		} catch (Exception e) {
		}
	}
}
