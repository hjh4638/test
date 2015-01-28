<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%String user_id = request.getParameter("user_id"); %>
<c:set var="user_id" value="<%=user_id %>"/>
<style>
.signFormTable{
	margin-top: 12px;
	border-top:1px solid #cccccc;
	width:728px;
}
.signFormTable th{
	height:35px;
	border:1px solid #cccccc;
	background-color : #F7FAFF;
	color : #2159B0;
}
.signFormTable td{
	padding-left:3px;
	padding-right:3px;
		height:30px;
		border:1px solid #cccccc;
/* 	border-right:0px solid #cccccc;  */
}

.signFormTable, .signFormTable tr, .signFormTable td, .signFormTable th{
	border-collapse: collapse;
	border-spacing: 0;
/* 	text-align: center; */
}
</style>
<script>
	$(function(){
		var user_id = '${USERINFO.user_id}';
		if(Number(user_id) != 0)
			$("input#user_id").attr("readonly","readonly");
	});
	 /* user_id가 있는거면 수정페이지니깐 user_id readonly 먹임 */
/*  $(function(){
	 var user_id = '${user_id}';
	 if(user_id != '')
		$("input#user_id").attr("readonly","readonly");
 }); 
	 에러나서 다시 이 페이지 떳을때 parameter로 user_id를 가지고 있어서 readonly됨;
	 */
	 $(function(){
		 $(".errorMessage").each(function(){
			/* $(this).parent().parent()
			.prepend('<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">'); 
		</div>도 같이 생기네 ㅡ.ㅡ
			*/
		 $(this).parent().parent()
		.prepend('<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">');
		 $(this).appendTo($(this).parent().parent().find('div'));
		 });
	 });
	 
	 function signUpSubmit(){
		 if($("#acceptInfo").attr("checked")=='checked')
		 $("#signUp").submit();
		 else
			 alert("개인정보제공란에 체크해주셔야 가입가능합니다.");
	 }
//	 
//	 function timeoutTest(){
//	 	 $("#acceptInfo").toggle("blind");
//		 		 
//		 setTimeout(timeoutTest(),3000);
//	 }
</script>
<!-- <input type="button" onclick="timeoutTest()"> -->

<center>
<c:if test="${USERINFO.user_id eq null }">
	<h2><img src="<c:url value='/images/title/title_28.gif'/>"></h2>
</c:if>
<c:if test="${USERINFO.user_id ne null }">
	<h2><img src="<c:url value='/images/title/title_29.gif'/>"></h2>
</c:if>
<!-- <div style="width:512px;height:590px;"> -->
<c:if test="${USERINFO.user_id eq null }">
<div style="margin-top:8px;margin-bottom:8px;;width:728px;height:150px;border:1px solid black;overflow-y:scroll;overflow-x:hidden;text-align:left;">

<pre style="margin-left: 3px;">항공전략연구원(이하 "연구원"라 함)은 개인정보보호법 등 관련 법령에 의거하여, 
개인정보를 수집·이용함에 있어 정보주체로부터의 이용 동의 여부를 사전에 고지하고 있습니다.
정보주체가 되는 이용자께서는 아래 내용을 확인하시고, 동의 여부를 결정하여 주시기 바랍니다.

1. 개인정보의 수집 및 이용 목적
연구원은 이용자의 회원관리, 발간물 다운로드 서비스를 제공하기 위해 최초 회원 가입 시 이용자가
작성한 개인 정보를 수집·이용하고 있습니다.

2. 수집하는 개인정보의 항목
- 필수 입력 항목: 로그인 ID(이메일), 비밀번호, 성명, 생년월일, 성별, 회원사

3. 개인정보의 보유 및 이용기간: 서비스 탈퇴 시까지

4. 개인정보의 제3자 제공의 관한 사항
연구원은 수집·보유하고 있는 개인정보를 이용자의 동의 없이 제3자에게 제공하지 않습니다.

5. 동의를 거부할 권리 및 동의 거부에 따른 안내
이용자는 개인정보 수집에 대한 거부를 할 수 있으며, 이 경우 회원 가입이 이루어지지 않음에 따라 
연구원의 회원관리, 발간물 다운로드 서비스를 이용할 수 없습니다.
</pre>

</div>

<!-- <div style="width:510px;height:354px;border:1px solid black;overflow-y:hidden;overflow-x:hidden;"> -->
개인정보 제공 동의하십니까? 
<input name="checkInfo" type="checkbox" value="true" id="acceptInfo">
<label for="acceptInfo">동의</label>
<!-- commandName는 따로 이름 안정하면 객체명으로 해야함 -->
<!-- url 같아서 action 생략가능 -->
<!-- 그러나 그렇게 되면 현재 파라미터인 user_id까지 두번 전송되 ㅡ.ㅡ -->
</c:if>
<c:if test="${USERINFO.user_id ne null }">
<input type="hidden" id="acceptInfo" checked="checked">
</c:if>
<form:form id="signUp" commandName="astiUserDTO" action="/ASTI/main/signUp.do" method="POST">
		<table class="signFormTable">
		<tr>
			<th style="width:150px;"> 
				<form:label path="user_id" >Email(ID 대용) </form:label>
			</th>
			<td>
				<form:input path="user_id" size="30" />
				<div class="ui-widget errorEfect">
					<p><form:errors path="user_id" cssClass="errorMessage"/></p>
				</div>
			</td>
		</tr>
		<tr>
		    <th> 
		    	<form:label path="user_name" >이름 </form:label>
			</th>
			<td>
				<form:input path="user_name"  />
				<div class="ui-widget errorEfect">
					<p><form:errors path="user_name" cssClass="errorMessage"/></p>
				</div>
		    </td>
		</tr>
		<c:if test="${USERINFO.user_id ne null }">
			 <tr>
				<th>
					<form:label path="origin_password" >기존 비밀번호</form:label>
				</th>
				<td>
					<form:password path="origin_password" />
					<div class="ui-widget errorEfect">
						<p><form:errors path="origin_password" cssClass="errorMessage"/></p>
					</div>
					<form:hidden path="user_authority"/>
				</td>  
			</tr>
		</c:if>
		<tr>
			<th>
				<form:label path="user_password" >비밀번호</form:label>
			</th>
			<td>
				<form:password path="user_password" />
				<div class="ui-widget errorEfect">
					<p><form:errors path="user_password" cssClass="errorMessage"/></p>
				</div>
			</td>  
		</tr>
		<tr>
			<th> 
				<form:label path="confirm_password" >비밀번호 다시입력</form:label>
			</th>
			<td>
				<form:password path="confirm_password" />
				<div class="ui-widget errorEfect">
					<p><form:errors path="confirm_password" cssClass="errorMessage"/></p>
				</div>
			</td> 
		</tr> 
		<tr>
			<th> 
				<form:label path="user_birth_date" >생년월일 </form:label>
			</th>
			<td>
				<form:input path="user_birth_date"/>
				<div class="ui-widget errorEfect">
					<p><form:errors path="user_birth_date" cssClass="errorMessage"/></p>
				</div>
			</td>
		</tr>
		<tr>
			<th>
				<form:label path="user_sex" >성별 </form:label>
			</th>
			<td>
				<form:radiobutton path="user_sex" label="남" value="M" />
				<form:radiobutton path="user_sex" label="여" value="F" />
				<div class="ui-widget errorEfect">
					<p><form:errors path="user_sex" cssClass="errorMessage"/></p>
				</div>
			</td>
		</tr>
		<tr>
			<th>
				<form:label path="user_job">회원사</form:label>
			</th>
			<td>
				<form:select path="user_job">
				<form:option value="">없음</form:option>
				<c:forEach var="dept" items="${userDeptList }">
					<form:option value="${dept.code_id }"><c:out value="${dept.code_name }"/></form:option>
				</c:forEach>
		</form:select>
			</td>
		</tr>
		</table>
				<a onclick="signUpSubmit()" style="margin-top: 15px;">
					<c:if test="${USERINFO.user_id eq null }">
						<img src="<c:url value='/images/btn/btn_01_0326.gif'/>">
					</c:if>
					<c:if test="${USERINFO.user_id ne null }">
						<img src="<c:url value='/images/btn/btn_06.gif'/>">
					</c:if>
				</a>
				<a onclick="javascript:history.back(-1)" style="margin-top: 15px;">
					<img src="<c:url value='/images/btn/btn_02_0326.gif'/>">
				</a>
<!-- 				<input style="margin-top: 15px;" type="button" value="승인요청" onclick="signUpSubmit()">  -->
<!-- 				<input style="margin-top: 15px;" type="button" value="뒤로가기" onclick="javascript:history.back(-1)">  -->
	</form:form>
<!-- </div> -->
<!-- </div> -->
</center>