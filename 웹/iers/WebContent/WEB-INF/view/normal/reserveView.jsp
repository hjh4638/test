<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>예약</title>
<script type="text/javascript" src="/iers/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="/iers/js/jquery-calendar.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="/iers/css/calendar.css" />
<style>
.less{
/* 	color: red; */
/* 	color:red; */
}
.full{
/* 	background-color: red; */
	color: red;
}
</style>
<script>
$(document).ready(function() {

		// 달력 기본 데이터
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendar').fullCalendar({
			events : ${calData},
			//events:[${calData[0]},${calData[1]}], 
			weekMode : 'variable',
			loading: function(bool) {
				if (bool) $('#calendar').hide();
				else $('#calendar').show();
			},
			eventClick: function(calEvent, jsEvent, view)
			{
 				
			}
		});
});
$(function(){
	$(".full").children().css('color','red');
// 	$(".less").find("fc-event-skin").css("color","");
})
</script>
</head>
<body>
<div id="loading" style="display:none;"><b>잠시만 기다려주십시오. 달력을 불러오고 있습니다.</b></div>
	<div style="margin:5px 0 10px 2px;"></div>
	<div id="calendar"></div>
<!-- 	<a href="main.do?type=reserve">예약</a> -->
	
</body>
</html>