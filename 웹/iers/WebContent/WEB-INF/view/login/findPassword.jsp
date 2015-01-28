<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디/비밀번호 찾기</title>
<style>

.loginFailForm{
	border: 1px solid black;
	width:70%;
	border-collapse: collapse;
	border-spacing: 0px;
	overflow:scroll;
	margin-top: 10px;
	margin-bottom: 10px;
	text-align: center;
}
.loginFailForm tr,.loginFailForm th,.loginFailForm td{
	border:1px solid black;
}
.loginFailForm th {
	background-color: #69c;
	color: #fff;
	font-weight: bold;
	text-align: center;
	padding: 5px;
}
</style>
<script>
var check = 0;
function getApproveNumber(){
	var id=$("#user_id").val();
	var sosok=$("#user_sosok").val();
	var idCheck2 = /([^0-9\-])/;
	if(!$('#user_id').val() || $('#user_id').val().length < 4 || idCheck2.test($('#user_id').val()))
    {
	  alert('아이디는 (13-12345)의 군번 형식으로 입력해주세요.');
      $('#user_id').focus();
      return false;
    } else if(!$('#phone').val() || $('#phone').val().length < 12 || idCheck2.test($('#phone').val())) {
    	alert('휴대전화번호는 (01x-xxxx-xxxx)의 형식으로 입력해주세요.');
      	$('#phone').focus();
      	return false;
    }

	 if(check == 0)
	 {
		 $.ajax({
			  url: "getApproveNumber.do",
			  type: "POST",
			  dataType:"json",
			  data:{
				    user_id: id,
			    	user_sosok:sosok,
			    	phone:$("#phone").val()
			  },
			  success: function(data){
				  if(data =="success"){
					  	 check = 1;
						 alert("인증번호가 발송되었습니다!\n\n발송된 인증번호를 입력해주세요.");
						 $("#user_id").attr("disabled", "disabled");
						 $("#user_sosok").attr("disabled", "disabled"); 
						 $("#phone").attr("disabled", "disabled");
						 $("#keyInit").show();
						 $('#keyToInit').focus();
						 $("#submitBtn").text('비밀번호 받기');
						 
				  }
				  else{
					alert("인증번호 발송에 실패하였습니다.\n\n입력하신 정보를 다시한번 확인해주세요.");  
				  }
			  }
		});
		 
	 } else if(check == 1) {
		 
			$.ajax({
				  url: "changePassword.do",
				  type: "POST",
				  dataType:"json",
				  data:{
					    id: id,
				    	sosok:sosok,
				    	approve_key:$("#keyToInit").val()
				  },
				  success: function(data){
					  if(data =="success"){
						  alert("임시 비밀번호를 발송하였습니다.");
						  location.href='main.do?type=login';
					  }
					  else{
						alert("임시비밀번호 발송에 실패하였습니다.\n\n인증번호가 올바르지 않습니다.");  
					  }
				  }
			});
		 
	 } else {
		 alert("실패하였습니다.\n\n잠시후 다시 시도하시기 바랍니다.");  
	 }
}
</script>
</head>
<body>
<h4 class="title">아이디/비밀번호 찾기</h4>
<h6 class="memo">분실하신 정보를 휴대전화 인증 후 문자(SMS)로 임시 비밀번호를 발송해드립니다. </h6>
	<div style="width:100%">
		<table class="bbs_list">
			<tr>
				<td class="title_right">ID</td>
				<td class="title_left"><select id="user_sosok">
						<option value="B01">공군</option>
						<option value="B02">육군</option>
						<option value="B03">해군</option>
						<option value="B04">예비역</option>
					</select> <input id="user_id" type="text" style="width:100px;"></td>
			</tr>
			<tr>
				<td class="title_right">휴대전화번호</td>
				<td class="title_left"><input id="phone" type="text" style="width:170px;"></td>
			</tr>
			<tr id="keyInit" style="display:none;">
				<td class="title_right">인증번호</td>
				<td class="title_left"><input id="keyToInit" type="text" style="width:170px;"></td>
			</tr>
		</table>
	</div>
	<div style="width:119px; float:right; margin-top:10px;">
		<span class="btn_blue btn_short" style="width:119px;">
			<a href="#" id="submitBtn" onclick="javacript:getApproveNumber();">인증번호 받기</a>
		</span>
	</div>
	
</body>
</html>