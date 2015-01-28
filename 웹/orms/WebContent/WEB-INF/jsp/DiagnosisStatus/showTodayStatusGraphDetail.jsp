<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<c:set var="detailList" value="${detailList}" />
<style>
	#closeButton{
		background:url("${cp}/images/button/close_button.gif");
		background-repeat:no-repeat;
		width:53px;
		height:21px;
		border:0;
		cursor:pointer;
	}
</style>
<script>
function printGraph()
{
		print();
}

</script>
<body>
<div style="padding: 20px;">
<h3 align="right">${flight_date }</h3>
<table id="resultListTable" border="1" style="width: 100%;">
	<thead>
		<th colspan="2">조치기준</th>
		<th>명수</th>
		<th>명단</th>
	</thead>
	<tbody>
		<tr>
			<td class="orange" >오렌지색</td>
			<td>비행취소 건의</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '03' }">
				<c:set var="count3" value="${count3 +1}" />
				</c:if>
				</c:forEach>
				<c:set var="seq3" value="${count3 }" />
				${seq3 }
			</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '03' }">
					${detailList.rankname },&nbsp;
				</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="yellow" >노란색</td>
			<td>위험완화 및 관리감독</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '02' }">
				<c:set var="count2" value="${count2 +1}" />
				</c:if>
				</c:forEach>
				<c:set var="seq2" value="${count2 }" />
				${seq2 }
			</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '02' }">
					${detailList.rankname },&nbsp;
				</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="green">초록색</td>
			<td>정상비행</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '01' }">
				<c:set var="count1" value="${count1 +1}" />
				</c:if>
				</c:forEach>
				<c:set var="seq1" value="${count1 }" />
				${seq1 }
			</td>
			<td>
				<c:forEach var="detailList" items="${detailList}">
				<c:if test="${ detailList.result eq '01' }">
					${detailList.rankname },&nbsp;
				</c:if>
				</c:forEach>
			</td>
		</tr>
	</tbody>
</table>
<input style="text-align: center;" type="button" id="printButton" onClick="printGraph('${cp}/DiagnosisStatus/showTodayStatusGraphDetail.do')"/>
<!-- <input type="button" id="closeButton" onClick="closeParentDialog()"/> -->
</div>
</body>