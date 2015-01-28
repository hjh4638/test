<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
var alertDialog;
var confirmDialog;
$(function() { 
	alertDialog=createDialog("#alert-dialog","알림",true,300,150);
	confirmDialog=createDialog("#confirm-dialog","확인",true,300,150);
	Nifty("div.dialog_button","transparent");
	$("div .dialog_button").hover(function(){
		$(this).css("background","#C0E6FE");
	},function(){
		$(this).css("background","#DAE6FE");
	});
});
</script>
<div id="alert-dialog" title="알림" class="dialog">
	<p id="alert-dialog-message" style="height:70%"></p>
	<div id="alert-dialog-confirm-button" class="dialog_button" style="color:#000000;background:#DAE6FE;width:80px;margin-left:80px;" onClick="alertDialog.dialog('close')">확인</div>
</div>
<div id="confirm-dialog" title="확인" class="dialog" style="text-align:center">
	<p id="confirm-dialog-message" style="height:70%"></p>
	<div id="confirm-dialog-buttons" style="width:100%;text-align:center">
	<div  id="confirm-dialog-confirm-button" class="dialog_button" style="float:left;color:#000000;background:#DAE6FE;margin-left:25px;width:70px;margin-right:20px;" onClick="confirmDialog.dialog('close')">예</div>
	<div  id="confirm-dialog-cancel-button" class="dialog_button" style="float:left;color:#000000;background:#DAE6FE;width:70px;" onClick="confirmDialog.dialog('close')">아니오</div>
	</div>
</div>