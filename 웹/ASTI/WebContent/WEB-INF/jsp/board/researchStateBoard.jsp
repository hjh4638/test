<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${astiBoardSearchDTO.astiBoardPaginationDTO }"/>
<c:set var="board_type" value="${astiBoardSearchDTO.board_type }"/> 
<c:set var="userInfo" value="${USERINFO }"/>
<script src="<c:url value='/js/board/board.js'/>"></script>
<script>
window.document.onkeypress = enterKeyPress;

</script>
<style>
	body {
		margin: 0;
	}
	#container {
		overflow: hidden;
		position: relative;
		height: 375.1px;
	}

	.slideimg {
		position: absolute;
	}
	</style>
<h1 style="margin-top:10px;font-size: 72px;">${boardSign }</h1>

<div style="width:730px;height:480px;">
	<c:forEach var="boardContent" items="${freeBoardContentsList}">
		<div style="float:left;width:350px;height:96px;">
			<a onclick="LoadView('${boardContent.board_id }','${board_type }')">		
				<img style="width: 140px;height: 95px; float: left"
					src="<c:url value='/departmentImage/${boardContent.astiBoardFileDTO[0].file_id }'/>">
			</a>
			<p><c:out value="${boardContent.board_register_date }"/></p>
			<p id="title${boardContent.board_id }" ><c:out value="${boardContent.board_title }"/></p>
		</div>
	</c:forEach>
</div>


<c:if test="${pagination.beginPage ne 1 }">
<img onclick="pageMove('1')" src="<c:url value='/images/btn/btn_prev_end.gif'/>"/>
<!-- <a href="javascript:pageMove('1')">◁◁</a> &nbsp; -->
<img onclick="pageMove('${pagination.beginPage-1 }')" src="<c:url value='/images/btn/btn_prev.gif'/>"/>
<%-- <a href="javascript:pageMove('${pagination.beginPage-1 }')">◀</a> --%>
</c:if>
<c:forEach var="pageStatus" varStatus="pageCount" begin="${pagination.beginPage }" end="${pagination.endPage }">
	<c:if test="${pagination.lastPage>=pageStatus}">
		<c:choose>
			<c:when test="${pagination.currentPage eq pageStatus }">
				<b>${pageStatus }</b>
			</c:when>
			<c:otherwise>
				<a href="javascript:pageMove('${pageStatus}')">
					${pageStatus }
				</a> 
			</c:otherwise>
		</c:choose>
		 <c:if test="${!pageCount.last and (pagination.lastPage ne pageStatus)}">|</c:if>
	</c:if>
</c:forEach>
<c:if test="${pagination.lastPage>=pagination.endPage }">
<img onclick="pageMove('${pagination.endPage+1 }')" src="<c:url value='/images/btn/btn_next.gif'/>"/>
<%-- <a href="javascript:pageMove('${pagination.endPage+1 }')">▶</a> &nbsp; --%>
<img onclick="pageMove('${pagination.lastPage }')" src="<c:url value='/images/btn/btn_next_end.gif'/>"/>
<%-- <a href="javascript:pageMove('${pagination.lastPage }')">▷▷</a> --%>
</c:if>
<form:form commandName="astiBoardSearchDTO" method="get" action="board.do">
	<input type="hidden" name="currentPage" id="currentPage" value="${pagination.currentPage }"/>
	<form:hidden path="board_type" value="${board_type }"/>
<%-- 	<form:label path="searchType">검색:</form:label> --%>
	<form:select path="searchType">
		<form:option value="writer">작성자</form:option> 
		<form:option value="title">제목</form:option>
		<form:option value="content">내용</form:option>
	</form:select>
	<form:input path="searchDetail"/>
<!-- 	<a href="javascript:searchFreeBoard()">검색</a> -->
<img style="cursor:pointer;" onclick="searchFreeBoard()" src="<c:url value='/images/btn/btn_01_0320.gif'/>"/>
</form:form>
<c:if test="${USERINFO.user_authority eq 'Z00'}">
<%-- 	<input type="button" value="입력" onclick="gotoInsertPage('${param.board_type}')"> --%>
	<img style="cursor:pointer;" onclick="gotoInsertPage('${param.board_type}')" src="<c:url value='/images/btn/btn_02_0320.gif'/>"/>
</c:if>
<%-- <form in="astiFreeBoardSearch" --%>
	
