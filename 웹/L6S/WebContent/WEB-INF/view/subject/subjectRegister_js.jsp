<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page import="java.util.*" %>
<%@page import="mil.af.L6S.component.subject.SubjectVO"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page	import="mil.af.common.util.UploadAndDownloadUtil"%>
<%
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(
		request.getSession().getServletContext());
UploadAndDownloadUtil upAndDown = context.getBean(UploadAndDownloadUtil.class);
String accept_type = upAndDown.getAccept_type();
%>

<c:set var="accept_type" value="<%=accept_type %>"/>
<style>
table,tr,td,th{
	border-color: #dedee0;
	border: 1px soild #dedee0;
}
.readonly{
	border-color: blue;
	border:2px soild;
}
</style>
<script>
$(function(){
	$(".readonly").attr("readonly","readonly");
// 	$("th").css("color","#008bc8");
});

function isAccept(file_type){
	var accept_type = '${accept_type}';
	if(accept_type.indexOf(file_type.toLowerCase())!= -1){
	}
	else
		alert("허용되지 않은 확장자입니다. 허용된 확장자:" + accept_type);
}
function checkFile(){
	var filename = $('input[name=file]').val();
	var file_type=filename.substring(filename.lastIndexOf(".")+1,
			filename.length).toLowerCase();
	isAccept(file_type);

	var la = filename.lastIndexOf("\\")+1;
	var real_filename=filename.substring(la,filename.length);
	$("input#myfilename").val(real_filename);


}
/* textarea 글자수 체크 */	
function checkCharSize(th){
		var a_id = $(th).parent().find("a").attr("id");
		$("a[id="+a_id+"]").replaceWith('<a id='+a_id+'>'+$(th).val().length+'</a>'); 
		if($(th).val().length >=1050)
			$("a[id="+a_id+"]").css("color","red");
}

/* UserTable null유입 막기위한 함수 */
function isNewRowNull(){
	var init_name = $("input#Aname").val();
	var init_sn = $("input#Asn").val();
	var init_department = $("input#Adepartment").val();
	var length = $("input[toggle_name=1]").length;
	
	if(isNotNull(init_name) && isNotNull(init_sn) && isNotNull(init_department)){
		if(length == 1){
			var visiable_name = $("input[toggle_name=1]").val();
			var visiable_sn = $("input[toggle_sn=1]").val();
			var visiable_department = $("input[toggle_department=1]").val();
		
				if(isNotNull(visiable_name) && isNotNull(visiable_sn) && isNotNull(visiable_department)){
					return true;
				}
				else return false;
		}else return true;
	}else return false;
}
 
/* 라인추가 */
var addedRowCount;
var lineSeq;
	$(function(){
		/* 행수 초기화 코드이다. 삭제시 한번 더 사용 */
		addedRowCount=$("tr.standardRow").length+1;
		lineSeq = addedRowCount;
		
		$("tr.standardRow").find("td.deleteCollection").find("a.deleteButton").remove();
		$("tr.standardRow:gt(0)").find("td.deleteCollection").append('<a class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
	});
	function attachRow(){
		 
		if(addedRowCount==14){
			alert("13개까지만 추가가능합니다");
			return;
		}
		addedRowCount+=1;
		lineSeq+=1;
				
		/* $("tr.standardRow").find("td.deleteCollection").find("a.deleteButton").remove(); */
	/* 템플릿 복제하여 행 붙여넣기 */
		var attach = $(".attachment").clone();
	/* 템플릿 가공 */
		attach.find("input#name").attr("id",lineSeq+"name");
		attach.find("input#sn").attr("id",lineSeq+"sn");
		attach.find("input#department").attr("id",lineSeq+"department");
		attach.attr("id",lineSeq);
		
		attach.removeClass("attachment").addClass("standardRow");
	/* 삭제버튼 추가 */
		attach.find("td.deleteCollection").append('<a class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>');
		$("tr.standardRow").last().after(attach);
	}
function deleteRow(th){
	$(th).parent().parent().remove();
	addedRowCount=$("tr.standardRow").length+1;
	lineSeq+=1;
	/* $("tr.standardRow").last().find("td.deleteCollection").append('<a class="deleteButton" href="#" onclick="deleteRow(this)"><img src="<c:url value="/images/button/delete.gif"/>"></a>'); */
}


// /* Jquery 달력 기능 */
$(function(){
 	var plan_date_input=$("#plan_d,#plan_m,#plan_a,#plan_i,#plan_c,"
 				+"#begin_plan_d,#begin_plan_m,#begin_plan_a,#begin_plan_i,#begin_plan_c").dateinput({
 		trigger:true,
 		format:'yyyy-mm-dd'
});
});
/* 관리자검색 */

function openSearchAdmin(th){
	var id=$(th).parent().attr("id");
	openPopup("<c:url value="popup/popupSearchAdmin.do"/>?id="+id,600,500);
}
/* 사람 검색 */
function openSearchUser(th){
	var tr= $(th).parent().parent();
	var id=tr.attr("id");
	openPopup("<c:url value="popup/popupSearchUser.do"/>?id="+id,600,500);
}
/* 폼 전송 */
function validationAndSubmit(){
	
	var textAvailable = true;
	$("textarea").each(function(){
		if($(this).val().length>=1050){
			alert("글자수가 초과되었습니다.");
			textAvailable=false;
		}
	});
	if(!(textAvailable))
		return;
	
	var b_d= $("#begin_plan_d").val();
	var b_m= $("#begin_plan_m").val();
	var b_a= $("#begin_plan_a").val(); 
	var b_i= $("#begin_plan_i").val();
	var b_c= $("#begin_plan_c").val();
	var d= $("#plan_d").val();
	var m= $("#plan_m").val();
	var a= $("#plan_a").val(); 
	var i= $("#plan_i").val();
	var c= $("#plan_c").val();
	
	$("input[name=plan_d]").val(b_d+","+d);
	$("input[name=plan_m]").val(b_m+","+m);
	$("input[name=plan_a]").val(b_a+","+a);
	$("input[name=plan_i]").val(b_i+","+i);
	$("input[name=plan_c]").val(b_c+","+c);
	
	
	var project_name=$("#project_name").val();
	var team_name=$("#team_name").val();
	
	var leader=$("input[name=leader]").val();
	var leader_qualification=$("input[name=leader_qualification]").val();
	var champion=$("input[name=champion]").val();
	var department_chairman=$("input[name=department_chairman]").val();
	var guide_committee=$("input[name=guide_committee]").val();
	var app_sn=$("input[name=app_sn]").val();
	
	var field_type=$("#field_type").val();
	var result_section=$("#result_section").val();
	var subject_section=$("#subject_section").val();
	var subject_type=$("#subject_type").val();
	
	if(isNotNull(project_name) && isNotNull(team_name)){
		if(isNotNull(champion) && isNotNull(department_chairman) && isNotNull(guide_committee)){
				if(isNotNull(field_type) && isNotNull(result_section) 
						&& isNotNull(subject_section) && isNotNull(subject_type)){		
							if(!(isAfter(b_d,d))||!(isAfter(b_m,m))||!(isAfter(b_a,a))||!(isAfter(b_i,i))||!(isAfter(b_c,c))){
								alert("단계별 날짜 정보를 다시 한번 확인해주시기 바랍니다.");
								return false;
							}
							else if(!(isAfter(d,b_m))|| !(isAfter(m,b_a))||!(isAfter(a,b_i))||!(isAfter(i,b_c))){
								alert("단계별 날짜 정보를 다시 한번 확인해주시기 바랍니다.");
								return false;
							}				
							$("#project_name").val(deleteSpace(project_name));
							$("#team_name").val(deleteSpace(team_name));
					
							$("#register").submit();
							
				}else	alert("과제 유형 분류를 해주시기 바랍니다.");
				
		}else alert("챔피언과 부서장을 지정해주시기 바랍니다.");
		
	}else alert("과제명과 팀명을 입력해주시기 바랍니다."); 
}

</script>