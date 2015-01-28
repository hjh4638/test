<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ include file="/WEB-INF/common/taglib.jsp" %>
<!-- 	<dl class="id"> -->
	
<!-- 	</dl> -->
<!-- 	<dl class="log"> -->
	
<!-- 	</dl> -->
<!-- 	<dl class="log"> -->
	
<!-- 	</dl> -->
	<dl class="id">
	<c:if test="${login eq null }">
		<form action="login.do" method="post">
			<table id="loginForm">
				<tr>
					<td>ID</td>
					<td><input name="user_id" type="text" style="width:60px;"></td>
					<td>
						<select name="user_sosok">
							<option value="B01">공군</option>
							<option value="B02">육국</option>
							<option value="B03">해군</option>
							<option value="B04">예비역</option>
						</select>
					</td>					
				</tr>
				<tr>
					<td>PW</td>
					<td><input name="user_password" type="password" style="width:60px;"></td>	
				</tr>
			</table>
		<input type="submit" value="로그인">
		<a href="main.do?type=member">회원가입</a>
		</form>
	</c:if>
	<c:if test="${login ne null }">
		<c:if test="${login.user_auth eq 'D03' or login.user_auth eq 'D04' }">
			<a href="admin.do">${login.user_auth_name}</a><br>
		</c:if> 
	${login.user_sosok_name } ${login.user_rank_name } ${login.user_name }
		<form action="logout.do" method="post">
			<input type="submit" value="로그아웃">
		</form>
		<a href="main.do?type=member">회원정보 수정</a>
	</c:if>
	</dl>
	<a href="main.do?type=reserveView" > 
		<dl class="button" style="background-image: url('images/common/left_01.gif');cursor: pointer;">
			<!-- <img src="images/common/left_01.gif"/> -->
		</dl>
	</a>
	<a href="main.do?type=myReserve">
		<dl class="button" style="background-image: url('images/common/left_02.gif');cursor: pointer;">
<!-- 			<img src="images/common/left_02.gif"/> -->
		</dl>
	</a>
	<dl class="button" style="background-image: url('images/common/left_03.gif');cursor: pointer;">
<!-- 		<img src="images/common/left_03.gif"/> -->
	</dl>
	<dl class="button" style="background-image: url('images/common/left_04.gif');cursor: pointer;">
<!-- 		<img src="images/common/left_04.gif"/> -->
	</dl>
	<dl class="button" style="background-image: url('images/common/left_05.gif');cursor: pointer;">
<!-- 		<img src="images/common/left_05.gif"/> -->
	</dl>
	<dl class="button" style="background-image: url('images/common/left_06.gif');cursor: pointer;">
<!-- 		<img src="images/common/left_06.gif"/> -->
	</dl>
	<dl class="button" style="background-image: url('images/common/left_07.gif');cursor: pointer;">
<!-- 		<img src="images/common/left_07.gif"/> -->
	</dl>