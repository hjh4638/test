<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>jQuery UI Position - Image Cycler</title>
	<script type="text/javascript" src="<c:url value='/js/jquery-1.8.2.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.9.1.custom.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.validate.min.js'/>"></script>
<!-- 	<link rel="stylesheet" type="text/css" media="screen" href="css/validateCSS/screen.css" /> -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui-1.8.16.custom.css'/>"/>
	
	<script>

	$(function(){
		$("#user_birth_date").datepicker({
			dateFormat : 'yy/mm/dd',
			changeMonth: true,
			changeYear: true,
			yearRange: "c-100:c",
			showOn: "both",
			showAnim: '',
			duration: '',
			buttonImage: "images/calender.gif",
			buttonImageOnly: true,
			numberOfMonths: 1,
			onClose: function(selectedDate){
				$("#user_birth_date").datepicker("option", "minDate", selectedDate);
			}
		});
		
		$("#user_id").focusout(function(){
			var user_id = $("#user_id").val(); //이메일
			
			if(user_id != null){
				$.get("isUserIdDup.do",{user_id:user_id},function(isDup){
					if(isDup == "true"){
						$("#dup").text("사용불가능");
					}else{
						$("#dup").text("사용가능");
					}
				});
			}
		});
		
		$("#signupForm").validate({
			rules:{
				user_id : { 
					required: true,
					email:true
				},
				user_name : "required",
				password: {
					required: true,
					minlength: 8
				},
				confirm_password: {
					required: true,
					minlength: 8,
					equalTo: "#user_password"
				},
				user_birth_date : "required"
			},
			messages:{
				user_id : "이메일 오류",
				user_name: "이름이 필요합니다.",
				password: {
					required: "비밀번호를 입력해주세요",
					minlength: "비밀번호는 8자리 이상"
				},
				confirm_password: {
					required: "비밀번호를 입력해주세요",
					minlength: "비밀번호는 8자리 이상",
					equalTo: "비밀번호가 다릅니다."
				},
				user_birth_date : "생년월일을 입력해세요"
			}
		});
		$("#signUpDiv").dialog({
			autoOpen : false,
			height: 400,
			width: 500,
			modal: true,
			buttons:{
				"계정생성" : function(){
					$("#submitBtn").click();
				},
				"닫기" : function(){
					$(this).dialog("close");
				}
			}
		});
		$("#joinBtn").click(function(){
			$("#signUpDiv").dialog("open");
		});
		
		$("#signInDiv").dialog({
			autoOpen : false,
			height: 400,
			width: 500,
			modal: true,
			buttons:{
				"로그인" : function(){
					var user_id = $("#sign_user_id").val();
					var user_password = $("#sign_user_password").val();
					$.get("isValidSignIn.do",{user_id:user_id,user_password:user_password},function(isValid){
						alert(isValid.test); 
						if(isValid == "true"){ 
							alert("로그인성공"); 
							window.location.href="top.do";
						}
						else if(isValid == "notApproval"){
							alert("계정 승인이 이루어지지 않았습니다.");
						}
						else{
							alert("아이디와 비밀번호를 다시확인 하여주십시오");
						}
					});
				},
				"닫기" : function(){
					$(this).dialog("close");
				}
			}
		});
		$("#signinBtn").click(function(){
			$("#signInDiv").dialog("open");
		});
		
	});
	
	$(function(){
		$("#signoutBtn").click(function(){
			window.location.href="sign_out.do";
		});
		$("#changeInfoBtn").click(function(){
			$("#changeInfoDiv").dialog("open");
		});
		
		$("#changeInfoDiv").dialog({
			autoOpen : false,
			height: 400,
			width: 500,
			modal: true,
			buttons:{
				"수정" : function(){
					//not done yet
					var user_id = $("#sign_user_id").val();
					var user_password = $("#sign_user_password").val();
					$.get("changeUserInfo",{user_id:user_id,user_password:user_password},function(isValid){
						if(isValid == "true"){
							alert("수정완료");
							window.location.href="top.do";
						}else{
							alert("수정내용을 다시한번 확인해주십시오")
						}
					});
				},
				"취소" : function(){
					$(this).dialog("close");
				},
				"탈퇴" : function(){
					$(this).dialog("close");
				}
			}
		});
	});
	</script>
<body>
	<c:choose>
		<c:when test="${signed == 'true'}"> 
			<script> alert("${signed}");</script>
			<button id="signoutBtn"> 로그아웃</button>
			<button id="changeInfoBtn"> 회원정보수정 </button>
		<div id ="changeInfoDiv">
			<form id="changeInfoForm" action="change_info.do" method="POST">
			<table>
			<tr>
				<td> <label for="user_id">Email(ID 대용) </label><input type="text" name="user_id" id="user_id" value="${USERINFO.user_id }" disabled="disabled"/></td>
			    <td> <label for="user_name">이름 </label> 
			    	<input type="text" name="user_name" id="user_name" value="${USERINFO.user_name }" /> </td>
			</tr>
			<tr>
				<td> <label for="password">변경될 비밀번호</label>  <input type="password" name="user_password" id="user_password" value=""/> </td>
				<td> <label for="confirm_password">변경될 비밀번호(다시입력)</label> <input type="password" name="confirm_password" id="confirm_password" value=""/> </td> 
			</tr>
			<tr>
				<td> <label for="user_birth_date">생년월일</label>  <input type="text" name="user_birth_date" id="user_birth_date" value="${USERINFO.user_birth_date}"/> </td>
				<td>
				성별 
				<input type="radio" id="user_sex_m" name ="user_sex" value="M"> <label for="sex_m"> 남</label>
				<input type="radio" id="user_sex_f" name ="user_sex" value="F"> <label for="sex_f"> 녀</label>
				</td>
				
			</tr>
			<tr>
				<td colspan="2"> <label for="com">회원사 </label> <input type="text" name="com" id="com" value=""/> </td>	
			</tr>
			</table>
			</form>
		</div>
			
		</c:when>
		<c:otherwise>
		<script> alert("${signed}");</script>
			<button id="joinBtn">회원가입</button>
			<button id="signinBtn"> 로그인</button>
		<div id="signUpDiv" title="회원가입">
		<form id="signupForm" class="cmxform" action="sign_up.do" method="POST">
			<table>
			<tr>
				<td> <label for="user_id">Email(ID 대용) </label><input type="text" name="user_id" id="user_id" value="" /></td>
			    <td> <label for="user_name">이름 </label> 
			    	<input type="text" name="user_name" id="user_name" value="" /> </td>
			</tr>
			<tr>
				<td> <label for="password">비밀번호</label>  <input type="password" name="user_password" id="user_password" value=""/> </td>
				<td> <label for="confirm_password">비밀번호(다시입력)</label> <input type="password" name="confirm_password" id="confirm_password" value=""/> </td> 
			</tr>
			<tr>
				<td> <label for="user_birth_date">생년월일</label>  <input type="text" name="user_birth_date" id="user_birth_date" value=""/> </td>
				<td>
				성별 
				<input type="radio" id="user_sex" name ="user_sex" id="sex_m" value="M"> <label for="sex_m"> 남 </label>
				<input type="radio" id="user_sex" name ="user_sex" id="sex_f" value="F"> <label for="sex_f"> 녀 </label>
				</td>
			</tr>
			<tr>
				<td> <label for="com">회원사 </label> <input type="text" name="com" id="com" value=""/> </td>
				<td> <button id="submitBtn" style="visibility:hidden;"></button> </td>
			</tr>
			</table>
			
			</form>
		</div>
		<div id="signInDiv" title="로그인">
				<table>
				<tr>
					<td> <label for="sign_user_id"> ID </label><input type="text" name="sign_user_id" id="sign_user_id" value="" /></td>
				<tr>
				<tr>
					<td> <label for="sign_user_password"> Password </label><input type="password" name="sign_user_password" id="sign_user_password" value="" /></td>
				</tr>
				</table>
		</div>

		</c:otherwise>
	</c:choose>
</body>
</html>