<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<%
	String airCraftCode = request.getParameter("airCraftCode");
%>
<style>
	#saveButton{
		border:0px;
		background:url("${cp}/images/button/save_button.gif");
		width:53px;
		height:21px;
		cursor:pointer;
	}
	#insertButton{
		border:0px;
		background:url("${cp}/images/button/add_button.gif");
		width:53px;
		height:21px;
		cursor:pointer;
	}
	#modifyButton{
		border:0px;
		background:url("${cp}/images/button/retouch_button.gif");
		width:53px;
		height:21px;
		cursor:pointer;
	}
	#deleteButton{
		border:0px;
		background:url("${cp}/images/button/delete_button.gif");
		width:53px;
		height:21px;
		cursor:pointer;
	}
 	input{ 
		text-align:center;
		width: 90%;
	} 
	
	/* .buttonInput{
		text-align:center;
		width: 40px;
	} */
	
	.readonly{
		border:0px;
		
	}
	#saveButton{
		display:none;
	}
	#section{
	/* IP 4L 2L WM 의 th의 ID */
	width:3%;
	}
	/*이하 input 길이조정 */
	#section1{
	width:70%;
	}
	#section2{
	width:70%;
	}
	#section3{
	width:70%;
	}
	#section4{
	width:70%;
	}
	#orderCd{
	width:70%;
	}
	#dayPeriod1{
	width:70%;
	}
	#dayPeriod2{
	width:70%;
	}
</style>
<script>
$(function(){
	$(".readonly").attr("readonly","readonly");
});
function updateQuestionPeriodType(th){
	var tr=$(th).parent().parent();
	var inputs=tr.find(".readonly");
	tr.find("#modifyButton").hide();
	tr.find("#saveButton").show();
	inputs.removeAttr("readonly").removeClass("readonly");
	
}
function saveQuestionPeriodType(th){
	var airCraftCode= $("#airCraftCode").val();
	var tr=$(th).parent().parent();
	var id=tr.attr("value");
	var lev=tr.attr("lev");
	var upper_id=tr.attr("upperId");
	var questionName = tr.find("#questionName").val();
	var dayPeriod1 = tr.find("#dayPeriod1").val();
	var dayPeriod2 = tr.find("#dayPeriod2").val();
	var orderCd = tr.find("#orderCd").val();
	tr.children().children().addClass("readonly").attr("readonly","readonly");
	tr.find("#modifyButton").removeClass("readonly").show();
	tr.find("#deleteButton").removeClass("readonly");
	tr.find("#saveButton").hide();
	if(((questionName != '' && orderCd !='') &&(dayPeriod1=='' &&dayPeriod2==''))||(questionName != '' && orderCd !='')&&(dayPeriod1!='' &&dayPeriod2!=''))
		{
	$.ajax({
		url:		'/orms/ValuationStandardTable/modifyQuestion.do',
		type:		'POST',
		dataType:	'json',
 		data: {
	 		id:id,
	 		question_name:questionName,
	 		order_cd:orderCd,
	 		day_period1:dayPeriod1,
	 		day_period2:dayPeriod2,
	 		lev:lev,
	 		upper_id:upper_id,
	 		gubun:"ORM003",
	 		airCraftCode:airCraftCode
 		},
 		success:function(data){
 			/* alert(data); */
 			if(data=='Success'){
 				location.reload();
 			}else{
 				
 			}
 		}
	});
		}
	else
	{
	alert("빈칸을 모두 입력하시오. SCORE를 빈값으로 넣길 원하면 빈칸에 N을 입력하시오");

	}
}
function updateQuestionSectionType(th){
		var tr=$(th).parent().parent();
		var inputs=tr.find(".readonly");
		tr.find("#modifyButton").hide();
		tr.find("#saveButton").show();
		inputs.removeAttr("readonly").removeClass("readonly");
		
}
function saveQuestionSectionType(th){
	var airCraftCode= $("#airCraftCode").val();
	var tr=$(th).parent().parent();
	var id=tr.attr("value");
	var lev=tr.attr("lev");
	var upper_id=tr.attr("upperId");
	var questionName = tr.find("#questionName").val();
	var section1 = tr.find("#section1").val();
	var section2 = tr.find("#section2").val();
	var section3 = tr.find("#section3").val();
	var section4 = tr.find("#section4").val();
	var orderCd = tr.find("#orderCd").val();
	tr.children().children().addClass("readonly").attr("readonly","readonly");
	tr.find("#modifyButton").removeClass("readonly").show();
	tr.find("#deleteButton").removeClass("readonly");
	tr.find("#saveButton").hide();
	if((questionName!='' && orderCd!='')&&(section1=='' && section2=='' && section3==''&&section4=='')||(questionName!='' && orderCd!='')&&(section1!='' && section2!='' && section3!=''&&section4!=''))
		{
	$.ajax({
		url:		'/orms/ValuationStandardTable/modifyQuestion.do',
		type:		'POST',
		dataType:	'json',
 		data: {
	 		id:id,
	 		question_name:questionName,
	 		order_cd:orderCd,
	 		section1:section1,
	 		section2:section2,
	 		section3:section3,
	 		section4:section4,
	 		lev:lev,
	 		upper_id:upper_id,
	 		gubun:"ORM004",
	 		airCraftCode:airCraftCode
 		},
 		success:function(data){
 			/* alert(data); */
 			if(data=='Success'){
 				location.reload();
 			}else{
 				
 			}
 		}
	});
		}
	else
		{
		alert("빈칸을 모두 입력하시오. SCORE를 빈값으로 넣길 원하면 빈칸에 N을 입력하시오");
		
		}
}
function insertQuestionPeriodType(th){
	var tr = $(th).parent().parent();
	var nextTr=tr.next();
	var id=tr.attr("value");
	var inputs=nextTr.find(".readonly");
	nextTr.fadeIn().find("#saveButton").show();
	inputs.removeAttr("readonly").removeClass("readonly");
	nextTr.find("#dayPeriod1,#dayPeriod2").hide();
	nextTr=$(th).parent().parent();
	
	
}
function insertQuestionSectionType(th){
	var tr = $(th).parent().parent();
	var nextTr=tr.next();
	var id=tr.attr("value");
	var inputs=nextTr.find(".readonly");
	nextTr.fadeIn().find("#saveButton").show();
	inputs.removeAttr("readonly").removeClass("readonly");
	nextTr.find("#section1,#section2,#section3,#section4").hide();
	nextTr=$(th).parent().parent();
}
function submitCode(){
	var airCraftCode= $("#airCraftCode").val();
	location.href='${cp}/ValuationStandardTable/valuationStandardModify.do?code=7&airCraftCode='+airCraftCode;
}
 function deleteQuestion(th){
	var tr=$(th).parent().parent();
	var id=tr.attr("value");
	$.ajax({
		url:		'/orms/ValuationStandardTable/deleteQuestion.do',
		type:		'POST',
		dataType:	'json',
 		data: {
	 		id:id
	 		
 		},
 		success:function(data){
 			if(data=='Success'){
 				alert("삭제되었습니다.");
 				location.reload();
 			}else{
 				
 			}
 		}
	});
} 

</script>
<img src="${cp }/images/title/valuationStandardModify.gif">
<form>
<img src="${cp }/images/dot.gif"/> 비행환경별

<select id="airCraftCode" onChange="submitCode()">
				<option value="01" <%=("01".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-16</option>
				<option value="02" <%=("02".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-15</option>
				<option value="03" <%=("03".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-4</option>
				<option value="04" <%=("04".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-5</option>
</select>

<table width="100%" id="resultListTable" border="1" >
<thead>
<th colspan="5">평가요소 비행환경</th>
<th>주 간</th>
<th>야 간</th>
<th>정렬순서</th>
<th></th>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }">
	
	<tr value="${valuation.id }" >
	<td >
	<input  id="questionName" type="text" value="${valuation.question_name }" class="readonly" >
	<input id="orderCd" type="hidden" value="${valuation.order_cd }"></td>
	<c:forEach begin="1" end="7">
	<td></td>
	</c:forEach>
	<td>
	<input type="button" id="saveButton" class="buttonInput" onClick="saveQuestionPeriodType(this)">
	<input type="button"id="modifyButton" class="buttonInput" onClick="updateQuestionPeriodType(this)">
	</td>
	</tr><!--여기까지 레벨1  -->
		<c:forEach var="child" items="${valuation.childrenForValuation }">
			<!--*********************************************************************************  -->
			<c:if test="${child.id eq 126 or child.id eq 128 or child.id eq 179 or child.id eq 230 }">
			<!--*********************************************************************************  -->
			<tr value="${child.id }" >
			<c:forEach begin="1" end="${child.lev -1}"><td></td></c:forEach>
			<td >
			<input  id="questionName" type="text" value="${child.question_name }" class="readonly" >
			<input id="orderCd" type="hidden" value="${child.order_cd }">
			</td>
			<c:forEach begin="1" end="6"><td></td></c:forEach>
			<td>
			<input type="button" id="saveButton" class="buttonInput" onClick="saveQuestionPeriodType(this)">
			<input type="button"id="modifyButton" class="buttonInput" onClick="updateQuestionPeriodType(this)">
			</td>
			</tr><!--여기까지 레벨2  -->
					<c:forEach var="child1" items="${child.childrenForValuation }">
					<tr value="${child1.id }" ><c:forEach begin="1" end="${child1.lev -1}"><td></td></c:forEach>
					<td >
					<input  id="questionName" type="text" value="${child1.question_name }" class="readonly" >
					<input id="orderCd" type="hidden" value="${child1.order_cd }">
					</td>
					<c:forEach begin="1" end="5">
					<td></td>
					</c:forEach>
					<td>
					<input type="button" id="insertButton" class="buttonInput" onClick="insertQuestionPeriodType(this)">
					<input type="button" id="saveButton" class="buttonInput" onClick="saveQuestionPeriodType(this)">
					<input type="button"id="modifyButton" class="buttonInput" onClick="updateQuestionPeriodType(this)">
					<input id="deleteButton" type="button" class="buttonInput" onClick="deleteQuestion(this)"></td>
					</tr><!--여기까지 레벨3  -->
		<!-- 추가라인 -->
		<tr id="newLine" style="display: none;" value="" upperId="${child1.id }" lev=${child1.lev }>
		<c:forEach begin="1" end="3"><td></td></c:forEach>
		<td ><input id="questionName" type="text" value="" class="readonly"></td>
		<td></td><td></td><td></td>
		<td><input id="orderCd" type="text" value="" class="readonly"></td>
		<td><input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionPeriodType(this)"><input id="deleteButton" type="submit" value="" onClick="deleteQuestion(this)"></td>
		</tr>
		<!--추가라인  --> 
						<c:forEach var="child2" items="${child1.childrenForValuation }">
						<tr value="${child2.id }" >
						<c:forEach begin="1" end="${child2.lev -1}"><td></td></c:forEach>
						<td ><input id="questionName" type="text" value="${child2.question_name }" class="readonly">
						</td>
						<c:if test="${child2.question_yn eq 'Y' }">
						<td></td>
						<td>
						<input  id="dayPeriod1" type="text" value="${child2.day_period1 }" class="readonly">
						</td>
						<td>
						<input  id="dayPeriod2" type="text" value="${child2.day_period2 }" class="readonly">
						</td>
						</c:if>
						<c:if test="${child2.question_yn eq 'N' }">
						<c:forEach begin="1" end="3"><td></td></c:forEach>
						</c:if>
						<td><input id="orderCd" type="text" value="${child2.order_cd }" class="readonly" ></td>
						<td>
						<c:if test="${child2.question_yn eq 'N'}">
						<input type="button" id="insertButton" class="buttonInput" onClick="insertQuestionPeriodType(this)">
						</c:if>
						<input type="button" id="saveButton" class="buttonInput" onClick="saveQuestionPeriodType(this)">
						<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionPeriodType(this)">
						<input id="deleteButton" type="button" class="buttonInput" onClick="deleteQuestion(this)"></td>
						</tr><!--여기까지 레벨4  -->
		<!-- 추가라인 -->
		<tr id="newLine" style="display: none;" value="" upperId="${child2.id }" lev="${child2.lev }">
		<c:forEach begin="1" end="4"><td></td></c:forEach>
		<td><input id="questionName" type="text" value="" class="readonly"></td>
		<td><input id="dayPeriod1" type="text" value="" class="readonly"></td>
		<td><input id="dayPeriod2" type="text" value="" class="readonly"></td>
		<td><input id="orderCd" type="text" value="" class="readonly"></td>
		<td><input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionPeriodType(this)"><input id="deleteButton" type="button" onClick="deleteQuestion(this)"></td>
		</tr>
		<!--추가라인  --> 
								<c:forEach var="finalChild" items="${child2.childrenForValuation }">
								<tr value="${finalChild.id }" >
								<c:forEach begin="1" end="${finalChild.lev -1}"><td></td></c:forEach>
								<td ><input  id="questionName" type="text" value="${finalChild.question_name }" class="readonly" >
								</td>
								<td ><input  id="dayPeriod1" type="text" value="${finalChild.day_period1 }" class="readonly">
								</td>
								<td><input  id="dayPeriod2" type="text" value="${finalChild.day_period2 }" class="readonly">
								</td>
								<td ><input  id="orderCd" type="text" value="${finalChild.order_cd }" class="readonly">
								</td>
								<td>
								<input type="button" id="saveButton" class="buttonInput" onClick="saveQuestionPeriodType(this)">
								<input type="button"id="modifyButton" class="buttonInput" onClick="updateQuestionPeriodType(this)">
								<input id="deleteButton" type="button" class="buttonInput" onClick="deleteQuestion(this)">
								</td>
								</tr><!--여기까지 레벨5  -->
					</c:forEach>
				</c:forEach>
			</c:forEach>
			</c:if>
		</c:forEach>
</c:forEach>
</tbody>
</table>
<br>
<br>
<img src="${cp }/images/dot.gif"/> 자격별
<table id="resultListTable" border="1" width="100%">
<thead>
<th colspan="3" width="65%">평가요소 비행환경</th>
<th id="section">IP</th>
<th id="section">4L</th>
<th id="section">2L</th>
<th id="section">WM</th>
<th>정렬순서</th>
<th></th>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }">						
	<tr value="${valuation.id }">
	<td>
	<input id="questionName" type="text" value="${valuation.question_name }" class="readonly">
	<input id="orderCd" type="hidden" value="${valuation.order_cd }">
	</td>
	<c:forEach begin="1" end="7"><td ></td></c:forEach>
	<td>
	<input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)">
	<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
	</td>
	</tr><!--여기까지 레벨1  -->
			<c:forEach var="child" items="${valuation.childrenForValuation }">
			<!--*********************************************************************************  -->
			<c:if test="${(child.id ne 126) and (child.id ne 128) and (child.id ne 179) and (child.id ne 230) }">
			<!--*********************************************************************************  -->
			<tr value="${child.id }" >
			<c:forEach begin="1" end="${child.lev -1}"><td></td></c:forEach>
			<td><input id="questionName" type="text" value="${child.question_name }" class="readonly"></td>
			<c:forEach begin="1" end="5"><td></td></c:forEach>
			<td><input id="orderCd" type="text" value="${child.order_cd }" class="readonly"></td>
			<td>
			<input type="button" id="insertButton" class="buttonInput" onClick="insertQuestionSectionType(this)">
			<input id="saveButton" type="button" class="buttonInput" onclick="saveQuestionSectionType(this)">
			<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
			<input id="deleteButton" type="submit" value="" class="buttonInput" onClick="deleteQuestion(this)">
			</td>
			</tr><!--여기까지 레벨 2 -->
			</c:if>
	<!-- 추가라인 -->
	<tr id="newLine" style="display: none;" value="" upperId="${child.id }" lev="${child.lev }">
	<c:forEach begin="1" end="2"><td></td></c:forEach>
	<td><input id="questionName" type="text" value="" class="readonly"></td>
	<td><input id="section1" type="text" value="" class="readonly"></td>
	<td><input id="section2" type="text" value="" class="readonly"></td>
	<td><input id="section3" type="text" value="" class="readonly"></td>
	<td><input id="section4" type="text" value="" class="readonly"></td>
	<td><input id="orderCd" type="text" value="" class="readonly"></td>
	<td><input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)"><input id="deleteButton" value="" type="submit" onClick="deleteQuestion(this)"></td>
	</tr>
	<!--추가라인  --> 
					<c:forEach var="finalChild" items="${child.childrenForValuation }">
					<!--*********************************************************************************  -->
			 <c:if test="${(finalChild.upper_id ne 126) and (finalChild.upper_id ne 128) and (finalChild.upper_id ne 179) and (finalChild.upper_id ne 230)}"> 
					<!--*********************************************************************************  -->
					<tr value="${finalChild.id }">
					<c:forEach begin="1" end="${finalChild.lev -1}"><td></td></c:forEach>
					<td><input id="questionName" type="text" value="${finalChild.question_name }" class="readonly"></td>
					<td><input id="section1" type="text" value="${finalChild.section1 }" class="readonly"></td>
					<td><input id="section2" type="text" value="${finalChild.section2 }" class="readonly"></td>
					<td><input id="section3" type="text" value="${finalChild.section3 }" class="readonly"></td>
					<td><input id="section4" type="text" value="${finalChild.section4 }" class="readonly"></td>
					<td><input id="orderCd" type="text" value="${finalChild.order_cd }" class="readonly"></td>
					<td>
					<input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)">
					<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
					<input id="deleteButton" type="submit" class="buttonInput" value="" onClick="deleteQuestion(this)">
					</td>
					</tr>
	 		 </c:if>  
					</c:forEach><!--여기까지 레벨 3 -->
		</c:forEach>
	</c:forEach>
<c:forEach var="valuation" items="${questionTreeForCommon }">						
	<tr value="${valuation.id }">
	<td>
	<input id="questionName" type="text" value="${valuation.question_name }" class="readonly">
	<input id="orderCd" type="hidden" value="${valuation.order_cd }">
	</td>
	<c:forEach begin="1" end="7"><td ></td></c:forEach>
	<td>
	<input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)">
	<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
	</td>
	</tr><!--여기까지 레벨1  -->
			<c:forEach var="child" items="${valuation.childrenForValuation }">
			<tr value="${child.id }" >
			<c:forEach begin="1" end="${child.lev -1}"><td></td></c:forEach>
			<td><input id="questionName" type="text" value="${child.question_name }" class="readonly"></td>
			<c:forEach begin="1" end="5"><td></td></c:forEach>
			<td><input id="orderCd" type="text" value="${child.order_cd }" class="readonly"></td>
			<td>
			<input type="button" id="insertButton" class="buttonInput" onClick="insertQuestionSectionType(this)">
			<input id="saveButton" type="button" class="buttonInput" onclick="saveQuestionSectionType(this)">
			<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
			<input id="deleteButton" type="submit" value="" class="buttonInput" onClick="deleteQuestion(this)">
			</td>
			</tr><!--여기까지 레벨 2 -->
	<!-- 추가라인 -->
	<tr id="newLine" style="display: none;" value="" upperId="${child.id }" lev="${child.lev }">
	<c:forEach begin="1" end="2"><td></td></c:forEach>
	<td><input id="questionName" type="text" value="" class="readonly"></td>
	<td><input id="section1" type="text" value="" class="readonly"></td>
	<td><input id="section2" type="text" value="" class="readonly"></td>
	<td><input id="section3" type="text" value="" class="readonly"></td>
	<td><input id="section4" type="text" value="" class="readonly"></td>
	<td><input id="orderCd" type="text" value="" class="readonly"></td>
	<td><input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)"><input id="deleteButton" value="" type="submit" onClick="deleteQuestion(this)"></td>
	</tr>
	<!--추가라인  --> 
					<c:forEach var="finalChild" items="${child.childrenForValuation }">
					<tr value="${finalChild.id }">
					<c:forEach begin="1" end="${finalChild.lev -1}"><td></td></c:forEach>
					<td><input id="questionName" type="text" value="${finalChild.question_name }" class="readonly"></td>
					<td><input id="section1" type="text" value="${finalChild.section1 }" class="readonly"></td>
					<td><input id="section2" type="text" value="${finalChild.section2 }" class="readonly"></td>
					<td><input id="section3" type="text" value="${finalChild.section3 }" class="readonly"></td>
					<td><input id="section4" type="text" value="${finalChild.section4 }" class="readonly"></td>
					<td><input id="orderCd" type="text" value="${finalChild.order_cd }" class="readonly"></td>
					<td>
					<input id="saveButton" type="button" class="buttonInput" onClick="saveQuestionSectionType(this)">
					<input id="modifyButton" type="button" class="buttonInput" onClick="updateQuestionSectionType(this)">
					<input id="deleteButton" type="submit" class="buttonInput" value="" onClick="deleteQuestion(this)">
					</td>
					</tr>
					</c:forEach><!--여기까지 레벨 3 -->
		</c:forEach>
	</c:forEach>
</tbody>
</table>
</form>

