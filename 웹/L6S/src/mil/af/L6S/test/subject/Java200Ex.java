package mil.af.L6S.test.subject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.Properties;

import javax.mail.Session;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;

public class Java200Ex {
	public static void main(String[] args) throws NumberFormatException, IOException
	{

		  Properties properties = new Properties();
		  properties.put("mail.transport.protocol", "smtp");
		  properties.put("mail.smtp.host", "www.mail.af.mil");
		  properties.put("mail.smtp.port", "25");
		  
		  Session mailSession = Session.getInstance(properties);
		  Message message = new MimeMessage(mailSession);
		  
		  try {
		   message.setFrom(new InternetAddress("11-70012670@af.mil"));
//		   "보내는 사람 주소"
		   message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("11-70012670@af.mil"));
//		   "받는 사람 주소"
		   message.setSentDate(new Date());
		   message.setSubject("메일 제목이 들어갈 부분");
		   
		   message.setText("메일 내용이 들어갈 부분");
		   
		   Transport.send(message);
		   System.out.println("E-mail successfully sent!");
		  } catch (AddressException e) {
		   e.printStackTrace();
		   System.out.println("AddressException : " + e);
		  } catch (MessagingException e) {
		   e.printStackTrace();
		   System.out.println("MessagingException : " + e);
		  }
	}
	
}
//
//public void sendEmail(SvReceiptVO receipt){
//	  //이메일
//	  String server = "www.mail.af.mil";
//	  Properties properties = new Properties();
//	  properties.put("mail.transport.protocol", "smtp");
//	  properties.put("mail.smtp.host", server);
//	  properties.put("mail.smtp.port", "25");
//	  Session mailSession = Session.getInstance(properties);
//	  Message message = new MimeMessage(mailSession);  
//	  String title = "제목";
//	  String context = "내용";
//	   try{
//	   String from, to;
//	   from = mainDAO.getEmail().getCode_context(); 보내는 주소
//	   to = mainDAO.getPatientInfo(receipt.getSn()).getEmailAddress();  받는 주소
//	   message.setFrom(new InternetAddress(from)); 
//	   message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//	   message.setSentDate(new Date());
//	   message.setSubject(title);
//	   message.setText(context);   
//	//   Transport.send(message);
//	//   System.out.println("E-mail successfully sent!");
//	  } catch (AddressException e) {
//	   e.printStackTrace();
//	   System.out.println("AddressException : " + e);
//	  } catch (MessagingException e) {
//	     e.printStackTrace();
//	     System.out.println("MessagingException : " + e);
//	  }
//	 }

