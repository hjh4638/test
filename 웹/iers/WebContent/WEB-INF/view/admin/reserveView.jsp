<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����</title>
<link rel="stylesheet" type="text/css" href="/iers/css/calendar.css" />
<script type="text/javascript" src="/iers/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="/iers/js/jquery-calendar.js" charset="UTF-8"></script>
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

		// �޷� �⺻ ������
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendar').fullCalendar({
			events : ${calData},
			//	events:['${calData[0]},${calData[1]}'], 
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
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">������Ȳ��ȸ</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">�ü��� ����</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">ȸ�� ����</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert">�ܿ�������ȸ</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">���ϰ��</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert2">���ϰ����ȸ</span></a>
</div>
<div id="loading" style="display:none;"><b>��ø� ��ٷ��ֽʽÿ�. �޷��� �ҷ����� �ֽ��ϴ�.</b></div>
	<div id="calendar"></div>
<!-- 	<a href="main.do?type=reserve">����</a> -->
	
</body>
</html>