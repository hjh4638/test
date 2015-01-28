<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
tr{
	height: 30px;
}
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
	var addedRowCount;
	/* 2012.12.17 상병 함준혁 모든 위치에 삭제 기능 구현하기 위해 수정 */
	var rowSeq;
	$(function(){
		/* 행수 초기화 코드이다. 삭제시 한번 더 사용 */
		addedRowCount=$("tr.standardRow").length+2;
		rowSeq=addedRowCount;
		$("th#varRowspan").attr("rowspan",addedRowCount);
		
		$("tr.standardRow:gt(0)").find("td.deleteCollection").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
	});
	function attachRow(){
		
	 /* 추가된 행만큼 rowspan 변경 */
		if(addedRowCount==7){
			alert("5개까지만 추가가능합니다");
			return;
		}
		addedRowCount+=1;
		rowSeq+=1;
		$("th#varRowspan").attr("rowspan",addedRowCount);
		
		/* $("tr.standardRow").find("td.deleteCollection").find("a.deleteButton").remove(); */
	/* 템플릿 복제하여 행 붙여넣기 */
		var attach = $(".attachment").clone();
		attach.find("input[name=subkey]").val(rowSeq-3);
		attach.removeClass("attachment").addClass("standardRow");
		attach.find("td.deleteCollection").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
		$("tr.standardRow").last().after(attach);
	}
function deleteRow(th){
	$(th).parent().parent().remove();
	addedRowCount=$("tr.standardRow").length+2;
	rowSeq+=1;
	$("th#varRowspan").attr("rowspan",addedRowCount);
	/* $("tr.standardRow").last().find("td.deleteCollection").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>'); */
}
</script>
<script>
$(function(){
	$("input.goal_specification").attr("size","10");
});
/* C단계 예측성과 합 구해주는 함수 */
function sumResult(){
	sum=0;
	$("tr.standardRow").children().find("input.economicResult").each(function(){
		sum=Number($(this).val())+sum;
	});
	$("input#last_sum").val(sum);
}
</script>
<center>
<h1 class="C_stage">C_stage</h1>
	<c:if test="${!(is_mystep) && stepping == 4}">
	<br><br>C단계가 아직 입력되지 않았습니다.
	</c:if>
<c:if test="${is_mystep && validateInsert }"> 
<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data"> 
<input type="hidden" name="seq" value="${param.seq}">
<input type="hidden" name="step" value="C">

<table class="assignmentstage_table">
	<tr>
		<th bgcolor="#f7f7f7" width="15%">과제명</th>
		<td class="left_align_text" width="85%" colspan="6"><c:out value="${subject.project_name}"/></td>
	</tr>
<%-- 		<th bgcolor="#f7f7f7">${data_form[0].title}</th> --%>
<!-- 		<td colspan="6"> -->
<!-- 			<div style="margin-top: 3px; margin-bottom: 3px;" align="center"> -->
<!-- 				<ul class="tool_List1"> -->
<!-- 					<li><input name="tool_data" value="SPC" type="checkbox">SPC</li> -->
<!-- 					<li><input name="tool_data" value="눈으로 보는 관리" type="checkbox">눈으로 보는 관리</li> -->
<!-- 					<li><input name="tool_data" value="Foolproof" type="checkbox">Foolproof</li> -->
<!-- 				</ul> -->
<!-- 				<ul class="tool_List1"> -->
<!-- 					<li><input name="tool_data" value="관리도 " type="checkbox">관리도</li> -->
<!-- 					<li> -->
<!-- 						기타<input size="20" name="tool_data" type="text">  -->
<%-- 				 		<input name="tool_form" type="hidden" value="${data_form[0].form_id }"> --%>
<!-- 			 		</li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 		</td> -->
		<!-- 적용 Tool -->
	<tr>
		<th bgcolor="#f7f7f7" rowspan="2">${data_form[0].title}</th>
		<td class="left_align" colspan="2"><input name="tool_data" value="SPC" type="checkbox">SPC</td>
		<td class="left_align" colspan="2"><input name="tool_data" value="눈으로 보는 관리" type="checkbox">눈으로 보는 관리</td>
		<td class="left_align" colspan="2"><input name="tool_data" value="Foolproof" type="checkbox">Foolproof</td>
		</tr>
		<tr>
		<td class="left_align" colspan="2"><input name="tool_data" value="관리도 " type="checkbox">관리도</td>
		<td class="left_align" colspan="2">&nbsp;&nbsp;기타&nbsp;&nbsp;<input size="19" name="tool_data" type="text">
		<input name="tool_form" type="hidden" value="${data_form[0].form_id }">
		</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="6">
			<input name="form_id" value="${data_form[1].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea cols="72" rows="8" name="data" 
			onkeyup="checkCharSize(this)"></textarea>
<!-- 			<br /> -->
<!-- 			<a id="bbbCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 표준화 및 확산내역 -->
		<th bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td colspan="6">
			<input name="form_id" value="${data_form[2].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea cols="72" rows="4" name="data" 
			onkeyup="checkCharSize(this)"></textarea>
<!-- 			<br /> -->
<!-- 			<a id="standardCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<th id="varRowspan" bgcolor="#f7f7f7">목표기술서</th>
		<th colspan="2" bgcolor="#f7f7f7">목표성과<br />(단위:천원)</th>
		<td class="c_mokpyo" value="${m_data[7].data }"></td>
			<script>
			/* 목표성과 콤마 넣어주기 */
			$(function(){
				var num_mok = $(".c_mokpyo").attr("value");
				var numAddCom_mok = insertComma(num_mok);
				$(".c_mokpyo").append(numAddCom_mok);
			});
			</script>
		<!-- C단계 예측성과(C 단계 개선 후 성과) -->
		<th colspan="2" bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td>
			<input name="form_id" value="${data_form[3].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="last_sum" class="goal_specification readonly" type="text" name="data">
			<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="sumResult()">
				<img src="<c:url value="/images/button/insert.gif"/>">
			</a>
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<!-- 항목 -->
		<th width="15%">${data_form[4].title}</th>
		<!-- 현재 -->
		<th width="15%">${data_form[5].title}</th>
		<!-- 목표 -->
		<th >${data_form[6].title}</th>
		<!-- 개선후 -->
		<th width="15%">${data_form[7].title}</th>
		<!-- 재무성과 -->
		<th width="15%">${data_form[8].title}</th>
		<th width="10%"></th>
	</tr>
	<tr class="standardRow">
		<td>
		<input name="form_id" value="${data_form[4].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="goal_specification" type="text" name="data">
		</td>
		<td>
		<input name="form_id" value="${data_form[5].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="goal_specification" type="text" name="data">
		</td>
		<td>
		<input name="form_id" value="${data_form[6].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="goal_specification" type="text" name="data">
		</td>
		<td>
		<input name="form_id" value="${data_form[7].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="goal_specification" type="text" name="data">
		</td>
		<td>
		<input name="form_id" value="${data_form[8].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="goal_specification economicResult mustBeNum" type="text" name="data">
		</td>
		<td>
		<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="attachRow()">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="5">
			<input class="fileCSS" type="file" name="file" size="60" onchange="checkFile()">
		</td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th bgcolor="#f7f7f7" width="15%" id="attachTitle">${data_form[10].title}</th>
		<td colspan="5" id="attach">
			<input name="form_id" value="${data_form[10].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="60" onchange="insertNameToData(this)" >
		</td>
		<td>
		<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="addNewAttach(this)">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a onfocus="blur();" href="#" onclick="sumResult();stepFormSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 	<a href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
</form>
</c:if>

<c:if test="${stepping > 4}">
	<c:if test="${isRegistered eq 'N' && stepping eq 5 && isApproved eq 4}">
		<input style="margin-top:5px; margin-left: 667px;" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 		<input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
	</c:if>
<!-- 출력용 -->
<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('c')">
<table id="printtable" class="assignmentstage_table print">
	<tr>
		<th bgcolor="#f7f7f7">과제명</th>
		<td class="left_align_text" colspan="5"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- 적용Tool -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td class="left_align_text" colspan="5">
			<c:out value="${data[0].data }"/>
		</td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="5">
			<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[1].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<!-- 표준화 및 확산내역 -->
		<th bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td colspan="5">
			<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[2].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<th width="15%" rowspan="${databindsize+2 }" bgcolor="#f7f7f7">목표기술서</th>
		<th bgcolor="#f7f7f7">목표성과<br />(단위:천원)</th>
		<td class="c_mokpyo" value="<c:out value="${m_data[7].data }"/>"></td>
		<!-- C단계 예측성과 ( C단계 개선 후 성과 ) -->
		<th bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td colspan="2" class="c_jaemu" value="<c:out value="${data[3].data }"/>">
		</td>
	</tr>
	<script>
	/* 재무성과 데이터에 콤마 찍어줌 */
	$(function(){
		var num_mok = $(".c_mokpyo").attr("value");
		var numAddCom_mok = insertComma(num_mok);
		$(".c_mokpyo").append(numAddCom_mok);
		
		var num_jaemu = $(".c_jaemu").attr("value");
		var numAddCom_jaemu = insertComma(num_jaemu);
		$(".c_jaemu").append(numAddCom_jaemu);
	});
	</script>
	<tr bgcolor="#f7f7f7">
		<!-- 항목 -->
		<th width="17%">${data_form[4].title}</th>
		<!-- 현재 -->
		<th width="17%">${data_form[5].title}</th>
		<!-- 목표 -->
		<th width="17%">${data_form[6].title}</th>
		<!-- 개선후 -->
		<th width="17%">${data_form[7].title}</th>
		<!-- 재무성과 -->
		<th width="17%">${data_form[8].title}</th>
	</tr>
	<!-- stage_a 에서 설명 -->
	<c:forEach var="sub" items="${databind }">
		<tr>
			<c:forEach var="subsub" items="${sub }">
			<td><c:out value="${subsub.data }"/></td>
			</c:forEach>
		</tr>
	</c:forEach>
	<tr>
		<!-- 단계별 완료보고서  다운로드-->
		<th bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="6">
			<c:if test="${data[0].filename ne null }">
				<form action="<c:url value="/subject/download.do"/>">  
					<input type="hidden" name="filename" value=<c:out value="${data[0].filename }"/>>
					<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()"><c:out value="${data[0].filename }"/></a></p>
				</form>
			</c:if>
		</td>
	</tr>
	<tr>
		<!-- 첨부파일 다운로드 -->
		<th bgcolor="#f7f7f7">${data_form[10].title}</th>
		<td colspan="6">
			<c:forEach var="sub" items="${data }">
			<c:if test="${sub.data_type eq 'FILE' }">
			<form action="<c:url value="/subject/download.do"/>">  
				<input type="hidden" name="filename" value=<c:out value="${sub.data }"/>>
				<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()"><c:out value="${sub.data }"/></a></p>
			</form>
			</c:if>
			</c:forEach>
		</td>
	</tr>
</table>

<!-- 수정용 -->
<form id="update" action="<c:url value="/subject/stepUpdate.do"/>" method="POST" enctype="multipart/form-data"> 
<input type="hidden" name="seq" value="${param.seq}">
<input type="hidden" name="step" value="C">

<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td width="85%" class="left_align_text" colspan="6"><c:out value="${subject.project_name}"/></td>
	</tr>
<!-- 	<tr> -->
<%-- 		<th bgcolor="#f7f7f7">${data_form[0].title}</th> --%>
<!-- 		<td colspan="6"> -->
<!-- 			<div style="margin-top: 3px;" align="center"> -->
<!-- 				<ul class="tool_List1"> -->
<!-- 					<li><input name="tool_data" value="SPC" type="checkbox">SPC</li> -->
<!-- 					<li><input name="tool_data" value="눈으로 보는 관리" type="checkbox">눈으로 보는 관리</li> -->
<!-- 					<li><input name="tool_data" value="Foolproof" type="checkbox">Foolproof</li> -->
<!-- 				</ul> -->
<!-- 				<ul class="tool_List1"> -->
<!-- 					<li><input name="tool_data" value="관리도 " type="checkbox">관리도</li> -->
<!-- 					<li > -->
<!-- 						기타<input size="20" name="tool_data" type="text">  -->
<%-- 				 		<input name="tool_form" type="hidden" value="${data_form[0].form_id }"> --%>
<!-- 			 		</li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 		</td> -->
<!-- 	</tr> -->
	<tr>
		<th bgcolor="#f7f7f7" rowspan="2">${data_form[0].title}</th>
		<td class="left_align" colspan="2"><input name="tool_data" value="SPC" type="checkbox">SPC</td>
		<td class="left_align" colspan="2"><input name="tool_data" value="눈으로 보는 관리" type="checkbox">눈으로 보는 관리</td>
		<td class="left_align" colspan="2"><input name="tool_data" value="Foolproof" type="checkbox">Foolproof</td>
		</tr>
		<tr>
		<td class="left_align" colspan="2"><input name="tool_data" value="관리도 " type="checkbox">관리도</td>
		<td class="left_align" colspan="2">&nbsp;&nbsp;기타&nbsp;&nbsp;<input size="19" name="tool_data" type="text">
		<input name="tool_form" type="hidden" value="${data_form[0].form_id }">
		</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="6">
			<input name="form_id" value="${data_form[1].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea cols="72" rows="8" name="data" 
			onkeyup="checkCharSize(this)">${data[1].data }</textarea>
<!-- 			<br /> -->
<!-- 			<a id="bbbCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 표준화 및 확산내역 -->
		<th bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td colspan="6">
			<input name="form_id" value="${data_form[2].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea cols="72" rows="5" name="data" 
			onkeyup="checkCharSize(this)">${data[2].data }</textarea>
<!-- 			<br /> -->
<!-- 			<a id="standardCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<th id="varRowspan" bgcolor="#f7f7f7">목표기술서</th>
		<th bgcolor="#f7f7f7">목표성과<br />(단위:천원)</th>
		<td colspan="2">${m_data[7].data }</td>
		<!-- 총 성과 금액 -->
		<th bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td  colspan="2" style="text-align:center;">
			<input name="form_id" value="${data_form[3].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="last_sum" class="goal_specification readonly" type="text" name="data" value="${data[3].data }">
			<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="sumResult()">
				<img src="<c:url value="/images/button/insert.gif"/>">
			</a>

		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<!-- 항목 -->
		<th width="15%">${data_form[4].title}</th>
		<!-- 현재 -->
		<th width="20%">${data_form[5].title}</th>
		<!-- 목표 -->
		<th width="20%">${data_form[6].title}</th>
		<!-- 개선후 -->
		<th width="20%">${data_form[7].title}</th>
		<!-- 재무성과 -->
		<th width="15%">${data_form[8].title}</th>
		<th width="10%">
		<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="attachRow()">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</th>
	</tr>
	<tr class="standardRow">
		<td>
			<input name="form_id" value="${data_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data" value="${databind[0][0].data}">
		</td>
		<td>
			<input name="form_id" value="${data_form[5].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data" value="${databind[0][1].data}">
		</td>
		<td>
			<input name="form_id" value="${data_form[6].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data" value="${databind[0][2].data}">
		</td>
		<td>
			<input name="form_id" value="${data_form[7].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data" value="${databind[0][3].data}">
		</td>
		<td>
			<input name="form_id" value="${data_form[8].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification economicResult mustBeNum" type="text" name="data" value="${databind[0][4].data}">
		</td>
		<td></td>
	</tr>
	<c:forEach var="sub" items="${databind }" begin="1" varStatus="i">
		<tr class="standardRow updateTr">
			<td>
				<input name="form_id" value="${data_form[4].form_id }" type="hidden">
				<input name="subkey" value="${i.index}" type="hidden">
				<input class="goal_specification" type="text" name="data" value="${sub[0].data }">
			</td>
			<td>
				<input name="form_id" value="${data_form[5].form_id }" type="hidden">
				<input name="subkey" value="${i.index}" type="hidden">
				<input class="goal_specification" type="text" name="data" value="${sub[1].data }">
			</td>
			<td>
				<input name="form_id" value="${data_form[6].form_id }" type="hidden">
				<input name="subkey" value="${i.index}" type="hidden">
				<input class="goal_specification" type="text" name="data" value="${sub[2].data }">
			</td>
			<td>
				<input name="form_id" value="${data_form[7].form_id }" type="hidden">
				<input name="subkey" value="${i.index}" type="hidden">
				<input class="goal_specification" type="text" name="data" value="${sub[3].data }">
			</td>
			<td>
				<input name="form_id" value="${data_form[8].form_id }" type="hidden">
				<input name="subkey" value="${i.index}" type="hidden">
				<input class="goal_specification economicResult mustBeNum" type="text" onkeyup="SetComma(this);" name="data" value="${sub[4].data}">
			</td>
			<td class="deleteCollection"></td>
		</tr>
	</c:forEach>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th width="15%" bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="5" style="text-align: left; text-indent: 10px;">
			<input class="fileCSS" type="file" name="file" size="60" onchange="checkFile()">
		</td>
		<td></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th bgcolor="#f7f7f7" width="15%" id="attachTitle">${data_form[10].title}</th>
		<td colspan="5" style="text-align: left; text-indent: 10px;" id="attach">
			<input name="form_id" value="${data_form[10].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="60" onchange="insertNameToData(this)" >
		</td>
		<td>
		<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="addNewAttach(this)">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a onfocus="blur();" href="#" onclick="sumResult();stepFormUpdateSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
	<a onfocus="blur();" href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a>
</form>
<c:if test="${stepping eq 5 }">
	<c:if test="${right.app_right.is_approval eq 'Y' }">
	<center>
		<ul class="appMenu">
			<a href="#" onclick="openPop(1);" onfocus="blur();"><li class="approval_btn"></li></a>
			<a href="#" onclick="openPop(2);" onfocus="blur();"><li class="disapproval_btn"></li></a>
		</ul>
	</center>
<!-- 		<input type="button" value="결재/기각" onclick="openPop()"> -->
	</c:if>
	<div id="approvalDialog" title="결재자 의견" style="width: 50px;">
		<form id="approvalForm" action="<c:url value="/approval_line/approvalSubject.do"/>" method="POST">
			<textarea cols="40" rows="8" name="comment"></textarea>
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
		</form>
	</div>
	<div id="approvalDialog2" title="결재자 의견" style="width: 50px;"> 
		<form id="approvalForm2" action="<c:url value="/approval_line/approvalSubject.do"/>" method="POST">
			<textarea cols="40" rows="8" name="comment"></textarea>
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
		</form>
	</div>
	<c:if test="${isRegistered eq 'N' && isApproved eq 4}">
		<form action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
			<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
		</form>
	</c:if>
</c:if>
</c:if>

<!-- 목표기술서 라인 추가시 가져다 씀 -->
<table style="display: none;">
	<tbody>
		<tr class="attachment">
			<td>
			<input name="form_id" value="${data_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data">
			</td>
			<td>
			<input name="form_id" value="${data_form[5].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data">
			</td>
			<td>
			<input name="form_id" value="${data_form[6].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data">
			</td>
			<td>
			<input name="form_id" value="${data_form[7].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification" type="text" name="data">
			</td>
			<td>
			<input name="form_id" value="${data_form[8].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input class="goal_specification economicResult mustBeNum" type="text" name="data">
			</td>
			<td class="deleteCollection"></td>
		</tr>
	</tbody>
</table>

<!-- 첨부파일 추가시 -->
<table style="display:none;">
	<tr class="attachTemplete">
		<td colspan="5" style="text-align: left; text-indent: 10px;">
			<input name="form_id" value="${data_form[10].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="60" onchange="insertNameToData(this)" >
		</td>
		<td class="deleteAttach"></td>
	</tr>
</table>
</center>
  