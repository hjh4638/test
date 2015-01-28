<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- 행 추가 -->
<script>
	var addedRowCount;
	$(function(){
		/* 행수 초기화 코드이다. 삭제시 한번 더 사용 */
		addedRowCount=$("tr.standardRow").length+1;
		$("th#varRowspan").attr("rowspan",addedRowCount);
	});
	function attachRow(){
		
	 /* 추가된 행만큼 rowspan 변경 */
		if(addedRowCount==11){
			alert("10개까지만 추가가능합니다");
			return;
		}
		addedRowCount+=1;
		$("th#varRowspan").attr("rowspan",addedRowCount);
		
		$("tr.standardRow").find("td.deleteCollection").find("a.deleteButton").remove();
	/* 템플릿 복제하여 행 붙여넣기 */
		var attach = $(".attachment").clone();
		attach.find("input[name=subkey]").val(addedRowCount-2);
		attach.find(".toggle1,.toggle2").attr("name",addedRowCount-2);
		attach.removeClass("attachment").addClass("standardRow");
		attach.find("td.deleteCollection").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
		$("tr.standardRow").last().after(attach);
		
	/* 새행에 달력기능 추가 */
	 	$(".standardRow").find(".begin_plan,.plan").each(function(){
	 		$(this).addClass("date").dateinput({
	 	 		trigger:true,
	 	 		format:'yyyy-mm-dd'
	 		});
	 	});
		$(".caltrigger").remove();
	}
function deleteRow(th){
	$(th).parent().parent().remove();
	addedRowCount=$("tr.standardRow").length+1;
	$("th#varRowspan").attr("rowspan",addedRowCount);
	$("tr.standardRow").last().find("td.deleteCollection").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
}
</script>
<!-- 달력 -->
<script>
$(function(){
 	var plan_date_input=$(".begin_plan,.plan").dateinput({
 		trigger:true,
 		format:'yyyy-mm-dd'
	});
	$(".caltrigger").remove();
});
</script>
<!-- 폼전송 -->
<script>
function validateStepA(){
	var t=1;
	var a;
	var b;
	var ti = true;
 	$(".standardRow").find(".begin_plan,.plan").each(function(){
		
 		if(t%2 == 1){
			a=$(this).val();
 			t++;
 		}
 		else{
 			b=$(this).val();
 			if(isAfter(a,b)){
 				t=1;
 				$(this).parent().find("input[name=data]").val(a+"~"+b);
 			}
 			else{
 				ti=false;
 				return;
 			}
 		}
	});
 	if(!(ti)){
 		alert("날짜가 잘못 입력되었습니다.");
 		return false;
 	}
 	else if(addedRowCount-1 != $("input.able_text").length){
 		//alert(addedRowCount+$("input.able_text").length);
 		alert("계량형, 계수형 둘중 하나를 선택하셔야합니다.");
 		return false;
 	}
 	else
 		return true;
}
function submitStep(){
	if(validateStepA())
		stepFormSubmit();
}
function submitStepForUpdate(){
	if(validateStepA())
		stepFormUpdateSubmit();
}

</script>
<!-- 라디오박스 함수 -->
<script>
$(function(){
	$(".toggle1,.toggle2").parent().find("input[type=text]").attr("readonly","readonly").addClass("disable_text");
});
function toggleAble(th){
	$(th).parent().parent().children().find("input.radio_text").val("").attr("readonly","readonly").removeClass("able_text").addClass("disable_text");
	$(th).parent().find("input[type=text]").attr("readonly","").addClass("able_text").removeClass("disable_text");
}

</script>
<script>
/* 수정 취소버튼 */
$(function(){
	$("form#update").hide();
	$("input#cancelbutton").hide();
	$("input#modifybutton").click(function(){
		$("form#update").show();
		$("table#printtable").hide();
		$("input#cancelbutton").show();
		$("input#modifybutton").hide();
	});
	$("input#cancelbutton").click(function(){
		$("form#update").hide();
		$("table#printtable").show();
		$("input#cancelbutton").hide();
		$("input#modifybutton").show();
	});
});
</script>
<style>
.able_text{
	border: 2px solid blue;
	border-color: blue;
}
.disable_text{
	background-color: gray;
}
</style>
<center>
<h1 class="A_stage">A_stage</h1>
<c:if test="${!(is_mystep) && stepping == 2}">
	<br><br>A단계가 아직 입력되지 않았습니다.
</c:if>

<!-- 입력용 -->
<c:if test="${is_mystep && validateInsert}">
<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data">
<input type="hidden" name="step" value="A">
<input type="hidden" name="seq" value="${param.seq}">
<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td width="85%" class="left_align_text" colspan="4"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- Vital Few X's -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3">
		<input name="form_id" value="${data_form[0].form_id}" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<textarea name="data" cols="73" rows="8"
		onkeyup="checkCharSize(this)"></textarea>
<!-- 		<a id="vitalCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th id="varRowspan" rowspan="2" >X's Data 수집</th>
		<!-- 계량형 X's -->
		<td width="28%">${data_form[1].title}</td>
		<!-- 계수형 X's -->
		<td width="28%">${data_form[2].title}</td>
		<!-- Data 수집기간 -->
		<td width="29%">${data_form[3].title}
		 <!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="attachRow()">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		  </td>
	</tr>
	
	<tr class="standardRow">
		<td class="text_box">
		<input name="form_id" value="${data_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="toggle1" name="measure" type="radio" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text" value="">EA 
		</td>
		<td class="text_box">
		<input name="form_id" value="${data_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="toggle2" name="measure" type="radio" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text" value="">EA 
		</td>
		<td >
		<input name="form_id" value="${data_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input type="date" class="date begin_plan" />
		~<input type="date" class="date plan" />
		<input class="datedata" name="data" type="hidden" >
		</td>
	</tr>
	<tr>
<!-- 		적용 Tool -->
		<th rowspan="4" bgcolor="#f7f7f7">${data_form[4].title}</th>
		<td class="left_align"><input type="checkbox" name="tool_data" value="특성요인도">특성요인도</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="분석">그래프 분석</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="등분산 검증">등분산 검증</td>
		</tr>
	<tr>
		<td class="left_align"><input type="checkbox" name="tool_data" value="상관 분석">상관 분석</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="브레인 스토밍">브레인 스토밍</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="안정성 검증">안정성 검증</td> 
	</tr>
	<tr>
		<td class="left_align"><input type="checkbox" name="tool_data" value="가설 검증">가설 검증</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="Logic Tree">Logic Tree</td>
		<td class="left_align"><input type="checkbox" name="tool_data" value="정규성 검증">정규성 검증</td>
	</tr>
	<tr>
		<td class="left_align"><input type="checkbox" name="tool_data" value="회귀분석">회귀분석</td> 
		<td class="left_align">&nbsp;&nbsp;기타&nbsp;&nbsp;<input type="text" name="tool_data">
			<input name="tool_form" type="hidden" value="${data_form[4].form_id }">
		</td>
	</tr>
	
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[5].title }</th>
		<td colspan="4">
			<input name="form_id" value="${data_form[5].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea name="data" cols="73" rows="8"
			onkeyup="checkCharSize(this)"></textarea>
<!-- 			<a id="bCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th bgcolor="#f7f7f7">${data_form[6].title}</th>
		<td colspan="3"><input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()"></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th id="attachTitle" bgcolor="#f7f7f7">${data_form[7].title}</th>
		<td  id="attach" colspan="3">
			<input name="form_id" value="${data_form[7].form_id }" type="hidden">
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
	<a onfocus="blur();" href="#" onclick="submitStep()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 	<a href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
</form>
</c:if>

<c:if test="${stepping > 2}">
	<c:if test="${isRegistered eq 'N' && stepping eq 3 && isApproved eq 2}">
		<input class="stage_edit" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 		<input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
	</c:if>
<!-- 출력용 -->
<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('a')">
<table id="printtable" class="assignmentstage_table print">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td class="left_align_text" colspan="3"><c:out value="${subject.project_name}"/></td>
	</tr> 
	<tr>
		<!-- Vital Few X's -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3">
		<textarea class="fixed_text" cols="73" rows="8" readonly="readonly" name="data"><c:out value="${data[0].data }"/></textarea>
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th rowspan="${databindsize+1}">X's Data 수집</th>
		<!-- 계량형 X's -->
		<th width="28%">${data_form[1].title}</th>
		<!-- 계수형 X's -->
		<th width="28%">${data_form[2].title}</th>
		<!-- Data 수집기간 -->
		<th width="29%">${data_form[3].title}</th>
	</tr>
	<!-- subkey>0인 경우는 행이 여러개란 의미이다.
	databind는 subkey별로 행을 가려 넣어둔 
	List<List<SubjectFormAndData>> 객체이다.
	databind={행1,행2,행3,행4...행n}으로 보면 된다.
	행과 subbind는 동일하다고 보면 된다.
	ex)databind size가 5이면 tr이 5개 생성된다 -->
	<c:forEach var="dabind" items="${databind }">
		<tr>
			<!-- subbind는 dabind 중 한 요소로 List<SubjectFormAndData>객체이다.
			이 안에 행에 들어갈 각 항목들이 SubjectFormAndData형태로 저장되어있다.
			subbind={data1,data2,data3...datan}으로 보면 된다.
			ex)subbind가 4개면 td 4개 생성 -->
			<c:forEach var="subbind" items="${dabind }">	
				<td class="text_box">
					<input type="text" readonly="readonly" value="<c:out value="${subbind.data}"/>" size="20" style="border: 0px;"/>
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
	<tr>
		<!-- 적용 Tool -->
		<th bgcolor="#f7f7f7">${data_form[4].title }</th>
		<td class="left_align_text" colspan="3">
		<c:out value="${data[4].data }"/>
		</td>
	</tr>
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[5].title}</th>
		<td colspan="3">
		<textarea class="fixed_text" readonly="readonly" cols="73" rows="10" name="data"><c:out value="${data[5].data }"/></textarea>
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 다운로드 -->
		<th bgcolor="#f7f7f7">${data_form[6].title}</th>
		<td colspan="3">
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
		<th bgcolor="#f7f7f7">${data_form[7].title}</th>
		<td colspan="3">
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
<input type="hidden" name="step" value="A">
<input type="hidden" name="seq" value="${param.seq}">
<table class="assignmentstage_table">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">과제명</th>
		<td width="85%" class="left_align_text" colspan="3"><c:out value="${subject.project_name}"/></td>
	</tr>
	<tr>
		<!-- Vital Few X's -->
		<th bgcolor="#f7f7f7">${data_form[0].title}</th>
		<td colspan="3">
		<input name="form_id" value="${data_form[0].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<textarea name="data" cols="73" rows="8"
		onkeyup="checkCharSize(this)"><c:out value="${data[0].data}"/></textarea>
<!-- 		<br/> -->
<!-- 		<a id="vitalCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr bgcolor="#f7f7f7">
		<th id="varRowspan" >X's Data 수집</th>
		<!-- 계량형 X's -->
		<td width="28%">${data_form[1].title}</td>
		<!-- 계수형 X's -->
		<td width="28%">${data_form[2].title}</td>
		<!-- Data 수집기간 -->
		<td width="29%">${data_form[3].title}
		 <!-- 추가버튼 -->
			<a onfocus="blur();" href="#" onclick="attachRow()">
				<img src="<c:url value="/images/button/add.gif"/>">
			</a>
		  </td>
	</tr>
	
	<tr class="standardRow">
		<td class="text_box">
		<input name="form_id" value="${data_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="toggle1" name="measure" type="radio" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text" value="">EA 
		</td>
		<td class="text_box">
		<input name="form_id" value="${data_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input class="toggle2" name="measure" type="radio" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text" value="">EA 
		</td>
		<td>
		<input name="form_id" value="${data_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input type="date" class="date begin_plan" />
		~<input type="date" class="date plan" />
		<input class="datedata" name="data" type="hidden" >
		</td>
	</tr>
	<tr class="tool_table">
		<!-- 적용 Tool -->
		<th rowspan="4" bgcolor="#f7f7f7">${data_form[4].title}</th>
		<td >
		<input style="text-align:left;"  type="checkbox" name="tool_data" value="특성요인도">특성요인도
		</td>
		<td >
		<input type="checkbox" name="tool_data" value="분석">그래프 분석
		</td>
		<td >
		<input type="checkbox" name="tool_data" value="등분산 검증">등분산 검증
		</td>
	</tr>
	<tr class="tool_table">
		<td>
		<input type="checkbox" name="tool_data" value="브레인 스토밍">브레인 스토밍
		</td>
		<td>
		<input type="checkbox" name="tool_data" value="안정성 검증">안정성 검증
		</td> 
		<td>
		<input type="checkbox" name="tool_data" value="가설 검증">가설 검증
		</td>		
	</tr>
	<tr class="tool_table">
	<td >
		<input type="checkbox" name="tool_data" value="상관 분석">상관 분석
	</td>
	<td>
		<input type="checkbox" name="tool_data" value="Logic Tree">Logic Tree
	</td>
	<td>
		<input type="checkbox" name="tool_data" value="정규성 검증">정규성 검증
	</td>
	</tr>	
	<tr class="tool_table">
		<td>
			<input type="checkbox" name="tool_data" value="회귀분석">회귀분석
		</td> 
		<td>&nbsp;&nbsp;기타<input type="text" name="tool_data">
			<input name="tool_form" type="hidden" value="${data_form[4].form_id }">
		</td>
		<td> </td>
	</tr>
	
	<tr>
		<!-- 단계요약 -->
		<th bgcolor="#f7f7f7">${data_form[5].title }</th>
		<td colspan="3">
			<input name="form_id" value="${data_form[5].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<textarea name="data" cols="73" rows="8"
			onkeyup="checkCharSize(this)"><c:out value="${data[5].data}"/></textarea>
<!-- 			<br/> -->
<!-- 			<a id="bCharSize">0</a>/1050 -->
		</td>
	</tr>
	<tr>
		<!-- 단계별 완료보고서 -->
		<th  bgcolor="#f7f7f7">${data_form[6].title}</th>
		<td colspan="3"><input class="fileCSS" type="file" name="file" size="65" onchange="checkFile()"></td>
	</tr>
	<tr class="standardLine">
		<!-- 첨부파일 -->
		<th id="attachTitle" bgcolor="#f7f7f7">${data_form[7].title}</th>
		<td id="attach" colspan="3">
			<input name="form_id" value="${data_form[7].form_id }" type="hidden">
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
	<a onfocus="blur();" href="#" onclick="submitStepForUpdate()"><img src="<c:url value="/images/button/save.gif"/>"></a>
	<a onfocus="blur();" href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a>
</form>
<c:if test="${stepping eq 3 }">
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
	<c:if test="${isRegistered eq 'N' && isApproved eq 2}">
		<form action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
			<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
		</form>
	</c:if>
</c:if>
</c:if>

<table style="display:none;">
	<tr class="attachTemplete">
		<td colspan="3" class="deleteAttach" style="text-align: left; text-indent: 10px;">
			<input name="form_id" value="${data_form[7].form_id }" type="hidden">
			<input name="subkey" value=0 type="hidden">
			<input id="filename" name="data" type="hidden">
			<input class="fileCSS" type="file" name="attachedFile" size="65" onchange="insertNameToData(this)" >
		</td>
	</tr>
</table>

<table style="display: none;">
	<tr class="attachment">
		<td>
		<input name="form_id" value="${data_form[1].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input type="radio" class="toggle1" name="measure" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text">EA 
		</td>
		<td>
		<input name="form_id" value="${data_form[2].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input type="radio" class="toggle2" name="measure" onclick="toggleAble(this)">
		<input class="radio_text" size="17" name="data" type="text">EA 
		</td>
		<td colspan="2" class="deleteCollection">
		<input name="form_id" value="${data_form[3].form_id }" type="hidden">
		<input name="subkey" value=0 type="hidden">
		<input type="date" class="begin_plan" />
		~<input type="date" class="plan" />
		<input class="datedata" name="data" type="hidden" >
		</td>
	</tr>
</table>
</center> 