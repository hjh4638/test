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
<div id="boardTableWrapper">
<table cellpadding="0" cellspacing="0" id="freeBoardTable">
	<tr style="background: #f7f7f7;">
		<th style="width:30px;border-left:1px solid #cccccc;">번호</th>
		<th style="width:470px">제목</th>
		<th style="width:80px;">저자</th>
		<th style="width:80px;">게시일</th>
		<th style="width:70px;border-right:1px solid #cccccc;">파일첨부</th>
		<c:if test="${USERINFO.user_authority eq 'Z00' }">
			<th><img src="<c:url value='/images/main/disket2.gif'/>"/></th>
		</c:if>
	</tr>
	
	<c:forEach items="${freeBoardContentsList }" var="freeBoardContents" varStatus="index">
		<tr id="bgcol${index.count }" onmouseover="onboard('${index.count }')" onmouseout="outboard('${index.count }')">
			<td><c:out value="${freeBoardContents.row_number }"/></td>
<%-- 			<td><a href="view.do?board_id=${freeBoardContents.board_id }&board_type=${board_type }">${freeBoardContents.board_title }</a></td> --%>
			<td><p id="title${freeBoardContents.board_id }" onclick="LoadView('${freeBoardContents.board_id }','${board_type }')" style="cursor: pointer;"><c:out value="${freeBoardContents.board_title }"/></p></td>
			<td><c:out value="${freeBoardContents.board_writer }"/></td>
			<td><c:out value="${freeBoardContents.board_register_date }"/></td>
			<td>
				<c:forEach var="file" items="${freeBoardContents.astiBoardFileDTO }">
					<div style="float:left;margin-left:10px;">	
						<form action="<c:url value="/main/download.do"/>" method="POST">
							<input type="hidden" name="filename" value="<c:out value="${file.file_id }"/>">
								<p><a href="#" onclick="downloadFile($(this).parent().parent())" title="${file.filename }">
							<img src="<c:url value='/images/main/disket2.gif'/>"/></a></p>
						</form>
					</div>
				</c:forEach>
			</td>
			<c:if test="${USERINFO.user_authority eq 'Z00' }">
				<td>
<%-- 					<input type="button" value="삭제" onclick="gotoDelete('${freeBoardContents.board_id }','<%=request.getHeader("referer") %>')"> --%>
					<img style="cursor:pointer;" onclick="gotoDelete('${freeBoardContents.board_id }','<%=request.getHeader("referer") %>')" src="<c:url value='/images/btn/btn_04_0320.gif'/>"/>
				</td>
			</c:if>
		</tr>
	</c:forEach>
</table>
</div>
<c:if test="${pagination.beginPage ne 1 }">
<!-- <a href="javascript:pageMove('1')">◁◁</a> &nbsp; -->
<img onclick="pageMove('1')" src="<c:url value='/images/btn/btn_prev_end.gif'/>"/>
<%-- <a href="javascript:pageMove('${pagination.beginPage-1 }')">◀</a> --%>
<img onclick="pageMove('${pagination.beginPage-1 }')" src="<c:url value='/images/btn/btn_prev.gif'/>"/>
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
<%-- <a href="javascript:pageMove('${pagination.endPage+1 }')"></a> &nbsp; --%>
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
<!-- 	<a href="javascript:searchFreeBoard()"> -->
	<img style="cursor:pointer;" onclick="searchFreeBoard()" src="<c:url value='/images/btn/btn_01_0320.gif'/>"/>
<!-- 	</a> -->
</form:form>
<c:if test="${USERINFO.user_authority eq 'Z00' or param.board_type eq 'B07'}">
<%-- 	<input type="button" value="입력" onclick="gotoInsertPage('${param.board_type}')"> --%>
	<img style="cursor:pointer;" onclick="gotoInsertPage('${param.board_type}')" src="<c:url value='/images/btn/btn_02_0320.gif'/>"/>
</c:if>
<%-- <form in="astiFreeBoardSearch" --%>
