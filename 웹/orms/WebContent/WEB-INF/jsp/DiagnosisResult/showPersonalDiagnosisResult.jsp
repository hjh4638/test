<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	#scheduleInfo {
		border:1px solid #C18C96;
	}
	#scheduleInfo th{
		background: #C18C96;
		height:30px;
		color:#FFFFFF;
	}
 	#result_buttons{
		margin-top:10px;
		text-align: center;
	}
	#answerTable{
		border:1px solid #C18C96;
 		margin-top:5px;
 	}
	#answerTable th{
		border:1px solid #ffffff;
 		margin-top:5px;
		color:#FFFFFF;
	}
	#answerTable td{
		border:1px solid #C18C96;
 		margin-top:5px;
	}
	#confirmTable{
		border:1px solid #C18C96;
		margin-top:5px;
 	}
	#confirmTable th{
		border:1px solid #C18C96;
		height:40px;
		text-align:center;
		color:#FFFFFF;
	}
	#confirmTable td{
		border:1px solid #C18C96;
 		margin-top:5px;
	}
	#confirm_time{
		font-size:11px;
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
	#confirmButton{
		background:url("${cp}/images/button/confirm_button.gif");
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
var confirmResultDialog;
var isConfirm=false;
$(function(){
	confirmResultDialog=createDialog('#confirmResultDialog','진단표 확인을 진행합니다.',true,350,250);

});
function openConfirmResultDialog(){
	/* var confirm_result_fix='${schedule.confirm_result_fix}';
	if(confirm_result_fix==''){ */
		confirmResultDialog.dialog("open");
	/* }else{
		alertMessage("알림","이미 확인 하셨습니다.");
	} */
}
function closeParentDialog(){
	parent.resultDialog.dialog("close");
	if(isConfirm==true){
		parent.location.reload();
	}
}
function doConfirm(){
	var scheduleId='${schedule.seq}';
	var result='${schedule.result}';
	var confirmResult=$("#confirmResult").val();
	var confirmOpinion=$("#confirmOpinion").val();
	if(validateConfirmResult(result,confirmResult,confirmOpinion)){
		$.ajax({
			url:		'/orms/DiagnosisResult/confirmSchedule.do',
			type:		'POST',
			dataType:	'json',
	 		data: {
		 		scheduleId:scheduleId,
		 		confirmResult:confirmResult,
		 		confirmOpinion:confirmOpinion
	 		},
	 		success:function(data){
	 			if(data=='Success'){
	 				confirmResultDialog.dialog("close");
	 				var confirmText='대기';
	 				if(confirmResult=='1'){
		 				confirmText='비행';
	 				}else if(confirmResult=='2'){
		 				confirmText='비행취소';
	 				}
	 				$("#confirm_result_fix").html(confirmText);
	 				isConfirm=true;
	 				$("#confirmTable .opinion").html(confirmOpinion);
	 				$("#confirmTable").fadeIn(500);
	 			}else{
		 			alert(data);
	 			}
	 		}
		});
	}
	
}
function validateConfirmResult(result,confirmResult,confirmOpinion){
	if(confirmOpinion!=''){
		return true;
	}else{
		if((result=='01'||result=='02')&&confirmResult=='1'){
			return true;
		}else if((result=='01'||result=='02')&&confirmResult=='2'){
			alert('해당결과를 비행취소 조치시에는 반드시 의견을 입력하셔야 합니다.');
			return false;
		}else if(result=='03'){
			alert('진단결과가 "비행취소 고려"인 스케쥴은 반드시 의견을 입력하셔야합니다.');
			return false;
		}else{
			return false;
		}
	}
}
</script>
<table width="100%" border="1" id="scheduleInfo">
	<thead>
		<tr>
			<th>편대</th>
			<th>비행날짜</th>
			<th>시간대</th>
			<th>계급/성명</th>
			<th>C/S</th>
			<th>조종위치</th>
			<th>총점</th>
			<th width="50px">확인</th>
		</tr>
	</thead>
	<tbody>
		<tr align="center" height="40px" border=1 bordercolor="#C18C96">
			<td>${schedule.unit_codename }</td>
			<td>${schedule.flight_date }</td>
			<td>${schedule.period_codename }</td>
			<td>${schedule.rankname }</td>
			<td>${schedule.cs }</td>
			<td>${schedule.position_codename }</td>
			<td class="${schedule.resultColor }" style="font-weight:bold">
				${schedule.initial_color }
			</td>
			<c:choose>
				<c:when test="${schedule.confirm_result_fix eq '1' or schedule.result eq '01'}">
					<td id="confirm_result_fix" class="green" >비행</td>
				</c:when>
				<c:when test="${schedule.confirm_result_fix eq '2'}">
					<td id="confirm_result_fix"	class="orange">비행취소</td>
				</c:when>
				<c:otherwise><td>대기</td></c:otherwise>
			</c:choose>
		</tr>
	</tbody>
</table>

<c:set var="answerCount" value="1"/>

<table width="100%" border="1" id="answerTable">
	<c:forEach var="question" items="${questionTree }">
		<c:forEach var="child1" items="${question.children }" varStatus="a">
			 <c:forEach var="child2" items="${child1.children }" varStatus="b">
			 	<c:forEach var="child3" items="${child2.children }" varStatus="c">
					<c:forEach var="child4" items="${child3.children }">
					<c:if test="${child4.id eq schedule.scoreList[0].id }">
						<tr align="center">
							<c:if test="${a.index eq '0'}">
							<th style="background:#C18C96;font-weight:bold" width="180px;" rowspan="${question.childrenSize }" bordercolor="#ffffff">${question.question_name }</th>
							</c:if>
							<td width="105px"  height="18px">${child1.question_name }</td>
							<td width="105px"  >${child2.question_name }</td>
							<td width="105px" >${child3.question_name }</td>
							<td width="105px"  >${child4.question_name }</td>
							<td width="50px" class="${schedule.scoreList[0].color }">
							${schedule.scoreList[0].initial_color }
							</td>
										
						</tr>
					</c:if>
					</c:forEach>
				<!--2013.1.3 임무관리 한번 더 가져오는 오류 수정  -->
				<c:if test="${child3.question_yn eq 'Y' and child3.id eq schedule.scoreList[0].id
								and child1.id ne 3200}">
					<tr align="center">
						<c:if test="${a.index eq '0'}">
							<th style="background:#C18C96;font-weight:bold" width="180px;" rowspan="${question.childrenSize }" bordercolor="#ffffff">${question.question_name }</th>
						</c:if>
						<td width="120px" height="18px">${child1.question_name }</td>
						<td width="120px">${child2.question_name }</td>
						<td  colspan="2">${child3.question_name }</td>
						<td width="50px" class="${schedule.scoreList[0].color }">
						${schedule.scoreList[0].initial_color }
						</td>
					</tr>
				</c:if>
				</c:forEach>
			</c:forEach>
		 	<!--***************************************************************************************  -->
<%-- 		 	 <c:if test="${(child1.id ne 126) and (child1.id ne 128) and (child1.id ne 179) and (child1.id ne 230 )}">  --%>
<%-- 			 <c:if test="${child1.id eq 505 or child1.id eq 617 or child1.id eq 727}"> --%>
<%-- 			 <c:set var="answerCount" value="0"/> --%>
<%-- 			 </c:if> --%>


<%--교육훈련기/특수임무기 확대 12.10.11--%>
		 
			 <c:if test="${(child1.id ne 126) and (child1.id ne 128) and (child1.id ne 179) and (child1.id ne 230 )}"> 
			 <c:if test="${child1.id eq 505 or child1.id eq 617 or child1.id eq 727 or child1.id eq 1005 
			 or child1.id eq 1205 or child1.id eq 1405 or child1.id eq 1605 or child1.id eq 1805 or child1.id eq 2005 
			 or child1.id eq 2205 or child1.id eq 2400 or child1.id eq 2600 or child1.id eq 2805 or child1.id eq 3005 
			 or child1.id eq 3200 or child1.id eq 3405 or child1.id eq 3605 or child1.id eq 3805 or child1.id eq 4005 
			 or child1.id eq 4201 or child1.id eq 4405}">
			 <c:set var="answerCount" value="0"/>
			 </c:if>		 
			<!--***************************************************************************************  -->
			<tr align="center">
				<c:if test="${a.index eq '0'}">
					<th style="background:#C18C96;font-weight:bold" width="180px;" rowspan="${question.childrenSize }" bordercolor="#ffffff">${question.question_name }</th>
				</c:if>
				<td colspan="2" height="18px">${child1.question_name }</td>
				<td colspan="2">${schedule.scoreList[answerCount].question_name } </td>
				<td width="50px" class="${schedule.scoreList[answerCount].color }">
				${schedule.scoreList[answerCount].initial_color }
				</td>
				<c:set var="answerCount" value="${answerCount+1}"/>
			</tr>
			 </c:if> 
		</c:forEach>
	</c:forEach> 
	
	<%--  <table width="100%" border="1" id="answerTable"> 
	< <c:set var="answerCount" value="0"/>
	<c:forEach var="question" items="${questionTree}">
		
		<c:forEach var="child1" items="${question.children}" varStatus="i">
			<tr align="center">
				<c:if test="${i.index eq '0'}">
					<th style="background:#C18C96;font-weight:bold" width="180px;" rowspan="${question.childrenSize }" bordercolor="#ffffff">
						${question.question_name }
					</th>
				</c:if>
				<c:if test="${answerCount ne 0 }">
					<td height="18px">${child1.question_name }</td>
				</c:if>
				
				<td height="18px">${schedule.scoreList[answerCount].question_name }${answerCount }</td>
				<td width="50px" class="${schedule.scoreList[answerCount].color }">${schedule.scoreList[answerCount].score }</td>
				<c:set var="answerCount" value="${answerCount+1}"/>
			</tr>
		</c:forEach>
		
	</c:forEach>  
	이한솔병장(님) 코딩
	--%>
</table> 
<table width="100%" border="1" id="confirmTable" <c:if test="${schedule.confirm_result_fix eq null }">class="hidden"</c:if>>
	<tr>
		<th width="180px" style="background:#C18C96;font-weight:bold">확인 의견</th>
		<td class="opinion">${schedule.confirm_opinion } <span id="confirm_time">[${schedule.confirm_time }]</span></td>
	</tr>
</table>
<div id="result_buttons" >
<c:if test="${UserVO.role ne 'NORMAL' and UserVO.role ne 'CQ'}">
	<input type="button" id="printButton" onClick="print()"/> <!-- input type="button" id="saveButton"/-->
</c:if>
<!-- 2012.5.9 일병 함준혁 -->
<c:if test="${UserVO.role eq 'SQUADRONMANAGER' and schedule.result ne '01' and (dateToCompare eq today or schedule.confirm_time eq null)}">
	<input type="button" id="confirmButton" onClick="openConfirmResultDialog()"/>
</c:if>
<input type="button" id="closeButton" onClick="closeParentDialog()"/>
</div>
<div id="confirmResultDialog" class="dialog">
	- 확인 결과 : 
	<select id="confirmResult" style="width:100px;">
		<option value="1" >비행</option>
		<option value="2" <c:if test="${schedule.result eq '03'}">selected="selected"</c:if>>비행취소</option>
	</select><br/><br/>
	- 의견을 작성해 주십시오<br/>
	<textarea id="confirmOpinion" style="width:95%;height:100px; ime-mode : active;"></textarea>
	<div id="confirmButtonDiv" style="text-align:center;width:100%">
		<input type="button" id="confirmButton" onClick="doConfirm()"/> <input type="button" id="closeButton" onClick="confirmResultDialog.dialog('close')"/>
	</div>
</div>