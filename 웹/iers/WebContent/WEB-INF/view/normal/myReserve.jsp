<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>예약확인</title>
<script type="text/javascript">
function deleteData(reservation_id){
	location.href = "<c:url value='/reserveDel.do?reservation_id='/>"+reservation_id;
}
</script>
</head>
<body>
<div style="width:740px; margin-left:2px;">
		<table class="bbs_list">
		<col width="70" />
		<col width="100" />
		<col width="100" />
		<col width="100" />
		<col width="100" />
		<col width="100" />
		<col width="100" />
 				<tr>
					<th scope="col">예약일</th>
					<th scope="col">예약기간</th>
					<th scope="col">예약상태</th>
					<th scope="col">사용인원</th>
					<th scope="col">예약객실</th>
					<th scope="col">금액</th>
					<th scope="col">예약변경</th>
				</tr>
				<c:forEach var="reserve" items="${myReserve }">
				<tr> 
                    <td class="num">${reserve.reservation_day }</td>
					<td>${reserve.reservation_period }일</td>
					<td>${reserve.reservation_state_name }</td>
					<td>${reserve.reservation_people_count }명</td>
					<td>${reserve.facilities_type_name }</td>
					<td>${reserve.reservation_price }원</td>
					<td><c:if test="${reserve.reservation_state eq 'C01'}">
					<input type="hidden" value="${reserve.reservation_id }">
					<span class="button medium"><button type="button" onclick="javascript:deleteData('${reserve.reservation_id }');">예약취소</button></span>
				</c:if></td>
				</tr>
				</c:forEach>
		</table>	
</div>
</body>
</html>
