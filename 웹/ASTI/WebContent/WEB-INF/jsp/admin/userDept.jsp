<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-1.8.2.js'/>"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.9.1.custom.min.js'/>"></script> --%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
.userDetpTable{
	margin-top: 12px;
	border-top:1px solid #cccccc;
	width:400px;
}
.userDetpTable th{
	height:35px;
	border:1px solid #cccccc;
	background-color : #F7FAFF;
	color : #2159B0;
}
.userDetpTable td{
	padding-left:3px;
	padding-right:3px;
		height:30px;
		border:1px solid #cccccc;
/* 	border-right:0px solid #cccccc;  */
}

.userDetpTable, .userDetpTable tr, .userDetpTable td, .userDetpTable th{
	border-collapse: collapse;
	border-spacing: 0;
	text-align: center;
}
</style>
<script>
function showConfirm(th){
	var td = $(th).parent();
	td.children().remove(); 
	td.siblings().find(".code_name").removeAttr("readonly");
	td.append('<a onclick="updateUserDept(this)"><img src="<c:url value='/images/btn/btn_03_0326.gif'/>"/></a>');
	td.append('<a onclick="hideConfirm(this)"><img src="<c:url value='/images/btn/btn_04_0326.gif'/>"/></a>');
}
function hideConfirm(th){
	var td= $(th).parent();
	td.children().remove();
	td.siblings().find(".code_name").attr("readonly","readonly");
	td.append('<a onclick="showConfirm(this)"><img src="<c:url value='/images/btn/btn_03_0320.gif'/>"/></a>');
	td.append('<a onclick="deleteUserDept(this)"><img src="<c:url value='/images/btn/btn_04_0320.gif'/>"/></a>');
}
function updateUserDept(th){
	var td=$(th).parent().siblings();
	var code_id = td.find(".code_id").val();
	var code_name = td.find(".code_name").val();
	
	$.post("/ASTI/ajax/mergeUserDept.do",{code_id:code_id,code_name:code_name},function(result){
		if(result == "success"){
			location.href='${cp}/admin/auth.do?tab=4';
		}else{
			alert("글자수가 초과되었습니다.");
		}
	});
}
function deleteUserDept(th){
	var td=$(th).parent().siblings();
	var code_id = td.find(".code_id").val();
	if(confirm("정말로 삭제하시겠습니까?")){	
		$.post("/ASTI/ajax/deleteUserDept.do",{code_id:code_id},function(result){
			if(result == "success"){
				location.href='${cp}/admin/auth.do?tab=4';
			}else{
				alert("실패");
			}
		});
	}
}
function insertUserDept(){
	var code_name=$("#userDeptInsertText").val();
	$.post("/ASTI/ajax/mergeUserDept.do",{code_name:code_name},function(result){
		if(result == "success"){
			location.href='${cp}/admin/auth.do?tab=4';
		}else{
			alert("글자수가 초과되었습니다.");
		}
	});
}

</script>
<center>
<table class="userDetpTable">
	<tr>
		<th>회원사</th>
		<th></th>
	</tr>
	<c:forEach var="code" items="${userDept}" varStatus="index">
		<tr>
			<td> 
				<input readonly="readonly" class="code_name" name="code_name" type="text" value="<c:out value="${code.code_name }"/>">
				<input class="code_id" name="code_id" type="hidden" value="<c:out value="${code.code_id }"/>">
			</td>
			<td>
<!-- 				<input type="button" value="수정" onclick="showConfirm(this)"> -->
<!-- 				<input type="button" value="삭제" onclick="deleteUserDept(this)" > -->
<!-- 				수정 -->
				<a onclick="showConfirm(this)">
					<img src="<c:url value='/images/btn/btn_03_0320.gif'/>"/>
				</a>
<!-- 				삭제 -->
				<a onclick="deleteUserDept(this)">
					<img src="<c:url value='/images/btn/btn_04_0320.gif'/>"/>
				</a>
			</td>
		</tr>
	</c:forEach>
</table>

<label>회원사</label><input type="text" id="userDeptInsertText">
<!-- <input type="button" value="입력" onclick="insertUserDept()"> -->
<a onclick="insertUserDept()">
	<img src="<c:url value='/images/btn/btn_02_0320.gif'/>"/>
</a>
</center>
