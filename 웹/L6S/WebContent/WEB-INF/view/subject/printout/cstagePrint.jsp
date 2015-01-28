<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!-- <script language="javascript"> -->
<!-- 	function openPop(){ -->
<%-- 		var url = '<c:url value="/subject/printout/cstagePrint.do"/>'; --%>
<!-- 		alert(url); -->
<!-- 		openPopup(url, 850, 650); -->
<!-- 	}   -->
<!-- </script>  -->

<style>
.newRow{
}
.lowRow{
	display: none;
}
.bottomTable{
	margin-top: 1px;
}
</style>
<script>
$(function(){
$("input[part=partition]").trigger("click");
})
function addRow(th){
	 var id = $(th).attr("val");
	var lowRow = $(".lowRow").filter("#"+id).clone();
	lowRow.removeClass("lowRow");
	
	$("#topTable"+id).append(lowRow);
	var length = $("tr[id="+id+"]").length/2+4;
	$("#rowspan"+id).attr("rowspan",length); 
}
 
/* 추가버튼 누를시 라인 추가 */
$(function(){
var i=4;
$("#title").attr("rowspan",i);
var vvar=0;
$("#addCon").click(function(){
	if(vvar<5){
	vvar++;
	var newRow = $('.rowTemplete').clone();
	newRow.find("input[name=subkey]").val(vvar);
	newRow.removeClass("rowTemplete");
	 $('#addedTable').append(newRow);
	 i++;
	 $("#title").attr("rowspan",i);
	}
	else
		alert("5개까지만 추가 가능합니다.");
});
});


</script>

<form id="d_insert" action="/L6S/subject/stepInsert.do" method="POST" enctype="multipart/form-data"> 
<input type="hidden" name="seq" value="${param.seq}">
<input type="hidden" name="step" value="C">
<table id="addedTable">
	<tr id="test">
		<td colspan="5">${subject.project_name}</td>
	</tr>
	<tr>
		<td id="title">중요요인관리계획</td>
		<td>${c_form[0].title }</td>
		<td>${c_form[1].title }</td>
		<td>${c_form[2].title }</td>
		<td>${c_form[3].title }</td>
	</tr>
	<tr id="test">	
		<td>
		<input name="form_id" value="${c_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
		<td>
		<input name="form_id" value="${c_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
		<td>
		<input name="form_id" value="${c_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
		<td>
		<input name="form_id" value="${c_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${c_form[4].title }</td>
		<td>${c_form[5].title }</td>
		<td>${c_form[6].title }</td>
		<td rowspan="2"><input id="addCon" type="button" value="추가"></td>
	</tr>
	<tr >
		<td>
		<input name="form_id" value="${c_form[4].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
		<td>
		<input name="form_id" value="${c_form[5].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
		<td>
		<input name="form_id" value="${c_form[6].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text">
		</td>
	</tr>
</table>
<table class="bottomTable">
	<tr>
		<td>${c_form[7].title}</td>
		<td colspan="3">
		<input name="form_id" value="${c_form[7].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${c_form[8].title}</td>
		<td colspan="3">
		<input name="form_id" value="${c_form[8].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${c_form[9].title}</td>
		<td colspan="3">
		<input name="form_id" value="${c_form[9].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${c_form[12].title}</td>
		<td colspan="3">
		<input name="form_id" value="${c_form[12].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td>${c_form[13].title}</td>
		<td colspan="3">
		<input name="form_id" value="${c_form[13].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text"></td>
	</tr>
	<tr>
		<td width="25%">${c_form[14].title}</td>
		<td width="25%"><input type="file" name="file" size="30" ></td>
	</tr>
	<tr>
		<td width="25%" id="attachTitle">${c_form[15].title}</td>
		<td width="25%" id="attach">
			<input name="form_id" value="${c_form[15].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input type="file" name="attachedFile" size="30" onchange="insertNameToData(this)" >
			<input type="button" value="추가" onclick="addNewAttach(this)">
		</td>
	</tr>
</table>
	<input type="submit" value="등록	">
	<input type="button" value="취소">
</form>

<c:set var="da" value="0"/>
<c:forEach var="step" items="${step }" varStatus="i">
	<c:if test="${ step.step_view eq 'C'}"> 
	<div style="float: right; margin-top: 20px">
	<input type="button" onclick="changeToInserMode(this)" step_code="${step.step_code }" value="수정">
	<input type="button" onclick="submitChangedData(this)" step_code="${step.step_code }" value="확인">
	</div>
	<table id="topTable${i.index }">
		<tr>
			<td colspan="5">${subject.project_name}</td>
		</tr>
		<tr>
			<td id="rowspan${i.index }" rowspan="4">중요요인관리계획</td>
			<td>${c_form[0].title }</td>
			<td>${c_form[1].title }</td>
			<td>${c_form[2].title }</td>
			<td>${c_form[3].title }</td>
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
			<td>${c_form[4].title }</td>
			<td>${c_form[5].title }</td>
			<td>${c_form[6].title }</td>
		</tr>
		<tr>
			<td loop="on" step_id="${step.step_code }">		
				<input part="partition" type="hidden" value="추가" val="${i.index }" onclick="addRow(this)">
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
	</table>
	<table class="bottomTable">
		<tr>
			<td>${c_form[7].title}</td>
			<td colspan="3" loop="on" step_id="${step.step_code }">		
				<input name="step_code" type="hidden" value="${data[da].step_code }">
				<input name="form_id" type="hidden" value="${data[da].form_id}">
				<input name="subkey" type="hidden" value="${data[da].subkey }">
				<input name="data" type="text" value="${data[da].data }" class="readonly">
				<c:set var="da" value="${da+1 }"/>
			</td>
		</tr>
		<tr>
			<td>${c_form[8].title}</td>
			<td colspan="3" loop="on" step_id="${step.step_code }">		
				<input name="step_code" type="hidden" value="${data[da].step_code }">
				<input name="form_id" type="hidden" value="${data[da].form_id}">
				<input name="subkey" type="hidden" value="${data[da].subkey }">
				<input name="data" type="text" value="${data[da].data }" class="readonly">
				<c:set var="da" value="${da+1 }"/>
			</td>
		</tr>
		<tr>
			<td>${c_form[9].title}</td>
			<td colspan="3" loop="on" step_id="${step.step_code }">		
				<input name="step_code" type="hidden" value="${data[da].step_code }">
				<input name="form_id" type="hidden" value="${data[da].form_id}">
				<input name="subkey" type="hidden" value="${data[da].subkey }">
				<input name="data" type="text" value="${data[da].data }" class="readonly">
				<c:set var="da" value="${da+1 }"/>
			</td>
		</tr>
		<tr>
			<td>${c_form[12].title}</td>
			<td colspan="3" loop="on" step_id="${step.step_code }">		
				<input name="step_code" type="hidden" value="${data[da].step_code }">
				<input name="form_id" type="hidden" value="${data[da].form_id}">
				<input name="subkey" type="hidden" value="${data[da].subkey }">
				<input name="data" type="text" value="${data[da].data }" class="readonly">
				<c:set var="da" value="${da+1 }"/>
			</td>
		</tr>
		<tr>
			<td>${c_form[13].title}</td>
			<td colspan="3" loop="on" step_id="${step.step_code }">		
				<input name="step_code" type="hidden" value="${data[da].step_code }">
				<input name="form_id" type="hidden" value="${data[da].form_id}">
				<input name="subkey" type="hidden" value="${data[da].subkey }">
				<input name="data" type="text" value="${data[da].data }" class="readonly">
				<c:set var="da" value="${da+1 }"/>
			</td>
		</tr>
		<c:forEach var="subData" items="${data }">
			<c:if test="${subData.subkey ne 0 and subData.form_id eq 'C05' and step.step_code eq subData.step_code}">
				<tr id="${i.index }" count="cou" class="lowRow">
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
			</c:if>
		</c:forEach>
				<tr>
					<td width="25%">${c_form[14].title}</td>
					<td width="25%">
						<c:if test="${data[da].filename ne null }">
							<form action="/L6S/subject/download.do">  
								<input type="text" name="filename" value="${data[da].filename }" class="readonly">
								<input type="submit" value="다운">
							</form>
						</c:if>
					</td>
					<td width="25%">${c_form[15].title}</td>
					<td width="25%">
						<c:if test="${data[da].data ne null }">
							<c:forEach var="subData" items="${data }">
								<c:if test="${subData.data_type eq 'FILE' and step.step_code eq subData.step_code}">
									<form action="/L6S/subject/download.do">  
										<input type="text" name="filename" value="${subData.data }" class="readonly">
										<c:set var="da" value="${da+1 }"/>
										<input type="submit" value="다운">
									</form>
								</c:if>
							</c:forEach>
						</c:if>
					</td>
				</tr>
		</table>
	 </c:if>
</c:forEach>


<table style="display: none;">
	<tbody>
		<tr class="rowTemplete">
			<td>
			<input name="form_id" value="${c_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input name="data" type="text">
			</td>
			<td>
			<input name="form_id" value="${c_form[5].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input name="data" type="text">
			</td>
			<td>
			<input name="form_id" value="${c_form[6].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input name="data" type="text">
			</td>
		</tr>	
	</tbody>
</table>

<table style="display:none;">
	<tr class="attachTemplete">
		<td>
			<input name="form_id" value="${c_form[15].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input type="file" name="attachedFile" size="30" onchange="insertNameToData(this)" >
		</td>
	</tr>
</table>
<%-- <center><input type="button" onclick="openPop()" value="출력창"></center> --%>