<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 메인</title>
</head>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert2">일일결산조회</span></a>
</div>

<h6 class="memo">관리메뉴를 선택하세요.</h6>
<!-- 
<a href="admin.do?type=reserve">관리자예약 </a><br/>
 -->
</body>
</html>