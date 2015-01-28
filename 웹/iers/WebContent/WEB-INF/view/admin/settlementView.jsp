<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="mil.af.iers.component.util.ReservationFixed"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일일결산 조회</title>
<script type="text/javascript">
function searchYear(){
	var year = Number($('#searchYear').val());
	location.href='admin.do?type=settlementView&year='+year;
}
function seeDetail(date){
	location.href='admin.do?type=settlementViewDetail&date='+date;
}
</script>
</head>
<jsp:useBean id="now" class="java.util.Date"/>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert">일일결산조회</span></a>
</div>
<c:if test="${param.year eq null or param.year eq ''}">
	<c:set var="year" value="<%=ReservationFixed.getYear(0) %>"/>
</c:if>

<!-- 연도 :<input type="text" id="searchYear"> -->
<select id="searchYear" onchange="searchYear()">
	<c:forEach begin="2013" end="2020" varStatus="i">
		<option value="${i.index }"
		<c:if test="${param.year eq i.index or year eq i.index}">
		selected="selected"
		</c:if>
		>${i.index }년</option>
	</c:forEach>
</select>

<table class="bbs_list">
	<tr>
		<th>날짜</th>
		<th>인원</th>
		<th>금액</th>
		<th></th>
	</tr>
<c:forEach var="settle" items="${ settleStatistics}">
	<tr>
		<td>${settle.settlement_day }</td>
		<td>${settle.settlement_people_count }명</td>
		<td>${settle.settlement_total_price }원</td>
		<td><span class="button medium"><button type="button" onclick="seeDetail('${settle.settlement_day}')">상세보기</button></span></td>
	</tr>
</c:forEach>
<c:forEach var="settle" items="${ settleStatisticsGroup}">
	<tr>
		<td colspan="2"><b>${settle.settlement_day }</b></td>
		<td>${settle.settlement_people_count }명</td>
		<td>${settle.settlement_total_price }원</td>
		
	</tr>
</c:forEach>
</table>
</body>
</html>