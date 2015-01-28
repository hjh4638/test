<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<center>
<h1 class="M_stage">M_stage</h1>
<c:if test="${!(is_mystep) && stepping == 1}">
	<br><br>M단계가 아직 입력되지 않았습니다.
</c:if>
<c:if test="${is_mystep && validateInsert }">
<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data">
<input type="hidden" name="step" value="M">
<input type="hidden" name="seq" value="${param.seq}">
<table  class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td class="left_align_text" width="85%" colspan="4"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- CTQ 정의 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td height="70" colspan="4">
		<input name="form_id" value="${data_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<textarea name="data" cols="73" rows="8"
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<br/> -->
<!-- 		<a id="ctqCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th rowspan="4" >현수준/<br>목표설정</th>
		<!-- 현수준 -->
		<th width="21%">${data_form[1].title}</th>
		<!-- 목표 -->
		<th width="21%">${data_form[2].title}</th>
		<!-- 개선 후 -->
		<th width="21%">${data_form[3].title}</th>
		<!-- 재무성과 -->
		<th width="23%">${data_form[7].title}</th>
	</tr>
	<tr>
		<td>
		<input  name="form_id" value="${data_form[1].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden"> 
		<input  name="data" type="text" size="15">
		</td>
		<td>
		<input  name="form_id" value="${data_form[2].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15">
		</td>
		<td>
		<input  name="form_id" value="${data_form[3].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15">
		</td>
		<td rowspan="3">
		<input  name="form_id" value="${data_form[7].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input class="mustBeNum" name="data" type="text" size="19">
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<!-- 현 시그마 수준 -->
		<th>${data_form[4].title}</th>
		<!-- 목표 -->
		<th>${data_form[5].title}</th>
		<!-- 개선 후 시그마 수준 -->
		<th>${data_form[6].title}</th>
	</tr>
	<tr>
		<td > 
		<input  name="form_id" value="${data_form[4].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15">
		</td>
		<td >
		<input  name="form_id" value="${data_form[5].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15">
		</td>
		<td >
		<input  name="form_id" value="${data_form[6].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15">
		</td>
	</tr>
	<tr class="tool_table">
		<!-- 적용 Tool -->
		<th rowspan="4" bgcolor="#f7f7f7">${data_form[8].title}</th>
		<td ><input type="checkbox" name="tool_data" value="파레토 챠트(Pareto Chart)">파레토 챠트</td>
		<td ><input type="checkbox" name="tool_data" value="정규성 검정">정규성 검정</td>
		<td><input type="checkbox" name="tool_data" value="친화도법">친화도법</td>
		<td><input type="checkbox" name="tool_data" value="Process Mapping">Process Mapping</td>
	</tr>
	<tr class="tool_table">
		<td><input type="checkbox" name="tool_data" value="QFD">QFD</td>
		<td><input type="checkbox" name="tool_data" value="FMEA">FMEA</td> 
		<td><input type="checkbox" name="tool_data" value="그래프 분석">그래프 분석</td>
		<td><input type="checkbox" name="tool_data" value="PULL 시스템">PULL 시스템</td>
	</tr>
	<tr class="tool_table">
		<td><input type="checkbox" name="tool_data" value="히스토그램">히스토그램</td>
		<td><input type="checkbox" name="tool_data" value="우선순위 매트릭스">우선순위 매트릭스</td> 
		<td><input type="checkbox" name="tool_data" value="MSA(GAGE R&R)">MSA(GAGE R&R)</td>
		<td><input type="checkbox" name="tool_data" value="공정능력 분석">공정능력 분석</td>
	</tr>
	<tr class="tool_table">
	    <td colspan="2">&nbsp;&nbsp;기타&nbsp;&nbsp;<input type="text" size="38" name="tool_data">
			<input name="tool_form" type="hidden" value="${data_form[8].form_id }">
		</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="4">
			<input name="form_id" value="${data_form[9].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea name="data" cols="73" rows="8"
			onkeyup="checkCharSize(this)"></textarea>
<!-- 			<br/> -->
<!-- 			<a id="biefCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th bgcolor="#f7f7f7">${data_form[10].title}</th>
		<td colspan="4"><input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()"></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th id="attachTitle" bgcolor="#f7f7f7">${data_form[11].title}</th>
		<td id="attach" colspan="4">
			<input name="form_id" value="${data_form[11].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
			<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="addNewAttach(this)">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a onfocus="blur();" href="#" onclick="stepFormSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 	<a href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
</form>
</c:if>

<c:if test="${stepping > 1}">
	<c:if test="${isRegistered eq 'N' && stepping eq 2 && isApproved eq 1}">
		<input class="stage_edit" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 		<input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
	</c:if>
<!-- 출력용 테이블 -->
<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('m')">
<table id="printtable" class="assignmentstage_table print">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td class="left_align_text" width="85%" colspan="4"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- CTQ 정의 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td height="70" colspan="4">
			<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[0].data }"/></textarea>
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th rowspan="4" >현수준/<br>목표설정</th>
		<!-- 현수준 -->
		<th width="21%">${data_form[1].title}</th>
		<!-- 목표 -->
		<th width="21%">${data_form[2].title}</th>
		<!-- 개선 후 -->
		<th width="21%">${data_form[3].title}</th>
		<!-- 재무성과 -->
		<th width="23%">${data_form[7].title}</th>
	</tr>
	<tr class="text_box">
		<td>
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[1].data }"/>">
		</td>
		<td >
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[2].data }"/>">
		</td>
		<td>
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[3].data }"/>">
		</td>
		<td rowspan="3" class="m_jaemu" value="${data[7].data }">
			<input style="margin-left: 5px;" class="readonly m_jaemu_input" type="text" size="15" value="<c:out value="${data[7].data }"/>">
	<script>
	/* 재무성과 데이터에 콤마 찍어줌 */
	$(function(){
		var num = $(".m_jaemu").attr("value");
		var numAddCom = insertComma(num);
		$(".m_jaemu_input").val(numAddCom);
	});
	</script>
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<!-- 현 시그마 수준 -->
		<th>${data_form[4].title}</th>
		<!-- 목표 -->
		<th>${data_form[5].title}</th>
		<!-- 개선 후 시그마 수준 -->
		<th>${data_form[6].title}</th>
	</tr>
	<tr class="text_box">
		<td> 
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[4].data }"/>">
		</td>
		<td>
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[5].data }"/>">
		</td>
		<td >
			<input style="margin-left: 5px;" class="readonly" type="text" size="15" value="<c:out value="${data[6].data }"/>">
		</td>
	</tr>
	<tr>
		<!-- 적용 Tool -->
		<th bgcolor="#f7f7f7">${data_form[8].title}</th>
		<td class="left_align_text" colspan="4"><c:out value="${data[8].data }"/></td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="4">
			<textarea class="fixed_text" readonly="readonly" name="data" cols="73" rows="8"><c:out value="${data[9].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 다운로드 -->
		<th bgcolor="#f7f7f7">${data_form[10].title}</th>
			<td colspan="4">
				<c:if test="${data[0].filename ne null }">
					<form action="<c:url value="/subject/download.do"/>">  
						<input type="hidden" name="filename" value="<c:out value="${data[0].filename }"/>">
						<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()">
						<c:out value="${data[0].filename }"/></a></p>
					</form>
				</c:if>
			</td>
		</tr>
		<!-- 첨부파일 다운로드-->
		<tr>
		<th bgcolor="#f7f7f7">${data_form[11].title}</th>
			<td colspan="4">
				<c:forEach var="sub" items="${data }">
					<c:if test="${sub.data_type eq 'FILE' }">
						<form action="<c:url value="/subject/download.do"/>">  
							<input type="hidden" name="filename" value="<c:out value="${sub.data }"/>">
							<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()">
							<c:out value="${sub.data }"/></a></p>
						</form>
					</c:if>
				</c:forEach>
			</td>
		</tr>
</table>

<!-- 수정용 -->
<form id="update" action="<c:url value="/subject/stepUpdate.do"/>" method="POST" enctype="multipart/form-data">
<input type="hidden" name="step" value="M">
<input type="hidden" name="seq" value="${param.seq}">
<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td class="left_align_text" width="85%" colspan="4"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- CTQ 정의 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td height="70" colspan="4">
		<input name="form_id" value="${data_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<textarea  name="data" cols="73" rows="8"
		onkeyup="checkCharSize(this)">${data[0].data }</textarea>
		<br/>
<!-- 		<a id="ctqCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th rowspan="4" >현수준/<br>목표설정</th>
		<!-- 현수준 -->
		<th width="21%">${data_form[1].title}</th>
		<!-- 목표 -->
		<th width="21%">${data_form[2].title}</th>
		<!-- 개선 후 -->
		<th width="21%">${data_form[3].title}</th>
		<!-- 재무성과 -->
		<th width="23%">${data_form[7].title}</th>
	</tr>
	<tr class="text_box">
		<td>
		<input name="form_id" value="${data_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<input name="data" type="text" size="15" value="${data[1].data }">
		</td>
		<td>
		<input name="form_id" value="${data_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text" size="15" value="${data[2].data }">
		</td>
		<td>
		<input name="form_id" value="${data_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input name="data" type="text" size="15" value="${data[3].data }">
		</td>
		<td rowspan="3">
		<input name="form_id" value="${data_form[7].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="mustBeNum" name="data" type="text" size="19" value="${data[7].data }">
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<!-- 현 시그마 수준 -->
		<th>${data_form[4].title}</th>
		<!-- 목표 -->
		<th>${data_form[5].title}</th>
		<!-- 개선 후 시그마 수준 -->
		<th>${data_form[6].title}</th>
	</tr>
	<tr class="text_box">
		<td > 
		<input  name="form_id" value="${data_form[4].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15" value="${data[4].data }">
		</td>
		<td >
		<input  name="form_id" value="${data_form[5].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15" value="${data[5].data }">
		</td>
		<td >
		<input  name="form_id" value="${data_form[6].form_id }" type="hidden">
		<input  name="subkey" value=0 type="hidden">
		<input  name="data" type="text" size="15" value="${data[6].data }">
		</td>
	</tr>
	<tr class="tool_table">
		<!-- 적용 Tool -->
		<th rowspan="4" bgcolor="#f7f7f7">${data_form[8].title}</th>
		<td ><input type="checkbox" name="tool_data" value="파레토 챠트(Pareto Chart)">파레토 챠트</td>
		<td ><input type="checkbox" name="tool_data" value="정규성 검정">정규성 검정</td>
		<td><input type="checkbox" name="tool_data" value="친화도법">친화도법</td>
		<td><input type="checkbox" name="tool_data" value="Process Mapping">Process Mapping</td>
	</tr>
	<tr class="tool_table">
		<td><input type="checkbox" name="tool_data" value="QFD">QFD</td>
		<td><input type="checkbox" name="tool_data" value="FMEA">FMEA</td> 
		<td><input type="checkbox" name="tool_data" value="그래프 분석">그래프 분석</td>
		<td><input type="checkbox" name="tool_data" value="PULL 시스템">PULL 시스템</td>
	</tr>
	<tr class="tool_table">
		<td><input type="checkbox" name="tool_data" value="히스토그램">히스토그램</td>
		<td><input type="checkbox" name="tool_data" value="우선순위 매트릭스">우선순위 매트릭스</td> 
		<td><input type="checkbox" name="tool_data" value="MSA(GAGE R&R)">MSA(GAGE R&R)</td>
		<td><input type="checkbox" name="tool_data" value="공정능력 분석">공정능력 분석</td>
	</tr>
	<tr class="tool_table">
	    <td colspan="2">&nbsp;&nbsp;기타&nbsp;&nbsp;<input type="text" size="35" name="tool_data">
			<input name="tool_form" type="hidden" value="${data_form[8].form_id }">
		</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[9].title}</th>
		<td colspan="4">
			<input name="form_id" value="${data_form[9].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea name="data" cols="73" rows="8"
			onkeyup="checkCharSize(this)">${data[9].data }</textarea>
<!-- 			<br/> -->
<!-- 			<a id="biefCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th bgcolor="#f7f7f7">${data_form[10].title}</th>
		<td colspan="4"><input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()"></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th id="attachTitle" bgcolor="#f7f7f7">${data_form[11].title}</th>
		<td id="attach" colspan="4">
			<input name="form_id" value="${data_form[11].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
			<!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="addNewAttach(this)">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a onfocus="blur();" href="#" onclick="stepFormUpdateSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
	<a onfocus="blur();" href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a>
</form>
<c:if test="${stepping eq 2 }">
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
	<c:if test="${isRegistered eq 'N' && isApproved eq 1}">
		<form action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
			<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
		</form>
	</c:if>
</c:if>
</c:if>

<!-- 첨부파일 추가할때 사용 -->
<table style="display:none;">
	<tr class="attachTemplete">
		<td colspan="4" class="deleteAttach" style="text-align: left; text-indent: 10px;">
			<input name="form_id" value="${data_form[11].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
		</td>
	</tr>
</table>
</center> 