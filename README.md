kFeedback
=========

应用名称：kFeedback-云反馈

应用URL 地址：http://kfeedback.cloudfoundry.com/

应用说明及使用场景：
成功的产品离不开用户的反馈；kFeedback就是你的产品与最终用户之间的沟通桥梁；
kFeedback一方面可以被动的收集用户的反馈信息，也可以主动的收集系统的异常信息；
kFeedback的工作流程：
1，开发者创建一个产品；
2，系统保存产品信息并生成一个token(令牌)
3，将API嵌入到你的应用中，如：java语言可以利用HttpClient来post反馈信息；(反馈输入界面需要在你的产品中自行实现)
4，系统收到反馈信息后，将其保存在数据库中，并邮件通知开发者，有新的用户反馈需要您的关注；
5，开发者进入kFeedback反馈监控台来阅读、分析用户的反馈信息来完善自己的产品；
kFeedback分为两大部分，一部分是核心API；另一部分是反馈监控台；
kFeedback提供了post API;
post API是嵌入到你的产品中，用户提供反馈信息后，调用此API将信息存储到kFeedback中；
post API的结构：

http://kfeedback.cloudfoundry.com/Action?m=insFeedback&token=kFeedback&fb=系统反馈信息

应用所使用的技术及软件： 
前端采用HTML5 + Twitter Bootstrap框架； 
服务端符合JAVA EE规范； 
web层使用传统jsp(基本上全是html) + servlet，简单、高效、清晰； 
数据层使用Spring JdbcTemplate； 
数据库使用MySQL； 
json序列化采用@wenshao的fastjson;
创新点（亮点）：
秉承metro的设计理念：“内容重于形式”；
应用简单、灵活,嵌入方便；分分钟即可让你的产品拥有反馈系统；

