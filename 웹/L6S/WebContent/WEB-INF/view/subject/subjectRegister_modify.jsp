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
<jsp:include page="subjectRegister_js.jsp"></jsp:include>


<form:form id="register" action="subjectUpdate.do" method="POST" htmlEscape="true" enctype="multipart/form-data">
<input name="seq" value="${param.seq }" type="hidden">

<table class="assignmentstage_table" >
	<tr >
		<th width="15%" align="center" bgcolor="#f7f7f7">
		과제명
		</th>
		<td class="left_align" colspan="3">
		<input value="<c:out value="${mainSubject.project_name}"/>" id="project_name" name="project_name" type="text" style="ime-mode:active;" maxlength="90" size="94">
		</td>
	</tr>
	<tr>
		<th width="15%" align="center" bgcolor="#f7f7f7">
		팀명 
		</th>
		<td width="35%" class="edit_text" align="left">   
		<input value="<c:out value="${mainSubject.team_name}"/>" id="team_name" name="team_name" type="text" style="ime-mode:active;" maxlength="48" size="34">
		</td>
		<th align="center" bgcolor="#f7f7f7" width="15%">
		부대담당자
		</th>
		<td width="35%" id="guide_committee" >
		<input value="${mainSubject.guide_committee}" id="guide_committee" type="text" size="34" onclick="openSearchAdmin(this)" class="readonly">
		<input type="hidden" name="guide_committee" value="empty">
		</td>
		
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		챔피언
		</th>
		<td id="champion" >
		<input value="${mainSubject.champion}" id="champion" type="text" size="34" onclick="openSearchAdmin(this)" class="readonly">
		<input type="hidden" name="champion" value="empty">
		</td>
		<th align="center" bgcolor="#f7f7f7">
		부서장
		</th>
		<td id="department_chairman" >
		<input value="${mainSubject.department_chairman}" id="department_chairman" type="text" size="34" onclick="openSearchAdmin(this)" class="readonly">
		<input type="hidden" name="department_chairman" value="empty">
		</td>
		
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		분야별 유형
		</th>
		<td  >
		<select id="field_type" name="field_type" style="width: 130px">
			<option></option>
			<c:forEach var="field" items="${subjectFieldType}">
				<option <c:if test="${field.title eq mainSubject.field_type }">selected</c:if>>${field.title}</option>
			</c:forEach>	
		</select>
		</td>
		<th align="center" bgcolor="#f7f7f7">
		성과구분
		</th>
		<td >
		<select id="result_section" name="result_section" style="width: 130px">
			<option></option>
			<c:forEach var="result" items="${subjectResultSection}">
				<option <c:if test="${result.title eq mainSubject.result_section }">selected</c:if>>${result.title}</option>
			</c:forEach>	
		</select>
		</td>
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		과제 구분
		</th>
		<td >
		<select id="subject_section" name="subject_section" style="width: 130px">
			<option></option>
			<c:forEach var="sec" items="${subjectSectionItem}">
				<option <c:if test="${sec.title eq mainSubject.subject_section }">selected</c:if>>${sec.title}</option>
			</c:forEach>	
		</select>
		</td>
		<th align="center" bgcolor="#f7f7f7">
		과제유형
		</th>
		<td >
		<select id="subject_type" name="subject_type" style="width: 130px">
			<option></option>
			<c:forEach var="type" items="${subjectTypeItem}">
				<option <c:if test="${type.title eq mainSubject.subject_type }">selected</c:if>>${type.title}</option>
			</c:forEach>
		</select>
		</td>
	</tr>
	 <tr>
		<th align="center" bgcolor="#f7f7f7">
		현실태/<br>문제점
		</th>
		<td class="edit_text" colspan="3" height="100px">
		<textarea name="problem" style="ime-mode:active;" id="problem" rows="7" cols="72" 
		onkeyup="checkCharSize(this)">${mainSubject.problem}</textarea>
<!-- 		<a id="problemCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		개선사항
		</th>
		<td class="edit_text" colspan="3" height="100px">
		<textarea name="advance" style="ime-mode:active;" id="advance" rows="5" cols="72" 
		onkeyup="checkCharSize(this)">${mainSubject.advance}</textarea>
<!-- 		<a id="advanceCharSize">0</a>/1050 -->
		</td>
	</tr> 
 	<tr>
		<th align="center" bgcolor="#f7f7f7">
		과제등록서
		</th>
		<td colspan="3" align="left">
			<!-- 찾아보기에 이미지 추가 -->
<!-- 			&nbsp;&nbsp;<input type="text" size="70" class="readonly" id="myfilename"> -->
<!-- 			 <a href="#" onclick="$('input[name=file]').trigger('click')"> -->
<%-- 				<img src="<c:url value="/images/button/search3.gif"/>"> --%>
<!-- 			</a> -->
			<input type="file" name="file" size="78" onchange="checkFile()">
<%-- 			<br><font size="2">&nbsp;&nbsp;허용 확장자 :${accept_type }</font> --%>
		</td>
	</tr> 
</table>

<table class="assignmentstage_table" >
	<tr bgcolor="#f7f7f7">
<!-- 		<th rowspan="2" align="center"> -->
<!-- 		과제<br>추진계획 -->
<!-- 		</th> -->
		<th align="center">
		Define
		</th>
		<th align="center">
		Measure
		</th>
		<th align="center">
		Analyze
		</th>
		<th align="center">
		Improve
		</th>
		<th align="center">
		Control
		</th>
	</tr>
	<tr>
		<td>
			<input id="begin_plan_d" type="date" class="date" value="${mainSubject.plan_map.begin_d }"/>
			~<input id="plan_d" type="date" class="date" value="${mainSubject.plan_map.end_d }"/>
			<input type="hidden" name="plan_d">
		</td>
		<td>
			<input id="begin_plan_m" type="date" class="date" value="${mainSubject.plan_map.begin_m }"/>
			~<input id="plan_m"  type="date" class="date" value="${mainSubject.plan_map.end_m }"/>
			<input type="hidden" name="plan_m">
		</td>
		<td>
			<input id="begin_plan_a" type="date" class="date" value="${mainSubject.plan_map.begin_a }"/>
			~<input id="plan_a"  type="date" class="date" value="${mainSubject.plan_map.end_a }"/>
			<input type="hidden" name="plan_a">
		</td>
		<td>
			<input id="begin_plan_i"  type="date" class="date" value="${mainSubject.plan_map.begin_i }"/>
			~<input id="plan_i"  type="date" class="date" value="${mainSubject.plan_map.end_i }"/>
			<input type="hidden" name="plan_i">
		</td>
		<td>
			<input id="begin_plan_c"  type="date" class="date" value="${mainSubject.plan_map.begin_c }"/>
			~<input id="plan_c" type="date" class="date" value="${mainSubject.plan_map.end_c }"/>
			<input type="hidden" name="plan_c">
		</td>
	</tr>
</table>
	<center>
	<!-- 등록버튼 -->
	<ul style="width: 125px;">
		<li style="width: 60px; float: left;">
			<a href="#" onclick="validationAndSubmit()">
				<img src="<c:url value="/images/button/save.gif"/>">
			</a>
		</li>
		<li style="width: 60px; float: left;">
			<input style="display: none;" onclick="history.go(0)" id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소">
		</li>
	</ul>
	</center>
</form:form>

<table style="display:none;">
	<tr class="attachment">
		<td><input id="name" type="text" maxlength="5" size="6" onclick="openSearchUser(this)" class="readonly"></td>
		<td><input id="sn" type="text" maxlength="11" size="9" class="readonly"></td>
		<td><input id="department" type="text" maxlength="50" size="40" class="readonly"></td>
		<td>
			<input name="role_name" type="text" maxlength="25" size="20">
			<input name="is_leader" type="hidden" value="">
		</td>
		<td class="deleteCollection">
			<!-- 입력버튼 -->
			<a href="#" onclick="openSearchUser(this)">
				<img src="<c:url value="/images/button/insert.gif"/>">
			</a>
		</td>
	</tr>
</table>