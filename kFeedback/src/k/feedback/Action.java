package k.feedback;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Servlet implementation class Action
 */
public class Action extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WebApplicationContext ctx = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Action() {
        super();
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		ctx = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
//		response.setCharacterEncoding("utf-8");
		response.setHeader("Cache-Control", "no-cache"); 
		response.setContentType("text/javascript");
		Service service = (Service)ctx.getBean("service");
		String callback = request.getParameter("callback");
		String method = request.getParameter("m");
		System.out.println("request method : " + method);
		if(method == null || method.trim().length() == 0){
			response.getWriter().print("您的请求是非法的!");
		}else{
			if(method.equals("login")){
				this.login(service,request,response,callback);
			}else if(method.equals("reg")){
				this.reg(service,request,response,callback);
			}else if(method.equals("updPwd")){
				this.updPwd(service,request,response,callback);
			}else if(method.equals("insApp")){
				this.insApp(service,request,response,callback);
			}else if(method.equals("getApp")){
				this.getApp(service,request,response,callback);
			}else if(method.equals("getFeedback")){
				this.getFeedback(service,request,response,callback);
			}else if(method.equals("updApp")){
				this.updApp(service,request,response,callback);
			}else if(method.equals("delApp")){
				this.delApp(service,request,response,callback);
			}else if(method.equals("insFeedback")){
				this.insFeedback(service,request,response,callback);
			}
		}
	}

	private void insFeedback(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String token = request.getParameter("token");
		String fb = request.getParameter("fb");
		service.insFeedback(token,fb);
		response.getWriter().write(callback+"({\"result\" : \"1\"})");
	}

	private void delApp(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String appId =request.getParameter("appId");
		service.delApp(appId);
		response.getWriter().write(callback+"({\"result\" : \"1\"})");
	}

	private void updApp(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String appId = request.getParameter("appId");
		String appName = request.getParameter("appName");
		String appDesc = request.getParameter("appDesc");
		service.updApp(appName,appDesc,appId);
		response.getWriter().write(callback+"({\"result\" : \"1\"})");
	}

	private void getFeedback(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String appId = request.getParameter("appId");
		String feedbackJson = service.getFeedback(appId);
		response.getWriter().write(callback+"("+feedbackJson+")");
	}

	private void getApp(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String empId = request.getParameter("empId");
		String appJson = service.getApp(empId);
		response.getWriter().write(callback+"("+appJson+")");
	}

	private void insApp(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String empId = request.getParameter("empId");
		String appName = request.getParameter("appName");
		String appDesc = request.getParameter("appDesc");
		service.insApp(empId,appName,appDesc);
		response.getWriter().write(callback+"({\"result\" : \"1\"})");
	}

	private void updPwd(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String empId = request.getParameter("empId");
		String newPwd = request.getParameter("newPwd");
		service.updPwd(empId, newPwd);
		response.getWriter().write(callback+"({\"result\" : \"1\"})");
	}

	private void reg(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException {
		String reg_email = request.getParameter("reg_email");
		String reg_pwd = request.getParameter("reg_pwd");
		int rv = service.reg(reg_email, reg_pwd);
		String output = callback+"({})";
		if(rv == 1){
			output = callback+"({\"result\" : \"1\"})";//reg成功
		}else{
			output = callback+"({\"result\" : \"0\"})";//reg失败
		}
		response.getWriter().write(output);
	}

	private void login(Service service, HttpServletRequest request,HttpServletResponse response, String callback) throws IOException, ServletException {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		String loginInfo = service.login(email, pwd);
		response.getWriter().write(callback+"("+loginInfo+")");
	}


	private void initDB(Service service, HttpServletRequest request,HttpServletResponse response) {
		service.initDB();
	}

}
