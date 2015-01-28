<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cp }/css/style1.css" type="text/css">
<script type="text/javascript" src="<c:url value='/js/jquery-1.5.1.min.js'/>"></script> 
<Script language="javascript" src="${cp }/js/approval_in.js" CHARSET="UTF-8"></Script>
<Script>
function gtest()
{
	if(document.bb.rank0.value=="")
		alert("결재자를  1명이상 지정하세요.");
	else
		submitTo();
}
function submitTo()
{
	var to = $(parent.opener.document);
	var app_view = to.find("#app_view");
	
	app_view.val(document.bb.rank0.value+" "+document.bb.name0.value);
	to.find("#app_rank").val(document.bb.rank0.value);
	to.find("#app_name").val(document.bb.name0.value);
	to.find("#app_ass").val(document.bb.ass0.value);
	to.find("#app_sn").val(document.bb.sn0.value);
	parent.close();
}
function closeWindow(){
	to = parent.opener.document.application;
	to.rank0.value = "";
	to.name0.value = "";
	to.ass0.value = "";
	to.sn0.value = "";
	parent.close();
}

function LOAD(){
	to = document.bb;
	to.rank0.value = parent.opener.document.getElementById("app_rank").value;
	to.name0.value = parent.opener.document.getElementById("app_name").value;
	to.ass0.value = parent.opener.document.getElementById("app_ass").value;
	to.sn0.value = parent.opener.document.getElementById("app_sn").value;
}
</Script>
</head>
<body onload="LOAD()" style="width:21px">
<form  name="bb">
<table border="0" align="left">
	<tr>
		<td colspan="3" align="left">	
			<table border="1" bordercolor="#dedee0" class="main_table_small"> <!-- class="main_table_g">-->
			<thead>
			<tr align="center">
				<th>계급</th>
				<th>이름</th>
				<th>직책</th>
				<th>비고</th>
			</tr>
			</thead>
			<img src="${cp }/images/comp_01_0311.gif">
				
					<tr align="center" id="approval">
						<td>
							<input type="text" id="rank0" name="rank0" size="8" readonly='readonly' style="text-align:center">
						</td>
						<td>
							<input type="text" id="name0" name="name0" size="8" readonly='readonly' style="text-align:center">
						</td>
						<td width="50">
							<input type="text" id="ass0" name="ass0" size="8" readonly='readonly' style="text-align:center">
						</td>
						<td> 
							<a href="#" onclick="javascript:DeleteLine(0)"><img src="<c:url value="/images/button/delete.gif"/>"></a>
							<input type="hidden" id="sn0" name="sn0">
						</td>
					</tr>
										
			</table>
	 		<tr>
			<td valign="top">
			
 		<br>
		</td>
		</tr>

		<tr>
			<td align="right" colspan="2">
				<a href="#" onclick="gtest()"><img src="<c:url value="/images/button/check.gif"/>"></a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="closeWindow()"><img src="<c:url value="/images/button/cancel.gif"/>"></a>
			</td>
		</tr>
		</table>
</form>
</body>
</html>