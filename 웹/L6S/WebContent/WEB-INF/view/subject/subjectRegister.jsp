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
<script type="text/javascript">
var result = <c:out value='${result}'/>;
$(document).ready(function() {
	if(result==false){
		alert("부대 담당자가 지정되어 있지 않습니다.\n공군본부 담당자에게 문의해 주시기 바랍니다.");
		location.href = "<c:url value="/main/start.do" />";
	}
	
});
</script>

<script>
function openApproval(){
	var s_sec = $("#subject_section").val();
	var sosok = $("#sosokcode").val().substring(0,4); 
	if(s_sec == "" || s_sec == null){alert("과제구분을 입력하시오.");	return false;}
	if(sosok == "" || sosok == null){return false;}
	
		openPopup("<c:url value="/approval_line/app/flash.do"/>",900,700);
}
function putBigo(form_id){

	$.ajax({
		  url: "getBigo.do",
		  type: "GET",
		  dataType:"json",
		  data:{
			    form_id:form_id
		  },
		  success: function(data){
			 $("#bigo").val(data.bigo);
// 			 $("#subject_type").val(data.title);
		  }
	});

}
</script>
<c:set var="accept_type" value="<%=accept_type %>"/>
<jsp:include page="subjectRegister_js.jsp"></jsp:include>

<center>
<h1 class="assignment_register_title">과제 등록</h1>
<form:form id="register" commandName="subjectVO" action="insert.do" method="post" htmlEscape="true" enctype="multipart/form-data">
<!-- <input type="button" value="결재자지정" onclick="openApproval()">
<input type="text" class="readonly" id="app_view">
<input type="hidden" id="app_rank" name="app_rank">
<input type="hidden" id="app_name" name="app_name">
<input type="hidden" id="app_ass"  name="app_ass">
<input type="hidden" id="app_sn" name="app_sn"> -->


<table class="assignmentstage_table">
	<tr >
		<th width="15%" align="center" bgcolor="#f7f7f7">
		과제명
		</th>
		<td class="edit_text" colspan="3">
		<input id="project_name" name="project_name" type="text" style="ime-mode:active;" maxlength="90" size="94">
		</td>
	</tr>
	<tr>
		<th width="15%" align="center" bgcolor="#f7f7f7">
		팀명 
		</th>
		<td width="35%" class="edit_text" align="left">   
		<input id="team_name" name="team_name" type="text" style="ime-mode:active;" maxlength="48" size="34">
		</td>
		<th width="15%" align="center" bgcolor="#f7f7f7">
		부대담당자
		</th>
		<td width="35%" id="guide_committee" >
		<input id="guide_committee" type="text" size="34" value="${guide_committee.app_rank} ${guide_committee.app_name}" class="readonly">
		<input type="hidden" name="guide_committee" value="${guide_committee.app_rank} ${guide_committee.app_name},${guide_committee.app_sn}">
		</td>
		
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		챔피언
		</th>
		<td id="champion" >
		<input id="champion" type="text" size="34" onclick="openSearchAdmin(this)"  class="readonly">
		<input type="hidden" name="champion" >
		</td>
		<th align="center" bgcolor="#f7f7f7">
		부서장
		</th>
		<td id="department_chairman" >
		<input id="department_chairman" type="text" size="34" onclick="openSearchAdmin(this)" class="readonly">
		<input type="hidden" name="department_chairman" >
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
				<option>${field.title}</option>
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
				<option>${result.title}</option>
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
			<option value="${subjectSectionItem[0].title}">Speedy Six Sigma</option>
			<option value="${subjectSectionItem[1].title}">Green Belt</option>
			<option value="${subjectSectionItem[2].title}">Black Belt</option>
			<option value="${subjectSectionItem[3].title}">BigY</option>
		</select>
		</td>
		<th align="center" bgcolor="#f7f7f7">
		과제유형
		</th>
		<td >
		<select id="subject_type" name="subject_type" style="width: 130px" onchange="putBigo($(this).val())">
			<option></option>
			<c:forEach var="type" items="${subjectTypeItem}" varStatus="i">
				<option value="${type.form_id }">${type.title}</option>
			</c:forEach>
		</select>
		<input style="width:95%;border:0;" type="text" readonly="readonly" id="bigo">
		</td>
	</tr>
	 <tr>
		<th align="center" bgcolor="#f7f7f7">
		현실태/<br>문제점
		</th>
		<td class="edit_text" colspan="3" height="100px">
		<textarea name="problem" style="ime-mode:active;" id="problem" rows="7" cols="72" 
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<a id="problemCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<th align="center" bgcolor="#f7f7f7">
		개선사항
		</th>
		<td class="edit_text" colspan="3" height="100px">
		<textarea name="advance" style="ime-mode:active;" id="advance" rows="5" cols="72" 
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<a id="advanceCharSize">0</a>/1050 -->
		</td>
	</tr> 
 	<tr>
		<th align="center" bgcolor="#f7f7f7">
		과제등록서
		</th>
		<td colspan="3" align="left">
			<!-- 찾아보기에 이미지 추가 -->
		<%-- 	<input type="text" class="readonly" id="myfilename">
			 <a href="#" onclick="$('input[name=file]').trigger('click')">
				<img src="<c:url value="/images/button/search3.gif"/>">
			</a> --%>
			<!-- style="visibility: hidden;width: 20px"  -->
			<input type="file" name="file" size="78" onchange="checkFile()">
<%-- 			<br><font size="2">허용 확장자 :${accept_type }</font> --%>
		</td>
	</tr> 
</table>

<table class="beltRegister_table">
	<tr bgcolor="#f7f7f7">
<!--		<th rowspan="2" align="center"> -->
<!--		과제<br>추진계획 -->
<!--		</th> -->
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
			<input id="begin_plan_d" type="date" class="date"/>
			~<input id="plan_d" type="date" class="date"/>
			<input type="hidden" name="plan_d">
		</td>
		<td>
			<input id="begin_plan_m" type="date" class="date" />
			~<input id="plan_m"  type="date" class="date" />
			<input type="hidden" name="plan_m">
		</td>
		<td>
			<input id="begin_plan_a" type="date" class="date"/>
			~<input id="plan_a"  type="date" class="date"/>
			<input type="hidden" name="plan_a">
		</td>
		<td>
			<input id="begin_plan_i"  type="date" class="date"/>
			~<input id="plan_i"  type="date" class="date"/>
			<input type="hidden" name="plan_i">
		</td>
		<td>
			<input id="begin_plan_c"  type="date" class="date"/>
			~<input id="plan_c" type="date" class="date"/>
			<input type="hidden" name="plan_c">
		</td>
	</tr>
</table>

<table class="beltRegister_table">
	<tr id="test" bgcolor="#f7f7f7">
		<th colspan="5" align="center">팀구성</th>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th align="center">
		성명
		</th>
		<th align="center">
		군번
		</th>
		<th align="center"> 
		부서
		</th>
		<th align="center">
		역할
		</th>
		<th>
		<!-- 추가버튼 -->
		<a href="#" onclick="attachRow()" onfocus="blur();">
			<img src="<c:url value="/images/button/add.gif"/>">
		</a>
		</th>
	</tr>
		<tr class="standardRow" >
			<td><input value="${login.rank} ${login.name }" name="name" type="text" maxlength="5" size="6" class="readonly"></td>
			<td><input value="${login.sn }" name="sn" type="text" maxlength="11" size="9" class="readonly"></td>
			<td><input value="${login.intrasosok }" name="department" type="text" maxlength="50" size="40" class="readonly"></td>
			<td>
				<input name="role_name" type="text" maxlength="25" size="20" value="리더" class="readonly">
				<input name="is_leader" type="hidden" value=1>
				<input type="hidden" name="leader" value="${login.rank} ${login.name },${login.sn }">
				<input type="hidden" name="leader_qualification" value="${login.rank} ${login.name },${login.sn }">
				<input id="sosokcode" type="hidden" name="sosokcode" value="${login.positionCode }">
				<input id="sosokcode" type="hidden" name="sosokname" value="${login.intrasosok }">
			</td>
			<td></td>
		</tr>
</table>
	<center>
	<a href="#" onclick="validationAndSubmit()" onfocus="blur();">
		<img src="<c:url value="/images/button/save.gif"/>">
	</a>
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
			<a href="#" onclick="openSearchUser(this)" onfocus="blur();">
				<img src="<c:url value="/images/button/insert.gif"/>">
			</a>
		</td>
	</tr>
</table>
</center>