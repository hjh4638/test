<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<form id="d_insert" action="/L6S/subject/stepInsert.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="step" value="E">
<input type="hidden" name="seq" value="${param.seq}">
<table>
	<tr>
		<td colspan="4">${subject.project_name}</td>
	</tr>
	<tr>
		<td>${e_form[0].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[1].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[2].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[3].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[4].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[4].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[5].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[5].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[6].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[6].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${e_form[7].title}</td>
		<td colspan="3">
		<input name="form_id" value="${e_form[7].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td width="25%">${e_form[8].title}</td>
		<td width="25%"><input type="file" name="file" size="30" ></td>
	</tr>
	
</table>
	<input type="submit" value="등록	">
	<input type="button" value="취소">
</form>


<c:set var="da" value="0"/>
<c:forEach var="step" items="${step }">
	<c:if test="${ step.step_view eq 'E'}">
	<div style="float: right; margin-top: 20px">
	<input type="button" onclick="changeToInserMode(this)" step_code="${step.step_code }" value="수정">
	<input type="button" onclick="submitChangedData(this)" step_code="${step.step_code }" value="확인">
	</div>
		<table>
			<tr>
				<td colspan="4">${subject.project_name}</td>
			</tr>
			<tr>
				<td>${e_form[0].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[1].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[2].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[3].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[4].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[5].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[6].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td>${e_form[7].title}</td>
				<td colspan="3" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
				</td>
			</tr>
			<tr>
				<td width="25%">${e_form[8].title}</td>
				<td width="25%">
					<c:if test="${data[da].filename ne null }">
						<form action="/L6S/subject/download.do">  
							<input type="text" name="filename" value="${data[da].filename }" class="readonly">
							<input type="submit" value="다운"> 
						</form>
					</c:if>
				</td>
			</tr>
		</table>
</c:if>
</c:forEach>
<%-- <center><input type="button" onclick="openPop()" value="출력창"></center>	 --%>
