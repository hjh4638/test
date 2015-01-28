<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="java.util.*" %>
<%@page import="mil.af.L6S.component.subject.SubjectVO"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page	import="mil.af.common.util.UploadAndDownloadUtil"%>
<%
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(
		request.getSession().getServletContext());
UploadAndDownloadUtil upAndDown = context.getBean(UploadAndDownloadUtil.class);
String accept_type = upAndDown.getAccept_type();
%>

<c:set var="accept_type" value="<%=accept_type %>"/>

<style>

table,tr,td,th{
	border-color: #dedee0;
	border: 1px soild #dedee0;
}
</style> 
<script>
$(function(){
	$(".readonly").attr("readonly","readonly");
// 	$("th").css("color","#008bc8");
	
});
/* 수정버튼 취소버튼 로직 */
$(function(){
	$("input#modifybutton").click(function(){
		$("#subject_modify").show();
		$("table.printtable").hide();
		$("input#cancelbutton").show();
		$("input#modifybutton").hide();
		$("form#approval").hide();
	});
	$("input#cancelbutton").click(function(){
		$("#subject_modify").hide();
		$("table.printtable").show();
		$("input#cancelbutton").hide();
		$("input#modifybutton").show();
	});
	
});	
</script>
<!-- 결제 완료 되고 추가예정 -->
<script>
function goToStep(step){
	var seq = '${param.seq}';
	if(step=="과제등록서")
	location.href="<c:url value="detailSubjectList.do"/>?seq="+seq;
	if(step=="D단계")
	location.href="<c:url value="stage/stage_d.do"/>?seq="+seq;
	if(step=="M단계")
	location.href="<c:url value="stage/stage_m.do"/>?seq="+seq;
	if(step=="A단계")
	location.href="<c:url value="stage/stage_a.do"/>?seq="+seq;
	if(step=="I단계")
	location.href="<c:url value="stage/stage_i.do"/>?seq="+seq;
	if(step=="C단계")
	location.href="<c:url value="stage/stage_c.do"/>?seq="+seq;
	if(step=="완료보고서")
	location.href="<c:url value="stage/stage_e.do"/>?seq="+seq;				
}
function openPrint(type){
	var code = type;
	openPopup("<c:url value='/subject/popup/popupPrint.do?type='/>"+code,900,900);
}
</script> 
<center>
	<c:if test="${isApproved eq 0 && finishApp eq 'Y'}"> 
		<ul class="btn_menu"> 
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 1}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 2}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 3}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 4}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li><a href="#" class="dinamicStep_C" onclick="goToStep('C단계')" onfocus="blur();">C단계</a></li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 5}"> 
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li><a href="#" class="dinamicStep_C" onclick="goToStep('C단계')" onfocus="blur();">C단계</a></li>
			<li><a href="#" class="dinamicStep_E" onclick="goToStep('완료보고서')" onfocus="blur();">완료보고서</a></li>
			<li><h1 class="dinamicStep_Bar"></h1></li>
		</ul>
	</c:if>

<h1 class="assignment_detail_title" style="margin-left: 13px;"></h1>
<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('s')">
<c:if test="${stepAppInfo.orderName ne null}">
 <a style="float:right; margin-right: 60px;">※${stepAppInfo.orderName}가 결재대기 중입니다.</a>
</c:if>
<c:if test="${endAppInfo.orderName ne null}">
 <a style="float:right; margin-right: 60px;">※완료보고서가 결재대기 중입니다.</a>
</c:if>

<%-- [${isRegistered}][${right.app_right.is_approval}] --%>
<!-- 결재 등록 안된때만 수정 가능 -->
<c:if test="${isRegistered eq 'N'}">
	<form action="<c:url value="/subject/expireSubject.do"/>">
		<input type="hidden" name="seq" value="${param.seq }">
<!-- 		<ul style="width: 300px; border:1px solid black;"> -->
<!-- 			<li style="width: 60px; float: left; border:1px solid red;"> -->
				<input style="margin-right:30px; float:right;" type="image" src="<c:url value="/images/button/delete.gif"/>" onclick="submit()">
<!-- 			</li>  -->
<!-- 		</ul> -->
	</form>
<!-- 			<li style="width: 120px; border:1px solid blue;"> -->
<%-- 			<a href="#" id="modifybutton" ><img src="<c:url value="/images/button/modify.gif"/>"></a> --%>
				<input style="float:right;"id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 				<input style="float:right;display: none;" onclick="history.go(0)" id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
<!-- 			</li> -->
</c:if>



<table class="assignmentstage_table printtable print">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">
		과제명
		</th>
		<td class="left_align_text" colspan="3">
		<c:out value="${mainSubject.project_name}"/>
		</td>
	</tr>
	<tr>
		<th width="15%" bgcolor="#f7f7f7">
		팀명
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.team_name}"/>
		</td>
		<th width="15%" bgcolor="#f7f7f7">
		리더
		</th>
		<td class="left_align_text" width="35%">
		<c:out value="${mainSubject.leader}" />
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		소속
		</th>
		<td class="left_align_text" width="35%">
		<c:out value="${mainSubject.sosokname}"/>
		</td>
		<th width="15%" bgcolor="#f7f7f7">
		부대담당자
		</th>
		<td class="left_align_text" width="35%" id="guide_committee">
		<c:out value="${mainSubject.guide_committee}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		성과구분
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.result_section}"/>
		</td>
		<th bgcolor="#f7f7f7">
		부서장
		</th>
		<td class="left_align_text" id="department_chairman">
		<c:out value="${mainSubject.department_chairman}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		분야별 유형
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.field_type}"/>
		</td>
		<th bgcolor="#f7f7f7">
		챔피언
		</th>
		<td class="left_align_text" id="champion">
		<c:out value="${mainSubject.champion}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		과제 구분
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.subject_section}"/>
		</td>
		<th bgcolor="#f7f7f7">
		과제유형
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.subject_type}"/>
		</td>
	</tr>
	 <tr>
		<th bgcolor="#f7f7f7">
		현실태<br>및 문제점
		</th>
		<td colspan="3" align="left">
		<textarea  class="fixed_text" readonly="readonly" name="problem" id="problem" rows="7" cols="72"><c:out value="${mainSubject.problem}"/></textarea>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		개선사항
		</th>
		<td colspan="3" align="left">
		<textarea class="fixed_text" readonly="readonly" name="advance" id="advance" rows="7" cols="72" ><c:out value="${mainSubject.advance}"/></textarea>
		</td>
	</tr> 
 	<tr>
		<th bgcolor="#f7f7f7">
		과제등록서
		</th>
		<td colspan="3">
		<c:if test="${mainSubject.filename ne null }">
		<form action="download.do">
			<input type="hidden" name="filename" value="<c:out value="${mainSubject.filename }"/>">
			<p><a href="#" onclick="$(this).parent().parent().submit()">
			<c:out value="${mainSubject.filename }"/></a></p>
		</form>
		</c:if>
		</td>
	</tr>  
</table>
 
<table class="stage_date_table printtable print"> 
	<tr>
		<th width="151" rowspan="2" bgcolor="#f7f7f7">
		과제 추진계획<br>
		(완료예정일)
		</th>
		<th width="115" bgcolor="#f7f7f7">
		Define
		</th>
		<th width="115" bgcolor="#f7f7f7">
		Measure
		</th>
		<th width="115" bgcolor="#f7f7f7">
		Analyze
		</th>
		<th width="115" bgcolor="#f7f7f7">
		Improve
		</th>
		<th width="115" bgcolor="#f7f7f7">
		Control
		</th>
	</tr> 
	<tr>
		<td>
		<c:out value="${mainSubject.plan_map.begin_d}"/><br>~<br><c:out value="${mainSubject.plan_map.end_d}"/>
		</td>
		<td>
		<c:out value="${mainSubject.plan_map.begin_m}"/><br>~<br><c:out value="${mainSubject.plan_map.end_m}"/>
		</td>
		<td>
		<c:out value="${mainSubject.plan_map.begin_a}"/><br>~<br><c:out value="${mainSubject.plan_map.end_a }"/>
		</td>
		<td>
		<c:out value="${mainSubject.plan_map.begin_i}"/><br>~<br><c:out value="${mainSubject.plan_map.end_i}"/>
		</td>
		<td>
		<c:out value="${mainSubject.plan_map.begin_c}"/><br>~<br><c:out value="${mainSubject.plan_map.end_c}"/>
		</td>
	</tr>
	
</table>
</center>
<center id="subject_modify" style="display: none;" >
<jsp:include page="subjectRegister_modify.jsp"></jsp:include>
</center>

<!-- 해당 과제에 결재권이 있을시 -->
<center>
	<c:if test="${right.app_right.is_approval eq 'Y' }">
		<center>
		<ul class="appMenu">
			<a href="#" onclick="openPop(1);" onfocus="blur();" ><li class="approval_btn"></li></a>
			<a href="#" onclick="openPop(2);" onfocus="blur();" ><li class="disapproval_btn"></li></a>
		</ul>
		</center>
	</c:if>
	<div id="dialog" title="결재자 의견" style="width: 50px; display: none;">
		<form id="approvalForm" action="<c:url value="/approval_line/approvalSubject.do"/>" method="POST">
			<textarea cols="48" rows="8" name="comment"></textarea>
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="S">
			<!-- 공본담당자일때 접수도 동시에 진행 -->
			<c:if test="${(right.app_order eq 6 || right.app_order eq 2 || right.app_order eq 4)}">
				<img src="<c:url value="../images/button/btn_setapp.gif"/>" onclick="openApproval()">
				<input type="text"  id="app_view" readonly="readonly">
				<input type="hidden" id="app_rank" name="app_rank" >
				<input type="hidden" id="app_name" name="app_name" >
				<input type="hidden" id="app_ass"  name="app_ass" >
				<input type="hidden" id="app_sn" name="app_sn" >
			</c:if>
		</form>
	</div>
	<div id="dialog2" title="결재자 의견" style="width: 50px; display: none;">
		<form id="approvalForm2" action="<c:url value="/approval_line/approvalSubject.do"/>" method="POST">
		<textarea cols="48" rows="8" name="comment"></textarea>
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="S">
			<!-- 공본담당자일때 접수도 동시에 진행 -->
		</form>
	</div>
		<c:if test="${isRegistered eq 'N'}">
			<form id="approval" action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
				<img src="<c:url value="/images/button/btn_setapp.gif"/>" onclick="openApproval()">
				<input type="text"  id="app_view" readonly="readonly">
				<input type="hidden" id="app_rank" name="app_rank" >
				<input type="hidden" id="app_name" name="app_name" >
				<input type="hidden" id="app_ass"  name="app_ass" >
				<input type="hidden" id="app_sn" name="app_sn" >
				<input type="hidden" name="seq" value="${param.seq}">
				<input type="hidden" name="app_type" value="S">
				<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
			</form>
		</c:if>
</center>
<script>
/* 접수기능 */
function openApproval(){
		openPopup("<c:url value="/approval_line/app/flash.do"/>",900,700);
}
/* dialog */
$(function(){
	$('#dialog').dialog({
		autoOpen: false
	});
});
$(function(){
	$('#dialog2').dialog({
		autoOpen: false
	});
});
function openPop(code){
	if(code == 1){
		$('#dialog').dialog('open');
		$('#dialog').dialog({
			autoOpen: false,
			width: 330,
			buttons: {
				"결재": function() { 
					if($("#app_sn").val()!=""){
						$("#approvalForm")
						.attr("action","<c:url value="/approval_line/approvalSubject.do"/>")
						.attr("method","POST").submit();
						$(this).dialog("close");
					}else{
						alert("결재자가 지정 되지 않았습니다.");
					}
				},
				"취소": function(){
					$(this).dialog("close"); 
				}
			}
		});
	}else if(code == 2){
		$('#dialog2').dialog('open');
		$('#dialog2').dialog({
			autoOpen: false,
			width: 330,
			buttons: {
				"기각": function() { 
					$("#approvalForm2")
					.attr("action","<c:url value="/approval_line/disapprovalSubject.do"/>")
					.attr("method","POST").submit();
					$(this).dialog("close"); 
				},
				"취소": function(){
					$(this).dialog("close"); 
				}
			}
		});
	}
}
</script>
<center>
<!-- 	<input type="text" name="approval"> -->
<%-- 	<input type="image" src="<c:url value="/images/button/search.gif"/>" onclick="submit"> --%>
<!-- 	<a href="#">결제상신</a> -->
</center>	
<jsp:include page="subjectRegister_js.jsp"></jsp:include>
