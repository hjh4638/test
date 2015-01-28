<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="pagination" value="${searchVO.pagination }"/>
<c:if test="${result eq 'true' }">
	<script type="text/javascript">
		alert("성공적으로 변경되었습니다.");
	
		var value = '<c:out value="${authority}"/>';
		
		opener.parent.location.reload(true);
		window.close();
	</script>
</c:if>

<script type="text/javascript">
<!--
	$(document).ready(function() {
		$('#search').click(function(){
			$('#searchVO').submit();
		});
	});
	
	function setUserInfo(sn,quarter){
		var answer = confirm("관리자를 변경하시겠습니까?")
		if(answer)
		{
			var form = document.forms['administratorVO'];
			form.sn.value = sn;
			form.quarter.value=quarter;
			form.submit();
		}
		else alert("선택이 취소되었습니다.");
			
	}
//-->
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
	
	var form = document.forms['searchVO'];
	form.submit();
}

function goToPreviousPages() {
	goToPage(Math.max(1, page - numPagesPerScreen));
}
/* ]]> */
</script>

<form:form commandName="searchVO" method="get" htmlEscape="true">
	<form:hidden path="code" value="${quarter}"/>
	<form:hidden path="page" value="${pagination.currentPage}"/>
</form:form>

<form:form commandName="administratorVO" action="addAdminView.do" method="post" htmlEscape="true">
	<form:hidden path="sn"/>
	<form:hidden path="quarter"/>
		<table class="administrator_register_table" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th style="width: 7.15%;">순번</th>
					<th style="width: 63.83%;">소속</th>
					<th style="width: 17.02%;">성명</th>
					<th style="width: 12.00%;">선택</th>
				</tr>
			</thead>
<%-- 인사소속을 인트라 소속으로 변경 --%>
			<tbody>
				<c:forEach items="${u0t}" var="user" varStatus="loop">
					<c:choose>
					<c:when test="${loop.count%2 eq 0 }">
						<tr class="even_tr">
					</c:when>
					<c:otherwise>
						<tr class="odd_tr">
					</c:otherwise>
					</c:choose>	
						<td><c:out value="${(pagination.currentPage - 1) * pagination.numItemsPerPage + loop.count}"/></td>
						<td style="text-align: left;">&nbsp;&nbsp;<c:out value="${user.intrasosok }"/></td>
						<td>
							<c:out value="${user.rank }"/>
							<c:if test="${rankLength[loop.count-1] > 3}"> 
								<br/>
							</c:if>
							<c:out value="${user.name }"/>
							
						</td>
						<td>
							<a onfocus="blur();" href="javascript:setUserInfo('<c:out value="${user.sn}"/>','<c:out value="${quarter}"/>');" class="button_check_image">[선택]</a>
						</td>
					</tr>
				</c:forEach>
				<tr class="delete_tr">
					<td> &nbsp; </td>
					<td> &nbsp; </td>
					<td> &nbsp; </td>
					<td> <a onfocus="blur();" href="javascript:setUserInfo('<c:out value=""/>','<c:out value="${quarter}"/>');" class="button_check_image">[삭제]</a> </td>
				</tr>	
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						<a href="javascript:void(goToPage(1))" onfocus="blur();">
							처음
						</a>
						<%-- <input type="button" value="&lt;&lt;" onclick="goToPreviousPages()" /> --%>
						<c:forEach var="i" begin="${pagination.pageBegin}" end="${pagination.pageEnd}">
							<c:if test="${i == pagination.currentPage}">
								<strong>${i}</strong>
							</c:if>
							<c:if test="${i != pagination.currentPage}">
								<a class="pageLink" href="javascript:void(goToPage(${i}))" onfocus="blur();">${i}</a>
							</c:if>
						</c:forEach>
						<%-- <input type="button" value="&gt;&gt;" onclick="goToNextPages()" /> --%>
						<a href="javascript:void(goToPage(${pagination.numPages}))" onfocus="blur();">
							끝
						</a>
					</td>
				</tr>
			</tfoot>
		</table>
	<div id="error_wrapper" class="unit_highlight_hide">
		<div class="ui-widget">
			<div class="ui-state-highlight ui-corner-all" style="padding: 0 .7em; margin-left: 5px; width: 452px;"> 
				<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
				<p id="input_confirm_text">
					<form:errors path="*"/>
				</p>
			</div>
		</div>
	</div>
</form:form>

<script type="text/javascript">
<!--
	$(document).ready(function(){
		var text = $('#input_confirm_text').text();
		
		if(text != ''){
			$('#error_wrapper').removeClass('unit_highlight_hide');
			$('#error_wrapper').addClass('unit_highlight_show');
		}
	});
//-->
</script>