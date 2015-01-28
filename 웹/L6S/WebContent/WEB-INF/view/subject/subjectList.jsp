<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${subjectVO.pagination }"/>

<style>

th{
	height:20px;
	border:1px solid #dedee0;
}
tr{
	height:30px;
	
}
td{
	border:1px solid #dedee0;
} 
#selectionDiv{
	margin-left: 50px;
	margin-top: 20px;
	margin-bottom: 20px;
	border:1px solid blue;
}
.sosok{
	width: 100px;
}
.select_bgcolor{
	background-color: #f8f9fb;
}
.subject_search_menu{
	width: 722px;
	height: 50px;
	margin-top: 5px;
	margin-bottom: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	font-weight: bold;
/* 	border: 1px solid #bbb; */
/* 	background-color: #f2f7fc; */
}

.subject_search_menu li {
	float: left;
	text-align: left;
	text-indent: 2px;
	margin-left: 5px;
	margin-right: 5px;
}

.subject_search_menu li a{
	float: right;
	padding-top: 5px;
}
</style>

<%-- Page 처리 Script --%>
<script type="text/javascript">
/* <![CDATA[ */
var numPagesPerScreen = <c:out value='${pagination.numPagesPerScreen}'/>;
var page = <c:out value='${pagination.currentPage}'/>;
var numPages = <c:out value='${pagination.numPages}'/>;

function goToNextPages() {
	goToPage(Math.min(numPages, page + 1));
}

function goToPage(page) {
	var input = document.getElementById('page');
	input.value = page;
	
	var form = document.forms['subjectVO'];
	form.submit();
}

function goToPreviousPages() {
	goToPage(Math.max(1, page - 1));
}

function SearchDatum(){
	var form = document.forms["subjectVO"];
	form.page.value=1;
	form.submit();
}
/* ]]> */
</script>

<script>
//엔터키 누르면 조회
$(function(){
	$("#subjectVO").keydown(function(event) {
		  if (event.keyCode == '13') {
			  SearchDatum();
		   }
		});
});


function gotoDetail(th){
	var seq=$(th).attr("seq");
	location.href="<c:url value="detailSubjectList.do"/>?seq="+seq;
}
function selectThis(th){
	$("tr").removeClass("select_bgcolor");
	$(th).addClass("select_bgcolor");
}
function openApproval(th){
	openPopup("<c:url value="/approval_line/popup/approvalProcessing.do"/>?seq="+th,750,500);
}
function SubjectExcel(){
	var url = '<c:url value="/subject/excel/SubjectExcel.do"/>';	
	location.href=url;
}
</script>
<center>
	<h1 class="assignment_search_title"> 벨트등록 </h1>
	<form:form commandName="subjectVO" method="get" htmlEscape="true">
		<form:hidden path="page" value="${pagination.currentPage}" htmlEscape="true"/>
			
		<ul class="subject_search_menu">
			<li style="width: 60px;">
				<form:label path="subject_section">과제 구분<br /></form:label>
				<form:select path="subject_section" id="subject_section" cssStyle="width: 60px; background-color: #f2f7fc;">
					<form:option value="">전체</form:option>
					<c:forEach var="sec" items="${subjectSectionItem}">
						<form:option value="${sec.title}">${sec.title}</form:option>
					</c:forEach>	
				</form:select>
			</li>
			<li style="width: 65px;">		
				<form:label path="result_section">성과 구분<br /></form:label>
				<form:select path="result_section" id="result_section" cssStyle="width: 65px; background-color: #f2f7fc;">
					<form:option value="">전체</form:option>
					<c:forEach var="result" items="${subjectResultSection}">
						<form:option value="${result.title}">${result.title}</form:option>
					</c:forEach>	
				</form:select>
			</li>	
			<li style="width: 100px;">	
				<form:label path="field_type">&nbsp;&nbsp;&nbsp;분야별 유형<br /></form:label>
				<form:select path="field_type" id="field_type" cssClass="subject_search_menu_nametype" cssStyle="background-color: #f2f7fc;">
					<form:option value="">전체</form:option>
					<c:forEach var="field" items="${subjectFieldType}">
						<form:option value="${field.title}">${field.title}</form:option>
					</c:forEach>	
				</form:select>
			</li>	
			<li style="width: 126px;">		
				<form:label path="subject_type">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;과제 유형<br /></form:label>
				<form:select path="subject_type" id="subject_type" cssStyle="width: 126px; background-color: #f2f7fc;">
					<form:option value="">전체</form:option>
					<c:forEach var="type" items="${subjectTypeItem}">
						<form:option value="${type.title}">${type.title}</form:option>
					</c:forEach>
				</form:select>
			</li>
			<li style="width: 173px;">
				<form:label path="nametype">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;직책별 이름 검색<br/></form:label>
				<form:select path="nametype" cssStyle="width: 75px; background-color: #f2f7fc;float:left;">
					<form:option value="2">리더</form:option>
					<form:option value="1">팀원</form:option>
					<form:option value="3">챔피언</form:option>
					<form:option value="4">부서장</form:option>
					<form:option value="5">부대담당자</form:option>
				</form:select>
				<form:input maxlength="10" path="username" cssStyle="width:87px;margin-left: 5px; background-color: #f2f7fc;float:left;"/>
			</li>
			<c:if test="${login.authority eq 'A'}">
				<li style="width: 74px; margin-right: 4px; margin-left: -2px; margin-top: 9px; float: right;">
					<a onfocus="blur();" href="#" onclick="SubjectExcel();">
						<img src="<c:url value="/images/button/excel.gif"/>">
					</a>
				</li>
			</c:if>
			<li style="width: 567px;">
				과제명 <form:input maxlength="70" path="project_name" cssStyle="width:250px;margin-top: 5px; background-color: #f2f7fc;"/>
				연도 <form:input maxlength="4" path="register_day" cssStyle="width:28px;margin-top: 5px; background-color: #f2f7fc;"/>
				&nbsp;&nbsp;&nbsp;부대별검색
				<form:select path="sosokname" cssStyle="margin-top: 5px;background-color: #f2f7fc;width:95px;">
					<form:option value="">전체</form:option>
					<c:forEach var="base" items="${allBase}">
					<form:option value="${base.basename }">${base.basename }</form:option>
					</c:forEach> 
				</form:select>
			</li>
			<li style="width: 60px;  margin-left: -11px; margin-top: 0px; float: right;">
				<a onfocus="blur();" href="#" onclick="javascript:SearchDatum();">
					<img src="<c:url value="/images/button/search2.gif"/>">
				</a>
			</li>
		</ul>
	</form:form>
<!-- 	assignmentstage_table -->
	<table class="assignmentstage_table">
		<thead>
		<tr bgcolor="#e7f0f9">
			<th>순번</th><th>과제명</th><th>분야</th><th>부대</th>
			<th>
			<c:if test="${param.nametype eq '1' && param.username ne ''}">팀원</c:if>
			<c:if test="${param.nametype eq '1' && param.username eq ''}">과제리더</c:if>
			<c:if test="${param.nametype ne '1'}">
				<c:choose>
					<c:when test="${param.nametype eq '2'}">과제리더</c:when>
					<c:when test="${param.nametype eq '3'}">챔피언</c:when>
					<c:when test="${param.nametype eq '4'}">부서장</c:when>
					<c:when test="${param.nametype eq '5'}">부대담당자</c:when>
					<c:otherwise>과제리더</c:otherwise>
				</c:choose>
			</c:if>
			 </th>
			<th>등록일</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="val" items="${allSubject }" varStatus="i">
			<tr style="cursor:default;" id="allSubjectList" onclick="gotoDetail(this)" seq="${val.subject_code }" OnMouseOver="selectThis(this)">
				<td> <c:out value="${(pagination.currentPage - 1) * pagination.numItemsPerPage + i.count}"/> </td>
				<td><c:out value="${val.project_name }"/></td>
				<td>${val.field_type }</td>
				<td>${val.sosokname}</td>
				<td>
					<c:if test="${param.nametype eq '1' && val.person ne null}">${val.person}</c:if> 
					<c:if test="${val.person eq null}">
						<c:choose>
							<c:when test="${param.nametype eq '2'}">${val.leader}</c:when>
							<c:when test="${param.nametype eq '3'}">${val.champion}</c:when>
							<c:when test="${param.nametype eq '4'}">${val.department_chairman}</c:when>
							<c:when test="${param.nametype eq '5'}">${val.guide_committee}</c:when>
							<c:otherwise>${val.leader }</c:otherwise>
					</c:choose>
					</c:if>
				</td>
				<td>${val.register_day}</td>
			</tr>	
		</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					<a href="javascript:void(goToPage(1))" onfocus="blur();">처음</a>
					<a href="javascript:void(goToPreviousPages())" onfocus="blur();">이전</a>
					<c:forEach var="i" begin="${pagination.pageBegin}" end="${pagination.pageEnd}">
						<c:if test="${i == pagination.currentPage}">
							<strong>${i}</strong>
						</c:if>
						<c:if test="${i != pagination.currentPage}">
							<a class="pageLink" href="javascript:void(goToPage(${i}))" onfocus="blur();">${i}</a>
						</c:if>
					</c:forEach>
					<a href="javascript:void(goToNextPages())" onfocus="blur();">다음</a>
					<a href="javascript:void(goToPage(${pagination.numPages}))" onfocus="blur();"> 끝</a>
				</td>
			</tr>
		</tfoot>
	</table>
	
	
</center>