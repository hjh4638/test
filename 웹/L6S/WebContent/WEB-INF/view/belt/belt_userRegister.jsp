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

<!-- Standard Action -->
<script type="text/javascript">
	$(document).ready(function(){
		$('.selectSosok').hide();
	});
</script>
	
<!-- Function -->
<script type="text/javascript">
	var totalname;
	
	function showSosokList(){
		$('.selectSosok').fadeIn();
	}
	
	function getBase(th){
		 var basecode=$(th).val();
		 var length = basecode.length;
		 var id;
		 if(length == 3){
			id="one";
		 	$("#one").find("option").remove();
		 	$("#two").find("option").remove();
		 	$("#three").find("option").remove();
		 }
		 else if(length == 6){
			 id="two";
			 $("#two").find("option").remove();
			 $("#three").find("option").remove();
		 }
		 else if(length == 9){
			 id="three";
			 $("#three").find("option").remove();
		 }
		$.ajax({
			url:		'/L6S/subject/getBaseByAjax.do',
			type:		'POST',
			dataType:	'json',
		 	data: {
		 			basecode:basecode
				},
			success:function(data){
		 		$("#"+id).append('<option value=""></option>');
				$.each(data,function(key,value){
					if(value==""){
						$("#"+id).append('<option value="">없음</option>');
					}
					$("#"+id).append('<option value="'+value.basecode+'">'+value.basename+'</option>');
				});
			}
		}); 
	}
	
	function sosokRegister(){
		var form = document.forms['beltVO'];
		var zero = $('#zero > option:selected');
		var one = $('#one > option:selected');
		var two = $('#two > option:selected');
		var three = $('#three > option:selected');
		if(zero.text()==one.text()||one.text()=='공본'){
			totalname = zero.text()+" "+two.text()+" "+three.text();
		}else{
			totalname = zero.text()+" "+one.text()+" "+two.text()+" "+three.text();
		}
		if($('#three').val()=="O"){
			alert("3");
		}
		form.sosokName.value=totalname;
		
		if(three.val()!=""){
			form.sosokCode.value=three.val();
		}else{
			form.sosokCode.value=two.val();
		}
		
		if(zero.val()!="O"&&
		   one.val()!=""){
			
			$(document).find("input[name=sosokName]").val(form.sosokName.value);
			$(document).find("input[name=sosokCode]").val(form.sosokCode.value);
			alert("성공적으로 입력이 되었습니다.");
			$('.selectSosok').hide();
		}else{
			alert("입력을 해주시기 바랍니다.");			
		}
	}
	
	function datumSubmit(th) {
		var form = document.forms[th];
		alert(th);
		form.submit();
	}
</script>

<!-- Error 표시 -->
<script type="text/javascript">
<!--
	$(document).ready(function(){
		var text = $('#input_confirm_text').text();
		
		if(text != ''){
			$('#error_wrapper').removeClass('unit_highlight_hide');
			$('#error_wrapper').addClass('unit_highlight_show');
		}
	});
//-->
</script>
 
<br/>
<input type="hidden" id="checkSN" value="${checkSN}"/>
<h1>■ 벨트 정보 신규등록</h1>
<br/><br/>
<form:form commandName="beltVO" action="beltUserRegister.do" method="post">
	<form:input path="sosokCode" type="hidden" name="sosokCode" value="${user.positionCode}" />
	<table>
		<tr height="30">
			<th colspan="6">필수 인적 정보  등록 </th>
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
				<form:input type="text" path="sosokName" name="sosokName" value="${user.intrasosok}" 
					style="width: 91%; border: 0px; text-align: center;" readonly="true" />
				<a href="#" onclick="showSosokList();" onfocus="blur();">
				<img src="<c:url value="/images/button/search3.gif"/>">
				</a>
			</td>
		</tr>
		<tr height="30">
			<td colspan="6">
				<a href="#" onclick="datumSubmit('<c:out value="beltVO"/>');" >Save and Exit</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="beltListResult.do">Cancel</a>
			</td>
		</tr>
	</table>
	<form:errors path="*"/>
</form:form>

<br/><br/><br/><br/><br/>

<center>
	<div class="selectSosok" style="border: 1px solid black; width: 678px; padding: 10px;">
		<h1>소속 등록</h1> <br/>
		<select id="zero" onchange="getBase(this)" style="width: 80px;">
			<option value="O">--선택--</option>
			<c:forEach var="base" items="${headBase}">
				
				<option value="${base.basecode}">${base.basename }</option>
			</c:forEach>
		</select>
		&nbsp;
		<select id="one" onchange="getBase(this)" style="width: 110px;">
		</select>
		&nbsp;
		<select id="two" onchange="getBase(this)" name="three" style="width: 140px;">
		</select>
		&nbsp;
		<select id="three" name="four" style="width: 110px;">
		</select>
		
		<a href="#" onclick="sosokRegister();">
		<img src="<c:url value="/images/button/insert.gif"/>">
		</a>
	</div>
</center>