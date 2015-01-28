<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원관리</title>
<script>
function Filter(){
	var form = document.forms["filter"];
	form.submit();
}
function filterData(id){
	location.href="admin.do?type=memberManage&auth_filter="+id;
}
function initPassword(id,sosok){
	var paramId=id;
	var paramSosok=sosok;
	$.ajax({
		  url: "initPassword.do",
		  type: "POST",
		  dataType:"json",
		  data:{
			    id: paramId,
		    	sosok:paramSosok
		  },
		  success: function(data){
			  alert(data+"로 비밀번호가 초기화 되었습니다");
		  }
	});
	
}

</script>
</head>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert2">일일결산조회</span></a>
</div>
	<select name="auth_filter" onchange="filterData($(this).val())">
		<option value="">전체</option>
		<c:forEach var="auth" items="${authList }">
			<option value="${auth.code_id }"
			<c:if test="${param.auth_filter eq auth.code_id }">
			selected="selected"
			</c:if>
			>${auth.code_name }</option>
		</c:forEach>
	</select>
<table class="bbs_list">
	<tr>
		<th>아이디</th>
		<th>계급</th>
		<th>이름</th>
		<th>임관일</th>
		<th>소속</th>
		<th>부대</th>
		<th>예약점수</th>
		<th>상태</th>
		<th>관리</th>
	</tr>

	<c:forEach var="user" items="${userData}" varStatus="loop">
		<form action="admin/memberManage.do" method="post">
		<tr>
			<td>
				${fn:escapeXml(user.user_id)}
			</td>
			<td>
				${fn:escapeXml(user.user_rank_name)}
			</td>
			<td>
				${fn:escapeXml(user.user_name)}
			</td>
			<td>
				${fn:escapeXml(user.user_service_term)}
			</td>
			<td>
				${fn:escapeXml(user.user_sosok_name)}
			</td>
			<td>
				${fn:escapeXml(user.user_sosok_detail)}
			</td>
			<td>
				${fn:escapeXml(user.user_score)}
			</td>
			<td>
				<select name="user_auth" style="width:90px;">
					<c:forEach var="auth" items="${authList }">
						<option value="${auth.code_id }"
						<c:if test="${auth.code_id eq user.user_auth}"> selected="selected"</c:if>
						>${auth.code_name }</option>
					</c:forEach>
				</select>
			</td>
		<%-- 
			<td>
				<c:if test="${user.user_file_id ne null }">
<!-- 					<form action="admin/download.do" method="post"> -->
					<input type="hidden" name="file_id" value="${user.user_file_id }"> 
						<input type="hidden" name="file_name" value="${user.user_file_name }"> 
						<a href="" >증명서</a>
<!-- 					</form>				 -->
				</c:if>
			</td> --%>
			<td>
				<input type="hidden" name="user_id" value="${user.user_id }">
				<input type="hidden" name="user_sosok" value="${user.user_sosok }">
				<c:if test="${user.user_file_id ne null }"><span class="button medium"><button type="button" onclick="location.href='admin/download.do?file_id=${user.user_file_id }';">증명서</button></span></c:if>
				<span class="button medium"><button type="submit">정보갱신</button></span>
				<span class="button medium"><button type="button" onclick="initPassword('${user.user_id}','${user.user_sosok }')">비번초기화</button></span>
			</td>
		</tr>
		</form>
	</c:forEach>
</table>
</body>
</html>