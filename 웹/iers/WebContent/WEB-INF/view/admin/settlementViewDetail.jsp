<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일일결산 상세보기</title>
</head>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert">일일결산조회</span></a>
</div>
<h4 class="title">${param.date} 일일결산 상세내용</h4>
<h6 class="memo"><b>현장결제</b></h6>
<table class="bbs_list">
	<tr>
		<th>날짜</th>
		<th>시설</th>
		<th>가격</th>
		<th>추가금액</th>
		<th>사용인원</th>
		<th>예약일</th>
		<th>금액합</th>
	</tr>
	<c:forEach var="settle" items="${settle }">
		<tr>
			<td>${settle.settlement_day }</td>
			<td>${settle.facilities_name }</td>
			<td>${settle.settlement_price }원</td>
			<td>${settle.settlement_add_price }원</td>
			<td>${settle.settlement_people_count }명</td>
			<td>${settle.settlement_reservation }</td>
			<td>${settle.settlement_total_price }원</td>
		</tr>
	</c:forEach> 
</table>
<br />
<h6 class="memo"><b>계좌이체</b></h6>
<table class="bbs_list">
	<tr>
		<th>시설</th>
		<th>계급</th>
		<th>이름</th>
		<th>예약일</th>
		<th>예약기간</th>
		<th>예약상태</th>
		<th>인원</th>
		<th>결재금액</th>
	</tr> 
	<c:forEach var="reserve" items="${reservation }">
		<tr>
			<td>${reserve.facilities_type_name }</td>
			<td>${reserve.user_rank_name }</td>
			<td>${reserve.user_name }</td>
			<td>${reserve.reservation_day }</td>
			<td>${reserve.reservation_period }일</td>
			<td>${reserve.reservation_state_name }</td>
			<td>${reserve.reservation_people_count }명</td>
			<td>${reserve.reservation_price }원</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>
