<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약자/확정자 조회</title>
<script>
function filterData(){
	var day =$("input#reservation_day").val();
	var type=$("select#facilities_type").val();
	location.href="admin.do?type=appList&&reservation_day="+day+"&&facilities_type="+type;
	
}
$(function() {
	$( "#reservation_day" ).datepicker(
			{ 
				showOtherMonths: true,
				selectOtherMonths: true,
				dateFormat:"yy-mm-dd",
				changeMonth: true,
				changeYear: true,
				yearRange: "1950:+0Y"
				
			}
	);
});
</script>
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
<h4 class="title">일자별 예약자/확정자 조회</h4>
<!-- <table> -->
<!-- <tr><td> -->
<%-- <form:form action="admin/appList.do" method="POST" commandName="ReservationDTO"> --%>
<%-- 	<form:input path="reservation_day"/> --%>
<%-- 	<form:input path="facilities_type"/> --%>
<%-- </form:form> --%>
<!-- </td></tr> -->
<!-- </table> -->
<!-- <input name="reservation_day" onchange="filterData($(this).val())"/> -->
<!-- 	<form action="admin/appList.do" method="post"> -->
<!-- 		<input type="text" name="reservation_day"/> -->
<!-- 		<input type="text" name="facilities_type"/> -->
<!-- 		<input type="submit" value="전송"/> -->
<!-- 	</form> -->
<!-- <form action="admin.do?type=appList" method="GET"> -->
<h6 class="memo">조회일 <input id="reservation_day" value="${param.reservation_day }"/>
객실구분 <select id="facilities_type">
		<option value="">전체</option>
		<c:forEach var="li" items="${fCodeList }">
			<option value="${li.facilities_type}"
			<c:if test="${param.facilities_type eq li.facilities_type }">
			selected="selected"
			</c:if>
			>${li.facilities_type_name }</option>
		</c:forEach>
	</select> <span class="button medium"><button type="button" onclick="filterData();">조회</button></span></h6>
<!-- </form> -->
<table class="bbs_list">
	<tr>
		<th>객실
		</th>
		<th>성명
		</th>
		<th>예약날짜
		</th>
<!-- 		<th>예약확정일 -->
<!-- 		</th> -->
		<th>예약상태
		</th>
		<th>점수
		</th>
		<th>권한
		</th>
		<th>관리
		</th>
	</tr>
	<c:forEach var="res" items="${reslist}" varStatus="i">
		<form action="admin/appList.do" method="post">
		<tr>
			<td>${res.facilities_type_name }
			</td>
			<td>
			<c:forEach var="rank" items="${rank}">
				<c:if test="${res.user_rank eq rank.code_id}">
					<c:out value="${rank.code_name}"/>
				</c:if>
			</c:forEach> 
			${res.user_name}
			</td>
			<td>
				${res.reservation_day }
			</td>
<!-- 			<td> -->
<%-- 			${res.reservation_register_date } --%>
<!-- 			</td> -->
			<td>
				<select name="reservation_state">
					<c:forEach var="code" items="${code}">
						<option value="${code.code_id}"
						<c:if test="${code.code_id eq res.reservation_state}"> selected="selected"</c:if>
						>${code.code_name }</option>
					</c:forEach>
				</select>
<%-- 					<input type="hidden" name="reservation_state" value="${res.reservation_state}"> --%>
					<input type="hidden" name="reservation_id" value="${res.reservation_id}">
			</td>
			<td>
				${res.user_score }
			</td>
			<td>
				${res.user_auth_name }
			</td>
			<td>
				<input type="hidden" name="date" value="${param.reservation_day }">
				<input type="hidden" name="type" value="${param.facilities_type }">
				<span class="button medium"><button type="submit">정보갱신</button></span>
			</td>
		</tr>
		</form>
	</c:forEach>
</table>
</body>
</html>