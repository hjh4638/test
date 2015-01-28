<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<jsp:include page="paramDiv.jsp"/>
<style>
	.period{
		width:1px;
		word-break: break-all;
		word-wrap: break-word;
		padding-left:4px;
		padding-right:4px;
	}
	#diagnosisStatusIframe{
		width:100%;
		height:100%;
	}
</style>
<script>
	var statusDialog;
	$(function(){
		statusDialog=createDialog('#diagnosisStatusDialog','',true,800,800);
	});
	function showStatusDialog(sn){
		$("#diagnosisStatusDialog").empty();
		$("#diagnosisStatusDialog").append("<iframe id='diagnosisStatusIframe' src='${cp}/DiagnosisStatus/view/showPersonalStatus.do?sn="+sn+"&start_date=${startDate}&end_date=${endDate}'></iframe>");
		statusDialog.dialog("open");
		
	}
	
	/* 반자를 전자로 변환하는 함수 */
	function StrToDStr(asStr){
		var rTmp;
		
		rTmp="";
		for(i=0; i < asStr.length; i++){
			if(asStr.charCodeAt(i) <= 127)
				iTmp = asStr.charCodeAt(i) + 65248;
			else
				iTmp = asStr.charCodeAt(i);
			rTmp = rTmp + String.formatCharCode(iTmp);
		}
		return rTmp;
	}
	
</script>
<div style="width: 785px; height:450px; overflow: auto;">
<table id="resultListTable" border="1" style="margin-top:10px" >

	<thead>
	<tr>
		<th rowspan="2" valign="middle">
			<hr style="color:#3D649F; visibility:hidden; width: 100px"/><br>
			조종사명/날짜<br>
			<hr style="color:#3D649F; visibility:hidden; width: 100px"/>
		</th>
		<c:forEach var="date" items="${dateRange}">
			<th style="word-break : nowrap;" colspan="${periodListSize }">${date }</th>
		</c:forEach>
	</tr>
	<tr>
		<c:forEach var="date" items="${dateRange}">
			<c:forEach var="period" items="${periodList}">
				<th class="period">
					${period.codename}
				</th>
			</c:forEach>
		</c:forEach>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="pilot" items="${resultList}">
		<tr style="cursor:pointer; " onClick="showStatusDialog('${pilot.pilot_sn}')">
			<td align="center" >
				${pilot.pilot_rankname }	
			</td>
			<c:forEach var="result" items="${pilot.resultByDateAndPeriodList}">
				<td class="<c:choose>
					<c:when test="${result eq '01' }">green</c:when>
					<c:when test="${result eq '02' }">yellow</c:when>
					<c:when test="${result eq '03' }">orange</c:when>
				</c:choose>"></td>
			</c:forEach>
		</tr>
	</tbody>
	</c:forEach>
</table>
</div>
<div id="diagnosisStatusDialog" class="dialog">
</div>