<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����Ȯ��</title>
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
					<th scope="col">������</th>
					<th scope="col">����Ⱓ</th>
					<th scope="col">�������</th>
					<th scope="col">����ο�</th>
					<th scope="col">���ఴ��</th>
					<th scope="col">�ݾ�</th>
					<th scope="col">���ຯ��</th>
				</tr>
				<c:forEach var="reserve" items="${myReserve }">
				<tr> 
                    <td class="num">${reserve.reservation_day }</td>
					<td>${reserve.reservation_period }��</td>
					<td>${reserve.reservation_state_name }</td>
					<td>${reserve.reservation_people_count }��</td>
					<td>${reserve.facilities_type_name }</td>
					<td>${reserve.reservation_price }��</td>
					<td><c:if test="${reserve.reservation_state eq 'C01'}">
					<input type="hidden" value="${reserve.reservation_id }">
					<span class="button medium"><button type="button" onclick="javascript:deleteData('${reserve.reservation_id }');">�������</button></span>
				</c:if></td>
				</tr>
				</c:forEach>
		</table>	
</div>
</body>
</html>
