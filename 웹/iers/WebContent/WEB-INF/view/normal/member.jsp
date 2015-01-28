<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보</title>
<script>
$(function() {
	$( "#user_service_term" ).datepicker(
			{ 
				showOtherMonths: true,
				selectOtherMonths: true,
				dateFormat:"yy-mm-dd",
				changeMonth: true,
				changeYear: true,
			 	yearRange: "1950:+0Y"
			}
	);
	
});
function checkJoin() {
	var idCheck2 = /([^0-9\-])/;
	if(!$('#user_id').val() || $('#user_id').val().length < 4 || idCheck2.test($('#user_id').val()))
    {
	  alert('아이디는 (13-12345)의 군번 형식으로 입력해주세요.');
      $('#user_id').focus();
      return false;
    <c:if test="${login ne null }">
	} else if(!$('#ori_password').val()) {
    	alert('기존 비밀번호가 입력되지 않았습니다.');
    	 $('#ori_password').focus();
		return false;
    </c:if>
    } else if(!$('#password').val() || $('#password').val().length < 7) {
    	alert('비밀번호를 7자 이상 입력해주세요.');
        $('#password').focus();
        return false;
    } else if(!$('#password2').val() || $('#password2').val().length < 7) {
    	alert('비밀번호 확인을 7자 이상 입력해주세요.');
        $('#password2').focus();
        return false;
    } else if($('#password').val() != $('#password2').val()) {
    	alert('비밀번호와 비밀번호 확인이 서로 일치하지 않습니다.');
    	$('#password2').val('');
      	$('#password2').focus();
      	return false;
    } else if(!$('#sosok').val() || $('#sosok').val().length < 4) {
    	alert('소속을 입력해 주세요.');
      	$('#sosok').focus();
      	return false;
    } else if(!$('#name').val() || $('#name').val().length < 2) {
    	alert('성명을 입력해주세요.');
      	$('#name').focus();
      	return false;
    } else if(!$('#mobile').val() || $('#mobile').val().length < 12 || idCheck2.test($('#mobile').val())) {
    	alert('휴대전화번호는 (01x-xxxx-xxxx)의 형식으로 입력해주세요.');
      	$('#mobile').focus();
      	return false;
    } else if(!$('#user_service_term').val()) {
    	alert('입대일을 선택하세요');
      	return false;
    <c:if test="${login eq null }">
	} else if(!$('#file').val()) {
    	alert('군복무 증명서 파일을 선택해주세요.\n\n파일이 없으면 가입승인이 이루어 지지 않습니다.');
		return false;
	</c:if>
	}
	
	 <c:if test="${login eq null }">
	download_start = confirm("정보를 다시한번 확인해주세요..\n\n====================================\n소속 : "+$("#gubunsosok option:selected").text()+" "+$("#sosok").val()+"\n계급/이름 : "+$("#rankname option:selected").text()+" "+$("#name").val()+" \n휴대전화 : "+$("#mobile").val()+"\n====================================\n\n입력하신 정보로 가입하시겠습니까?");
	if(download_start == true){
		$('#userDTO').attr('action','member.do').submit();
	}else{
		return false;
	}</c:if>
	<c:if test="${login ne null }">
	$('#userDTO').attr('action','member.do').submit();
	</c:if>
}
function onSubmit(){
	checkJoin();
}
</script>
<link rel="stylesheet" href="<c:url value='/css/humanity/jquery-ui-1.9.1.custom.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/humanity/jquery-ui-1.9.1.custom.min.css'/>"/>
</head>
<body>
<h4 class="title"><c:if test="${login ne null }">개인정보 수정</c:if><c:if test="${login eq null }">회원가입</c:if></h4>
<c:if test="${login eq null }">
<h6 class="memo">철매휴양소 가입을 환영합니다.</h6>
</c:if>
<form:form commandName="userDTO" method="POST" enctype="multipart/form-data">
<div style="width:100%;">
<table class="bbs_list">
			<tr>
				<td class="title_right">아이디(군번)</td>
				<td class="title_left">
				<c:if test="${login ne null }">
					<input type="text" readonly="readonly" id="user_id" name="user_id" size="30" value="${userDTO.user_id }"/>
				</c:if>
				<c:if test="${login eq null }">
					<form:input path="user_id" size="30" />
				</c:if>
				</td>
			</tr>
			<c:if test="${login ne null }">
				<tr>
					<td class="title_right">기존 패스워드</td>
					<td class="title_left">
						<form:password path="origin_password" id="ori_password" size="30" />
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="title_right">패스워드</td>
				<td class="title_left">
					<form:password path="user_password" id="password"  size="30" />
				</td>
			</tr>
			<tr>
				<td class="title_right">패스워드확인</td>
				<td class="title_left">
					<form:password path="password_confirm" id="password2"  size="30"/>
				</td>
			</tr>
			<tr>
				<td class="title_right">소속</td>
				<td class="title_left">
				<c:if test="${login ne null }">
					<input type="hidden" name="user_sosok" value="${userDTO.user_sosok }">
				</c:if>
				<c:if test="${login eq null }">
					<form:select path="user_sosok" id="gubunsosok">
						<c:forEach var="sosok" items="${sosokList }">
							<form:option value="${sosok.code_id }">${sosok.code_name }</form:option>
						</c:forEach>
					</form:select>
				</c:if>
				<form:input path="user_sosok_detail" id="sosok" size="30" />
				</td>
			</tr>
			<tr>
				<td class="title_right">계급 / 이름</td>
				<td class="title_left">
					<form:select path="user_rank" id="rankname">
						<c:forEach var="rank" items="${rankList }">
							<form:option value="${rank.code_id }">${rank.code_name }</form:option>
						</c:forEach>
					</form:select>
					<form:input path="user_name" id="name" size="30" />
				</td>
			</tr>
			<tr>
				<td class="title_right">핸드폰번호</td>
				<td class="title_left">
					<form:input path="user_cellular_phone" id="mobile" size="30" />
				</td>
			</tr>
			<tr>
				<td class="title_right">입대일</td>
				<td class="title_left">
					<form:input path="user_service_term" size="30" id="user_service_term" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td class="title_right">군복무증명서</td>
				<td class="title_left">
					<c:if test="${userDTO.user_file_name ne null }">
						기존파일 : ${userDTO.user_file_name }<br>
					</c:if>
					<input type="file" name="file" id="file" style="width:250px;">
					<input type="hidden" name="user_file_id" value="${userDTO.user_file_id }">
					<input type="hidden" name="user_file_name" value="${userDTO.user_file_name }">
				</td>
			</tr>
		</table>
</div>
	<div style="width:90px; float:right; margin-top:10px;">
		<span class="btn_blue btn_short">
			<a href="#" onclick="javacript:onSubmit();"><c:if test="${login ne null }">정보수정</c:if><c:if test="${login eq null }">회원가입</c:if></a>
		</span>
	</div>
</form:form>
</body>
</html>