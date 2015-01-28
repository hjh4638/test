<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@page import="com.ksign.ssoapi.util.SSOCipherUtil" %>
<%@page import="java.util.*" %>
<%@page import="mil.af.L6S.component.subject.SubjectVO"%>
<%@page import="mil.af.L6S.component.subject.SubjectService"%>
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
table{
	margin-top: 20px;
	margin-bottom: 20px;
}
tr{
		height: 30px;
	}
.readonly{
	border:0px;
}
</style> 
<script>
//인쇄 페이지 팝업띄우기
function openPrint(type){
	var code = type;
	openPopup("<c:url value='/subject/popup/popupPrint.do?type='/>"+code,900,900);
}
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
$(function(){
	$(".readonly").attr("readonly","readonly");
// 	$("th").css("color","#008bc8");
}); 
/* 확장자 체크 */
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
	
}
/* 첨부파일 name=data인 input 박스에 파일네임 넣어주는 함수 */
function insertNameToData(th){
	
	var filename = $(th).val();
	var la = filename.lastIndexOf("\\")+1;
	var real_filename=filename.substring(la,filename.length);
	var td = $(th).parent();
	td.find("#filename").val(real_filename);

	var file_type=filename.substring(filename.lastIndexOf(".")+1,
			filename.length).toLowerCase();
	isAccept(file_type);
}

var addedLineCount;
/* 2012.12.17 상병 함준혁 모든 위치에 삭제 기능 구현하기 위해 수정 */
var fileSeq;
$(function(){
	/* 행수 초기화 코드이다. 삭제시 한번 더 사용 */
	addedLineCount=$("tr.standardLine").length+1;
	fileSeq=addedLineCount;
	$("td#attachTitle").attr("rowspan",addedLineCount);
});
function addNewAttach(){
	
	 /* 추가된 행만큼 rowspan 변경 */
		if(addedLineCount==6){
			alert("5개까지만 추가가능합니다");
			return;
		}
		addedLineCount+=1;
		fileSeq+=1;
		$("th#attachTitle").attr("rowspan",addedLineCount);
		
		 /* $("tr.standardLine").find("td.deleteAttach").find("a.deleteAttachButton").remove(); */ 
	/* 템플릿 복제하여 행 붙여넣기 */
		var attach = $(".attachTemplete").clone();
		attach.find("input[name=subkey]").val(fileSeq-2);
		attach.removeClass("attachTemplete").addClass("standardLine");
		attach.find("td.deleteAttach").append('<a class="deleteAttachButton" href="#" onclick="deleteAttach(this)"><img style="margin-left:8px;" src="<c:url value="/images/button/delete.gif"/> onfocus="blur();""></a>');
		$("tr.standardLine").last().after(attach);
	}
function deleteAttach(th){
	$(th).parent().parent().remove();
	addedLineCount=$("tr.standardLine").length+1;
	fileSeq+=1;
	$("td#attachTitle").attr("rowspan",addedLineCount);
	/* $("tr.standardLine").last().find("td.deleteAttach").append('<a class="deleteAttachButton" href="#" onclick="deleteAttach(this)"><img style="margin-left:8px;" src="<c:url value="/images/button/delete.gif"/> onfocus="blur();""></a>'); */
}

function goToStep(step){
	var seq = '${param.seq}';
	if(step=="과제등록서")
	location.href="<c:url value="/subject/detailSubjectList.do"/>?seq="+seq;
	if(step=="D단계")
	location.href="<c:url value="stage_d.do"/>?seq="+seq;
	if(step=="M단계")
	location.href="<c:url value="stage_m.do"/>?seq="+seq;
	if(step=="A단계")
	location.href="<c:url value="stage_a.do"/>?seq="+seq;
	if(step=="I단계")
	location.href="<c:url value="stage_i.do"/>?seq="+seq;
	if(step=="C단계")
	location.href="<c:url value="stage_c.do"/>?seq="+seq;
	if(step=="완료보고서")
	location.href="<c:url value="stage_e.do"/>?seq="+seq;
}

/* textarea 글자수 체크 */	
function checkCharSize(th){
		var a_id = $(th).parent().find("a").attr("id");
		$("a[id="+a_id+"]").replaceWith('<a id='+a_id+'>'+$(th).val().length+'</a>'); 
		if($(th).val().length >=1050)
			$("a[id="+a_id+"]").css("color","red");
}
function textareaSizeCheck(){
	var textAvailable = true;
	$("textarea").each(function(){
		if($(this).val().length>=1050){
			alert("글자수가 초과되었습니다.");
			textAvailable=false;
		}
	});
	if(!(textAvailable))
		return false;
	return true;
}
function checkNumVali(){
	var numAvail = true;
	$(".mustBeNum").each(function(){
		if(Number($(this).val())+"" == Number.NaN+""){
			numAvail = false;
		}
	});
	if(!(numAvail))
		alert("재무성과는 숫자만 입력이 가능합니다.");
	return numAvail;
}

/* 모든 과제가 과제 등록시 거쳐가는 최종 함수 공통적인 유효성검사를 위해 생성했다*/
function stepFormSubmit(){
	if(textareaSizeCheck() && checkNumVali())
		$("form#insert").submit();
}
/* 모든 과제가 과제 수정시 거쳐가는 최종 함수 공통적인 유효성검사를 위해 생성했다*/
function stepFormUpdateSubmit(){
	if(textareaSizeCheck() && checkNumVali())
		$("form#update").submit();
}
/* 수정 취소버튼 */
$(function(){
	$("form#update").hide();
	$("input#cancelbutton").hide();
	$("input#modifybutton").click(function(){
		$("form#update").show();
		$("table#printtable").hide();
		$("input#cancelbutton").show();
		$("input#modifybutton").hide();
		$("input#sendapproval").hide();
		$("form#approval").hide();
		
	});
	$("input#cancelbutton").click(function(){
		$("form#update").hide();
		$("table#printtable").show();
		$("input#cancelbutton").hide();
		$("input#modifybutton").show();
		$("input#sendapproval").show();
		$("form#approval").show();
	});
});	

/* dialog */
$(function(){
	$('#approvalDialog').dialog({
		autoOpen: false
	});
});
$(function(){
	$('#approvalDialog2').dialog({
		autoOpen: false
	});
});

function openPop(code){
	if(code == 1){
		$('#approvalDialog').dialog('open');
		$('#approvalDialog').dialog({
			autoOpen: false,
			width: 330,
			buttons: {
				"결재": function() { 
					if($("#app_sn").val()!=""){
						$("#approvalForm")
						.attr("action","<c:url value="/approval_line/approvalSubject.do"/>")
						.attr("method","POST").submit();
						$(this).dialog("close");
					}else{
						alert("결재자가 지정 되지 않았습니다.");
					}
				},
				"취소": function(){
					$(this).dialog("close"); 
				}
			}
		});
	}else if(code == 2){
		$('#approvalDialog2').dialog('open');
		$('#approvalDialog2').dialog({
			autoOpen: false,
			width: 330,
			buttons: {
				"기각": function() { 
					$("#approvalForm2")
					.attr("action","<c:url value="/approval_line/disapprovalSubject.do"/>")
					.attr("method","POST").submit();
					$(this).dialog("close"); 
				},
				"취소": function(){
					$(this).dialog("close"); 
				}
			}
		});
	}
}
/* 접수기능 */
function openApproval(){
		openPopup("<c:url value="/approval_line/app/flash.do"/>",900,700);
}
</script>

<center>
	<c:if test="${isApproved eq 0 && finishApp eq 'Y'}"> 
		<ul class="btn_menu"> 
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_E" onclick="goToStep('완료보고서')" onfocus="blur();">완료보고서</a></li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 1}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 2}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 3}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li>qqqqq</li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 4}">
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li><a href="#" class="dinamicStep_C" onclick="goToStep('C단계')" onfocus="blur();">C단계</a></li>
			<li>qqqqq</li>
			<li class="dinamicStep_Bar"></li>
		</ul>
	</c:if>
	<c:if test="${isApproved eq 5}"> 
		<ul class="btn_menu">
			<li><a href="#" class="dinamicStep_S" onclick="goToStep('과제등록서')" onfocus="blur();">과제등록서</a></li>
			<li><a href="#" class="dinamicStep_D" onclick="goToStep('D단계')" onfocus="blur();">D단계</a></li>
			<li><a href="#" class="dinamicStep_M" onclick="goToStep('M단계')" onfocus="blur();">M단계</a></li>
			<li><a href="#" class="dinamicStep_A" onclick="goToStep('A단계')" onfocus="blur();">A단계</a></li>
			<li><a href="#" class="dinamicStep_I" onclick="goToStep('I단계')" onfocus="blur();">I단계</a></li>
			<li><a href="#" class="dinamicStep_C" onclick="goToStep('C단계')" onfocus="blur();">C단계</a></li>
			<li><a href="#" class="dinamicStep_E" onclick="goToStep('완료보고서')" onfocus="blur();">완료보고서</a></li>
			<li><h1 class="dinamicStep_Bar"></h1></li>
		</ul>
	</c:if>
</center>