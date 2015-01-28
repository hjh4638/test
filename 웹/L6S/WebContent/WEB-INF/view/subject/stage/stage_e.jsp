<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>
$(function(){
 	var plan_date_input=$("input#expire_day").dateinput({
 		trigger:true,
 		format:'yyyy-mm-dd'
	});
 	
 	var num = '${c_data[3].data }';
	var numAddCom = insertComma(num);
	$("#acomInteger").append(numAddCom);
});
</script>
<center>
	<h1 class="End_stage">End_stage</h1>
	<c:if test="${!(is_mystep) && stepping == 5}">
	<br><br>완료보고서가 아직 입력되지 않았습니다.
	</c:if>
	<c:if test="${is_mystep && validateInsert}">
		<form id="insert" action="<c:url value="/subject/stepInsert.do"/>" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="step" value="E">
			<input type="hidden" name="seq" value="${param.seq}">
			<table class="assignmentstage_table">
				<tr>
					<th width="15%">과제명</th>
					<td class="left_align_text" width="85%" colspan="3"><c:out value="${subject.project_name}"/></td>
				</tr>
				<tr>
				<th bgcolor="#f7f7f7">과제 수행부서</th>
				<td class="left_align_text" colspan="3">${subject.sosokname }</td>
				</tr>
				<tr>
					<th bgcolor="#f7f7f7">과제리더</th>
					<td>${subject.leader}</td>
					<th width="15%" bgcolor="#f7f7f7">챔피언</th>
					<td>${subject.champion }</td>
				</tr>
				<tr>
					<!-- C에서 데이터 가져옴 -->
					<th bgcolor="#f7f7f7">재무성과</th>
					<td>${c_data[3].data }</td>
					<!-- 완료일자 -->
					<th>${data_form[0].title}</th>
					<td>
						<input name="form_id" value="${data_form[0].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<input name="data" id="expire_day" type="date" class="date"/>
					</td>
				</tr>
				<tr>
					<!-- 무형성과 -->
					<th bgcolor="#f7f7f7">${data_form[1].title}</th>
					<td  colspan="3">
						<input name="form_id" value="${data_form[1].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="ee1CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr bgcolor="#f7f7f7">
					<th rowspan="${i_databindsize*2+1}" style="width: 10%;">개선사항</th>
					<th colspan="1" width="42.5%">개선 전</th>
					<th colspan="2" width="42.5%">개선 후</th>
				</tr>
				<c:forEach var="ibind" items="${i_databind }">
					<tr>
						<td>
							<img src="<c:url value="/Temp/${ibind[1].data}"/>" width="250" height="250">
						</td>
						<td colspan="2">
							<img src="<c:url value="/Temp/${ibind[2].data}"/>" width="250" height="250">
						</td>
					</tr>
					<tr>
						<td class="fixed_text">
							<textarea class="fixed_text" readonly="readonly" cols="33" rows="5" >${ibind[0].data }</textarea>
						</td>
						<td class="fixed_text" colspan="2"> 
							<textarea class="fixed_text" readonly="readonly" cols="33" rows="5" >${ibind[3].data }</textarea>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<!-- 재무성과 산출근거 -->
					<th bgcolor="#f7f7f7">${data_form[2].title}</th>
					<td colspan="3">
						<input name="form_id" value="${data_form[2].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="ee2CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr>
					<!-- 성과 공유부대(서) -->
					<th bgcolor="#f7f7f7">${data_form[3].title}</th>
					<td colspan="3">
						<input name="form_id" value="${data_form[3].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data"
						onkeyup="checkCharSize(this)"></textarea>
<!-- 						<br /> -->
<!-- 						<a id="eee3CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr>
					<th bgcolor="#f7f7f7">${data_form[4].title}</th>
					<td colspan="3"><input type="file" name="file" size="77" onchange="checkFile()"></td>
				</tr>
			</table>
			<a onfocus="blur();" href="#" onclick="stepFormSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
<%-- 			<a href="#" onclick="history.go(0)"><img src="<c:url value="/images/button/cancel.gif"/>"></a> --%>
		</form>
	</c:if>
	
	<c:if test="${stepping > 5}">
		<c:if test="${(isRegistered eq 'N' || right.app_right.is_handin eq 'Y') && canStart eq 'Y'}">
			<input class="stage_edit" id="modifybutton" type="image" src="<c:url value="/images/button/modify.gif"/>" value="수정">
		</c:if>
		<!-- 출력용 테이블 -->
		<input style="float: right;margin-right:41px;" type="button" value="출력" onclick="openPrint('e')">
		<table id="printtable" class="assignmentstage_table print">
			<tr>
				<th width="15%">과제명</th>
				<td class="left_align_text" colspan="3"><c:out value="${subject.project_name}"/></td>
			</tr>
			<tr>
				<th bgcolor="#f7f7f7">과제 수행부서</th>
				<td class="left_align_text" colspan="3">${subject.sosokname }</td>
			</tr>
			<tr>
				<th bgcolor="#f7f7f7">과제리더</th>
				<td class="left_align_text" width="40%">${subject.leader}</td>
				<th width="15%" bgcolor="#f7f7f7">챔피언</th>
				<td class="left_align_text" width="35%">${subject.champion }</td>
			</tr>
			<tr>
				<th bgcolor="#f7f7f7">재무성과<br>(단위:천원)</th>
				<td class="left_align_text" id="acomInteger"></td>
					<!-- 완료 일자 -->
				<th>${data_form[0].title}</th>
				<td class="left_align_text">
					${data[0].data }
				</td>
			</tr>
			<tr>
				<!-- 무형성과 -->
				<th bgcolor="#f7f7f7">${data_form[1].title}</th>
				<td colspan="3">
				<textarea class="fixed_text" readonly="readonly" cols="72" rows="8" name="data"><c:out value="${data[1].data }"/></textarea>
				</td>
			</tr>

			<tr bgcolor="#f7f7f7">
				<th rowspan="${i_databindsize*2+1}" width="15%">개선사항</th>
				<th>개선 전</th>
				<th colspan="2">개선 후</th>
			</tr>
			<c:forEach var="ibind" items="${i_databind }">
				<tr>
					<td>
						<img src="<c:url value="/Temp/${ibind[1].data}"/>" width="250" height="250">
					</td>
					<td colspan="2">
						<img src="<c:url value="/Temp/${ibind[2].data}"/>" width="250" height="250">
					</td>
				</tr>
				<tr>
					<td>
						<textarea class="fixed_text" readonly="readonly" cols="30" rows="5"><c:out value="${ibind[0].data }"/></textarea>
					</td>
					<td colspan="2">
						<textarea class="fixed_text" readonly="readonly" cols="33" rows="5"><c:out value="${ibind[3].data }"/></textarea>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<!-- 재무성과 산출근거 -->
				<th bgcolor="#f7f7f7">${data_form[2].title}</th>
				<td colspan="3">
					<textarea class="fixed_text" readonly="readonly" cols="72" rows="8" name="data"><c:out value="${data[2].data }"/></textarea>
				</td>
			</tr>
			<tr>
				<!-- 성과 공유부대(서) -->
				<th bgcolor="#f7f7f7">${data_form[3].title}</th>
				<td colspan="3">
					<textarea class="fixed_text" readonly="readonly" cols="72" rows="8" name="data"><c:out value="${data[3].data }"/></textarea>
				</td>
			</tr>
			<tr>
				<!-- 단계별 완료보고서는 스텝테이블에 저장된다. 여기서 가져오는 단게별완료보고서의 파일이름은
				스텝테이블과 데이터테이블을 조인한 쿼리에서 가져온다
				따라서 data[0].filename,data[1].filename,data[2].filename이든지 숫자에 상관없이 결과는 같다.
				--> 
				<th bgcolor="#f7f7f7">${data_form[4].title}</th>
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
		</table>
		
		<!-- 수정용 -->
		<form id="update" action="<c:url value="/subject/stepUpdate.do"/>" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="step" value="E">
			<input type="hidden" name="seq" value="${param.seq}">
			<table class="assignmentstage_table">
				<tr>
					<th width="15%">과제명</th>
					<td width="40%" class="left_align_text"><c:out value="${subject.project_name}"/></td>
					<!-- 완료일자 -->
					<th width="15%">${data_form[0].title}</th>
					<td class="left_align_text" width="30%">
						<input name="form_id" value="${data_form[0].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<input name="data" id="expire_day" type="date" class="date" value="${data[0].data }">
					</td>
				</tr>
				<tr>
					<th bgcolor="#f7f7f7">과제<br />수행부서</th>
					<td class="left_align_text">${subject.sosokname }</td>
					<th bgcolor="#f7f7f7">과제리더</th>
					<td class="left_align_text">${subject.leader}</td>
				</tr>
				<tr>
					<!-- C에서 데이터 가져옴 -->
					<th bgcolor="#f7f7f7">재무성과</th>
					<td class="left_align_text">${c_data[3].data }</td>
					<th bgcolor="#f7f7f7">챔피언</th>
					<td class="left_align_text">${subject.champion }</td>
				</tr>
				<tr>
					<!-- 무형성과 -->
					<th bgcolor="#f7f7f7">${data_form[1].title}</th>
					<td colspan="3">
						<input name="form_id" value="${data_form[1].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data" 
						onkeyup="checkCharSize(this)">${data[1].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="ee1CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr bgcolor="#f7f7f7">
					<th rowspan="${i_databindsize*2+1}">개선사항</th>
					<th>개선 전</th>
					<th colspan="2">개선 후</th>
				</tr>
				<c:forEach var="ibind" items="${i_databind }">
					<tr>
						<td>
							<img src="<c:url value="/Temp/${ibind[1].data}"/>" width="250" height="250">
						</td>
						<td colspan="2">
							<img src="<c:url value="/Temp/${ibind[2].data}"/>" width="250" height="250">
						</td>
					</tr>
					<tr>
						<td>
							<textarea class="fixed_text" cols="30" rows="5"  readonly="readonly">${ibind[0].data }</textarea>
						</td>
						<td colspan="2">
							<textarea class="fixed_text" cols="35" rows="5"  readonly="readonly">${ibind[3].data }</textarea>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<!-- 재무성과 산출근거 -->
					<th bgcolor="#f7f7f7">${data_form[2].title}</th>
					<td colspan="3">
						<input name="form_id" value="${data_form[2].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data" 
						onkeyup="checkCharSize(this)">${data[2].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="ee2CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr>
					<!-- 성과 공유부대(서) -->
					<th bgcolor="#f7f7f7">${data_form[3].title}</th>
					<td colspan="3">
						<input name="form_id" value="${data_form[3].form_id }" type="hidden">
						<input name="subkey" value=0 type="hidden">
						<textarea cols="72" rows="8" name="data" 
						onkeyup="checkCharSize(this)">${data[3].data }</textarea>
<!-- 						<br /> -->
<!-- 						<a id="eee3CharSize">0</a>/1050 -->
					</td>
				</tr>
				<tr>
					<th bgcolor="#f7f7f7">${data_form[4].title}</th>
					<td colspan="3"><input type="file" name="file" size="75" onchange="checkFile()"></td>
				</tr>
			</table>
			<a onfocus="blur();" href="#" style="float: left; margin-left: 340px;" onclick="stepFormUpdateSubmit()"><img src="<c:url value="/images/button/save.gif"/>"></a>
		</form>
			<a onfocus="blur();" href="#" style="float: left;" onclick="history.go(0)"><input id="cancelbutton" type="image" src="<c:url value="/images/button/cancel.gif"/>" value="취소"></a>
	<c:if test="${stepping eq 6 }">
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
				<input type="hidden" name="app_type" value="E">
				<c:if test="${right.app_order eq 6 || right.app_order eq 2 || right.app_order eq 4 }">			
					<img style="margin-top:2px;"src="<c:url value="/images/button/btn_setapp.gif"/>" onclick="openApproval()">
					<input type="text"  id="app_view" readonly="readonly">
					<input type="hidden" id="app_rank" name="app_rank" >
					<input type="hidden" id="app_name" name="app_name" >
					<input type="hidden" id="app_ass"  name="app_ass" >
					<input type="hidden" id="app_sn" name="app_sn" >
				</c:if>
			</form>
		</div>
		<div id="approvalDialog2" title="결재자 의견" style="width: 50px;">
			<form id="approvalForm2" action="<c:url value="/approval_line/approvalSubject.do"/>" method="POST">
				<textarea cols="40" rows="8" name="comment"></textarea>
				<input type="hidden" name="seq" value="${param.seq }">
				<input type="hidden" name="app_type" value="E">
			</form>
		</div>
		<c:if test="${(isRegistered eq 'N' || right.app_right.is_handin eq 'Y') && canStart eq 'Y'}">
			<form id="approval"action="<c:url value="/approval_line/registerNext.do"/>" method="POST">
				<img src="<c:url value="/images/button/btn_setapp.gif"/>" onclick="openApproval()">
				<input type="text"  id="app_view" readonly="readonly">
				<input type="hidden" id="app_rank" name="app_rank" >
				<input type="hidden" id="app_name" name="app_name" >
				<input type="hidden" id="app_ass"  name="app_ass" >
				<input type="hidden" id="app_sn" name="app_sn" >
				<input type="hidden" name="seq" value="${param.seq}">
				<input type="hidden" name="app_type" value="E">
				<input id="sendapproval" type="image" src="<c:url value="/images/button/btn_sendapp.gif"/>">
			</form>
		</c:if>
	</c:if>
</c:if>
</center> 