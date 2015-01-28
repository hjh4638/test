<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
table {
	width: 700px;
	margin-top: 20px;
	margin-left: 50px;
	border: 1px solid black;
	border-collapse: collapse;
	border-spacing: 0;
	text-align: center;
}

td,th {
	border: 1px solid black;
}
</style>
<script>
	$(document).ready(function() {
		$('.selectOne').click(function() {
			var a = $('input[name=requirment]:checked').val();
			if (a == 2||a == 4) {
				$('#scoreInput').removeAttr('disabled');
			} else {
				$('#scoreInput').attr('disabled', 'true');
			}
			;
		});

	});
	
	$(function(){
		$('#tabs').tabs();
	});
	
	$(document).ready(function() {
		$('#eduNum').keypress(function() {
			var eduNumVal = $('#eduNum').val();
			if (eduNumVal.length == 2) {
				eduNumVal += "-";
				$('#eduNum').val(eduNumVal);
			}
			if (eduNumVal.length >= 2) {
				if (eduNumVal.slice(0, 1) != "-"
					&& eduNumVal.slice(1, 2) != "-"
					&& eduNumVal.slice(2, 3) != "-"
					&& eduNumVal.slice(3, 4) != "-"
					&& eduNumVal.slice(4, 5) != "-") {
					$('#eduNum').val(
						eduNumVal.slice(0, 2) + "-"
						+ eduNumVal.slice(2, 5));
				}
			}
		});
	});
	
	function showRow(th) {
		var tr = $(th).parent().parent();
		var nextTr = tr.next();

		nextTr.show();
	}

	function openPop() {
		var url = '<c:url value="/belt/popup/beltSosok.do"/>';
		alert(url);
		openPopup(url, 500, 200);
	}

	function datumSubmit(th) {
		var form = document.forms[th];
		alert(th);
		form.submit();
// 		sn = form.sn.value;
// 		eduStartDate = form.eduStartDate.value;
// 		eduEndDate = form.eduEndDate.value;
// 		belt = form.belt.value;
// 		institution = form.institution.value;
// 		score = form.score.value;
// 		if (form.eduNum.value.length == 5) {
// 			alert(sn + " " + belt + " " + eduStartDate + " " + eduEndDate + " "	+ institution+" "+score);
// 			fileUpload();
// 			form.submit();
// 		} else {
// 			alert("입력 양식에 맞지 않습니다");
// 		}
	}

	$(function() {
		var dates = $('#eduStartDate, #eduEndDate').datepicker({
			dateFormat : 'yy-mm-dd',
			changeYear : true,
			width : 220,
			onSelect : function(selectedDate) {
				var option = this.id == 'eduStartDate' ? 'minDate'
						: 'maxDate', instance = $(this).data("datepicker");
				date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
					   $.datepicker._defaults.dateFormat,
						selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
			}
		});
	});
	
</script>

<!-- Tabs -->
		<h2 class="demoHeaders">Tabs</h2>
		<div id="tabs" style="width: 790px;">
			<ul>
				<li><a href="#tabs-1">First</a></li>
				<li><a href="#tabs-2">Second</a></li>
				<li><a href="#tabs-3">Third</a></li>
			</ul>
			<div id="tabs-1">
<input type="hidden" id="checkSN" value="${checkSN}"/>
<h1>■ 벨트 정보 신규등록</h1>
<form:form commandName="beltVO" action="beltAddUser.do" method="post" htmlEscape="true">
	<form:input path="sosokCode" type="hidden" />
	<table>
		<tr height="30">
			<th colspan="6">신규 벨트 등록서 </th>
		</tr>
		<tr height="30">
			<th width="14%">성명 </th>
			<td width="16%">
				 <form:input path="name" value="${user.name}" cssStyle="width: 90px; text-align: center; border: 0px;" readonly="readonly" />
			</td>
			<th width="14%">계급</th>
			<td width="16%">
				<form:input path="rank" value="${user.rank}" cssStyle="width: 90px; text-align: center; border: 0px;" readonly="readonly" />
			</td>
			<th width="12%">군번</th>
			<td>
				<form:input path="sn" value="${user.sn}" cssStyle="width: 150px; text-align: center; border: 0px;" readonly="readonly" />
			</td>
		</tr>
		<tr height="30">
			<th>소속</th>
			<td colspan="5">
				<form:input type="text" path="sosokName" style="width: 91%; border: 0px; text-align: center;" readonly="true" />
				<a href="#" onclick="openPop();" onfocus="blur();">
				<img src="<c:url value="/images/button/search3.gif"/>">
				</a>
			</td>
		</tr>
		<tr height="30">
			<td colspan="6">
				<a href="#" onclick="datumSubmit('<c:out value="beltVO"/>');">저장</a>
				<a href="#">취소</a>
			</td>
		</tr>
	</table>
</form:form>
			 </div>
			<div id="tabs-2">
			<form:form commandName="contentsVO" action="beltAddUser.do" method="post" htmlEscape="true">
	<form:input type="hidden" path="sn" value="${user.sn}"/>
	<table>
		<tr height="30">
			<th>벨트</th>
			<td>
				<form:select path="belt">벨트
					<form:option value="MBB" htmlEscape="true">MBB</form:option>
					<form:option value="BB" htmlEscape="true">BB</form:option>
					<form:option value="GB" htmlEscape="true">GB</form:option>
					<form:option value="FEA" htmlEscape="true">FEA</form:option>
				</form:select></td>
			<th>수료/자격여부</th>
			<td colspan="3">
				<input type="radio" name="requirment" class="selectOne" value="1" onfocus="blur()"/>해당 없음 
				<input type="radio"	name="requirment" class="selectOne" value="2" onfocus="blur()"/>수료 완료
				<input type="radio" name="requirment" class="selectOne" value="4" onfocus="blur()"/>자격	취득
				&nbsp;&nbsp;&nbsp;&nbsp; 취득점수 : <form:input	path="score" id="scoreInput" maxlength="2" size="1" disabled="true" />점
		</tr>
		<tr height="30">
			<th width="14%">교육기관</th>
			<td width="16%">
				<form:select path="institution">교육기관
					<form:option value="KAI" htmlEscape="true"></form:option>
					<form:option value="국방부" htmlEscape="true"></form:option>
					<form:option value="교육사" htmlEscape="true"></form:option>
				</form:select>
			</td>
			<th width="14%">교육차수</th>
			<td width="16%">
				<form:input path="eduNum" type="text" maxlength="5" size="4" />차
			</td>
			<th width="12%">교육기간</th>
			<td>
				<form:input path="eduStartDate" id="eduStartDate" cssStyle="width: 70px;" readonly="true" />&nbsp;~&nbsp;
				<form:input	path="eduEndDate" id="eduEndDate" cssStyle="width: 70px;" readonly="true" />
			</td>
		</tr>
		<tr height="30">
			<th>자격/수료 인증</th>
			<td colspan="5">
				<c:forEach items="${contentsVO.fileVO}" var="fileVO">
					<div id="file_<c:out value="${fileVO.fileUniqueNum }"/>">
						<a onfocus="blur();" class="download_aTag" href="javascript:download('<c:out value="${fileVO.fileUniqueNum }"/>');"><c:out value="${fileVO.name}" /></a>
						<a onfocus="blur();" href="#" class="file_delete_aTag" onclick="deleteFileData('<c:url value="/ajax/deleteFileData.do"/>', '<c:out value="${fileVO.fileUniqueNum }"/>');">[삭제]</a>
					</div>
				</c:forEach>
				<div style="clear: left;">
					<script type="text/javascript" >
					<!--
						Embed();
					//-->
					</script>
				</div>
			</td>
		</tr>
		<tr height="30">
			<td colspan="6">
				<a href="#" onclick="datumSubmit('<c:out value="contentsVO"/>');" >저장</a>
				<a href="#">취소</a>
			</td>
		</tr>
	</table>
</form:form>
			</div>
			<div id="tabs-3"> </div>
		</div>







