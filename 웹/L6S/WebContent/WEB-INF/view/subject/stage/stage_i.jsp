<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script>
	var solutionCount;
	var briefCount;
	/* 2012.12.17 상병 함준혁 모든 위치에 삭제 기능 구현하기 위해 수정 */
	var solutionSeq;
	var briefSeq;
	
	$(function(){
		/* 행수 초기화 코드이다. 삭제시 한번 더 사용 */
		solutionCount=$("tr.solutionStandard").length+1;
		/* 2012.12.17 상병 함준혁 모든 위치에 삭제 기능 구현하기 위해 수정 */
		solutionSeq=solutionCount;
		$("th#solutionRowspan").attr("rowspan",solutionCount);
	
		briefCount=$("tr.briefStandard").length+1;
		/* 2012.12.17 상병 함준혁 모든 위치에 삭제 기능 구현하기 위해 수정 */
		briefSeq=briefCount;
		$("th#briefRowsspan").attr("rowspan",briefCount);
		
		$("tr.solutionStandard:gt(0)").find("td.deleteSolution").append('<a class="deleteButton" href="#" onclick="deleteSolution(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
		$("tr.briefStandard:gt(0)").find("td.deleteBrief").append('<a class="deleteButton" href="#" onclick="deleteBrief(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
	});
	function attachSolution(){
		
	 /* 추가된 행만큼 rowspan 변경 */
		if(solutionCount==6){
			alert("5개까지만 추가가능합니다");
			return;
		}
		solutionCount+=1;
		solutionSeq+=1;
		
		$("th#solutionRowspan").attr("rowspan",solutionCount);
		
		/* $("tr.solutionStandard").find("td.deleteSolution").find("a").remove(); */
	/* 템플릿 복제하여 행 붙여넣기 */
		var attach = $(".solutionAttach").clone();
		
		/* 각 행 구별위해 서브키 변환 */
		attach.find("input[name=subkey]").val(solutionSeq-2);
		
		/* 글자수 체크하기 위해 a 태그 아이디 변환 */
		/* attach.find("a").first().attr("id","sCharSize"+(solutionCount-2)+"");
		attach.find("a").last().attr("id","ssCharSize"+(solutionCount-2)+"");*/
		
		attach.removeClass("solutionAttach").addClass("solutionStandard");
		attach.find("td.deleteSolution").append('<a onfocus="blur();" class="deleteButton" href="#" onclick="deleteSolution(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
		$("tr.solutionStandard").last().after(attach);
	}
	function attachBrief(){
		
		 /* 추가된 행만큼 rowspan 변경 */
			if(briefCount==6){
				alert("5개까지만 추가가능합니다");
				return; 
			}
			briefCount+=1;
			briefSeq+=1;
			
			$("th#briefRowsspan").attr("rowspan",briefCount);
			
			/* $("tr.briefStandard").find("td.deleteBrief").find("a").remove(); */
		/* 템플릿 복제하여 행 붙여넣기 */
			var attach = $(".briefAttach").clone();
			attach.find("input[name=subkey]").val(briefSeq-2);
			
			/* attach.find("a").first().attr("id","bfCharSize"+(briefCount-2)+"");
			attach.find("a").last().attr("id","afCharSize"+(briefCount-2)+""); */
			
			attach.removeClass("briefAttach").addClass("briefStandard");
			attach.find("td.deleteBrief").append('<a class="deleteButton" href="#" onclick="deleteBrief(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
			$("tr.briefStandard").last().after(attach);
		}
function deleteSolution(th){
	$(th).parent().parent().remove();
	solutionCount=$("tr.solutionStandard").length+1;
	solutionSeq+=1;
	$("th#solutionRowspan").attr("rowspan",solutionCount);
	/* $("tr.solutionStandard").last().find("td.deleteSolution").append('<a class="deleteButton" href="#" onclick="deleteSolution(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>'); */
}
function deleteBrief(th){
	$(th).parent().parent().remove();
	briefCount=$("tr.briefStandard").length+1;
	briefSeq+=1;
	$("th#briefRowsspan").attr("rowspan",briefCount);
	/* $("tr.briefStandard").last().find("td.deleteBrief").append('<a class="deleteButton" href="#" onclick="deleteBrief(this)" onfocus="blur();"><img src="<c:url value="/images/button/delete.gif"/>"></a>'); */
}
</script>
<script type="text/javascript">

 function preview(th){
	 	var src=$(th).val();
		var file_type=src.substring(src.lastIndexOf(".")+1,
				src.length).toLowerCase();
		if(file_type == 'jpg' || file_type == 'gif' || file_type == 'bmp'){
		 	$("img#previewImage").attr("src",src);
			$('#dialog').dialog('open');
		}
		else{
			$(th).val("");
			alert("이미지만 입력 가능합니다.");
		}
		return false;
	}
//Dialog		
$(function(){
	$('#dialog').dialog({
		autoOpen: false,
		width: 330,
		buttons: {
			"확인": function() { 
				$(this).dialog("close"); 
			} 
		}
	});
});
function validateImage(){
	var isAvailable = true;
	$("form#insert,form#update").find("input.imageup").each(function(){
		var v = $(this).val();
		var file_type=v.substring(v.lastIndexOf(".")+1,v.length).toLowerCase();
		
		if(file_type != 'jpg' && file_type != 'gif' && file_type != 'bmp'){
			isAvailable = false;
		}
	});
	if(isAvailable){
		return true;
	}
	else{
		alert("이미지를 넣어주시기 바랍니다.");
		return false;
	}
}
function submitI(){
	if(validateImage())
		stepFormSubmit();
}
function submitUpdateI(){
	if(validateImage())
		stepFormUpdateSubmit();
}
</script>

<div id="dialog" title="이미지 미리보기" style="display: none;">
	<img id="previewImage" width="300px" height="300px">
</div> 

<center>
	<h1 class="I_stage">I_stage</h1>
	<c:if test="${!(is_mystep) && stepping == 3}">
	<br><br>I단계가 아직 입력되지 않았습니다.
	</c:if>
	<c:if test="${is_mystep && validateInsert }">
		<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="step" value="I">
		<input type="hidden" name="seq" value="${param.seq}">
		
			<table class="assignmentRegister_table">
				<tr>
					<th width="15%" bgcolor="#f7f7f7">과제명</th> 
					<td width="85%" class="left_align_text" colspan="5"><c:out value="${subject.project_name}"/></td>
				</tr>
				<tr bgcolor="#f7f7f7">
					<th rowspan="2" bgcolor="#f7f7f7" id="solutionRowspan">주요원인/<br>개선대책</th>
					<!-- 주요원인 -->
					<th width="35%" colspan="2">${data_form[0].title}</th>
					<!-- 개선대책 -->
					<th width="35%" colspan="2">${data_form[1].title}</th>
					<th width="6%">				
						<!-- 추가버튼 -->
						<a href="#" onclick="attachSolution()" onfocus="blur();">
							<img src="<c:url value="/images/button/add.gif"/>">
						</a>
					</th>
				</tr>
				<tr class="solutionStandard">
					<td colspan="2">
						<input name="form_id" value="${data_form[0].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea name="data" cols="30" rows="5"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="soCharSize">0</a>/1050 -->
					</td>
					<td colspan="2">
						<input name="form_id" value="${data_form[1].form_id }" type="hidden"> 
						<input name="subkey" value=0 type="hidden">
						<textarea name="data" cols="30" rows="5"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="sosoCharSize">0</a>/1050 -->
					</td>
					<td></td>
				</tr>
				<tr class="tool_table">
					<!-- 적용 Tool -->
					<th rowspan="2" bgcolor="#f7f7f7">${data_form[2].title}</th>
<!-- 					<td colspan="3"> -->
<!-- 						<div style="margin-top: 3px; margin-bottom: 3px;" align="center"> -->
<!-- 							<ul class="tool_List1"> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="벤치마킹">벤치마킹</li> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="브레인스토밍">브레인스토밍</li> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="우선순위매트릭스">우선순위매트릭스</li> -->
<!-- 							</ul> -->
<!-- 							<ul class="tool_List1"> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="실험계획법">실험계획법</li> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="storvboard">storvboard</li> -->
<!-- 								<li><input type="checkbox" name="tool_data" value="Gantt Chart">Gantt Chart</li> -->
<!-- 							</ul> -->
<!-- 							<ul class="tool_List2"> -->
<!-- 								<li> -->
<!-- 									기타&nbsp;<input name="tool_data" type="text"> -->
<%-- 									<input name="tool_form" type="hidden" value="${data_form[2].form_id }"> --%>
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 					</td> -->
					<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="벤치마킹">벤치마킹</td>
					<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="브레인스토밍">브레인스토밍</td>
					<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="우선순위매트릭스">우선순위매트릭스</td>
					<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="실험계획법">실험계획법</td>
					<td></td>
					</tr>
					<tr class="tool_table">
					<td class="left_align"><input type="checkbox" name="tool_data" value="Gantt Chart">Gantt Chart</td>
					<td class="left_align"><input type="checkbox" name="tool_data" value="storyboard">storyboard</td>
					<td class="left_align" colspan="2">
						기타
						<input name="tool_data" type="text" size="32">
						<input name="tool_form" type="hidden" value="${data_form[2].form_id }">
					 </td>
				</tr>
				<tr bgcolor="#f7f7f7"> 
					<th rowspan="2" id="briefRowsspan">단계요약</th>
					<!-- 개선전 -->
					<th width="35%" colspan="2">${data_form[4].title}</th>
					<!-- 개선후 -->
					<th width="35%" colspan="2">${data_form[5].title}</th>
					<th width="10%">
					<!--  추가버튼 -->
						<a href="#" onclick="attachBrief()" onfocus="blur();">
								<img src="<c:url value="/images/button/add.gif"/>">
						</a>
					</th>
				</tr>
				<tr class="briefStandard">
					<td width="35%" colspan="2">
						<!-- 이미지 개선전 -->
						<input name="form_id" size="5" value="${data_form[4].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<input id="filename" name="data" type="hidden">
						<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
						
						<input name="form_id" value="${data_form[3].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea name="data" cols="30" rows="5"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="beforeCharSize">0</a>/1050 -->
					</td>
					<td width="35%" colspan="2">
						<!-- 이미지 개선후 -->
						<input name="form_id" value="${data_form[5].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<input id="filename" name="data" type="hidden">
						<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
						
						<input name="form_id" value="${data_form[6].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea name="data" cols="30" rows="5"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="afterCharSize">0</a>/1050 -->
					</td>
					<td></td>						
				</tr>
				<tr>
					<!-- 단계별완료보고서 -->
					<th bgcolor="#f7f7f7">${data_form[7].title}</th>
					<td colspan="4"><input class="fileCSS" type="file" name="file" size="63" onchange="checkFile()"></td>
				</tr>
				<tr class="standardLine">
					<!-- 첨부파일 -->
					<th id="attachTitle" bgcolor="#f7f7f7">${data_form[8].title}</th>
					<td class="align_left"id="attach" colspan="4" align="left">
						<input name="form_id" value="${data_form[8].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<input id="filename" name="data" type="hidden">
						<input class="fileCSS" type="file" name="attachedFile" size="63" onchange="insertNameToData(this)" >
						<!-- 추가버튼 -->
					</td>
					<td>
						<a href="#" onclick="addNewAttach(this)" onfocus="blur();">
							<img src="<c:url value="/images/button/add.gif"/>">
						</a>
					</td>
				</tr> 
			</table>
		<a href="#" onclick="submitI()" onfocus="blur();"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 		<a href="#" onfocus="blur();" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
		</form>
	</c:if>
	
	<c:if test="${stepping > 3}">
		<c:if test="${isRegistered eq 'N' && stepping eq 4 && isApproved eq 3}">
			<input style="margin-top:5px; margin-left: 667px;" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
<%-- 			<input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"> --%>
		</c:if>
	<!-- 출력용 테이블 -->
	<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('i')">
	<table id="printtable" class="assignmentstage_table print">
		<tr>
			<th width="15%" bgcolor="#f7f7f7">과제명</th> 
			<td width="85%" class="left_align_text" colspan="4"><c:out value="${subject.project_name}"/></td>
		</tr>
		<tr bgcolor="#f7f7f7"> 
			<th rowspan="${solutionbindsize+1 }" bgcolor="#f7f7f7">주요원인/<br>개선대책</th>
			<!-- 주요원인 -->
			<th colspan="2" width="42.5%">${data_form[0].title}</th>
			<!-- 개선대책 -->
			<th colspan="2" width="42.5%">${data_form[1].title}</th>
		</tr>
		<!-- stage_a에서 이미 설명함 -->
		<c:forEach var="sovar" items="${solutionbind }">
			<tr>
				<td colspan="2">
					<textarea name="data" readonly="readonly" class="fixed_text" cols="34" rows="5">${sovar[0].data }</textarea>
				</td>
				<td colspan="2">
					<textarea name="data" readonly="readonly" class="fixed_text" cols="34" rows="5">${sovar[1].data }</textarea>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<!-- 적용Tool -->
			<th bgcolor="#f7f7f7">${data_form[2].title}</th>
			<td class="left_align_text" colspan="4"><c:out value="${data[2].data}"/></td>
		</tr>
		<tr bgcolor="#f7f7f7">
			<th rowspan="${briefbindsize+1 }">단계요약</th>
			<!-- 개선전 -->
			<th colspan="2">${data_form[4].title}</th>
			<!-- 개선후 -->
			<th colspan="2">${data_form[5].title}</th>
		</tr>
		<c:forEach var="sovar" items="${briefbind }">
			<tr>
				<td colspan="2">
					<!-- 이미지(개선전) 다운로드 -->
					<form action="<c:url value="/subject/download.do"/>">  
						<input type="hidden" name="filename" value="${sovar[1].data }">
						<p><a href="#" onclick="$(this).parent().parent().submit()" onfocus="blur();"><c:out value="${sovar[1].data }"/></a></p>
					</form>
					<textarea name="data" class="fixed_text" cols="34" rows="5" readonly="readonly"><c:out value="${sovar[0].data }"/></textarea>
				</td>
				<td colspan="2">
					<!-- 이미지(개선후) 다운로드 -->
					<form action="<c:url value="/subject/download.do"/>">   
						<input type="hidden" name="filename" value="${sovar[2].data }">
						<p><a href="#" onclick="$(this).parent().parent().submit()" onfocus="blur();"><c:out value="${sovar[2].data }"/></a></p>
					</form>
					<textarea name="data" class="fixed_text" cols="34" rows="5" readonly="readonly"><c:out value="${sovar[3].data }"/></textarea>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<!-- 단계별 완료보고서 다운로드 -->
			<th bgcolor="#f7f7f7">${data_form[7].title}</th>
			<td colspan="4">
				<c:if test="${data[0].filename ne null }">
					<form action="<c:url value="/subject/download.do"/>">  
						<input type="hidden" name="filename" value=<c:out value="${data[0].filename }"/>>
						<p><a href="#" onclick="$(this).parent().parent().submit()" onfocus="blur();"><c:out value="${data[0].filename }"/></a></p>
					</form>
				</c:if>
			</td>
		</tr>
		<tr>
			<!-- 첨부파일 다운로드 -->
			<th bgcolor="#f7f7f7">${data_form[8].title}</th>
			<td colspan="4">
				<c:forEach var="sub" items="${data }">
					<c:if test="${sub.data_type eq 'FILE' }">
						<form action="<c:url value="/subject/download.do"/>">  
							<input type="hidden" name="filename" value=<c:out value="${sub.data }"/>>
							<p><a href="#" onclick="$(this).parent().parent().submit()" onfocus="blur();"><c:out value="${sub.data }"/></a></p>
						</form>
					</c:if>
				</c:forEach>
			</td>
		</tr>
	</table>
	
	<!-- 수정용 -->
	<form id="update" action="<c:url value="/subject/stepUpdate.do"/>" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="step" value="I">
	<input type="hidden" name="seq" value="${param.seq}">
	
		<table class="assignmentstage_table">
			<tr>
				<th width="15%" bgcolor="#f7f7f7">과제명</th> 
				<td width="85%" class="left_align_text" colspan="5"><c:out value="${subject.project_name}"/></td>
			</tr>
			<tr bgcolor="#f7f7f7">
				<th rowspan="2" bgcolor="#f7f7f7" id="solutionRowspan">주요원인/<br>개선대책</th>
				<!-- 주요원인 -->
				<th width="35%" colspan="2">${data_form[0].title}</th>
				<!-- 개선대책 -->
				<th width="35%" colspan="2">${data_form[1].title}</th>
				<th width="10%">
					<!-- 추가버튼 -->
					<a href="#" onclick="attachSolution()" onfocus="blur();">
						<img src="<c:url value="/images/button/add.gif"/>">
					</a>
				</th>
			</tr>
			<tr class="solutionStandard">
				<td colspan="2">
					<input name="form_id" value="${data_form[0].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<textarea name="data" cols="30" rows="5"
					onkeyup="checkCharSize(this)">${solutionbind[0][0].data }</textarea>
<!-- 					<br /> -->
<!-- 					<a id="soCharSize">0</a>/1050 -->
				</td>
				<td colspan="2" style="border-right: none;">
					<input name="form_id" value="${data_form[1].form_id }" type="hidden"> 
					<input name="subkey" value=0 type="hidden">
					<textarea name="data"  cols="30" rows="5"
					onkeyup="checkCharSize(this)">${solutionbind[0][1].data }</textarea>
<!-- 					<br /> -->
<!-- 					<a id="sosoCharSize">0</a>/1050 -->
				</td>
				<td></td>
			</tr>
			<c:forEach var="sovar" items="${solutionbind }" begin ="1" varStatus="i">
				<tr class="solutionStandard updateSoulutionTr">
					<td colspan="2">
						<input name="form_id" value="${data_form[0].form_id }" type="hidden">
						<input name="subkey" value="${i.index}" type="hidden">
						<textarea name="data"  cols="30" rows="5"
						onkeyup="checkCharSize(this)">${sovar[0].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="soCharSize">0</a>/1050 -->
					</td>
					<td colspan="2" style="border-right: none;">
						<input name="form_id" value="${data_form[1].form_id }" type="hidden"> 
						<input name="subkey" value="${i.index}" type="hidden">
						<textarea name="data" cols="30" rows="5"
						onkeyup="checkCharSize(this)">${sovar[1].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="sosoCharSize">0</a>/1050 -->
					</td>
					<td class="deleteSolution"></td>
				</tr>
			</c:forEach>
			<tr class="tool_table">
				<!-- 적용 Tool -->
<%-- 				<th>${data_form[2].title}</th> --%>
<!-- 				<td colspan="3"> -->
<!-- 					<div style="margin-top: 3px; margin-bottom: 3px;" align="center"> -->
<!-- 						<ul class="tool_List1"> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="벤치마킹">벤치마킹</li> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="브레인스토밍">브레인스토밍</li> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="우선순위매트릭스">우선순위매트릭스</li> -->
<!-- 						</ul> -->
<!-- 						<ul class="tool_List1"> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="실험계획법">실험계획법</li> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="storyboard">Storyboard</li> -->
<!-- 							<li><input type="checkbox" name="tool_data" value="Gantt Chart">Gantt Chart</li> -->
<!-- 						</ul> -->
<!-- 						<ul class="tool_List2"> -->
<!-- 							<li> -->
<!-- 								기타&nbsp;<input name="tool_data" type="text"> -->
<%-- 								<input name="tool_form" type="hidden" value="${data_form[2].form_id }"> --%>
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 				</td> -->

				<th rowspan="2" bgcolor="#f7f7f7">${data_form[2].title}</th>
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="벤치마킹">벤치마킹</td>
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="브레인스토밍">브레인스토밍</td>
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="우선순위매트릭스">우선순위매트릭스</td>
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="실험계획법">실험계획법</td>
				<td></td>
			</tr>
			<tr class="tool_table">
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="Gantt Chart">Gantt Chart</td>
				<td class="left_align" width="17.5%"><input type="checkbox" name="tool_data" value="storyboard">Storyboard</td>
				 <td colspan="2">&nbsp;&nbsp;기타&nbsp;<input name="tool_data" type="text">
					 <input name="tool_form" type="hidden" value="${data_form[2].form_id }">
				 </td>
			</tr>
			<tr bgcolor="#f7f7f7"> 
				<th rowspan="2" id="briefRowsspan">단계요약</th>
				<!-- 개선전 -->
				<th width="35%" colspan="2">${data_form[4].title}</th>
				<!-- 개선후 -->
				<th width="35%" colspan="2">${data_form[5].title}</th>
				<th width="10%">
					<!-- 추가버튼 -->
					<a href="#" onclick="attachBrief()" onfocus="blur();">
						<img src="<c:url value="/images/button/add.gif"/>">
					</a>
				</th>
			</tr>
			<tr class="briefStandard">
				<td width="35%" colspan="2">
				<!-- 이미지 개선전 -->
					<input name="form_id" size="5" value="${data_form[4].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<input id="filename" name="data" type="hidden">
					<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
				
					<input name="form_id" value="${data_form[3].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<textarea name="data" class="edit_text" cols="30" rows="5"
					onkeyup="checkCharSize(this)">${briefbind[0][0].data }</textarea>
<!-- 					<br /> -->
<!-- 					<a id="beforeCharSize">0</a>/1050 -->
				</td>
				<td width="35%" colspan="2">
					<!-- 이미지 개선후 -->
					<input name="form_id" value="${data_form[5].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<input id="filename" name="data" type="hidden">
					<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
				
					<input name="form_id" value="${data_form[6].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<textarea name="data" class="edit_text" cols="30" rows="5"
					onkeyup="checkCharSize(this)">${briefbind[0][3].data }</textarea>
<!-- 					<br /> -->
<!-- 					<a id="afterCharSize">0</a>/1050 -->
				</td>
				<td></td>
			</tr>
			<c:forEach var="sovar" items="${briefbind }" begin="1" varStatus="i">
				<tr class="briefStandard updateBriefTr">
					<td width="35%" colspan="2">
						<!-- 이미지 개선전 -->
						<input name="form_id" value="${data_form[4].form_id }" type="hidden">
						<input name="subkey" value="${i.index}" type="hidden">
						<input id="filename" name="data" type="hidden">
						<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
					
						<input name="form_id" value="${data_form[3].form_id }" type="hidden">
						<input name="subkey" value="${i.index}" type="hidden">
						<textarea name="data" class="edit_text" cols="30" rows="5"
						onkeyup="checkCharSize(this)">${sovar[0].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="beforeCharSize">0</a>/1050 -->
					</td> 
					<td colspan="2">
						<!-- 이미지 개선후 -->
						<input name="form_id" value="${data_form[5].form_id }" type="hidden">
						<input name="subkey" value="${i.index }" type="hidden">
						<input id="filename" name="data" type="hidden">
						<input class="imageup" type="file" accept="image/*" name="attachedFile" onchange="preview(this)" size="20">
						
						<input name="form_id" value="${data_form[6].form_id }" type="hidden">
						<input name="subkey" value="${i.index }" type="hidden">
						<textarea name="data" class="edit_text" cols="30" rows="5"
						onkeyup="checkCharSize(this)">${sovar[3].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="beforeCharSize">0</a>/1050 -->
					</td>
					<td class="deleteBrief"></td>
				</tr>
			</c:forEach>
			<tr>
				<!-- 단계별완료보고서 -->
				<th bgcolor="#f7f7f7">${data_form[7].title}</th>
				<td colspan="4" align="left">
					<input class="fileCSS" type="file" name="file" size="63" onchange="checkFile()">
				</td>
			</tr>
			<tr class="standardLine">
				<!-- 첨부파일 -->
				<th id="attachTitle" bgcolor="#f7f7f7">${data_form[8].title}</th>
				<td id="attach" colspan="4" class="text_edit" align="left">
					<input name="form_id" value="${data_form[8].form_id }" type="hidden">
					<input name="subkey" value=0 type="hidden">
					<input id="filename" name="data" type="hidden">
					<input class="fileCSS" type="file" name="attachedFile" size="63" onchange="insertNameToData(this)" >
				</td>
				<td>	
					<!-- 추가버튼 -->
					<a href="#" onclick="addNewAttach(this)" onfocus="blur();">
						<img src="<c:url value="/images/button/add.gif"/>">
					</a>
				</td>
			</tr> 
		</table>
	<a href="#" onclick="submitUpdateI()" onfocus="blur();"><img src="<c:url value="/images/button/save.gif"/>"></a>
	<a href="#" onfocus="blur();" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a>
	</form>
<c:if test="${stepping eq 4 }">
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
	<c:if test="${isRegistered eq 'N' && isApproved eq 3}">
		<form action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
			<input type="hidden" name="seq" value="${param.seq }">
			<input type="hidden" name="app_type" value="step">
			<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
		</form>
	</c:if>
</c:if>
	</c:if>
	
	<!-- 첨부파일 추가할 때 갖다쓰는 템플릿 -->
	<table style="display:none;">
		<tr class="attachTemplete">
			<td colspan="4" class="align_left" align="left">
				<input name="form_id" value="${data_form[8].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<input id="filename" name="data" type="hidden">
				<input class="fileCSS" type="file"  name="attachedFile" size="63" onchange="insertNameToData(this)" >
			</td>
			<td class="deleteAttach"></td>
		</tr>
	</table>
	
	<!-- 주요원인/개선대책 라인 추가할 때 사용 -->
	<table style="display: none;">
		<tr class="solutionAttach">
			<td colspan="2" class="edit_text">
				<input name="form_id" value="${data_form[0].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<textarea name="data" cols="30" rows="5"
				onkeyup="checkCharSize(this)"></textarea>
<!-- 				<br /> -->
<!-- 				<a id="sCharSize">0</a>/1050 -->
			</td>
			<td colspan="2" class="edit_text">
				<input name="form_id" value="${data_form[1].form_id }" type="hidden"> 
				<input name="subkey" value=0 type="hidden">
				<textarea name="data" cols="30" rows="5"
				onkeyup="checkCharSize(this)"></textarea>
<!-- 				<br /> -->
<!-- 				<a id="ssCharSize">0</a>/1050 -->
			</td>
			<td class="deleteSolution"></td>
		</tr>
	</table>
	
	<!-- 단계요약 라인 추가할 때 사용 -->
	<table style="display: none;">
		<tr class="briefAttach">
			<td colspan="2" >
				<input name="form_id" value="${data_form[4].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<input id="filename" name="data" type="hidden">
				<input class="imageup" type="file" accept="image/*" size="20" name="attachedFile" onchange="preview(this)">
				
				<input name="form_id" value="${data_form[3].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<textarea name="data" cols="30" rows="5"
				onkeyup="checkCharSize(this)"></textarea>
<!-- 				<br /> -->
<!-- 				<a id="bfCharSize">0</a>/1050 -->
			</td>
			<td colspan="2" >
				<input name="form_id" value="${data_form[5].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<input id="filename" name="data" type="hidden">
				<input class="imageup" type="file" accept="image/*" size="20" name="attachedFile" onchange="preview(this)">
			
				<input name="form_id" value="${data_form[6].form_id }" type="hidden">
				<input name="subkey" value=0 type="hidden">
				<textarea name="data" cols="30" rows="5"
				onkeyup="checkCharSize(this)"></textarea>
<!-- 				<br /> -->
<!-- 				<a id="afCharSize">0</a>/1050 -->
			</td>
			<td class="deleteBrief"></td>
		</tr> 
	</table>
</center>  