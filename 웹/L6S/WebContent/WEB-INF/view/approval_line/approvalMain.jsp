<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${approvalVO.pagination }"/>
<script>
function gotoDetail(th){
	location.href="<c:url value="/subject/detailSubjectList.do"/>?seq="+th;
}
function goBeltDetail(th){
	location.href="<c:url value="/belt/detail.do"/>?num="+th;
}
$(document).ready(function() {
	$('tbody tr').hover(function() {
		$(this).css('background', '#f5f5f5');
	}, function() {
		$(this).css('background', '#ffffff');
	});
});

</script>

<%-- Page 처리 Script --%>
<script type="text/javascript">
/* <![CDATA[ */
var numPagesPerScreen = <c:out value='${pagination.numPagesPerScreen}'/>;
var page = <c:out value='${pagination.currentPage}'/>;
var numPages = <c:out value='${pagination.numPages}'/>;


function goToNextPages() {
	goToPage(Math.min(numPages, page + numPagesPerScreen));
}

function goToPage(page) {
	var input = document.getElementById('page');
	input.value = page;
	
	var form = document.forms['approvalVO'];
	form.submit();
}

function goToPreviousPages() {
	goToPage(Math.max(1, page - numPagesPerScreen));
}
/* ]]> */
</script>

<center>
<h1 class="approval_line_main">결재 수신 현황</h1>
	<form:form commandName="approvalVO" method="get" htmlEscape="true">
		<form:hidden path="page" value="${pagination.currentPage}" htmlEscape="true"/>
		<h1 class="subject_line_main">과제 결재 목록</h1>
		<table class="approvalmain_table">
			
				<tr>
					<th width="7%">순번</th>
					<th width="54%">과제명</th>
					<th width="10%">과제 구분</th>
					<th width="17%">과제 리더</th>
					<th width="12%">처리 상태</th>
				</tr>
		
			<c:forEach var="app" items="${appList }" varStatus="i">
			<tr style="cursor:default;" onclick="gotoDetail(${app.subject_code})">
				<td>${i.index+1 }</td>
				<td><c:out value="${app.project_name }"/></td>
				<td>${app.subject_section }</td>
				<td>${app.leader }</td>
				<td>${app.app_right.approvalState }</td>
			</tr>
			</c:forEach>
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
						<a href="javascript:void(goToPage(${pagination.numPages}))" onfocus="blur();">끝</a>
					</td>
				</tr>			
			</tfoot>
		</table>
		<br />
		
		<c:if test="${user.authority == 'A'}" >
			<h1 class="belt_line_main">벨트 결재 목록</h1>
			<table class="approvalmain_table">
			 
				<tr>
					<th width="7%">순번</th>
					<th width="39%">소속</th>
					<th width="10%">벨트등급	</th>
					<th width="17%">인증 대상자</th>
					<th width="15%">인증 내용	</th>
					<th width="12%">처리 상태</th>
				</tr>
				
				<c:forEach var="bal" items="${beltappList }" varStatus="i">
						<tr onclick="goBeltDetail(${bal.pn})">
							<td>${i.index+1 }</td>
							<td>${bal.sosokname }</td>
							<td>${bal.belt }</td>
							<td>${bal.rank }&nbsp;${bal.name}</td>
							<td>${bal.beltstr}</td>
							<td>${bal.app_str}</td>
						</tr> 
				</c:forEach>
			</table>
		</c:if>
	</form:form>
</center>