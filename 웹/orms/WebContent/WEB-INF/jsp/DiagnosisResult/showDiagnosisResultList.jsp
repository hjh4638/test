<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<script>
	var param_date='${param.scheduleDate}';
	var param_calendar=getDate(param_date);
	if(param_date==''){
		param_calendar=0;
	}	
	var printParam='${param.print}';
	$(function(){
		if(printParam!=''){
			$("#tools_buttons").hide();
			print();
		}
	});
	function printTable(){
		var scheduleDate=$("#scheduleDateVal").val();
		var unit=$("#unitList").val();
		window.open('${cp}/DiagnosisResult/view/showDiagnosisResultList.do?print=1&scheduleDate='+scheduleDate+'&unit='+unit,'valuationTable','width=800,height=700,resizable=yes,scrollbars=yes');
		
	}
	var resultDialog;
	$(function(){
		$("#scheduleDate").dateinput({trigger:true,format:'yyyy년 mm월 dd일'}).data("dateinput").setValue(param_calendar);
		var scheduleDate=$("#scheduleDate").val();
		scheduleDate=scheduleDate.replace("년 ","");
		scheduleDate=scheduleDate.replace("월 ","");
		scheduleDate=scheduleDate.replace("일","");
		$("#scheduleDateVal").val(scheduleDate);
		$("#scheduleDate").change(function() {
			//날짜 선택시
			submitResult();
		});

		resultDialog=createDialog('#diagnosisResultDialog','',true,700,800);
	});
	function showResultDialog(seq){
		$("#diagnosisResultDialog").empty();
		$("#diagnosisResultDialog").append("<iframe id='diagnosisResultIframe' src='${cp}/DiagnosisResult/view/showPersonalDiagnosisResult.do?scheduleSeq="+seq+"'></iframe>");
		resultDialog.dialog("open");
	}
	function submitResult(){
		var unit=$("#unitList").val();
		var scheduleDate=$("#scheduleDate").val();
		var period=$("#period").val();
		scheduleDate=scheduleDate.replace("년 ","");
		scheduleDate=scheduleDate.replace("월 ","");
		scheduleDate=scheduleDate.replace("일","");
		$("#scheduleDateVal").val(scheduleDate);
		location.href='${cp}/DiagnosisResult/showDiagnosisResultList.do?scheduleDate='+scheduleDate+'&unit='+unit+'&period='+period;
	}
	</script>
	

<img src="${cp }/images/title/showDiagnosisResultList.gif"/>

<div id="result_tools" style="float:right">
	<div id="tools_buttons" style="float:left"><a href="javascript:printTable()"><img src="${cp }/images/button/print_button.gif"/></a>
	<!-- a href="#"><img src="${cp }/images/button/filesave_button.gif"/></a--></div>
	<c:choose>
		<c:when test="${UserVO.role eq 'FORMATIONMANAGER' or UserVO.role eq 'SQUADRONMANAGER'}">
			<select id="unitList" onChange="submitResult()">
				<option value="">전체</option>
				<c:forEach var="unit" items="${unitList}">
				<option value="${unit.sosokcode }" <c:if test="${unit.sosokcode eq param.unit }">selected="selected"</c:if>>${unit.fullass }</option>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
		<input type="hidden" id="unitList" value=""/>
		</c:otherwise>
	</c:choose>
		<select id="period" onChange="submitResult()">
			<option value="">전체</option>
			<c:forEach var="period" items="${sys_period }">
			<option value="${period.code }"<c:if test="${period.code eq param.period }">selected="selected"</c:if>>${period.codename }</option>
			</c:forEach>
		</select>
	<input type="date" id="scheduleDate" class="date" >
	<input type="hidden" id="scheduleDateVal">
</div>
<div id="resultDiv" style="margin-top:50px;">
<table border="1" id="resultListTable">
	<thead>
		<tr>
			<th colspan="7">구분</th>
			<c:forEach var="headQuestion" items="${questionTree}">
			<c:if test="${headQuestion.question_name eq '임무별 기준' }"> 
			 <c:if test="${UserVO.airplane eq headQuestion.question_group }">
			<th colspan="${headQuestion.childrenSize }">${headQuestion.question_name }</th>
			</c:if> 
			</c:if>
			<c:if test="${headQuestion.question_name ne '임무별 기준' }">
			<th colspan="${headQuestion.childrenSize }">${headQuestion.question_name }</th>
			</c:if>
			</c:forEach>
			<th rowspan="2" class="branchQuestion">조치기준</th>
			<th rowspan="2" class="branchQuestion">비행여부</th>
			<th rowspan="2" class="branchQuestion">확인</th>
		</tr>
		<tr>
			<td class="branchQuestion">순번</td>
			<td class="branchQuestion" style="width:80px;padding:0px;">편대</td>
			<td class="branchQuestion">시간대</td>
			<td class="branchQuestion" style="width:60px;padding:0px;">이름</td>
			<td class="branchQuestion">C/S</td>
			<td class="branchQuestion">조종위치</td>
			<td class="branchQuestion">비행자격</td>
			<c:set var="tdCount" value="10"/>
			<c:forEach var="headQuestion" items="${questionTree}">
				<c:forEach var="branchQuestion" items="${headQuestion.children}">
					<c:if test="${headQuestion.question_name eq '임무별 기준' }"> 
					<c:if test="${branchQuestion.question_group eq UserVO.airplane }">
					<td class="branchQuestion">${branchQuestion.question_name }</td>
					<c:set var="tdCount" value="${tdCount+1}"/>
					</c:if>
					</c:if>
					<c:if test="${headQuestion.question_name ne '임무별 기준' }">
					<td class="branchQuestion">${branchQuestion.question_name }</td>
					<c:set var="tdCount" value="${tdCount+1}"/>
					</c:if>
				</c:forEach>
			</c:forEach>
		</tr>
	</thead>
	<tbody> 
		<c:set var="scheduleCount" value="0"/>
		<c:forEach var="schedule" items="${scheduleWithResult}" varStatus="i">
		<tr onClick="showResultDialog('${schedule.seq}')" style="cursor:pointer">
			<td class="branchQuestion">${i.index+1 }</td>
			<td class="branchQuestion" style="width:80px;padding:0px;">${schedule.unit_codename }</td>
			<td class="branchQuestion">${schedule.period_codename }</td>
			<td class="branchQuestion" style="width:70px;padding:0px;">${schedule.rankname }</td>
			<td class="branchQuestion">${schedule.cs }</td>
			<td class="branchQuestion">${schedule.position_codename }</td>
			<td class="branchQuestion">${schedule.section_codename }</td>
			<c:forEach var="scoreVO" items="${schedule.scoreList}">
				<td class="branchQuestion ${scoreVO.color }">${scoreVO.initial_color }
				</td>
			</c:forEach>
			<td class="branchQuestion ${schedule.resultColor }">${schedule.initial_color }</td>
			<c:choose>
					<c:when test="${schedule.confirm_result_fix eq '1' or schedule.result eq '01'}"><td class="branchQuestion green">비행</td></c:when>
					<c:when test="${schedule.confirm_result_fix eq '2'}"><td class="branchQuestion orange">비행취소</td></c:when>
					<c:otherwise><td class="branchQuestion">대기</td></c:otherwise>
			</c:choose>
			<td class="branchQuestion"><c:choose>
					<c:when test="${schedule.confirm_result_fix ne null or schedule.result eq '01'}">확인</c:when>
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
<div id="diagnosisResultDialog" class="dialog">
</div>