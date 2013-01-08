package k.feedback;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;

public class Demo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		Demo.sendFeedback("1b07ea28-5f02-4868-9df2-56f5650bb2a6", "demp 测试数据");
		Demo.sendFeedbackInJava("1b07ea28-5f02-4868-9df2-56f5650bb2a6", "demo测试数据in java");
	}
	
	// in httpClient
	public static void sendFeedback(String appToken,String fb){
		DefaultHttpClient httpclient = new DefaultHttpClient();
		StringBuilder url = new StringBuilder();
		url.append("http://").append("/test/Action");
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
			//do
		}finally{
			httpclient.getConnectionManager().shutdown();
		}
	}
	
	// in Java
	private static void sendFeedbackInJava(String appToken,String fb){
		try {
			fb = URLEncoder.encode(fb, "utf8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		StringBuilder urlStr = new StringBuilder();
		urlStr.append("http://localhost:8080/test/Action?m=insFeedback&token=");
		urlStr.append(appToken);
		urlStr.append("&fb=");
		urlStr.append(fb);
		try {
			
			URL url = new URL(urlStr.toString());
			URLConnection connection = url.openConnection();
			connection.connect();
			connection.getInputStream();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
