<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.disabled{
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
function submitToParent(th){
	var tr=$(th).parent().parent();
	var rank=tr.find("#rank").attr("value");
	var sn=tr.find("#sn").val();
	var name=tr.find("#name").val();
	var data=rank+" "+name+","+sn;
	var id=	'${param.id}';
	$(opener.document).find("body").find("input[name="+id+"]").val(data);
	$(opener.document).find("body").find("input#"+id).val(rank+" "+name); 
	window.close();
}
</script>

<form action="popupSearchAdmin.do">
<h1 style="margin-left: 11px; padding-bottom: 5px;">
	이름 :  <input type="text" name="name" maxlength="5" size="6" style="margin-left: 10px; margin-bottom:-3px; ime-mode: active;">
	<input type="hidden" name="id" value="${param.id}">
	<input style="margin-top: 8px; margin-bottom: -5px;" type="image" src="<c:url value="/images/button/search.gif"/>" value="검색">
</h1>
</form>
<table style="border-collapse: collapse;
	margin-left:10px; border-spacing: 0; width: 550px; height: 27px; text-align: center; border: 1px solid #dedee0;">
	<tr bgcolor="#f7f7f7" style="height: 25px;">
		<th style="border: 1px solid #dedee0; width: 7.1%" align="center">순번</th>
		<th style="border: 1px solid #dedee0; width: 59.5%" align="center">소속</th>
		<th style="border: 1px solid #dedee0; width: 22.4%" align="center">성명</th>
		<th style="border: 1px solid #dedee0; width: 11%">선택</th>
	</tr>
<c:forEach var="admin" items="${admin }" varStatus="i">
	<tr height="22px">
		<td>${i.index+1 }</td>
		<td>${admin.intrasosokname }</td>
		<td id="rank" value="${admin.rankname}">${admin.rankname }
		${admin.name }
		<input id="sn" type="hidden" value="${admin.userid }">
		<input id="name" type="hidden" value="${admin.name }">
		</td>
		
		<%-- <td>${admin.authorityName}</td> --%>
		<td><input type="image" id onclick="submitToParent(this)" src="<c:url value="/images/button/register.gif"/>" value="등록"></td>
	</tr>
</c:forEach>
</table>
