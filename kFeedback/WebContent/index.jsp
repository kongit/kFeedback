<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>kFeedback - 云反馈!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="feedback system on Cloud Foundry">
    <meta name="author" content="zhoukai">

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 15px;
      }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
  <body>
    <div class="container">

      <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="hero-unit">
		<h1>kFeedback - 云反馈!</h1>
		<p>kFeedback是一个极简主义作品。</p>
		<p>成功的产品离不开用户的反馈；kFeedback就是你的产品与最终用户之间的沟通桥梁。</p>
      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span4">
			<blockquote>
				<p><strong>kFeedback基本路径(Guide).</strong></p>
				<small>kFeedback使用指南</small>
			</blockquote>
			<p>
				<ol>
				<li>注册kFeedback账号(Reg account)</li>
				<li>登录kFeedback(Login)</li>
				<li>创建App(New app)</li>
				<li>将系统生成的API嵌入到你的产品中(Embed kFeedback post-api in your projduct)</li>
				<li>OK</li>
				</ol>
			</p>
        </div>
        <div class="span4">
			<blockquote>
				<p><strong>登录kFeedback系统(Login).</strong></p>
				<small>用您注册的电子邮件和密码登录系统</small>
			</blockquote>
			<p>
				<label class="control-label" for="login_email">电子邮件(Email)</label>
				  <input type="text" id="login_email" placeholder="Email">
				<label class="control-label" for="login_pwd">登录密码(Password)</label>
				  <input type="password" id="login_pwd" placeholder="Password">
				<p>
				  <button id="btn_login" class="btn btn-primary">登录(Login now!)</button>
				</p>
			</p>
       </div>
        <div class="span4">
			<blockquote>
				<p><strong>注册kFeedback账号(Register).</strong></p>
				<small>提供您的电子邮件及登录密码，瞬间即可完成注册</small>
			</blockquote>		  
			<p>
				<label class="control-label" for="reg_email">电子邮件</label>
				  <input type="text" id="reg_email" placeholder="Login email">
				<label class="control-label" for="reg_pwd">登录密码</label>
				  <input type="password" id="reg_pwd" placeholder="Login pwd">
				<label class="control-label" for="reg_repwd">确认密码</label>
				  <input type="password" id="reg_repwd" placeholder="Confirm pwd">
				<p><button id="btn_reg" class="btn btn-primary">注册(Register now!)</button></p>
			</p>
        </div>
      </div>

      <hr>

      <footer>
		<div class="row">
			<div class="span4">&copy; <i class="icon-user"></i>恺哥作品 - <a href="mailto:kzhou.hrb@gmail.com?subject=to 恺哥">kzhou.hrb@gmail.com</a></div>
			<div class="span4"></div>
			<div class="span4">
				<a target="_blank" href="http://www.oschina.net" title="OSChina"><img src="img/osc.ico" alt="OSChina"></a>
				<a target="_blank" href="http://www.cloudfoundry.com/" title="CloudFoundry"><img src="img/cf.ico" alt="Cloudfoundry"></a>
				<a target="_blank" href="http://twitter.github.com/bootstrap/" title="Bootstrap"><img src="img/bootstrap.ico" alt="Bootstrap"></a>
			</div>
		</div>
      </footer>


	<!-- dialog -->
		<div id="myAlertModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 id="myModalLabel">kFeedback信息提示窗</h3>
            </div>
            <div class="modal-body">
            	<div id="alertInfo"></div>
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div> <!-- /container -->
				
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-1.8.3.js"></script>
    <script src="js/bootstrap.js"></script>
    <script type="text/javascript">
    	var app = "http://kfeedback.cloudfoundry.com";
	    var url = app + "/Action?callback=?";
	    $(document).ready(function() {
	    	//login email focus
	    	var localStorageLoginInfo = localStorage.getItem("login_email");
	    	if(!$.isEmptyObject(localStorageLoginInfo)){
	    		$("#login_email").val(localStorageLoginInfo);
	    		$("#login_pwd").focus();
	    	}else{
		    	$("#login_email").focus();
	    	}
	    	
	    	$("#btn_reg").click(function(){
	    		var reg_email = $("#reg_email").val();
	    		var reg_pwd = $("#reg_pwd").val();
	    		var reg_repwd = $("#reg_repwd").val();
	    		var alertInfo = checkRegForm(reg_email,reg_pwd,reg_repwd);
	    		if($.isEmptyObject(alertInfo)){
	        		$.getJSON(url,{m:"reg",reg_email:reg_email,reg_pwd:reg_pwd},function(json){
	        			if(json.result == "1"){
	        				//init login form
	        				$("#login_email").val(reg_email);
	        				$("#login_pwd").val(reg_pwd);
	        				$("#alertInfo").html("<p class=\"text-success\">账号注册成功，请登录kFeedback！</p>");
	        				$('#myAlertModal').modal('show');
	        			}else{
	        				$("#alertInfo").html("<p class=\"text-error\">账号注册失败，您提供的电子邮件已被使用，请重新尝试！</p>");
	        				$('#myAlertModal').modal('show');
	        			}
	        		});
	    		}else{
					$("#alertInfo").html(alertInfo);
					$('#myAlertModal').modal('show');
		    	}
	    	});
	    	
	    	$("#login_pwd").keydown(function(e){
	    		if(e.keyCode==13){ //回车
	    			$("#btn_login").click();
	    		}
	    	});
	    	
	    	$("#btn_login").click(function(){
	    		var login_email = $("#login_email").val();
	    		var login_pwd = $("#login_pwd").val();
				if($.isEmptyObject(login_email) || $.isEmptyObject(login_pwd)){
    				$("#alertInfo").html("<p class=\"text-error\">登录时，电子邮件和登录密码是必须的.</p>");
    				$('#myAlertModal').modal('show');
				}else{
	        		$.getJSON(url,{m:"login",email:login_email,pwd:login_pwd},function(json){
	        			if(json.result == "0"){
	        				$("#alertInfo").html("<p class=\"text-error\">登录失败，用户名或密码错误，请重新尝试！</p>");
	        				$('#myAlertModal').modal('show');
	        			}else{
	    					sessionStorage.setItem("email", login_email);
	    					sessionStorage.setItem("empId", json.emp_id);
	    					localStorage.setItem("login_email",login_email);
	        				location.href=app+"/main.jsp";
	        			}
	        		});
				}

	    	});
	  	});
	    
	    //check reg form
	    function checkRegForm(reg_email,reg_pwd,reg_repwd){
	    	var alertInfo = "";
			//check reg_email
			if($.isEmptyObject(reg_email)){
				alertInfo += "<p class=\"text-error\">注册时，电子邮件不能为空.</p>";
			}
			if(!verifyEmail(reg_email)){
				alertInfo += "<p class=\"text-error\">您提供的电子邮件格式不合法.</p>";
			}
			if($.isEmptyObject(reg_pwd)){
				alertInfo += "<p class=\"text-error\">注册时，登录密码不能为空.</p>";
		  		}
			if(reg_pwd != reg_repwd){
				alertInfo += "<p class=\"text-error\">登录密码不一致，请重新检查.</p>";
			}
			return alertInfo;
	    }
	    
		//email checker
	    function verifyEmail(emailStr){
		    var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
			if(emailStr.search(emailRegEx) == -1) {
				return false;
			}else{
				return true;
			}
	    } 	    
    </script>

  </body>
</html>
