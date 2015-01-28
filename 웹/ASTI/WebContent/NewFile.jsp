<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="java.util.*" %>
<%
	String a =request.getSession().getServletContext().getInitParameter("contextConfigLocation");
%>
<%=a %>


<title>Insert title here</title>
<script type="text/javascript" src="/ASTI/js/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="/ASTI/js/jquery-ui-1.9.1.custom.min.js"></script>
<script>
	var size; 
	var left;
	var center;
	var right;
$(function(){
	size= Number($(".img").length);
	left=size-1;
	center=0;
	right=1;
	$("#left").append($(".img:eq("+left+")").children().clone());
	$("#center").append($(".img:eq("+center+")").children().clone());
	$("#right").append($(".img:eq("+right+")").children().clone());
});
function autoSlide(){
	$('#arrow2').trigger('click');
	setTimeout("autoSlide()",5000);
}
$(function(){
	setTimeout("autoSlide()",5000);
});

function rightdd(){
	$(".tem").children().remove();
	if(left ==0)
		left = size-1;
	else
		left-=1;
	
	if(right==0)
		right = size-1;
	else
		right-=1;
	
	if(center==0)
		center = size-1;
	else
		center-=1;
	
	$("#left").append($(".img:eq("+left+")").children().clone());
	$("#center").append($(".img:eq("+center+")").children().clone());
	$("#right").append($(".img:eq("+right+")").children().clone());
}
function leftdd(){
	$(".tem").children().remove();
	if(left ==size-1)
		left = 0;
	else
		left+=1;
	
	if(right==size-1)
		right =0;
	else
		right+=1;
	
	if(center==size-1)
		center = 0;
	else
		center+=1;
	
	$("#left").append($(".img:eq("+left+")").children().clone());
	$("#center").append($(".img:eq("+center+")").children().clone());
	$("#right").append($(".img:eq("+right+")").children().clone());
}
function test(){alert("test");}

</script>
</head>
<body> 

<div id="0" class="img"><img src="images/btn/btn_01_0320.gif"></div>
<div id="1" class="img"><img src="images/btn/btn_01_0326.gif"></div>
<div id="2" class="img"><img src="images/btn/btn_01.gif"></div>
<div id="3" class="img"><img src="images/btn/btn_02_0320.gif"></div>
<div id="4" class="img"><img src="images/btn/btn_02_0326.gif"></div>
<div id="5" class="img"><img src="images/btn/btn_02.gif"></div>

<div class="tem" id="left" style="float:left;border: 1px solid black;width: 200px;height: 200px;"></div>
<div class="tem" id="center" style="float:left;border: 1px solid black;width: 200px;height: 200px;"></div>
<div class="tem" id="right" style="float:left;border: 1px solid black;width: 200px;height: 200px;"></div>

<input type="button" value="이전" onclick="leftdd()">
<input type="button" value="이후" onclick="rightdd()" id="arrow2">
<input type="button" value="test" onclick="test()">


<form action="http://www.oper.hq.af.mil:8080/ASTI/ajax/back.do" method="post">
<input type="text" value="qwer" name="map">
<input type="text" value="qw123er" name="map">
<input type="text" value="qwe124r" name="map">
<input type="text" value="qwer4" name="map">
<input type="text" value="qwer1" name="map">
<input type="submit" value="전송">
</form>
</body>
</html>