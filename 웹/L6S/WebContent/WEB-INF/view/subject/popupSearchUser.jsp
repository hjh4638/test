<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
.readonly{
	border: 2px;
	border-color: blue;
}
table,tr,td,th{
	border-color: #dedee0;
	border: 1px soild #dedee0;
}
</style>

<script>
// $(function(){
// 	$("th").css("color","#008bc8");
// });
function add(th){
	var tr = $(th).parent().parent();
	var name=tr.find("td#name").attr("value");
	var sn=tr.find("td#sn").attr("value");
	var insasosokname=tr.find("td#insasosokname").attr("value");
	var sosokcode=tr.find("input#sosokcode").val();
	var id=	'${param.id}';
	
	/* 사용자 입력 칸 채워준다 */
	$(opener.document).find("body")
							.find("input#"+id+"name")
							.attr("name","name")
							.attr("value",name)
							.removeAttr("toggle_name");
	$(opener.document).find("body")
							.find("input#"+id+"sn")
							.attr("name","sn")
							.attr("value",sn)
							.removeAttr("toggle_sn");
	$(opener.document).find("body")
							.find("input#"+id+"department")
							.attr("name","department")
							.attr("value",insasosokname)
							.removeAttr("toggle_department");
	$(opener.document).find("body")
							.find("input#addUser")
							.removeAttr("disabled");
	window.close(); 
}
	


</script>
<form action="popupSearchUser.do">
<!-- <label style="margin-left: 11px; padding-bottom: 10px; border: 1px solid black;"></label> -->
<h1 style="margin-left: 11px; padding-bottom: 5px;">
	이름 :  <input type="text" name="name" maxlength="5" size="6" style="margin-left: 10px; margin-bottom:-3px; ime-mode: active;">
	<input type="hidden" name="id" value="${param.id}">
	<input style="margin-top: 8px; margin-bottom: -5px;" type="image" src="<c:url value="/images/button/search.gif"/>" value="검색">
</h1>
</form>

<table style="border-collapse: collapse; margin-left: 10px; border-spacing: 0; width: 550px; text-align: center; border: 1px solid #dedee0;">
	<tr bgcolor="#f7f7f7" style="height: 25px;">
		<th style="border: 1px solid #dedee0;" width="15%">성명</th>
<!-- 		<th style="border: 1px solid #dedee0;" width="20%">군번</th> -->
		<th style="border: 1px solid #dedee0;">부서</th>
	</tr>
	<c:forEach var="user" items="${user}">
		<tr style="height: 20px;">
			<td id="name" value="${user.rankname} ${user.name}">
			${user.rankname} ${user.name}
			<input id="sn" value="${user.userid}" type="hidden">
			</td>
<%-- 			<td id="sn" value="${user.userid}">${user.userid}</td> --%>
			<td id="insasosokname" value="${user.intrasosokname}">
			${user.intrasosokname}
			<input id="sosokcode" type="hidden" value="${user.intrasosokcode}">
			</td>
			<td><input type="image" onclick="add(this)" src="<c:url value="/images/button/register.gif"/>" value="등록"></td>
<!-- 			<td><input type="button" value="등록" onclick="add(this)"></td> -->
		</tr>
	</c:forEach> 
</table>