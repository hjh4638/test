<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="userInfo" value="${USERINFO }"/>
<script src="<c:url value='/js/board/board.js'/>"></script>

<script>
	/* board에 user_id가없으면  비번체크*/
	var board_user_id = '${boardContent.user_id}';
	var user_id = '${USERINFO.user_id}';
	var user_auth = '${USERINFO.user_authority}';
	var board_type = '${param.board_type}'; 
	
	function openPasswordToDel(){
		/* 회원이 게시판 작성한거 아니면 */
		/* 아나 ''으로 하니깐 안되네 ${boardContent.user_id}가 자리수 하나 잡는듯 ㅡ.ㅡ */
		//Number 메소드로 널체크. 게시판 테이블에 user_id 없으면
		if( Number(board_user_id) == 0){
			$("#passwordFormToUp").hide();
			$("#passwordFormToDel").show();
		}
		//웹마스터면 다이렉트로 삭제 고고
		else if(user_auth == 'Z00')
			gotoDelete('${param.board_id }','<%=request.getHeader("referer") %>');
		//기고문에서 자기가 올린거 삭제할라믄~~
		else if(user_id ==board_user_id && board_type == 'B07')
			gotoDeleteByB07('${param.board_id }','<%=request.getHeader("referer") %>','');
	}
	function openPasswordToUp(){
		if( Number(board_user_id) == 0){
			$("#passwordFormToDel").hide();
			$("#passwordFormToUp").show();
		}
		//기고문에서 내가 올린거거나 웹마스터면 update 페이지로 고고
		else if((user_id ==board_user_id && board_type == 'B07') || user_auth == 'Z00')
			LoadUpdate('${param.board_id}','${param.board_type }');
	}
    //기고문에서 삭제할때만 쓰는 메소드!
	//비번체크후 삭제 고고
	function deleteBoard(){
		var password =$("#board_passwordToDel").val();
		var compare_password = '${boardContent.board_password}';
		alert("its me");
		if(password==compare_password)
			gotoDeleteByB07('${param.board_id }','<%=request.getHeader("referer") %>',password);
	}
	//기고문에서 비번 맞으면 업데이트 페이지로 고고
	function updateBoard(){
		var password =$("#board_passwordToUp").val();
		var compare_password = '${boardContent.board_password}';
		
		if(password==compare_password)
			LoadUpdate('${param.board_id}','${param.board_type }');
	}
	function changeDeptImage(th){
		$("#mainImage").remove();
		
		var tagetImg = $(th).children().clone();
		tagetImg.attr("width","600px;");
		tagetImg.attr("height","450px;");
		tagetImg.attr("id","mainImage");
		tagetImg.css("margin-left","50px");
		
		$("#mainImageParentTag").append(tagetImg);
	}
</script>

<c:if test="${USERINFO.user_authority eq 'Z00' or 
				boardContent.board_type eq 'B07'}">
<!-- 	<input type="button" value="삭제" onclick="openPasswordToDel()"> -->
	<a onclick="openPasswordToDel()"><img src="<c:url value='/images/btn/btn_04_0320.gif'/>"></a>
<!-- 	<input type="button" value="수정" onclick="openPasswordToUp()"> -->
	<a onclick="openPasswordToUp()"><img src="<c:url value='/images/btn/btn_03_0320.gif'/>"></a>
</c:if>
<p id="passwordFormToDel" style="display: none;">
비밀번호 입력 : 
	<input id="board_passwordToDel" type="password"> 
	<input type="button" value="확인" onclick="deleteBoard()">
</p>
<p id="passwordFormToUp" style="display: none;">
비밀번호 입력 : 
	<input id="board_passwordToUp" type="password"> 
	<input type="button" value="확인" onclick="updateBoard()">
</p>
<table id="boardViewTable" cellpadding="0" cellspacing="0">
	<tr>
		<th style="width:90px;">
			<c:choose>
				<c:when test="${param.board_type eq 'B08' }">
				언론사
				</c:when>
				<c:otherwise>
				저자
				</c:otherwise>
			</c:choose>
		</th>
		<td style="width:180px;"><c:out value="${boardContent.board_writer }"/></td>
		<th style="width:90px;">
			<c:choose>
				<c:when test="${param.board_type eq 'B00' or
							  param.board_type eq 'B01' or
							  param.board_type eq 'B02' or
							  param.board_type eq 'B03' }">
					발행일
				 </c:when>
				 <c:otherwise>
				 	게시일
				 </c:otherwise>
			 </c:choose>
		</th>
		<td style="width:340px;"><c:out value="${boardContent.board_register_date }"/></td>		
	</tr>
	<tr>
		<th style="width:90px;">제목</th>
		<td colspan="3" style="width:610px;"><c:out value="${boardContent.board_title }"/></td>
	</tr>
	<tr>
		<td id="mainImageParentTag" colspan="4" style="width:700px;height:300px;
			vertical-align: top;"><pre><c:out value="${boardContent.board_content }"/></pre>
			<c:if test="${boardContent.board_type eq 'B05' }">
				<img id="mainImage" style="margin-left:50px;" width="600px" height="450px" src="<c:url value='/departmentImage/${boardFile[0].file_id }'/>">
			</c:if>		
		</td>
	</tr>
	<c:if test="${boardContent.board_type ne 'B05' }">
	<tr>
		<th style="width:90px;">첨부파일</th>
		<td colspan="3">  
			<c:if test="${boardFile[0] eq null }">
				첨부파일이 없습니다.
			</c:if>
			<c:forEach var="file" items="${boardFile }">
			<form action="<c:url value="/main/download.do"/>" method="POST">
				<input type="hidden" name="filename" value="<c:out value="${file.file_id }"/>">
				<p><a href="#" onclick="downloadFile($(this).parent().parent())">
				<c:out value="${file.filename }"/></a></p>
			</form>
			</c:forEach>
		</td>
	</tr>
	</c:if>
<!-- 	연구원 동정일때 -->
	<c:if test="${boardContent.board_type eq 'B05' }">
	<tr>
		<td colspan="4">
			<c:forEach var="file" items="${boardFile }">
				<a onclick="changeDeptImage(this)">
					<img style="float: left" width="100px" height="100px" src="<c:url value='/departmentImage/${file.file_id }'/>">
				</a>
			</c:forEach>
		</td>
	</tr>
	</c:if>
</table>

<table id="nextPreviousTable" cellpadding="0" cellspacing="0" >
	
	<tr>
		<th style="width:50px;">다음글</th>
		<td style="width:
		<c:choose>
		<c:when test="${next eq null}">650px;" colspan="2">다음글이 없습니다.
		</c:when>
		<c:otherwise>
			600px;"><a href="javascript:LoadView('${next.board_id }','${next.board_type }')"><c:out value="${next.board_title }"/></a>
			</td>
			<td style="width:50px";>
				<c:out value="${next.board_writer }"/>
		</c:otherwise>
		</c:choose>
		</td>
		
	</tr>
	<tr onclick="LoadView('${previous.board_id }','${previous.board_type }')">
		<th style="width:50px;">이전글</th>
		<td style="width:
			<c:choose>
				<c:when test="${previous eq null}">650px;" colspan="2">이전글이 없습니다.
				</c:when>
				<c:otherwise>
					600px;">
					<a href="javascript:LoadView('${previous.board_id }','${previous.board_type }')"><c:out value="${previous.board_title }"/></a>
				</td>
				<td style="width:50px;">
				<c:out value="${previous.board_writer }"/>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>

<!-- <div id="view_CommentViewZone"> -->
<%-- 	<c:if test="${boardComment ne null }"> --%>
<%-- 		<form action="/ASTI/board/addReplyComment.do" method="post" name="insertReply" id="insertReply"> --%>
		
<%-- 			<c:forEach items="${boardComment }" var="comments" varStatus="list"> --%>
<%-- 			<c:if test="${comments.lev ne 1 }"> --%>
<%-- 			<div style="text-align:right;width:${(comments.lev-1)*20}px;float:left;"> --%>
<!-- 				☞ -->
<!-- 			</div> -->
<%-- 			</c:if> --%>
<%-- 			<table style="float:left;width:${730 - (comments.lev-1) * 20}px;"cellspacing="0" cellpadding="2">  --%>
<!-- 				<tr> -->
<!-- 					<td style="width:120px; text-align:center"> -->
<%-- 						${comments.add_writer }  --%>
<!-- 					</td> -->
<%-- 					<td  style="width:${420 - (comments.lev-1) * 20}px;">   --%>
<%-- 						${comments.add_content } --%>
<!-- 					</td>  -->
<!-- 					<td style="width:140px;"> -->
<%-- 						${comments.add_register_date } --%>
<!-- 					</td> -->
<!-- 					<td style="width:40px"> -->
<%-- 						<c:if test="${userInfo ne null }"> --%>
<%-- 							<a href="javascript:replyComment('${comments.add_id }')"> 답글 </a> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 				<c:if test="${userInfo ne null }"> --%>
<%-- 					<tr id="view_CommentReply_${comments.add_id }" class="view_CommentReplyZone"> --%>
<!-- 						<td style="width:120px; text-align:center"> -->
<%-- 							<input type="hidden" id="add_writer_${comments.add_id }" value="${userInfo.user_name }"/> --%>
<%-- 							${userInfo.user_name } --%>
<!-- 						</td> -->
<!-- 						<td colspan="2" style="width:560px;"> -->
<%-- 							<textarea id="add_content_${comments.add_id }"></textarea> --%>
<!-- 						</td> -->
<!-- 						<td style="width:40px;"> -->
<%-- 							<button onclick="replyCommentSubmit(${comments.board_id},${comments.add_id })">입력</button> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 				</c:if> --%>
<!-- 			</table>  -->
<%-- 			</c:forEach> --%>
		
<!-- 			<input type="hidden" id="board_id" name="board_id"/> -->
<!-- 			<input type="hidden" id="add_content" name="add_content"/> -->
<!-- 			<input type="hidden" id="add_upper_id" name="add_upper_id"/> -->
<%-- 			<input type="hidden" name="board_type" value="${boardContent.board_type }"/> --%>
<!-- 			<input type="hidden" id="add_writer" name="add_writer"/> -->
<%-- 			<input type="hidden" name="insertUrl" value="${nowUrl }"/> --%>
<%-- 		</form> --%>
<%-- 	</c:if>  --%>
<!-- </div> -->
<!-- <div id="view_CommentInputZone"> -->
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${userInfo eq null }">  --%>
<!-- 			로그인 후 댓글입력이 가능합니다. -->
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 		<form id="insertComment" name="insertComment" action="/ASTI/board/insertComment.do" method="post"> --%>
<%-- 			<input type="hidden" name="board_id" value="${boardContent.board_id }"/> --%>
<%-- 			<input type="hidden" name="add_writer" value="${userInfo.user_name }"/>  --%>
<%-- 			<input type="hidden" name="board_type" value="${boardContent.board_type }"/> --%>
<%-- 			<input type="hidden" name="insertUrl" value="${nowUrl }"/> --%>
<!-- 			<table> -->
<!-- 				<tr> -->
<!-- 					<td style="width:120px; text-align:center"> -->
<%-- 						${userInfo.user_name } --%>
<!-- 					</td> -->
<!-- 					<td style="width:460px;"> -->
<!-- 						<textarea name="add_content"></textarea> -->
<!-- 					</td> -->
<!-- 					<td style="width:140px; text-align:center;"> -->
<!-- 						<input type="submit" value="입력"> -->
<!-- 					</td> -->
<!-- 				</tr>	 -->
<!-- 			</table> -->
<%-- 		</form> --%>
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
	
<!-- </div> -->