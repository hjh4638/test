<!--
	작성자 : 상병 함준혁
	
	DESCRIPTION :
	data 테이블은 step_code,form_id,subkey,data의 4개 칼럼으로 이루어져있다.
	각 td는 data테이블에 저장될 한 행이다. 여기에서 데이터를 입력하기 위해서
	step_code가 빠졌는데 이것은  stepInsert.do 에서 nextVal(DB시퀀스함수)로 새 step_code 
	만들어서 공통으로 사용한다.
	프로세스는
	1.step(d,m,a,i,c,e 구분용)과 seq(과제코드) 그리고 
	데이터의 집합({d1,d2,d3,...dn}로 구성, dn은 {form_idn,subkeyn,datan}으로 이루어짐)
	이 세가지의 데이터를 컨트롤러 stepInsert.do로 전송
	2.단계별 완료보고서,첨부파일,이미지(개선전,개선후)을 업로드하고 파일명 가져와서 service로 파라미터 전달
	3.컨트롤러에서 step_code를 생성하고 전송한 seq로 step_table에 insert 하기위해 service로 파라미터 전달
	(각 단계에 한개씩의 스텝이 있고 그 스텝 밑에 데이터가 있는 구조이다.)
	4.2에서 구한 과제코드와 전송한 데이터 집합을 리스트로 만들어(ListVOUtil이 해준다.) service로 전달
	5.inserStepAndData 메소드에서 각 파라미터 받아 step 테이블에 한행 insert
	data 테이블에 리스트에 담긴만큼 insert(data 테이블에 insert하는중 form_id가 첨부파일 혹은 이미지이면
	파일명으로 setData해서 insert
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>
function test(){
	var f= $("input#test").html();
	$("input#ttest").val(f);
}
</script>
<center>
<h1 class="D_stage">D_stage</h1>

<c:if test="${!(is_mystep) && stepping == 0}">
	<br><br>D단계가 아직 입력되지 않았습니다.
</c:if>

<c:if test="${is_mystep && validateInsert && isRegistered eq 'N'}">
<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data">

<!-- 이 과제가 d,m,a,i,c 중 무엇인지 구분하기 위해 전송 -->
<input type="hidden" name="step" value="D">
<!-- 이 과제의 과제코드(subject_code)를 보내기 위해 전송 -->
<input type="hidden" name="seq" value="${param.seq}">

<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th> 
		<td class="left_align_text" width="85%" colspan="3"><c:out value="${subject.project_name}"/></td>
	</tr> 
	<tr>
		<!-- 현 실태 및 문제점 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3"> 
		<input name="form_id" value="${data_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<textarea name="data" cols="72" rows="10"
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<a id="pCharSize">0</a>/1050 -->
		</td> 
	</tr>
	<tr>
		<!-- 개선사항 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="3">
		<input name="form_id" type="hidden" value="${data_form[1].form_id }">
		<input name="subkey" value=0 type="hidden">
		<textarea name="data" cols="72" rows="10"
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<a id="iCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 적용 Tool -->
		<th rowspan="3" bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td class="left_align" width="28%">
			<input type="checkbox" name="tool_data" value="파레토 챠트(Pareto Chart)">파레토 챠트(Pareto Chart)
		</td>
		<td class="left_align" width="28%">
			<input type="checkbox" name="tool_data" value="사이팍 매핑 (SIPOC)">사이팍 매핑 (SIPOC)
		</td>
		<td class="left_align" width="29%">
			<input type="checkbox" name="tool_data" value="시간 가치 매핑(Time Value Map)">시간 가치 매핑(Time Value Map)
		</td>
	</tr>
	<tr>
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="프로젝트 챠터(Project Charter)">프로젝트 챠터(Project Charter)</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="SWOT 분석">SWOT 분석</td> 
		<td class="left_align"><input type="checkbox" name="tool_data" value="3C 분석">3C 분석</td>
	</tr>
	<tr>
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="CTQ 세부 전개 (Flow Down)">CTQ 세부 전개 (Flow Down)
		</td>
	<td class="left_align">기타 &nbsp;&nbsp;&nbsp;<input type="text" name="tool_data" maxlength="35" size="15">
		<input name="tool_form" type="hidden" value="${data_form[2].form_id }">
	</td>
	<td></td>				
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td colspan="3"><input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()"></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th id="attachTitle" bgcolor="#f7f7f7">${data_form[4].title}</th>
		<td id="attach" colspan="3">
			<input name="form_id" value="${data_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
			<!-- 추가버튼 -->
			<a href="#" onclick="addNewAttach(this)">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a href="#" onclick="stepFormSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 	<a href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
</form> 
</c:if>

<c:if test="${stepping > 0}">
	<c:if test="${isRegistered eq 'N' && stepping eq 1 && isApproved eq 0}">
		<input class="stage_edit" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 		<input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
	</c:if>
<!-- 출력용 -->
<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('d')">
<table id="printtable" class="assignmentstage_table print">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th> 
		<td class="left_align_text" width="85%" colspan="3"><c:out value="${subject.project_name}"/></td>
	</tr> 
	<tr>
		<!-- 현 실태 및 문제점 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3">
			<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[0].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<!-- 개선사항 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="3">
			<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[1].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<!-- 적용 Tool -->
		<th bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td class="left_align_text" colspan="3"><c:out value="${data[2].data}"/></td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 다운로드 -->
		<!-- filename는 step 테이블에 저장되는거고 쿼리로 가져올때도
		step data 조인해서 가져와서 
		data[x].filename에서 x가 상계 밑에의 정수기만 하면 모두 값이 같다.-->
		<th width="15%" bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td width="85%">
			<c:if test="${data[0].filename ne null }">
				<form action="<c:url value="/subject/download.do"/>">  
					<input type="hidden" name="filename" value=<c:out value="${data[0].filename }"/>>
					<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()">
					<c:out value="${data[0].filename }"/></a></p>
				</form>
			</c:if>
		</td>
	</tr>
	<tr>
		<!-- 첨부파일 다운로드 -->
		<th width="15%" bgcolor="#f7f7f7">${data_form[4].title}</th>
		<td width="85%">
			<c:forEach var="sub" items="${data }">
			<!-- 첨부파일의 데이터타입은 FILE로 form 테이블에 저장되어있다.
			여기서는 해당 데이터 목록중 첨부파일(data_type가 FILE인)을 뿌려준다 -->
			<c:if test="${sub.data_type eq 'FILE' }">
			<form action="<c:url value="/subject/download.do"/>">  
				<input type="hidden" name="filename" value=<c:out value="${sub.data }"/>>
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

<!-- 이 과제가 d,m,a,i,c 중 무엇인지 구분하기 위해 전송 -->
<input type="hidden" name="step" value="D">
<!-- 이 과제의 과제코드(subject_code)를 보내기 위해 전송 -->
<input type="hidden" name="seq" value="${param.seq}">

<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th> 
		<td class="left_align_text" width="85%" colspan="3"><c:out value="${subject.project_name}"/></td>
	</tr> 
	<tr>
		<!-- 현 실태 및 문제점 -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3"> 
		<input name="form_id" value="${data_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden"> 
		<textarea  name="data" cols="73" rows="10"
		onkeyup="checkCharSize(this)">${data[0].data }</textarea>
<!-- 		<a id="pCharSize">0</a>/1050 -->
		</td> 
	</tr>
	<tr>
		<!-- 개선사항 -->
		<th bgcolor="#f7f7f7">${data_form[1].title}</th>
		<td colspan="3">
		<input name="form_id" type="hidden" value="${data_form[1].form_id }">
		<input name="subkey" value=0 type="hidden">
		<textarea  name="data" cols="73" rows="10"
		onkeyup="checkCharSize(this)">${data[1].data }</textarea>
<!-- 		<a id="iCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr class="tool_table">
		<!-- 적용 Tool -->
		<th rowspan="3" bgcolor="#f7f7f7">${data_form[2].title}</th>
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="파레토 챠트(Pareto Chart)">파레토 챠트(Pareto Chart)
		</td>
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="사이팍 매핑 (SIPOC)">사이팍 매핑 (SIPOC)
		</td>
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="시간 가치 매핑(Time Value Map)">시간 가치 매핑(Time Value Map)
		</td>
	</tr>
	<tr class="tool_table">
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="프로젝트 챠터(Project Charter)">프로젝트 챠터(Project Charter)</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="SWOT 분석">SWOT 분석</td> 
		<td class="left_align"><input type="checkbox" name="tool_data" value="3C 분석">3C 분석</td>
	</tr>
	<tr class="tool_table">
		<td class="left_align">
			<input type="checkbox" name="tool_data" value="CTQ 세부 전개 (Flow Down)">CTQ 세부 전개 (Flow Down)
		</td>
	<td class="left_align">기타 &nbsp;&nbsp;&nbsp;<input type="text" name="tool_data" maxlength="35" size="15">
		<input name="tool_form" type="hidden" value="${data_form[2].form_id }">
	</td>
	<td></td>				
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th width="15%" bgcolor="#f7f7f7">${data_form[3].title}</th>
		<td width="85%" colspan="3">
			<input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()">
		</td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th width="15%" id="attachTitle" bgcolor="#f7f7f7">${data_form[4].title}</th>
		<td width="85%" id="attach" colspan="3">
			<input name="form_id" value="${data_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
			<!-- 추가버튼 -->
			<a href="#" onclick="addNewAttach(this)" onfocus="blur();">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		</td>
	</tr>
</table>
	<a onfocus="blur();" href="#" onclick="stepFormUpdateSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 	<a href="#"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
<input id="cancelbutton" type="image" onclick="history.go(0)" src="<c:url value="/images/button/cancel.gif"/>" value="취소">
</form> 
	<c:if test="${stepping eq 1 }">
		<c:if test="${right.app_right.is_approval eq 'Y' }">
	<center>
		<ul class="appMenu">
			<a href="#" onclick="openPop(1);" onfocus="blur();"><li class="approval_btn"></li></a>
			<a href="#" onclick="openPop(2);" onfocus="blur();"><li class="disapproval_btn"></li></a>
		</ul>
	</center>
<!-- 			<input type="button" value="결재/기각" onclick="openPop()"> -->
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
		<c:if test="${isRegistered eq 'N' && isApproved eq 0}">
			<form action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
				<input type="hidden" name="seq" value="${param.seq }">
				<input type="hidden" name="app_type" value="step">
				<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
				<!--img id="sendapproval" src="<c:url value="/images/button/btn_sendapp.gif"/>" onclick="#"-->
			</form>
		</c:if>
	</c:if>
</c:if>

<!-- 첨부파일 추가할때 사용하는 템플릿 -->
<table style="display:none;">
	<tr class="attachTemplete">
		<td colspan="3" class="deleteAttach" style="text-align: left; text-indent: 10px;">
			<input name="form_id" value="${data_form[4].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
	</tr>
</table>

</center> 