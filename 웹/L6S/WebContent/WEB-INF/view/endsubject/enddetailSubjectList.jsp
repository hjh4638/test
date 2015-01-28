<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
th,td{
	width:16%;
}

</style>
<script>

$(function(){
	<c:if test="${is_mine eq false}">
		$(".functionTrriger").hide();
	</c:if>
	var nu='${C04}';
	$("#needComma").append(insertComma(nu));
})
function insertComma(num){
	var num_size =num.length;
	var result;
	var count = num_size /3 -1;
	var x;
	x = num_size % 3;
	if(x != 0){
		result = num.substring(0,x);
	}
	else if(x == 0){
		result = num.substring(0,3);
		x=3;
	}
	if(count >0){
		for(var i=0;i<count;i++){
			result = result + "," + num.substring(x+3*i,x+3*i+3);
		}
	}
	return result;
}
// Integer subject_code,Integer price,String content,Integer title,String mode
function insertAfter(){
// 	var subject_code;
	var com=$("#inspinner").val();
	var price;
	if(isNaN(Number(com)))
		price=0;
	else
		price=com;
	
	var content=$("#incontent").val();
	var title=$("#intitle").val();
	var mode="in";
	var subject_code=$("#insubject_code").val();
	$.ajax({
		  url: "InAndChange.do",
		  type: "POST",
		  dataType:"json",
		  data:{
			  subject_code:subject_code,
			  price:price,
			  content:content,
			  title:title,
			  mode:mode
		  },
		  success: function(data){
			if(data=="success")
				location.reload();
		  }
	});
}
function updateAfter(){
// 	var subject_code;
	var com=$("#chspinner").val();
	var price;
	if(isNaN(Number(com)))
		price=0;
	else
		price=com;
	
	var content=$("#chcontent").val();
	var title=$("#chtitle").val();
	var mode="change";
	var seq=$("#chseq").val();
	$.ajax({
		  url: "InAndChange.do",
		  type: "POST",
		  dataType:"json",
		  data:{
			  seq:seq,
			  price:price,
			  content:content,
			  title:title,
			  mode:mode
		  },
		  success: function(data){
			if(data=="success")
				location.reload();
		  }
	});
}
function deleteAfter(seq){
	if(confirm("정말로 삭제하시겠습니까?")){
		$.ajax({
			  url: "deleteAfter.do",
			  type: "POST",
			  dataType:"json",
			  data:{
				  seq:seq
			  },
			  success: function(data){
				if(data=="success")
					location.reload();
			  }
		});
	}
	else
		return;
}
function goToUpdate(seq,title,price,content){
	$("#inDiv").hide();
	
	$("#chtitle").val(title);
	$("#chspinner").val(price);
	$("#chcontent").val(content);
	$("#chseq").val(seq);
	
	$("#chDiv").show();
	
}
function goToInser(){
	$("#chDiv").hide();
	$("#inDiv").show();
		
}
</script>
<center>
<table class="assignmentstage_table printtable print">
	<tr>
		<th width="15%" bgcolor="#f7f7f7">
		과제명
		</th>
		<td class="left_align_text" colspan="5">
		<c:out value="${mainSubject.project_name}"/>
		</td>
	</tr>
	<tr>
		<th width="15%" bgcolor="#f7f7f7">
		팀명
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.team_name}"/>
		</td>
		<th width="15%" bgcolor="#f7f7f7">
		리더
		</th>
		<td class="left_align_text" width="35%">
		<c:out value="${mainSubject.leader}" />
		</td>
		<th width="15%" bgcolor="#f7f7f7">
		부대담당자
		</th>
		<td class="left_align_text" width="35%" id="guide_committee">
		<c:out value="${mainSubject.guide_committee}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		소속
		</th>
		<td class="left_align_text" width="35%">
		<c:out value="${mainSubject.sosokname}"/>
		</td>
		<th bgcolor="#f7f7f7">
		챔피언
		</th>
		<td class="left_align_text" id="champion">
		<c:out value="${mainSubject.champion}"/>
		</td>
		<th bgcolor="#f7f7f7">
		부서장
		</th>
		<td class="left_align_text" id="department_chairman">
		<c:out value="${mainSubject.department_chairman}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		분야별 유형
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.field_type}"/>
		</td>
		<th bgcolor="#f7f7f7">
		과제 구분
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.subject_section}"/>
		</td>
		<th bgcolor="#f7f7f7">
		과제유형
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.subject_type}"/>
		</td>
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		성과구분
		</th>
		<td class="left_align_text">
		<c:out value="${mainSubject.result_section}"/>
		</td>
		<th bgcolor="#f7f7f7">
		재무성과 금액
		</th>
		<td class="left_align_text">
	 		<span id="needComma"></span> 
		</td>
		<th bgcolor="#f7f7f7">
		첨부파일
		</th>
		<td>
			<c:if test="${E05 ne null }">
				<form action="<c:url value="/subject/download.do"/>">  
					<input type="hidden" name="filename" value=<c:out value="${E05}"/>>
					<p><a onfocus="blur();" href="#" onclick="$(this).parent().parent().submit()">
					<c:out value="${E05}"/></a></p>
				</form>
			</c:if>
		</td>
<!-- 		<th bgcolor="#f7f7f7"> -->
<!-- 		총 합계(단위:천원) -->
<!-- 		</th> -->
<!-- 		<td class="left_align_text"> -->
<%-- 		<c:out value="${mainSubject.result_section}"/> --%>
<!-- 		</td> -->
	</tr>
	<tr>
		<th bgcolor="#f7f7f7">
		산출내용/근거
		</th>
		<td colspan="5">
			<c:out value="${E03}"/>
		</td>
	</tr>
	
</table>

<div id="inDiv" class="functionTrriger">
	<table id="inTable" class="assignmentstage_table">
		<tr>
			<th>
				월
			</th>
			<td>
				<select id="intitle" name="title">
					<c:forEach begin="1" end="12" varStatus="i">
						<option value="${i.index }">${i.index }월</option>
					</c:forEach>
				</select>
			</td>
			<th>성과금액<br>(단위:천원)</th>
			<td>
				<input id="inspinner" type="text" name="price" style="width:80px;" maxlength="10">
				
			</td>
		</tr>
		<tr>
			<th>성과내용</th>
			<td colspan="3">
				<textarea id="incontent" rows="7" cols="70" name="content"></textarea>
				<input id="insubject_code" type="hidden" name="subject_code" value="${mainSubject.subject_code }">
			</td>
		</tr>
	</table>
	<input type="button" value="입력" onclick="insertAfter()">
</div>
<p id="ch" ></p>
<div id="chDiv" style="display: none;" class="functionTrriger">
	<table id="chTable" class="assignmentstage_table" >
		<tr>
			<th>
				월
			</th>
			<td>
				<select id="chtitle" name="title">
					<c:forEach begin="1" end="12" varStatus="i">
						<option value="${i.index }">${i.index }월</option>
					</c:forEach>
				</select>
			</td>
			<th>성과금액<br>(단위:천원)</th>
			<td>
				<input id="chspinner" type="text" name="price" style="width:80px;" maxlength="10">
			</td>
		</tr>
		<tr>
			<th>성과내용</th>
			<td colspan="3">
				<textarea id="chcontent" rows="7" cols="70" name="content"></textarea>
				<input id="chseq" type="hidden">
			</td>
		</tr>
	</table>
	<input type="button" onclick="updateAfter()" value="수정">
	<input type="button" onclick="goToInser()" value="추가">
		
</div>

<c:forEach var="vi" items="${after }">
<table id="viewTable" class="assignmentstage_table">
	<tr>
		<th>
			월
		</th>
		<td>
			${vi.title }월 성과 금액
		</td>
		<th>성과금액<br>(단위:천원)</th>
		<td>
			<span style="float:left; margin-left:10px;">${vi.price_com }</span>
			<a class="functionTrriger" style="float: right;margin-right: 3px;" href="#ch" onclick="goToUpdate('${vi.seq}','${vi.title }','${vi.price }','${vi.content }')">수정</a>
			<input class="functionTrriger" style="float: right;margin-right: 10px;" type="button" value="삭제" onclick="deleteAfter('${vi.seq}')">
		</td>
	</tr>
	<tr>
		<th>성과내용</th>
		<td colspan="3">
			<textarea id="incontent" rows="7" cols="70" name="content" readonly="readonly">${vi.content }</textarea>
		</td>
	</tr>
</table>
</c:forEach>

</center>