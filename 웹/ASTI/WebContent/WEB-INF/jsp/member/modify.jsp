<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id ="changeInfoDiv" title="회원정보수정">
	<form id="changeInfoForm" action="change_info.do" method="POST">
	<table>
	<tr>
		<td> <label for="user_id">Email(ID 대용) </label></td>
	    <td> <label for="user_name">이름 </label></td> 
	</tr>
	<tr>    
	    <td><input type="text" name="user_id" id="user_id" value="${USERINFO.user_id }" disabled="disabled"/></td>
	    <td><input type="text" name="user_name" id="user_name" value="${USERINFO.user_name }" /> </td>
	</tr>
	<tr>
		<td> <label for="password">비밀번호</label></td><td> <label for="confirm_password">비밀번호(다시입력)</label></td>
	</tr>
	<tr>
		<td><input type="password" name="user_password" id="user_password" value=""/> </td><td> <input type="password" name="confirm_password" id="confirm_password" value=""/> </td> 
	</tr>
	<tr>
		<td> <label for="user_birth_date">생년월일</label></td><td>성별 </td>
	</tr>
	<tr>
		<td>  <input type="text" name="user_birth_date" id="user_birth_date" value=""/> </td>
		
		<td>
			<input type="radio" id="user_sex" name ="user_sex" id="sex_m" value="M"> <label for="sex_m"> 남</label>
			<input type="radio" id="user_sex" name ="user_sex" id="sex_f" value="F"> <label for="sex_f"> 여</label>
		</td>
		
	</tr>
	<tr>
		<td colspan="2"> <label for="com">회원사 </label></td>	
	</tr>
	<tr>
		<td> <input type="text" name="com" id="com" value=""/> </td>
	</tr>
	</table>
	</form>
</div>