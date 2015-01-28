<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${searchVO.pagination }"/>

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
	
	var form = document.forms['searchVO'];	
	form.submit();
}

function goToPreviousPages() {
	goToPage(Math.max(1, page - numPagesPerScreen));
}
/* ]]> */
</script>


<script type="text/javascript">
<!--
	$(document).ready(function(){
		$('#authority').change(function(){
			$('#searchVO').submit();
		});
	});

	function openPop(quarter){
		var url = '<c:url value="/admin/popup/addAdminView.do?code="/>'+quarter;
		openPopup(url, 500, 500);
	}  
	
// 	function changeAdministrator(sn){
// 		$('#administratorVO #sn').val(sn);
// 		$('#administratorVO').submit();
// 		alert("정상적으로 변경 되었습니다.");
// 	}

	function UpdateBeltUser(){
			
	}
	
//-->
</script>

<form:form commandName="searchVO" method="get" htmlEscape="true"  action="adminTable.do">
	<form:hidden path="page" value="${pagination.currentPage}" htmlEscape="true"/>
</form:form>

<!-- <ul class="assignment_register_menu_ul"> -->
<!-- 	<li> -->
<!-- 		<a class="menu_search" onfocus="blur();" href="javascript:openPop();"> 등록</a> -->
<!-- 	</li> -->
	
<!-- 	AJax로 할까? 일반적으로 Controller 돌려서 받을까? ReFlash 유무 -->
<!-- 	<li> -->
<!-- 		<a class="menu_search" onfocus="blur();" href="javascript:UpdateBeltUser();" >갱신</a> -->
<!-- 	</li> -->
<!-- </ul> -->
<center>
	<h1 class="adminTitle">관리자 관리</h1>
	<form:form commandName="administratorVO" method="put" htmlEscape="true"  action="adminTable.do">
	<form:hidden path="sn" htmlEscape="true"/>
		<table class="adminTable">
			<thead>
				<tr>
					<th width="7.5%">번호</th>
					<th width="27.3%">소속</th>
					<th width="32.7%">직책</th>
					<th width="22.5%">성명</th>
					<th width="10%">변경</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="administrator" varStatus="loop">
					<c:if test="${administrator.code != '0000000'}">
						<tr style="cursor:default;">
							<td><c:out value="${(pagination.currentPage - 1) * pagination.numItemsPerPage + loop.count}"/></td>
							<td><c:out value="${administrator.name }"/></td>
							<td><c:out value="${administrator.position}"/></td>
							<td><c:out value="${administrator.sn_rank } ${administrator.sn_name }"/></td>
							<td>
									<c:if test="${userInfo.authority == 'A' }">
										<a href="javascript:openPop('<c:out value="${administrator.quarter }"/>');" onfocus="blur();" >[변경]</a>
									</c:if>
									<c:if test="${userInfo.authority == 'B' }">
										<c:if test="${userInfo.sn == administrator.sn }">
											<a href="javascript:openPop('<c:out value="${administrator.quarter }"/>');" onfocus="blur();" >[변경]</a>
										</c:if>			
									</c:if>
									<c:if test="${userInfo.authority == 'C' }">
										<c:if test="${userInfo.sn == administrator.sn}">
											<a href="javascript:openPop('<c:out value="${administrator.quarter }"/>');" onfocus="blur();" >[변경]</a>
										</c:if>
									</c:if>
							</td>
						</tr>
					</c:if>
					<c:if test="${administrator.code == '0000000'}">
						<c:if test="${userInfo.sn == administrator.sn }">
							<tr>
								<td><c:out value="${(pagination.currentPage - 1) * pagination.numItemsPerPage + loop.count}"/></td>
								<td><c:out value="${administrator.name }"/></td>
								<td><c:out value="${administrator.position}"/></td>
								<td><c:out value="${administrator.sn_rank } ${administrator.sn_name }"/></td>
								<td><a href="javascript:openPop('<c:out value="${administrator.quarter }"/>');" onfocus="blur();" >[변경]</a>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="5">
						<a href="javascript:void(goToPage(1))" onfocus="blur();">
							처음
						</a>
						<c:forEach var="i" begin="${pagination.pageBegin}" end="${pagination.pageEnd}">
							<c:if test="${i == pagination.currentPage}">
								<strong>${i}</strong>
							</c:if>
							<c:if test="${i != pagination.currentPage}">
								<a class="pageLink" href="javascript:void(goToPage(${i}))" onfocus="blur();">${i}</a>
							</c:if>
						</c:forEach>
						<a href="javascript:void(goToPage(${pagination.numPages}))" onfocus="blur();">
							끝
						</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</form:form>
</center>				