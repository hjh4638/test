function createDialog(id,title,modal,width,height, beforeClose){
	$( "#dialog:ui-dialog" ).dialog( "destroy" );

	var dialog=$(id ).dialog({
		title:title,
		resizable:false,
		width:width,
		height: height,
		modal: modal,
		autoOpen:false,
		beforeClose: beforeClose
	});
	$(".ui-dialog-titlebar").removeClass("ui-widget-header");
	$(".ui-widget").removeClass("ui-widget");
	$(".ui-dialog-title").css("font-weight","bold");
	$(".ui-dialog-title").css("font-size","15px");
	return dialog;
}

function alertMessage(title,message,onConfirmClick){
	$(function(){
	$("#alert-dialog-confirm-button").unbind('click','');
	$("#alert-dialog").attr("title",title);
	$("#alert-dialog-message").html(message);
	$("#alert-dialog-confirm-button").bind('click','',onConfirmClick);
	alertDialog.dialog("open");
	});
}
function confirm(title,message,confirmButtonCallback,cancelButtonCallback){
	$(function(){
	$("#confirm-dialog-confirm-button").unbind('click','');
	$("#confirm-dialog-cancel-button").unbind('click','');
	$("#confirm-dialog").attr("title",title);
	$("#confirm-dialog-message").html(message);
	$("#confirm-dialog-confirm-button").bind('click','',confirmButtonCallback);
	$("#confirm-dialog-cancel-button").bind('click','',cancelButtonCallback);
	confirmDialog.dialog("open");
	});
}

/*비행대대 리스트를 가져오는 ajax*/
function ajaxSquadronList(flightGroupCode,selectId,param,plusAll){
	$.ajax({
		url:		'/orms/SystemManage/getSquadronList.do',
		type:		'POST',
		dataType:	'json',
 		data: {
	 		flightGroupCode:flightGroupCode
 		},
 		success:function(data){
 			var squadronOption='';
 			if(plusAll==true){
 				squadronOption=squadronOption+'<option value="">전체</option>';
 			}
 			for(var i=0;i<data.length;i++){
 				if(param == data[i].sosokcode){
 					
 					squadronOption=squadronOption+'<option value="'+data[i].sosokcode+'" selected="selected">'+data[i].fullass+'</option>';
 					
 				}else{
 					squadronOption=squadronOption+'<option value="'+data[i].sosokcode+'">'+data[i].fullass+'</option>';
 				}
	 			
 			}
 			
 			if($(selectId).attr("type")!='hidden'){
 				$(selectId).html(squadronOption);
 			}
 			
 		}
	});
}
