<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${astiAdminSearchDTO.astiBoardPaginationDTO }"/>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-1.8.2.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.9.1.custom.min.js'/>"></script> --%>
<script src="<c:url value='/js/admin/admin.js'/>"></script>
<!--  <script> -->
<!--  	window.document.onkeypress = enterKeyPress -->
<!-- </script>  -->
<script>
$(function(){
	var code = '${param.searchType}';
	if(code =='user_id')
		$('#user_id').attr("selected","selected");
	else if(code == 'user_authority')
		$('#user_auth').attr("selected","selected");
	else if(code == 'user_name')
		$('#user_name').attr("selected","selected");
	
	var detail = '${param.searchDetail}';
	$("#searchDetail").val(detail);
});

$(function(){
	$("#passwordChangeDialog").dialog({
			autoOpen : false,
			width: 300,
			height: 200,
			modal: true,
			buttons:{
				"닫기" : function(){
					$(this).dialog("close");
				}
			}
		});
});
function openPasswordChangeDialog(user_id){
 	$("#passwordChangeUserId").val("");
 	$("#passwordChangePassword").val("");
	
	$("#passwordChangeUserId").val(user_id);
	$("#passwordChangeDialog").dialog("open");
}
function subminPasswordChange(){
	var user_id=$("#passwordChangeUserId").val();
	var user_password=$("#passwordChangePassword").val();
	
	$.post("/ASTI/ajax/userPasswordChange.do",
		{
		user_id:user_id,
		user_password:user_password
		},
		function(data){
			if(data =="success")
				alert("패스워드 변경 성공");
			else
				alert("에러");
		}
	);
}

</script>
		<form name="authChange" id="authChange" action="authChange.do" method="post">
			<table id="admin_member_table" cellpadding="0" cellspacing="0">
				<tr>
					<th>ID</th><th>비밀번호</th><th>성명</th><th>권한</th><th>삭제</th>
				</tr>
			
			<c:forEach items="${astiUserDTO }" var="dto" >
				<tr>
					<td><input type="hidden" name="user_id" value="${dto.user_id }"/><c:out value="${dto.user_id }"/></td>
					<td>
<!-- 						변경버튼 -->
						<a onclick="openPasswordChangeDialog('${dto.user_id}')">
							<img src="<c:url value='/images/btn/btn_06.gif'/>">
						</a>
					</td>
					<td><c:out value="${dto.user_name }"/></td>
					<td>
						<select name="user_authority">
							<c:forEach items="${astiCodeDTO}" var="codeDTO">
								<option value="${codeDTO.code_id }"
								<c:if test="${codeDTO.code_id eq dto.user_authority }">
									selected="selected"
								</c:if>>
									${codeDTO.code_name } 
								</option>
								
							</c:forEach>
							<c:if test="${dto.user_authority eq '' or dto.user_authority eq null}"> 
								<option value="none" selected="selected">미승인</option>
							</c:if>
						</select>
					</td>
					<td>
						<a href="javascript:deleteMember('${dto.user_id}')">
							<img src="<c:url value='/images/btn/btn_04_0320.gif'/>"/>
						</a>
						
					</td>
				</tr>
			</c:forEach>
			</table>
			<a href="javascript:changeAuth()">
			<img src="<c:url value='/images/btn/btn_01.gif'/>"/>
			</a> 
		</form>
		<p>
		<c:if test="${pagination.beginPage ne 1 }">
		<a href="javascript:pageMove('1')">◁◁</a> &nbsp;
		<a href="javascript:pageMove('${pagination.beginPage-1 }')">◀</a>
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
		<a href="javascript:pageMove('${pagination.endPage+1 }')">▶</a> &nbsp;
		<a href="javascript:pageMove('${pagination.lastPage }')">▷▷</a>
		</c:if>
		</p>
			<input type="hidden" name="currentPage" id="currentPage" value="${pagination.currentPage }"/>
			<select id="searchType">
				<option id="user_id" value="user_id">ID</option> 
				<option id="user_auth" value="user_authority">권한</option>
				<option id="user_name" value="user_name">이름</option> 
			</select>
			<input type="text" id="searchDetail"/> 
			<a href="javascript:searchAdminBoard()" >
				<img src="<c:url value='/images/btn/btn_01_0320.gif'/>"/>
			</a> 
			| <a href="auth.do">
				<img src="<c:url value='/images/btn/btn_02.gif'/>"/>
			</a>
			
<div id="passwordChangeDialog" class="dialog" title="비밀번호 변경">
	<p><input readonly="readonly" type="text" id="passwordChangeUserId" size="40"
			  style="border: 0px;"></p>
	<p>패스워드 변경 : <input type="password" id="passwordChangePassword"></p>
	<a onclick="subminPasswordChange()">
		<img src="<c:url value='/images/btn/btn_02_0320.gif'/>">
	</a>
</div>