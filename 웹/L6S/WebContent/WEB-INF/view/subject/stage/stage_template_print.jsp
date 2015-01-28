<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
table{
	border:1px solid black;
	border-collapse: collapse;
	border-spacing: 0;
	margin-top: 20px;
	margin-left:50px; 
	width:700px;
	text-align: center;
}
th{
	height:20px;
	border:1px solid black;
}
tr{
	height:30px;
	
}
td{
	border:1px solid black;
} 
.readonly{
	border:0px;
}
</style> 
<script>
$(function(){
	$(".readonly").attr("readonly","readonly");
}); 
	
function goToStep(th){
	var seq = '${param.seq}';
	var step = $(th).val();
	if(step=="S")
	location.href="<c:url value="/subject/detailSubjectList.do"/>?seq="+seq;
	if(step=="D")
	location.href="<c:url value="stage_d.do"/>?seq="+seq;
	if(step=="M")
	location.href="<c:url value="stage_m.do"/>?seq="+seq;
	if(step=="A")
	location.href="<c:url value="stage_a.do"/>?seq="+seq;
	if(step=="I")
	location.href="<c:url value="stage_i.do"/>?seq="+seq;
	if(step=="C")
	location.href="<c:url value="stage_c.do"/>?seq="+seq;
	if(step=="E")
	location.href="<c:url value="stage_e.do"/>?seq="+seq;
}

function insertNameToData(th){
	var filename = $(th).val();
	var la = filename.lastIndexOf("\\")+1;
	var real_filename=filename.substring(la,filename.length);
	var td = $(th).parent();
	td.find("#filename").val(real_filename);
}

var i=1;
function addNewAttach(th){
	if(i<5){
	var table = $(th).parent().parent().parent();
	var newAttach = $(".attachTemplete").clone().removeClass("attachTemplete");
	newAttach.children().find("input[name=subkey]").val(i);
	table.append(newAttach);
	i++;
	$("#attachTitle").attr("rowspan",i);
	}
	else alert("5개까지만 추가 가능합니다.");
}
function submitChangedData(th){
	var step_id = $(th).attr("step_code");
	var step_codes='';
	var form_ids='';
	var subkeys='';
	var datas='';
	$("td[loop=on]").filter("td[step_id="+step_id+"]").find("input[name=step_code]").each(function(){
		if(step_codes=='')
			step_codes+=$(this).val();
		else
			step_codes+=','+$(this).val();
	});
	$("td[loop=on]").filter("td[step_id="+step_id+"]").find("input[name=form_id]").each(function(){
		if(form_ids=='')
			form_ids+=$(this).val();
		else
			form_ids+=','+$(this).val();
	});
	$("td[loop=on]").filter("td[step_id="+step_id+"]").find("input[name=subkey]").each(function(){
		if(subkeys=='')
			subkeys+=$(this).val();
		else
			subkeys+=','+$(this).val();
	});
	$("td[loop=on]").filter("td[step_id="+step_id+"]").find("input[name=data]").each(function(){
		$(this).addClass("readonly").attr("readonly","readonly");
		if(datas==''){
			if($(this).val() == '')
				datas+=' ';
			else
			datas+=$(this).val();
		}else{
			if($(this).val() == '')
				datas+=', ';
			else
			datas+=','+$(this).val();
		}
	});
		
	  $.ajax({
		url:		'/L6S/subject/stepUpdate.do',
		type:		'POST',
		dataType:	'json',
		data: {
			step_codes:step_codes,
			form_ids:form_ids,
			subkeys:subkeys,
			datas:datas
	 		},
	 	success:function(data){
	 			alert(data);
	 	}
	 }); 
}
function changeToInserMode(th){
	var step_id = $(th).attr("step_code");
	 $("td[loop=on]").find("input[name=data]")
		.addClass("readonly").attr("readonly","readonly");
		 
	$("td[loop=on]").filter("td[step_id="+step_id+"]")
		.find("input[name=data]").removeAttr("readonly").removeClass("readonly");
}
</script> 
<%-- <center> --%>
<!-- <input type="button" onclick="goToStep(this)" value="S"> -->
<!-- <input type="button" onclick="goToStep(this)" value="D"> -->
<!-- <input type="button" onclick="goToStep(this)" value="M"> -->
<!-- <input type="button" onclick="goToStep(this)" value="A"> -->
<!-- <input type="button" onclick="goToStep(this)" value="I"> -->
<!-- <input type="button" onclick="goToStep(this)" value="C"> -->
<!-- <input type="button" onclick="goToStep(this)" value="E"> -->
<%-- </center> --%>

 