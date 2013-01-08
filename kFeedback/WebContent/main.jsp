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
        padding-top: 60px;
        padding-bottom: 5px;
      }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link href="css/prettify.css" rel="stylesheet">
    <script src="js/prettify.js"></script>
    

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body onload="prettyPrint()">
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">kFeedback - 云反馈!</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li><a href="#" id="goto_index">首页(Home)</a></li>
              <li><a href="#" id="goto_about">关于(About)</a></li>
              <li><a href="#" id="goto_demo">示例(Demo)</a></li>
              <li><a href="#" id="goto_updpwd">修改密码(Upd pwd)</a></li>
              <li class="active"><a href="#"><i class="icon-user icon-white"></i><span id="login_email"></span></a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>


	<div class="container">
		<h2>App反馈监控台(App feedback console)</h2>
		<hr>
		<div class="tabbable tabs-left">
		  <ul id="appList" class="nav nav-tabs">
			<li class="active"><a href="#addApp" data-toggle="tab"><i class="icon-plus"></i>新增App(New App)</a></li>
		  </ul>
		  <div id="appList_content" class="tab-content">
		  <!-- 固定存在 -->
			<div class="tab-pane active" id="addApp">
			  <p>
				  <div class="control-group">
					<label class="control-label" for="app_name">App名称(&lt;=100个字.)</label>
					<div class="controls">
					  <input class="input-xlarge" type="text" id="app_name" maxlength="100" placeholder="App name">
					</div>
				  </div>
				  <div class="control-group">
					<label class="control-label" for="app_desc">App描述(&lt;=150个字.)</label>
					<div class="controls">
					  <textarea maxlength="150" class="input-xlarge" id="app_desc" rows="3"></textarea>
					</div>
				  </div>
				  <div class="control-group">
					<div class="controls">
					  <button id="btn_addApp" class="btn btn-primary">新增App(New app now!)</button>
					</div>
				  </div>
			  </p>
			</div>
			<!-- 固定存在 end-->
		  </div>
		</div>	
	
	
		<hr>

      <footer>
		<div class="row">
			<div class="span4">&copy; <i class="icon-user"></i>恺哥作品 - <a href="mailto:kzhou.hrb@gmail.com?subject=to 恺哥">kzhou.hrb@gmail.com</a></div>
			<div class="span4"></div>
			<div class="span4">
				<a target="_blank" href="http://www.oschina.net" title="OSChina"><img src="img/osc.ico" alt="OSChina"></a>
				<a target="_blank" href="http://www.cloudfoundry.com/" title="CloudFoundry"><img src="img/cf.ico" alt="cloudfoundry"></a>
				<a target="_blank" href="http://twitter.github.com/bootstrap/" title="Bootstrap"><img src="img/bootstrap.ico" alt="Bootstrap"></a>
			</div>
		</div>
      </footer>
      
	<!-- dialog -->
	<div id="updPwdModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 id="myModalLabel">kFeedback信息提示窗</h3>
            </div>
            <div class="modal-body">
            	<h4><span id="loginer"></span>修改密码</h4>
            	<div id="updPwd_error_info"></div>
            	<p>
				<label class="control-label" for="upd_new_pwd">新密码</label>
				  <input type="password" id="upd_new_pwd" placeholder="New pwd">
				<label class="control-label" for="upd_new_repwd">确认新密码</label>
				  <input type="password" id="upd_new_repwd" placeholder="Confirm new pwd">
				</p>
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal">Close</button>
              <button id="btn_updpwd" class="btn btn-primary">提交(Update now!)</button>
            </div>
    </div>
	<div id="updAppModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 id="myModalLabel">kFeedback信息提示窗</h3>
            </div>
            <div class="modal-body">
            	<h4>修改App信息</h4>
            	<div id="updApp_error_info"></div>
            	<p>
				<label class="control-label" for="upd_app_token">App Token</label>
				  <input type="text" disabled="disabled" class="input-xlarge uneditable-input" id="upd_app_token" placeholder="">
				<label class="control-label" for="upd_app_name">App名称(<=100个字.)</label>
				  <input type="text" maxlength="100" class="input-xlarge" id="upd_app_name" placeholder="">
				  <input type="hidden" id="upd_app_id" >
				<label class="control-label" for="upd_app_desc">App描述(<=150个字.)</label>
				  <textarea maxlength="150" class="input-xlarge" id="upd_app_desc" rows="3"></textarea>
				</p>
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal">Close</button>
              <button id="btn_updApp" class="btn btn-primary">提交(Update now!)</button>
            </div>
    </div>
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
	<div id="myAlertModal4Reload" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
             <h3 id="myModalLabel">kFeedback信息提示窗</h3>
           </div>
           <div class="modal-body">
           	<div id="alertInfo4Reload"></div>
           </div>
           <div class="modal-footer">
             <button class="btn" data-dismiss="modal">Close</button>
           </div>
     </div>
	<div id="delAppModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
             <h3 id="myModalLabel">kFeedback信息提示窗</h3>
           </div>
           <div class="modal-body">
			<h4>删除App - <span id="delAppName"></span></h4>
			<p>删除App的同时，也会删除该App的所有反馈信息，请注意.</p>
			<p>删除App点击[删除App]按钮，取消删除操作请点击[取消]按钮.</p>
			<input type="hidden" id="del_app_id" >
           </div>
           <div class="modal-footer">
             <button class="btn" data-dismiss="modal">取消(Cancel)</button>
             <button id="btn_delApp" class="btn btn-primary">删除App(Delete app now!)</button>
           </div>
     </div>
	<div id="aboutModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
             <h3 id="myModalLabel">关于kFeedback</h3>
           </div>
           <div class="modal-body">
           	     <div class="thumbnail">
                  <img src="img/me.png" alt="恺哥">
                  <div class="caption">
                    <h4>周恺(<a href="http://weibo.com/u/2697324452" target="_blank">@新浪微博</a>)</h4>
                    <p>联通系统集成有限公司黑龙江省分公司 信息系统开发部 技术经理.</p>
                  </div>
                </div>
           </div>
           <div class="modal-footer">
             <button class="btn" data-dismiss="modal">Close</button>
           </div>
     </div>
	<div id="demoModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
             <h3 id="myModalLabel">kFeedback Demo(示例)</h3>
           </div>
           <div class="modal-body">
                  <h4>如何将Post-API嵌入到您的产品中</h4>
                  <div class="caption">
                    <h5>基于Apache HttpClient(推荐)</h5>
                    <p>
<pre class="prettyprint ">
public static void sendFeedback(String appToken,String fb){
  DefaultHttpClient httpclient = new DefaultHttpClient();
  StringBuilder url = new StringBuilder();
  url.append("http://kfeedback.cloudfoundry.com/Action");
  try {
    HttpPost httpost = new HttpPost(url.toString());
    List<NameValuePair> params = new ArrayList<NameValuePair>(); 
	params.add(new BasicNameValuePair("m", "insFeedback")); 
	params.add(new BasicNameValuePair("token", appToken)); 
	params.add(new BasicNameValuePair("fb", fb)); 
	httpost.setEntity(new UrlEncodedFormEntity(params,HTTP.UTF_8));
	ResponseHandler<String> responseHandler = new BasicResponseHandler();
	httpclient.execute(httpost, responseHandler);
  } catch (Exception e) {
  }finally{httpclient.getConnectionManager().shutdown();}
}
</pre>
					</p>
                </div>
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
    $(document).ready(function(){
    	var app = "http://kfeedback.cloudfoundry.com";
	    var url = app + "/Action?callback=?";
    	//init login_info
    	$("#login_email").html(sessionStorage.getItem("email")+"("+sessionStorage.getItem("empId")+")");
    	
    	//init app tab
    	$("#appList").empty();//清空列表
    	$("#appList").append("<li class=\"active\"><a href=\"#addApp\" data-toggle=\"tab\"><i class=\"icon-plus\"></i>新增App(New App)</a></li>");
   		$.getJSON(url,{m:"getApp",empId:sessionStorage.getItem("empId")},function(json){
			$.each(json, function(i,item){
				var appInfo = "<li><a id=\""+item.app_id+"\" href=\"#"+item.app_id+"t\" data-toggle=\"tab\" title=\""+item.app_desc+"\">"+item.app_name+" - <span class=\"badge badge-info\">"+item.app_feedback_qty+"</span></a></li>";
				$("#appList").append(appInfo);
				
				$("#"+item.app_id).bind("click",function(){
					if(item.app_id == 1){
						if(sessionStorage.getItem("empId") == "1"){
		    				//init app detail info
							var appTabContent = "<div class=\"tab-pane\" id=\""+item.app_id+"t\">";
							appTabContent += "	<p> <div class=\"row\">                       					";
							if(item.app_feedback_qty > 0){
								appTabContent += "	  <div class=\"span3\"><i class=\"icon-list\"></i><strong><a href=\"#\" id=\"loadAppFB"+item.app_id+"\">加载"+item.app_name+"的反馈信息</a></strong></div>   ";
							}else{
								appTabContent += "	  <div class=\"span3\"><i class=\"icon-list\"></i><strong>"+item.app_name+"无信息</strong></div>   ";
							}
							appTabContent += "	  <div class=\"span3\"><i class=\"icon-edit\"></i><strong><a href=\"#\" id=\"go2updApp"+item.app_id+"\">修改"+item.app_name+"的信息</a></strong></div>  			";
							appTabContent += "	  <div class=\"span3\"><i class=\"icon-remove\"></i><strong><a href=\"#\" id=\"go2delApp"+item.app_id+"\">删除"+item.app_name+"的所有信息</a></strong></div>     		";
							appTabContent += "	</div><hr>	                     					";
							appTabContent += "	<div class=\"row\">                       					";
							appTabContent += "	  <div class=\"span2\"><p><strong>创建时间</strong></p><p>"+item.cdate+"</p></div>  			";
							appTabContent += "	  <div class=\"span4\"><p><strong>描述</strong></p><p>"+item.app_desc+"</p></div>     		";
							appTabContent += "	  <div class=\"span3\"><p><strong>Token</strong></p><p>"+item.app_token+"</p></div>   ";
							appTabContent += "	</div>	</p>  <hr>                      					";
							//init feedback info
							appTabContent += "  <p>                                                                         ";
							appTabContent += "	<table class=\"table table-striped\">                                         ";
							appTabContent += "	  <thead>                                                                   ";
							appTabContent += "		<tr>                                                                    ";
							appTabContent += "		  <th>#</th>                                                            ";
							appTabContent += "		  <th><i class=\"icon-time\"></i>反馈时间(Feedback time)</th>             ";
							appTabContent += "		  <th><i class=\"icon-info-sign\"></i>反馈内容(Feedback content)</th>     ";
							appTabContent += "		  <th><i class=\"icon-wrench\"></i>操作(Operate)</th>                     ";
							appTabContent += "		</tr>                                                                   ";
							appTabContent += "	  </thead>                                                                  ";
							appTabContent += "	  <tbody id=\"fb_tbody"+item.app_id+"\">                                                                   ";
							appTabContent += "	  </tbody>                                                                  ";
							appTabContent += "	</table>                                                                    ";
							appTabContent += " </p>                                                                         ";
							appTabContent += "</div>";
							$("#appList_content").append(appTabContent);
						}else{
		    				//init app detail info
							var appTabContent = "<div class=\"tab-pane\" id=\""+item.app_id+"t\">";
							appTabContent += "<div class=\"input-append\">";
							appTabContent += "  <input class=\"span6\" placeholder=\"留下您对kFeedback的感受\" id=\"feedback_info\" type=\"text\">";
							appTabContent += "  <button class=\"btn btn-info\" id=\"bth_addFeedback"+item.app_id+"\" type=\"button\">提交反馈</button>";
							if(item.app_feedback_qty > 0){
								appTabContent += "  <button class=\"btn btn-primary\" id=\"btnLoadAppFB"+item.app_id+"\" type=\"button\">加载反馈信息</button>";
							}
							
							appTabContent += "</div>";
							
							appTabContent += "	<hr>	                     					";
							appTabContent += "	<div class=\"row\">                       					";
							appTabContent += "	  <div class=\"span2\"><p><strong>创建时间</strong></p><p>"+item.cdate+"</p></div>  			";
							appTabContent += "	  <div class=\"span4\"><p><strong>描述</strong></p><p>"+item.app_desc+"</p></div>     		";
							appTabContent += "	  <div class=\"span3\"><p><strong>Token</strong></p><p>"+item.app_token+"</p></div>   ";
							appTabContent += "	</div>	</p>  <hr>                      					";
							//init feedback info
							appTabContent += "  <p>                                                                         ";
							appTabContent += "	<table class=\"table table-striped\">                                         ";
							appTabContent += "	  <thead>                                                                   ";
							appTabContent += "		<tr>                                                                    ";
							appTabContent += "		  <th>#</th>                                                            ";
							appTabContent += "		  <th><i class=\"icon-time\"></i>反馈时间(Feedback time)</th>             ";
							appTabContent += "		  <th><i class=\"icon-info-sign\"></i>反馈内容(Feedback content)</th>     ";
							appTabContent += "		  <th><i class=\"icon-wrench\"></i>操作(Operate)</th>                     ";
							appTabContent += "		</tr>                                                                   ";
							appTabContent += "	  </thead>                                                                  ";
							appTabContent += "	  <tbody id=\"fb_tbody"+item.app_id+"\">                                                                   ";
							appTabContent += "	  </tbody>                                                                  ";
							appTabContent += "	</table>                                                                    ";
							appTabContent += " </p>                                                                         ";
							appTabContent += "</div>";
							$("#appList_content").append(appTabContent);
						}
					}else{
	    				//init app detail info
						var appTabContent = "<div class=\"tab-pane\" id=\""+item.app_id+"t\">";
						appTabContent += "	<p> <div class=\"row\">                       					";
						if(item.app_feedback_qty > 0){
							appTabContent += "	  <div class=\"span3\"><i class=\"icon-list\"></i><strong><a href=\"#\" id=\"loadAppFB"+item.app_id+"\">加载"+item.app_name+"的反馈信息</a></strong></div>   ";
						}else{
							appTabContent += "	  <div class=\"span3\"><i class=\"icon-list\"></i><strong>"+item.app_name+"无信息</strong></div>   ";
						}
						appTabContent += "	  <div class=\"span3\"><i class=\"icon-edit\"></i><strong><a href=\"#\" id=\"go2updApp"+item.app_id+"\">修改"+item.app_name+"的信息</a></strong></div>  			";
						appTabContent += "	  <div class=\"span3\"><i class=\"icon-remove\"></i><strong><a href=\"#\" id=\"go2delApp"+item.app_id+"\">删除"+item.app_name+"的所有信息</a></strong></div>     		";
						appTabContent += "	</div><hr>	                     					";
						appTabContent += "	<div class=\"row\">                       					";
						appTabContent += "	  <div class=\"span2\"><p><strong>创建时间</strong></p><p>"+item.cdate+"</p></div>  			";
						appTabContent += "	  <div class=\"span4\"><p><strong>描述</strong></p><p>"+item.app_desc+"</p></div>     		";
						appTabContent += "	  <div class=\"span3\"><p><strong>Token</strong></p><p>"+item.app_token+"</p></div>   ";
						appTabContent += "	</div>	</p>  <hr>                      					";
						//init feedback info
						appTabContent += "  <p>                                                                         ";
						appTabContent += "	<table class=\"table table-striped\">                                         ";
						appTabContent += "	  <thead>                                                                   ";
						appTabContent += "		<tr>                                                                    ";
						appTabContent += "		  <th>#</th>                                                            ";
						appTabContent += "		  <th><i class=\"icon-time\"></i>反馈时间(Feedback time)</th>             ";
						appTabContent += "		  <th><i class=\"icon-info-sign\"></i>反馈内容(Feedback content)</th>     ";
						appTabContent += "		  <th><i class=\"icon-wrench\"></i>操作(Operate)</th>                     ";
						appTabContent += "		</tr>                                                                   ";
						appTabContent += "	  </thead>                                                                  ";
						appTabContent += "	  <tbody id=\"fb_tbody"+item.app_id+"\">                                                                   ";
						appTabContent += "	  </tbody>                                                                  ";
						appTabContent += "	</table>                                                                    ";
						appTabContent += " </p>                                                                         ";
						appTabContent += "</div>";
						$("#appList_content").append(appTabContent);
					}
					
					$("#bth_addFeedback"+item.app_id).bind("click",function(){
						var fbInfo = $("#feedback_info").val();
						if($.isEmptyObject(fbInfo)){
	        				$("#alertInfo").html("<p class=\"text-error\">提交反馈失败！反馈信息不能为空！</p>");
	        				$('#myAlertModal').modal('show');
						}else{
			        		$.getJSON(url,{m:"insFeedback",token:"kFeedback",fb:fbInfo},function(json){
			        			if(json.result == "1"){
			        	    		$("#feedback_info").val("");
			        				$("#alertInfo4Reload").html("<p class=\"text-success\">新增成功！感谢您对kFeedback的支持.</p>");
			        				$('#myAlertModal4Reload').modal('show');
			        			}else{
			        				$("#alertInfo").html("<p class=\"text-error\">新增失败！</p>");
			        				$('#myAlertModal').modal('show');
			        			}
			        		});
						}
					});
					
					$("#btnLoadAppFB"+item.app_id).bind("click",function(){
						$.getJSON(url,{m:"getFeedback",appId:item.app_id},function(json){
							//clear tbody
							$("#fb_tbody"+item.app_id).empty();
							var tbody = "";
		        			if(json.length > 0){
				   				$.each(json, function(j,feedbackItem){
				   					tbody += "<tr>";
				   					tbody += "<td>" + feedbackItem.feedback_id + "</td>";
				   					tbody += "<td>" + feedbackItem.feedback_time + "</td>";
				   					tbody += "<td>" + feedbackItem.feedback_info + "</td>";
				   					tbody += "<td><i class=\"icon-comment\"></i><strong><a href=\"#\">预留</a></strong></td>";
				   					tbody += "</tr>";
				   				});
				   				$("#fb_tbody"+item.app_id).append(tbody);
		        			}
		        		});
					});
					
					//bind load feedback info click event
					$("#loadAppFB"+item.app_id).bind("click",function(){
						$.getJSON(url,{m:"getFeedback",appId:item.app_id},function(json){
							//clear tbody
							$("#fb_tbody"+item.app_id).empty();
							var tbody = "";
		        			if(json.length > 0){
				   				$.each(json, function(j,feedbackItem){
				   					tbody += "<tr>";
				   					tbody += "<td>" + feedbackItem.feedback_id + "</td>";
				   					tbody += "<td>" + feedbackItem.feedback_time + "</td>";
				   					tbody += "<td>" + feedbackItem.feedback_info + "</td>";
				   					tbody += "<td><i class=\"icon-comment\"></i><strong><a href=\"#\">预留</a></strong></td>";
				   					tbody += "</tr>";
				   				});
				   				$("#fb_tbody"+item.app_id).append(tbody);
		        			}
		        		});
					});
					
					//bind updApp and delApp click event
					$("#go2updApp"+item.app_id).bind("click",function(){
						$("#upd_app_id").val(item.app_id);
						$("#upd_app_token").val(item.app_token);
						$("#upd_app_name").val(item.app_name);
						$("#upd_app_desc").val(item.app_desc);
						$('#updAppModal').modal('show');
					});
					$("#go2delApp"+item.app_id).bind("click",function(){
						$("#del_app_id").val(item.app_id);
						$("#delAppName").html("<strong>"+item.app_name+"</strong>");
						$('#delAppModal').modal('show');
					});
					
				});
				
			});

   		});
   		//init app tab end
   		
    	$("#goto_index").click(function(){
    		//clear sessionStorage
    		sessionStorage.clear();
    		//forward
    		location.href = app + "/index.jsp";
    	});
    	
    	$("#goto_about").click(function(){
    		$('#aboutModal').modal('show');
    	});
    	
       	$("#goto_demo").click(function(){
    		$('#demoModal').modal('show');
    	});
    	
    	
   		
    	$("#goto_updpwd").click(function(){
    		$("#updPwd_error_info").html("");
    		$("#upd_new_pwd").val("");
    		$("#upd_new_repwd").val("");
    		$("#loginer").html(sessionStorage.getItem("email")+"("+sessionStorage.getItem("empId")+")");
    		$('#updPwdModal').modal('show');
    	});
    	$("#btn_updpwd").click(function(){
    		var upd_new_pwd = $("#upd_new_pwd").val();
    		var upd_new_repwd = $("#upd_new_repwd").val();
			if(!$.isEmptyObject(upd_new_pwd) && (upd_new_pwd == upd_new_repwd)){
        		$.getJSON(url,{m:"updPwd",empId:sessionStorage.getItem("empId"),newPwd:upd_new_pwd},function(json){
        			if(json.result == "1"){
        				$("#updPwd_error_info").html("<p class=\"text-success\">修改密码成功.</p>");
        	    		$("#upd_new_pwd").val("");
        	    		$("#upd_new_repwd").val("");
        			}else{
        				$("#updPwd_error_info").html("<p class=\"text-error\">修改密码失败.</p>");        			}
        		});
			}else{
				$("#updPwd_error_info").html("<p class=\"text-error\">修改密码失败，新密码为空或密码不一致，请重新尝试.</p>");
			}
    	});
    	
    	$("#btn_addApp").click(function(){
    		var app_name = $("#app_name").val();
    		var app_desc = $("#app_desc").val();
    		if(!$.isEmptyObject(app_name) && !$.isEmptyObject(app_desc)){
        		$.getJSON(url,{m:"insApp",empId:sessionStorage.getItem("empId"),appName:app_name,appDesc:app_desc},function(json){
        			if(json.result == "1"){
        	    		$("#app_name").val("");
        	    		$("#app_desc").val("");
        				$("#alertInfo4Reload").html("<p class=\"text-success\">App新增成功！</p>");
        				$('#myAlertModal4Reload').modal('show');
        			}else{
        				$("#alertInfo").html("<p class=\"text-error\">App新增失败！</p>");
        				$('#myAlertModal').modal('show');
        			}
        		});
    		}else{
				$("#alertInfo").html("<p class=\"text-error\">App名称与描述为必填字段！</p>");
				$('#myAlertModal').modal('show');
    		}
    	});
    	
    	$("#btn_updApp").click(function(){
    		var upd_app_id = $("#upd_app_id").val();
    		var upd_app_name = $("#upd_app_name").val();
    		var upd_app_desc = $("#upd_app_desc").val();
    		if(!$.isEmptyObject(upd_app_id) && !$.isEmptyObject(upd_app_name) && !$.isEmptyObject(upd_app_desc)){
        		$.getJSON(url,{m:"updApp",appId:upd_app_id,appName:upd_app_name,appDesc:upd_app_desc},function(json){
        			if(json.result == "1"){
        	    		$("#upd_app_id").val("");
        	    		$("#upd_app_token").val("");
        	    		$("#upd_app_name").val("");
        	    		$("#upd_app_desc").val("");
        	    		$('#updAppModal').modal('hide');
       					$("#alertInfo4Reload").html("<p class=\"text-success\">App修改成功！</p>");
        				$('#myAlertModal4Reload').modal('show');
        			}else{
        				$("#alertInfo").html("<p class=\"text-error\">App修改失败！</p>");
        				$('#myAlertModal').modal('show');
        			}
        		});
    		}else{
				$("#updApp_error_info").html("<p class=\"text-error\">App名称与描述为必填字段！</p>");
    		}
    	});

    	
    	$("#btn_delApp").click(function(){
       		$.getJSON(url,{m:"delApp",appId:$("#del_app_id").val()},function(json){
       			if(json.result == "1"){
       	    		$("#del_app_id").val("");
       	    		$('#delAppModal').modal('hide');
      				$("#alertInfo4Reload").html("<p class=\"text-success\">App删除成功！</p>");
       				$('#myAlertModal4Reload').modal('show');
       			}else{
       				$("#alertInfo").html("<p class=\"text-error\">App删除失败！</p>");
       				$('#myAlertModal').modal('show');
       			}
       		});
    	});
    	
    	$('#myAlertModal4Reload').on('hidden', function () {
    		location.reload(true);//是的，我承认我偷懒了
    	});
    });
    
    </script>
  </body>
</html>
