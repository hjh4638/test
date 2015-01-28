<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<%
	String code = request.getParameter("code");
%>

<style>
.hidden{
	display: none;
}
</style>


<script>
/* $(function(){
	$("#diagnosis_table_create_menu").mouseup(function(){
		$("#diagnosis_table_create_menu").toggleClass("hidden");
		$("#diagnosis_table_create_menu_over").toggleClass("hidden");
	});
	
	$("#diagnosis_table_create_menu").toggleClass("hidden");
	$("#diagnosis_table_create_menu_over").toggleClass("hidden"); 	
});
 */
 function rollOver(th){
	 alert("asdfa");
	 alert("<%=code%>");
 }
</script>

<div id="main_menu_user_info">
	<font color="#3D649F"><b>${UserVO.rankname } ${UserVO.name} 님</b></font><br/>
	${UserVO.intrasosokname }<br/>
	<c:choose>
		<c:when test="${UserVO.role eq 'NORMAL'}">조종사</c:when>
		<c:when test="${UserVO.role eq 'FORMATIONMANAGER'}">안전편대장</c:when>
		<c:when test="${UserVO.role eq 'SQUADRONMANAGER'}">비행대대장/대장</c:when>
		<c:when test="${UserVO.role eq 'GROUPMANAGER'}">단장/전대장</c:when>
		<c:when test="${UserVO.role eq 'CQ'}">대대CQ</c:when>
		<c:when test="${UserVO.role eq 'SYSTEMADMIN'}">시스템관리자</c:when>
		<c:when test="${UserVO.role eq 'SCHEDULEOFFICER' }">스케줄장교</c:when>
	</c:choose>

</div>
<table id="main_menu_table">
	<c:set var="role" value="${UserVO.role}"/>
	<c:if test="${role eq 'NORMAL' or role eq 'FORMATIONMANAGER' or role eq 'SQUADRONMANAGER' or role eq 'SCHEDULEOFFICER' }">
	<tr>	
		<td><a href="${cp }/DiagnosisTableCreate/showMyScheduleList.do?code=1"><img <%=("1".equals(code) ? "class=\"hidden\"" : "") %> id="diagnosis_table_create_menu" src="${cp }/images/menu/diagnosis_table_create_menu.gif"/></a><img <%=("1".equals(code) ? "" : "class=\"hidden\"") %> id="diagnosis_table_create_menu_over" src="${cp }/images/menu/diagnosis_table_create_menu_over.gif"/></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'NORMAL' or role eq 'FORMATIONMANAGER' or role eq 'SQUADRONMANAGER'or role eq 'SCHEDULEOFFICER' }">
	<tr>	
		<td><a href="${cp }/DiagnosisResult/showDiagnosisResultList.do?code=2"><img <%=("2".equals(code) ? "class=\"hidden\"" : "") %> id="diagnosis_result_menu" src="${cp }/images/menu/diagnosis_result_menu.gif"/></a><img <%=("2".equals(code) ? "" : "class=\"hidden\"") %> id="diagnosis_result_menu_over" src="${cp }/images/menu/diagnosis_result_menu_over.gif" /></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'GROUPMANAGER' or role eq 'FORMATIONMANAGER' or role eq 'SQUADRONMANAGER' or role eq 'SYSTEMADMIN' }">
	<tr>	
		<td><a href="${cp }/DiagnosisStatus/showDiagnosisStatus.do?code=3">
		<img <%=("3".equals(code) ? "class=\"hidden\"" : "") %> id="diagnosis_status_menu" src="${cp }/images/menu/diagnosis_status_menu.gif" /></a><img <%=("3".equals(code) ? "" : "class=\"hidden\"") %> id="diagnosis_status_menu_over" src="${cp }/images/menu/diagnosis_status_menu_over.gif" /></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'NORMAL' or role eq 'FORMATIONMANAGER' or role eq 'SQUADRONMANAGER' or role eq 'SYSTEMADMIN' or role eq 'SCHEDULEOFFICER' }">
	<tr>	
		<td><a href="${cp }/ValuationStandardTable/valuationStandardTable.do?code=4&airCraftCode=${UserVO.airplane}"><img <%=("4".equals(code) ? "class=\"hidden\"" : "") %> id="valuation_standard_table_menu" src="${cp }/images/menu/valuation_standard_table_menu.gif" /></a><img <%=("4".equals(code) ? "" : "class=\"hidden\"") %> id="valuation_standard_table_menu_over" src="${cp }/images/menu/valuation_standard_table_menu_over.gif" /></td>
	</tr>
	</c:if>
	<!--조치기준표  -->
	<c:if test="${role eq 'NORMAL' or role eq 'FORMATIONMANAGER' or role eq 'SQUADRONMANAGER' or role eq 'SYSTEMADMIN' or role eq 'SCHEDULEOFFICER' }">
	<tr>	
		<td><a href="${cp }/MeasureStandardTable/measureStandardTable.do?code=5"><img <%=("5".equals(code) ? "class=\"hidden\"" : "") %> id="measure_Standard_Table_menu" src="${cp }/images/menu/measure_standard_table_menu.gif" /></a><img <%=("5".equals(code) ? "" : "class=\"hidden\"") %> id="measure_Standard_Table_menu_over" src="${cp }/images/menu/measure_standard_table_menu_over.gif" /></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'CQ' or role eq 'SYSTEMADMIN' or role eq 'SCHEDULEOFFICER'}">
	<tr>
		<td><img id="system_manage_menu" src="${cp }/images/menu/system_manage_menu.gif" /></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'SYSTEMADMIN'}">
	<tr>
		<td><a href="${cp}/SystemManage/authorityManage.do?code=6"><img <%=("6".equals(code) ? "class=\"hidden\"" : "") %> id="authority_manage_menu" src="${cp }/images/menu/authority_manage_menu.gif" /></a><img <%=("6".equals(code) ? "" : "class=\"hidden\"") %> id="authority_manage_menu_over" src="${cp }/images/menu/authority_manage_menu_over.gif" /></td>
	</tr>
	<tr>
		<td><a href="${cp}/ValuationStandardTable/valuationStandardModify.do?code=7"><img <%=("7".equals(code) ? "class=\"hidden\"" : "") %> id="valuation_table_manage_menu" src="${cp }/images/menu/valuation_table_manage_menu.gif" /></a><img <%=("7".equals(code) ? "" : "class=\"hidden\"") %> id="valuation_table_manage_menu_over" src="${cp }/images/menu/valuation_table_manage_menu_over.gif" /></td>
	</tr>
	</c:if>
	<c:if test="${role eq 'CQ' or role eq 'SYSTEMADMIN'or role eq 'SCHEDULEOFFICER'}">
	<tr>
		<td><a href="${cp}/ScheduleManage/scheduleManage.do?code=8"><img <%=("8".equals(code) ? "class=\"hidden\"" : "") %> id="schedule_manage_menu" src="${cp }/images/menu/schedule_manage_menu.gif" /></a><img <%=("8".equals(code) ? "" : "class=\"hidden\"") %> id="schedule_manage_menu_over" src="${cp }/images/menu/schedule_manage_menu_over.gif" /></td>
	</tr>
	</c:if>
	
</table>
<table id="main_menu_common_info">
	<tr>
		<td><img src="${cp }/images/tel_info.gif"/></td>
	</tr>
	<!-- tr>
		<td><a href="${cp }/rmate/index.html">[임시]rMate 예제&매뉴얼(host를 localhost.hq.af.mil대신 oper.hq.af.mil로 설정해야함)</a></td>
	</tr-->
</table>
