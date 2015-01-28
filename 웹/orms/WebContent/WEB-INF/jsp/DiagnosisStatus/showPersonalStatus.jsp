<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	#statusDiv{
  		width:100%;
		height:95%;		
	}

	#statusDiv th{
		background: #C18C96;
		color:#FFFFFF;
		border:1px solid #FFFFFF;
 	}

	#statusDiv table{
		border:1px solid #C18C96;
	}
	#statusTools{
		text-align: center;
	}
 
 	body{
		width:95%;
	}

	#printButton{
		background:url("${cp}/images/button/print_button.gif");
		background-repeat:no-repeat;
		width:60px;
		height:22px;
		border:0;
		cursor:pointer;
	}
	#saveButton{
		background:url("${cp}/images/button/save_button.gif");
		background-repeat:no-repeat;
		width:60px;
		height:22px;
		border:0;
		cursor:pointer;
	}
	#closeButton{
		background:url("${cp}/images/button/close_button.gif");
		background-repeat:no-repeat;
		width:60px;
		height:22px;
		border:0;
		cursor:pointer;
	}
</style>
<script>
var resultDialog;
$(function(){
	resultDialog=createDialog('#diagnosisResultDialog','',true,700,750);
});
function showResultDialog(seq){
	$("#diagnosisResultDialog").empty();
	$("#diagnosisResultDialog").append("<iframe id='diagnosisResultIframe' src='${cp}/DiagnosisResult/view/showPersonalDiagnosisResult.do?scheduleSeq="+seq+"'></iframe>");
	resultDialog.dialog("open");
}
</script>
<div id="statusDiv">
	<table width="100%">
		<tr>
			<th>계급/성명</th>
			<td>${pilot.rankname } ${pilot.name }</td>
			<th>소속</th>
			<td>${pilot.intrasosokname }</td>
			<td><input type="button" id="printButton" onClick="print()"/>
			<!-- input type="button" id="saveButton"/-->
			<input type="button" id="closeButton" onClick="parent.statusDialog.dialog('close');"/></td>
		</tr>
	</table>
	<div id="resultDiv" style="margin-top:10px;">
<table border="1" id="resultListTable">
	<thead>
		<tr>
			<th colspan="6">구분</th>
			<c:forEach var="headQuestion" items="${questionTree}">
			<th colspan="${headQuestion.childrenSize }">${headQuestion.question_name }</th>
			</c:forEach>
			<th rowspan="2" class="branchQuestion">조치기준</th>
			<th rowspan="2" class="branchQuestion">비행여부</th>
			<th rowspan="2" class="branchQuestion" >확인</th>
		</tr>
		<tr align="center">
			<td class="branchQuestion">순번</td>
			<td class="branchQuestion" style="width:130px">날짜</td>
			<td class="branchQuestion">시간대</td>
			<td class="branchQuestion">C/S</td>
			<td class="branchQuestion">조종위치</td>
			<td class="branchQuestion">비행자격</td>
			<c:set var="tdCount" value="10"/>
			<c:forEach var="headQuestion" items="${questionTree}">
				<c:forEach var="branchQuestion" items="${headQuestion.children}">
					<td class="branchQuestion">${branchQuestion.question_name }</td>
					<c:set var="tdCount" value="${tdCount+1}"/>
				</c:forEach>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:set var="scheduleCount" value="0"/>
		<c:forEach var="schedule" items="${scheduleList}" varStatus="i">
		<tr  onClick="showResultDialog('${schedule.seq}')" style="cursor:pointer">
			<td class="branchQuestion">${i.index+1 }</td>
			<td class="branchQuestion" style="width:130px;">${schedule.formedFlightDate }</td>
			<td class="branchQuestion">${schedule.period_codename }</td>
			<td class="branchQuestion">${schedule.cs }</td>
			<td class="branchQuestion">${schedule.position_codename }</td>
			<td class="branchQuestion">${schedule.section_codename }</td>
			<c:forEach var="scoreVO" items="${schedule.scoreList}">
				<td class="branchQuestion ${scoreVO.color }">${scoreVO.score }</td>
			</c:forEach>
			<td class="branchQuestion ${schedule.resultColor }">${schedule.totalScore }</td>
			<c:choose>
					<c:when test="${schedule.confirm_result_fix eq '1' or schedule.result eq '01'}"><td class="branchQuestion green">비행</td></c:when>
					<c:when test="${schedule.confirm_result_fix eq '2'}"><td class="branchQuestion orange">비행취소</td></c:when>
					<c:otherwise><td class="branchQuestion">대기</td></c:otherwise>
			</c:choose>
			<td class="branchQuestion"><c:choose>
					<c:when test="${ schedule.result eq '01'}">확인</c:when>
					<c:when test="${schedule.confirm_sosokcode ne null }">${schedule.confirm_sosokcode}</c:when>
					<c:otherwise>대기</c:otherwise>
			</c:choose></td>
		</tr>
		<c:set var="scheduleCount" value="${scheduleCount+1 }"/>
		</c:forEach>
		<c:if test="${scheduleCount eq 0}">
		<tr align="center">
			<td colspan="${tdCount }" height="50px">작성된 진단결과가 없습니다.</td>
		</tr>
		</c:if>
	</tbody>
</table>
</div>
</div>
<div id="diagnosisResultDialog" class="dialog">
	<iframe id="diagnosisResultIframe" src="" style="width:100%;height:100%"></iframe>
</div>
