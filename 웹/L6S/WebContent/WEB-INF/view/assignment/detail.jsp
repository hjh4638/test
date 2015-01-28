<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script language="javascript">
	function printOut(){
		window.print();
	}
</script> 

${Code}

<ul class="assignment_list_menu_ul">
	<li>
		<a class="menu_print" href="#" onfocus="blur();" onclick="printOut();">출력</a>
	</li>
	<li>
		<a class="menu_list" onfocus="blur();" href="<c:url value='assignList.do'/>">목록</a>
	</li>
	<c:if test="${Code eq 'A101'}">
		<li>
			<a class="menu_search" onfocus="blur();" href="#">삭제</a>
		</li>
		<li>
			<a class="menu_register" onfocus="blur();" href="#">수정</a>		
		</li>
	</c:if> 
</ul>

<center>
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
		<table style="border-top: 0px;" width="700" border="1" cellspacing="0" cellpadding="0" height="150">
		<tr>
			<th rowspan="2" height="20" width="90">프로젝트<br>추진계획</th>
			<th width="121" height="20">Define</th><th width="121">Measure</th><th width="121">Analyze</th><th width="121">Improve</th><th width="122">Control</th>
		</tr>	
		<tr>	
			<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
		</tr>
		<tr>
			<th rowspan="2">팀구성</th>
			<th height="20">성명</th><th colspan="2">부서</th><th>역할</th><th>&nbsp;</th>
		</tr>
		<tr>
			<td height="20">&nbsp;</td><td colspan="2">&nbsp;</td><td>&nbsp;</td><td><a href=#>추가</a></td>
		</tr>

	</table>
	<!-- <a href="<c:url value='/assignment/assignList.do'/>"> 이전단계 </a>&nbsp;&nbsp;&nbsp; -->
	<a href="<c:url value='/assignment/dstage.do'/>"> 다음단계 </a>
</center>