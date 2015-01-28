package mil.af.iers.component.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.SQLException;

public class SMSSender {
	private URL url;
	URLConnection connection;
	public SMSSender()
	{
	}
	
	public String SendSMS (String Sender, String Receiver, String Message) throws MalformedURLException
	{
		String Result = new String();
		try{
			url = new URL("http://oper.hq.af.mil:9999/sms/sendAPI.action");
			
			connection = url.openConnection();
			
			connection.setRequestProperty("Referer", "http://www2.hq.af.mil:9999/acrs/");

			connection.setDoOutput(true);
			
			String PostData = URLEncoder.encode("sysCode","UTF-8")+"="+URLEncoder.encode("ACRS","UTF-8")+"&"
					+ URLEncoder.encode("subSysCode","UTF-8")+"="+URLEncoder.encode("acrs01","UTF-8")+"&"
					+ URLEncoder.encode("sender","UTF-8")+"="+URLEncoder.encode(Sender.replace("-", ""),"UTF-8")+"&"
					+ URLEncoder.encode("receiver","UTF-8")+"="+URLEncoder.encode(Receiver.replaceAll("-", ""),"UTF-8")+"&"
					+ URLEncoder.encode("message","UTF-8")+"="+URLEncoder.encode(Message,"UTF-8")+"&"
					+ URLEncoder.encode("send_type","UTF-8")+"="+URLEncoder.encode("","UTF-8")+"&"
					+ URLEncoder.encode("reservedtime","UTF-8")+"="+URLEncoder.encode("","UTF-8")+"&"
					+ URLEncoder.encode("returntype","UTF-8")+"="+URLEncoder.encode("","UTF-8");
			
			OutputStreamWriter wr = new OutputStreamWriter(connection.getOutputStream());
			wr.write(PostData);
			wr.flush();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
			
			Result = br.readLine();

			wr.close();
			br.close();
			
			connection = null;
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			return Result;
		}
	}
}
