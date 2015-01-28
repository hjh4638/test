<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!-- <script language="javascript"> -->
<!-- 	function openPop(){ -->
<%-- 		var url = '<c:url value="/subject/printout/dstagePrint.do"/>'; --%>
<!-- 		alert(url); -->
<!-- 		openPopup(url, 850, 650); -->
<!-- 	}   -->
<!-- </script>  -->

D단계입력
<form id="d_insert" action="/L6S/subject/stepInsert.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="step" value="D">
<input type="hidden" name="seq" value="${param.seq}">
<table>
	<tr>
		<td colspan="5">${subject.project_name}</td>
	</tr> 
	<tr>
		<td>${d_form[0].title}</td>
		<td colspan="4">
		<input name="form_id" value="${d_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<input name="data" type="text">
		</td>
	</tr>
	<tr>
		<td>${d_form[1].title}</td>
		<td colspan="4">
		<input name="form_id" type="hidden" value="${d_form[1].form_id }">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
	</tr>
	<tr>
		<td rowspan="2">목표기술서</td>
		<td>${d_form[2].title}</td>
		<td>${d_form[3].title}</td>
		<td>${d_form[4].title}</td>
		<td>${d_form[5].title}</td>
	</tr>
	<tr>
		<td>
		<input name="form_id" type="hidden" value="${d_form[2].form_id }">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
		<td>
		<input name="form_id" type="hidden" value="${d_form[3].form_id }">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
		<td>
		<input name="form_id" type="hidden" value="${d_form[4].form_id }">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
		<td>
		<input name="form_id" type="hidden" value="${d_form[5].form_id }">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
	</tr>
	<tr>
		<td width="25%" colspan="2">${d_form[6].title}</td>
		<td width="25%" colspan="3"><input type="file" name="file" size="30" ></td>
	</tr>
	<tr>
		<td width="25%" id="attachTitle" colspan="2">${d_form[7].title}</td>
		<td width="25%" id="attach" colspan="3">
			<input name="form_id" value="${d_form[7].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input type="file" name="attachedFile" size="30" onchange="insertNameToData(this)" >
			<input type="button" value="추가" onclick="addNewAttach(this)">
		</td>
	</tr>
</table>
<!-- 	<input type="submit" value="등록	"> -->
<!-- 	<input type="button" value="취소"> -->
</form> 

<c:set var="da" value="0"/>
<c:forEach var="step" items="${step }">
	<c:if test="${ step.step_view eq 'D'}">
		<div style="float: right; margin-top: 20px">
<%-- 		<input type="button" onclick="changeToInserMode(this)" step_code="${step.step_code }" value="수정"> --%>
<%-- 		<input type="button" onclick="submitChangedData(this)" step_code="${step.step_code }" value="확인"> --%>
		</div>
		<table>
				<tr>
					<td colspan="5">${subject.project_name}</td>
				</tr>
				<tr>
					<td>${d_form[0].title}</td>
					<td colspan="4" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
				</tr>
				<tr>
					<td>${d_form[1].title}</td>
					<td colspan="4" loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
				</tr>
				<tr>
					<td rowspan="2">목표기술서</td>
					<td>${d_form[2].title}</td>
					<td>${d_form[3].title}</td>
					<td>${d_form[4].title}</td>
					<td>${d_form[5].title}</td>
				</tr>
				<tr>
					<td loop="on" step_id="${step.step_code }">		
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
					<td loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
					<td loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
					<td loop="on" step_id="${step.step_code }">
					<input name="step_code" type="hidden" value="${data[da].step_code }">
					<input name="form_id" type="hidden" value="${data[da].form_id}">
					<input name="subkey" type="hidden" value="${data[da].subkey }">
					<input name="data" type="text" value="${data[da].data }" class="readonly">
					<c:set var="da" value="${da+1 }"/>
					</td>
				</tr>
				<tr>
						<td width="25%">${d_form[6].title}</td>
						<td width="25%">
							<c:if test="${data[da].filename ne null }">
								<form action="/L6S/subject/download.do">  
									<input type="text" name="filename" value="${data[da].filename }" class="readonly">
<!-- 									<input type="submit" value="다운"> -->
								</form>
							</c:if>
						</td>
						<td width="25%">${d_form[7].title}</td>
						<td width="25%">
							<c:if test="${data[da].data ne null }">
								<c:forEach var="subData" items="${data }">
									<c:if test="${subData.data_type eq 'FILE' and step.step_code eq subData.step_code}">
										<form action="/L6S/subject/download.do">  
											<input type="text" name="filename" value="${subData.data }" class="readonly">
											<c:set var="da" value="${da+1 }"/>
<!-- 											<input type="submit" value="다운"> -->
										</form>
									</c:if>
								</c:forEach>
							</c:if>
						</td>
					</tr>
			</table>
		</c:if>
</c:forEach>


<table style="display:none;">
	<tr class="attachTemplete">
		<td colspan="3">
			<input name="form_id" value="${d_form[7].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input type="file" name="attachedFile" size="30" onchange="insertNameToData(this)" >
		</td>
	</tr>
</table>
<%-- <center><input type="button" onclick="openPop()" value="출력창"></center> --%>