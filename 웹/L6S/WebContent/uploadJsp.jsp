<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%
	HttpServletRequest req = request;
	
	File re = new File("C:\\qqq.txt");
	BufferedOutputStream ou = new BufferedOutputStream(new FileOutputStream(re));

	BufferedInputStream a = new BufferedInputStream(request.getInputStream());
	int read;
	while((read=a.read()) !=-1){
		ou.write((byte)read); 
	}
	RandomAccessFile raf = new RandomAccessFile(re,"rw");
	raf.seek(0);
	raf.writeBytes("test");
	
	ou.close();
	a.close();
	

%> 
 
