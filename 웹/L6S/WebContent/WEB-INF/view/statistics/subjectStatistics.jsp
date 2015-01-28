<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="<c:url value='/rmate/config/AC_OETags.js'/>"></script>
<script src="<c:url value='/rmate/config/rMateChart.js'/>"></script>
<!--rMate Chart 라이선스 등록 완료 모습 -->
<script src="<c:url value='/rmate/config/rMateChartLicense.js'/>"></script>
 
<script>

//차트 레이아웂 URL 경로를 설정하십시오.
var fieldGraphLayoutURL = encodeURIComponent("<c:url value="/rmate/FieldGraphLayout.xml"/>");
var fieldGraphFlashVars = "layoutURL="+fieldGraphLayoutURL;

// 차트 데이타 URL 경로를 설정하십시오.
var fieldGraphDataURL =encodeURIComponent("<c:url value="/rmate/FieldGraphData.jsp"/>?year="+'${param.year}');
fieldGraphFlashVars += "&dataURL="+fieldGraphDataURL;

//차트 레이아웂 URL 경로를 설정하십시오.
var sosokGraphLayoutURL = encodeURIComponent("<c:url value="/rmate/SosokGraphLayout.xml"/>");
var sosokGraphFlashVars = "layoutURL="+sosokGraphLayoutURL;

// 차트 데이타 URL 경로를 설정하십시오.
var sosokGraphDataURL =encodeURIComponent("<c:url value="/rmate/SosokGraphData.jsp"/>?year="+'${param.year}');
sosokGraphFlashVars += "&dataURL="+sosokGraphDataURL;

window.onload = function() {
	// rMateChart 초기화
	rMateChartInit();
};
</script> 
<!-- 사용자 정의 설정 끝 --> 

<script>
	$(document).ready(function(){
		$('#selectYear').change(function(){
			var frm = document.forms['searchFilter'];
			frm.action='subjectStatistics.do';
			frm.submit();
		});
	});	
</script>
<center>
	<h1 class="assignment_result_title">과제 현황</h1>
</center>

<form:form commandName="searchFilter">
	<form:select id="selectYear" path="year" cssClass="beltStatistics_year input_select_base_style">
		<c:forEach varStatus="loop" begin="0" end="10">
			<form:option value="${searchFilter.year-6+loop.count}"><c:out value="${searchFilter.year-6+loop.count}"/>년</form:option>
		</c:forEach>
	</form:select>
</form:form>

<center>
	<h2 class="assignment_result_title2"> 단계 및 등급별 과제 현황 </h2>
	<table class="statistics_subjectTable">
		<tr>
			<th rowspan="2">과제<br>현황</th><th>등록서</th><th>D 단계</th><th>M 단계</th><th>A 단계</th><th>I 단계</th><th>C 단계</th><th>완료</th>
			<th rowspan="2">과제<br>구분</th><th>Big-Y</th><th>BB</th><th>GB</th><th>SSS</th><th style="width: 0.5%;background-color: white;"></th><th>합계</th>
		</tr>
		<tr>
			<td>${section_count.BIGY.subject_count+section_count.BB.subject_count+section_count.GB.subject_count+section_count.SSS.subject_count
			-step_count.D.fnd_count}</td>
			<td><%-- ${step_count.D.fnd_count} --%>${step_count.D.fnd_count-step_count.M.fnd_count}</td> 
			<td><%-- ${step_count.M.fnd_count} --%>${step_count.M.fnd_count-step_count.A.fnd_count}</td>
			<td><%-- ${step_count.A.fnd_count} --%>${step_count.A.fnd_count-step_count.I.fnd_count}</td>
			<td><%-- ${step_count.I.fnd_count} --%>${step_count.I.fnd_count-step_count.C.fnd_count}</td>
			<td><%-- ${step_count.C.fnd_count} --%>${step_count.C.fnd_count-finishCount}</td>
			<td>${finishCount -0}</td>
			<td>${section_count.BIGY.subject_count-0}</td>
			<td>${section_count.BB.subject_count-0}</td>
			<td>${section_count.GB.subject_count-0}</td>
			<td>${section_count.SSS.subject_count-0}</td>
			<td style="width: 0.5%;"> </td>
			<td ><b>${section_count.BIGY.subject_count+section_count.BB.subject_count+section_count.GB.subject_count+section_count.SSS.subject_count}</b></td>
		</tr>
	</table>
	
	<h2 class="assignment_result_title3"> 부대 및 분야별 등록 현황 </h2>
	<script>
		// 차트를 생성하고자 하는 위치에서 다음과 같이 함수 호춗하십시오.
		// 파라메터 설명(순서대로)
		// 1. ID (임의로 정의하십시오)
		// 2. swf 파일 URL(확장자는 생략)
		// 3. URL 경로 등을 정의한 변수명.
		// 4. 차트 가로 사이즈.
		// 5. 차트 세로 사이즈.
		// 6. 차트 배경색.
		rMateChartCreate("chart2","<c:url value="/rmate/config/rMateChart"/>",sosokGraphFlashVars, 905, 180, "#FFFFFF");
	</script>
	<br/><br/>
	<script>
		// 차트를 생성하고자 하는 위치에서 다음과 같이 함수 호춗하십시오.
		// 파라메터 설명(순서대로)
		// 1. ID (임의로 정의하십시오)
		// 2. swf 파일 URL(확장자는 생략)
		// 3. URL 경로 등을 정의한 변수명.
		// 4. 차트 가로 사이즈.
		// 5. 차트 세로 사이즈.
		// 6. 차트 배경색.
		rMateChartCreate("chart1","<c:url value="/rmate/config/rMateChart"/>",fieldGraphFlashVars, 905, 180, "#FFFFFF");
	</script>
</center>