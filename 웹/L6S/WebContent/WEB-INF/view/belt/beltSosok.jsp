<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>
	var totalname;
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
			alert("성공적으로 입력이 되었습니다.");
			$(opener.document).find("input[name=sosokName]").val(form.sosokName.value);
			$(opener.document).find("input[name=sosokCode]").val(form.sosokCode.value);
			window.close();
		}else{
			alert("입력을 해주시기 바랍니다.");			
		}
	}
</script>

<form:form commandName="beltVO" method="post" htmlEscape="true">
	<form:input path="sosokCode" type="hidden" id="baseCode"/>
	<form:input path="sosokName" type="hidden" id="baseName"/>
</form:form>

	<select id="zero" onchange="getBase(this)" style="width: 80px;">
		<option value="O">--선택--</option>
		<c:forEach var="base" items="${headBase }">
			<option value="${base.basecode}">${base.basename }</option>
		</c:forEach>
	</select>

	<select id="one" onchange="getBase(this)" style="width: 110px;">
	</select>

	<select id="two" onchange="getBase(this)" name="three" style="width: 140px;">
	</select>

	<select id="three" name="four" style="width: 110px;">
	</select>
	
	<a href="#" onclick="sosokRegister();">
	<img src="<c:url value="/images/button/insert.gif"/>">
	</a>	