<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
table{
	border:1px solid black;
	border-collapse: collapse;
	border-spacing: 0;
	margin-top: 20px;
	margin-left:50px; 
	width:700px;
	text-align: center;
}
th{
	height:20px;
	border:1px solid black;
}
tr{
	height:30px;
	
}
td{
	border:1px solid black;
} 
.readonly{
	border:0px;
}
</style>
<script>
$(function(){
	$(".readonly").attr("readonly","readonly");
})
</script>
<script>
function goToStep(th){
	var seq = '${param.seq}';
	var step = $(th).val();
	if(step=="S")
	location.href="<c:url value="detailSubjectList.do"/>?seq="+seq;
	if(step=="D")
	location.href="<c:url value="stage/stage_d.do"/>?seq="+seq;
	if(step=="M")
	location.href="<c:url value="stage/stage_m.do"/>?seq="+seq;
	if(step=="A")
	location.href="<c:url value="stage/stage_a.do"/>?seq="+seq;
	if(step=="I")
	location.href="<c:url value="stage/stage_i.do"/>?seq="+seq;
	if(step=="C")
	location.href="<c:url value="stage/stage_c.do"/>?seq="+seq;
	if(step=="E")
	location.href="<c:url value="stage/stage_e.do"/>?seq="+seq;
					
}
</script>
<script language="javascript">
	function openPop(){
		var url = 'detailSubjectListPrint.do';
		alert(url);
		openPopup(url, 850, 650);
	}  
</script> 
<center>
<input type="button" onclick="goToStep(this)" value="S">
<input type="button" onclick="goToStep(this)" value="D">
<input type="button" onclick="goToStep(this)" value="M">
<input type="button" onclick="goToStep(this)" value="A">
<input type="button" onclick="goToStep(this)" value="I">
<input type="button" onclick="goToStep(this)" value="C">
<input type="button" onclick="goToStep(this)" value="E">
</center>
<table>
	<tr>
		<td>
		프로젝트 명
		</td>
		<td colspan="5">
		<input value="${mainSubject.project_name}" class="readonly" id="project_name" name="project_name" type="text" maxlength="15" size="25">
		</td>
	</tr>
	<tr>
		<td>
		팀명
		</td>
		<td>
		<input value="${mainSubject.team_name}" class="readonly" id="team_name" name="team_name" type="text" maxlength="15" size="16">
		</td>
		<td>소속</td>
		<td  colspan="3"></td>
	</tr>
	<tr>
		<td>
		챔피언
		</td>
		<td id="champion">
		<input value="${mainSubject.champion}" class="readonly" id="champion" type="text" size="9" onclick="openSearchAdmin(this)" class="readonly">
		</td>
		<td>
		부서장
		</td>
		<td id="department_chairman">
		<input value="${mainSubject.department_chairman}" class="readonly" id="department_chairman" type="text" size="9" onclick="openSearchAdmin(this)" class="readonly">
		</td>
		<td>
		부대담당자
		</td>
		<td id="guide_committee">
		<input value="${mainSubject.guide_committee}" class="readonly" id="guide_committee" type="text" size="9" onclick="openSearchAdmin(this)" class="readonly">
		</td>
	</tr>
	<tr>
		<td>
		분야별 유형
		</td>
		<td colspan="2">
		${mainSubject.field_type}
		<%-- <select id="field_type" name="field_type">
			<option></option>
			<c:forEach var="field" items="${subjectFieldType}">
				<option>${field.title}</option>
			</c:forEach>	
		</select> --%>
		</td>
		<td>
		성과구분
		</td>
		<td colspan="2">
		${mainSubject.result_section}
		<%-- <select id="result_section" name="result_section">
			<option></option>
			<c:forEach var="result" items="${subjectResultSection}">
				<option>${result.title}</option>
			</c:forEach>	
		</select> --%>
		</td>
	</tr>
	<tr>
		<td>
		과제 구분
		</td>
		<td colspan="2">
		${mainSubject.subject_section}
		<%-- <select id="subject_section" name="subject_section">
			<option></option>
			<c:forEach var="sec" items="${subjectSectionItem}">
				<option>${sec.title}</option>
			</c:forEach>	
		</select> --%>
		</td>
		<td>
		과제유형
		</td>
		<td colspan="2">
		${mainSubject.subject_type}
		<%-- <select id="subject_type" name="subject_type">
			<option></option>
			<c:forEach var="type" items="${subjectTypeItem}">
				<option>${type.title}</option>
			</c:forEach>
		</select> --%>
		</td>
	</tr>
	 <tr>
		<td>
		현실태/<br>문제점
		</td>
		<td colspan="5" height="100px">
		<textarea class="readonly" name="problem" id="problem" rows="7" cols=60>${mainSubject.problem}</textarea>
		</td>
	</tr>
	<tr>
		<td>
		개선사항
		</td>
		<td colspan="5" height="100px">
		<textarea class="readonly" name="advance" id="advance" rows="5" cols="60" >${mainSubject.advance}</textarea>
		</td>
	</tr> 
 	<tr>
		<td>
		과제등록서
		</td>
		<td>
		<c:if test="${mainSubject.filename ne null }">
		<form action="download.do">
			<input type="text" name="filename" value="${mainSubject.filename }" class="readonly">
			<input type="submit" value="다운">
		</form>
		</c:if>
		</td>
	</tr>  
</table>
 
<table>
	<tr>
		<td rowspan="2">
		프로젝트 추진계획<br>
		(완료예정일)
		</td>
		<td>
		Define
		</td>
		<td>
		Measure
		</td>
		<td>
		Analyze
		</td>
		<td>
		Improve
		</td>
		<td>
		Control
		</td>
	</tr>
	<tr>
		<td>
		<input value="${mainSubject.plan_d}" class="readonly" size="10"> <!-- id="plan_d" name="plan_d" type="date" class="date"> -->
		</td>
		<td>
		<input value="${mainSubject.plan_m}" class="readonly" size="10"> <!-- id="plan_m" name="plan_a" type="date" class="date"> -->
		</td>
		<td>
		<input value="${mainSubject.plan_a}" class="readonly" size="10"> <!-- id="plan_a" name="plan_m" type="date" class="date"> -->
		</td>
		<td>
		<input value="${mainSubject.plan_i}" class="readonly" size="10"><!--  id="plan_i" name="plan_i" type="date" class="date"> -->
		</td>
		<td>
		<input value="${mainSubject.plan_c}" class="readonly" size="10"><!--  id="plan_c" name="plan_c" type="date" class="date"> -->
		</td>
	</tr>
</table> <br>
<center><input type="button" onclick="openPop()" value="출력창"></center>
