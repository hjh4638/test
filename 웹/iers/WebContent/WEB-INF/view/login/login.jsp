<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<script>
$(document).ready(function() {
	$("#user_id").keypress(function(event) {
		if (event.keyCode == 13) {
			checkLogin();
		}
	});
	$("#user_password").keypress(function(event) {
		if (event.keyCode == 13) {
			checkLogin();
		}
	});
});
function checkLogin() {
	if(!$('#user_id').val())
    {
	  alert('아이디를 입력해주세요.');
      $('#user_id').focus();
      return false;
    } else if(!$('#user_password').val()) {
    	alert('비밀번호를 입력해주세요.');
        $('#user_password').focus();
        return false;
    }
		$('#login').attr('action','login.do').submit();
}
function onSubmit(){
	checkLogin();
}
</script>
</head>
<body>
<h4 class="title">로그인</h4>
<div class="loginForm_wrap">
	<div class="loginForm">
			<form id="login" name="login" method="post">
					<div class="userId">
						<label for="userId">아이디</label>
						<select name="user_sosok" style="width:53px; height:25px;">
							<option value="B01">공군</option>
							<option value="B02">육군</option>
							<option value="B03">해군</option>
							<option value="B04">예비역</option>
						</select>
						<input type="text" name="user_id" id="user_id" style="ime-mode:inactive; width:154px;">
					</div>
					<div class="userPwd">
						<label for="password">비밀번호</label>
						<input type="password" id="user_password"  name="user_password">
					</div>
					<a href="#" onclick="onSubmit();"><img class="loginBtn" src="images/layout/btn_login.gif"></a>
			</form>
	</div>							
	<div class="findAccout_wrap">
			<p class="txt01">
				<b>아이디/비밀번호를 잊어버리셨나요?</b><br /><br />
				<span style="padding-left:32px;"><span class="button medium"><button type="button" onclick="location.href='find.do';">아이디/비밀번호 찾기</button></span></span>
			</p>
			<p class="txt02">
				<b>아직 철매 휴양소 회원이 아니세요?</b><br /><br />
				<span style="padding-left:35px;"><span class="button medium"><button type="button" onclick="location.href='main.do?type=member';">철매휴양소 회원가입</button></span></span>
			</p>
	</div>
	<div class="helpMessage_wrap">
			<b>[공군 및 타군 사용자 로그인 안내]</b><br />공군방공유도탄사령부 사격지원대 철매휴양소는 <font color=red>공군 통합인증시스템과 개별적으로 운영</font>되고 있습니다.<br />
			따라서 공군 사용자도 별도로 회원가입을 하셔야 철매휴양소 이용이 가능합니다.<br />
			타군 사용자의 경우도 별도의 회원가입 후 이용이 가능합니다.<br /><br />
	</div>
</div>
</body>
</html>