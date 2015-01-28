<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<SCRIPT TYPE="TEXT/JAVASCRIPT">

</SCRIPT>

<h1 class="page_sub_title_h1_promote_list"> ■ 과제 등록</h1>
<br>
<center>
<%-- <form:form commandName="AssignmentVO" action="assignRegister.do" htmlEscape="true"> --%>
	<table style="border-bottom: 0px;" border="1" cellspacing="0" cellpadding="0" height="200" width="700">
		<tr>
			<th width="90">프로젝트 명 </th><td colspan="3">&nbsp;</td>
			<th width="90">등록일</th>
			<td><a href="#" onclick="dateset();">&nbsp;</a>
<%-- 				<form:input path="AssignmentVO.startDate" id="startDate" cssStyle="width: 100px;" readonly="true"/> --%>
			</td>
		</tr>
		<tr>
			<th width="90">팀명</th>
			<td width="240">&nbsp;</td>
			<th width="90">리더</th>
			<td width="125">&nbsp;</td>
			<th width="90">리더자격</th>
			<td width="55">&nbsp;</td>
		</tr>
		<tr>
			<th>챔피언</th>
			<td>&nbsp;</td>
			<th width="90">부서장</th>
			<td>&nbsp;</td>
			<th>지도위원</th>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>분야별 유형</th>
			<td>&nbsp;</td>
			<th>과제구분</th>
			<td colspan="3">&nbsp;</td>
		</tr>	
		<tr>
			<th>성과구분</th>
			<td>&nbsp;</td>
			<th>과제유형</th>
			<td colspan="3">&nbsp;</td>
		</tr>
		</table>
		<table style="border-top: 0px;" width="700" border="1" cellspacing="0" cellpadding="0" height="200">
		<tr>
			<th rowspan="2" height="20" width="90">프로젝트<br>추진계획</th>
			<th width="121">Define</th><th width="121">Measure</th><th width="121">Analyze</th><th width="121">Improve</th><th width="122">Control</th>
		</tr>	
		<tr>	
			<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
		</tr>
		<tr>
			<th rowspan="2">팀구성</th>
			<th>성명</th><th colspan="2">부서</th><th>역할</th><th>&nbsp;</th>
		</tr>
		<tr>
			<td>&nbsp;</td><td colspan="2">&nbsp;</td><td>&nbsp;</td><td><a href=#>추가</a></td>
		</tr>
		
		<tr>
			<th>과제등록서</th>
			<td colspan="2">&nbsp;</td>
			<th>회의록</th>
			<td colspan="2">&nbsp;</td>
		</tr>
	</table>
	<a href="<c:url value='/assignment/assignList.do'/>"> 등록 </a>&nbsp;&nbsp;&nbsp;
	<a href="<c:url value='/assignment/assignList.do'/>"> 취소 </a>
<%-- </form:form> --%>
</center>
