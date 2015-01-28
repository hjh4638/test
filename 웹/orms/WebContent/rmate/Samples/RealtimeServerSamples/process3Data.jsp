<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
Random myRandom = new Random();
Date date = new Date();
int p1 = myRandom.nextInt(100);
int p2 = myRandom.nextInt(100);
int p3 = myRandom.nextInt(100);

// 데이트 포맷 형식은 반드시 "2010/02/15 20:30:00" 형태로 하여주십시오.
SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

response.setHeader( "Content-Type" ,"text/xml" );
out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
out.println("<items>");
out.println("<item>");
out.println("<Time>"+dateFmt.format(date)+"</Time>");
out.println("<P1>"+p1+"</P1>");
out.println("<P2>"+p2+"</P2>");
out.println("<P3>"+p3+"</P3>");
out.println("</item>");
out.println("</items>");
%>
