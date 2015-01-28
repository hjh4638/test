<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="<c:url value='/js/dept/deptworker.js'/>"></script>

<style>

</style>
<script>
function getFileInfo(){
	$("#ajaxForm").append($("#worker_picture"));
	$.post("isValidSignIn.do",{user_id:user_id,user_password:user_password},function(isValid){
		if(isValid == "true"){
			alert("로그인성공");
			window.location.href="top.do";
		}else{
			alert("아이디와 비밀번호를 다시확인 하여주십시오");
		}
	});
}
</script>
<form:form commandName="astiResearchWorkerDTO" method="post" action="/ASTI/admin/workerRegister.do" enctype="multipart/form-data">
<!-- 	<table class="workerTable" cellspacing="0" cellpadding="0"> -->
<!-- 		<tr> -->
<!-- 			<th rowspan="2" style="width:80px;height:220px;"> -->
<!-- 			연구원 사진 -->
<!-- 			</th> -->
<!-- 			<td rowspan="2" style="width:150px;height:220px;"> -->
<%-- 					<c:if test="${astiResearchWorkerDTO.worker_picture_name ne '' --%>
<!-- 								and astiResearchWorkerDTO.worker_picture_name ne null}"> -->
<%-- 						<img src="/ASTI/Temp/${astiResearchWorkerDTO.worker_picture_id }"> --%>
<%-- 					</c:if> --%>
<!-- 				<input style="width:150px;"id="worker_picture" type="file" name="worker_picture"> -->
<%-- 				<form:hidden path="worker_picture_id" />value="${astiResearchWorkerDTO.worker_picture_id }" --%>
<%-- 				<form:hidden path="worker_picture_name" />value="${astiResearchWorkerDTO.worker_picture_id }" --%>
<%-- 				<form:hidden path="worker_id" />value="${astiResearchWorkerDTO.worker_id }" --%>
<!-- 			</td> -->
<!-- 			<th style="width:50px;height:170px;"> -->
<!-- 			이름 -->
<!-- 			</th> -->
<!-- 			<td style="width:150px;height:170px"> -->
<%-- 				<form:input path="worker_name" />    --%>
<%-- 				<form:errors pate="worker_name"/>value="${astiResearchWorkerDTO.worker_name }" --%>
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th style="width:50px;height:50px;"> -->
<!-- 			직책 -->
<!-- 			</th> -->
<!-- 			<td style="width:150px;height:50px;"> -->
<%-- 			<form:select path="worker_department"> --%>
<%-- 				<c:forEach var="department" items="${department }"> --%>
<%-- 					<form:option id="${department.code_id }" value="${department.code_id }">${department.code_name }</form:option> --%>
<%-- 				</c:forEach> --%>
<%-- 			</form:select> --%>
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr>  -->
<!-- 			<th style="width:50px;height:100px;">세부사항</th>  -->
<!-- 			<td colspan="3" style="width:350px;height:100px"> -->
<%-- 				<form:textarea cols="50" rows="10" path="worker_detail_info" ></form:textarea> --%>
<!-- 			</td> -->
<!-- 		</tr> -->
	
<!-- 	</table> -->
	
		<table id="workerInfomationTable" cellspacing="0" cellpadding="0">
		<tr>
			<th rowspan="2" style="width:150px;height:200px;">	
			<c:if test="${astiResearchWorkerDTO.worker_picture_name ne ''
								and astiResearchWorkerDTO.worker_picture_name ne null}">
						<img src="/ASTI/Temp/${astiResearchWorkerDTO.worker_picture_id }">
					</c:if>
				<input style="width:150px;"id="worker_picture" type="file" name="worker_picture">
				<form:hidden path="worker_picture_id" /><%-- value="${astiResearchWorkerDTO.worker_picture_id }" --%>
				<form:hidden path="worker_picture_name" /><%-- value="${astiResearchWorkerDTO.worker_picture_id }" --%>
				<form:hidden path="worker_id" /></th>
			<th style="width:50px;height:140px;">성명</th><td style="width:300px;height:140px;"><form:input path="worker_name" />   
				<form:errors path="worker_name"/><%-- value="${astiResearchWorkerDTO.worker_name }" --%></td>
		</tr>
		<tr>
			<th style="width:50px;height:60px;">직책</th><td style="width:300px;height:60px;"><form:select path="worker_department">
				<c:forEach var="department" items="${department }">
					<form:option id="${department.code_id }" value="${department.code_id }">${department.code_name }</form:option>
				</c:forEach>
			</form:select></td>
		</tr>
		<tr>
			<th style="width:150px;height:25px;">연구/전공 분야</th>
			<td colspan="2" style="width:350px;height:25px;"><form:input path="worker_major" />   
				<form:errors path="worker_major"/></td> 
		</tr>
		<tr>
			<th style="width:150px;height:25px;">전화번호</th>
			<td colspan="2" style="width:350px;height:25px;"><form:input path="worker_phone_number" />   
				<form:errors path="worker_phone_number"/></td>
		</tr>
		<tr>
			<th style="width:150px;height:25px;">FAX</th>
			<td colspan="2" style="width:350px;height:25px;"><form:input path="worker_fax_number"/>
			<form:errors path="worker_fax_number"/></td>
		</tr>
		<tr>
			<th style="width:150px;height:25px;">E-MAIL</th>
			<td colspan="2" style="width:350px;height:25px;"><form:input path="worker_email"/>
			<form:errors path="worker_email"/></td>
		</tr>		
	</table>
<input type="button" value="입력" onclick="submit()">
</form:form>