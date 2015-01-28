$(function(){
	$("#workerInfomationDialog").dialog({
			autoOpen : false,
			width: 525,
			height: 405,
			modal: true,
			buttons:{
				"닫기" : function(){
					$(this).dialog("close");
				}
			}
		});
});


function pageMoveDept(page,code){
	if(code == null || code =="")
		code = "";
	$("#workerAdmin")
		.empty()
		.load("/ASTI/admin/deptworkerAdmin.do?currentPage="+page+"&code="+code);
//	location.href="/ASTI/admin/deptworkerAdmin.do?currentPage="+page+"&code="+code;
}

function pageChangeDept(page,code){
	if(code == null || code =="")
		code = "";
	$("#workerAdmin")
		.empty()
		.load("/ASTI/admin/deptworkerAdmin.do?currentPage="+page+"&code="+code);
}

function loadDeptWorker(){
	/*$("#workerAdmin")
	.empty()
	.load("/ASTI/admin/deptworkerAdmin.do");*/
	$.ajax({
		  url: "/ASTI/admin/deptworkerAdmin.do",
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#workerAdmin").html(data);
		  }
	});
}
function loadWorkerRegister(id){
	var worker_id = id;
	/*$("#workerAdmin")
	.empty()
	.load("/ASTI/admin/workerRegister.do?worker_id="+worker_id);*/
	$.ajax({
		  url: "/ASTI/admin/workerRegister.do",
		  data:{worker_id:worker_id},
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#workerAdmin").html(data);
		  }
	});
}

function loadWorkerInfomation(id){
	var worker_id = id;
	$("#workerInfomationDialog").dialog("open");
	$.ajax({
		url: "/ASTI/ajax/workerInfomation.do",
		data:{worker_id:worker_id},
		cache: false,
		dataType : "JSON" ,
		success: function(data){
			$('#workerInfomationDialog').empty();
			$('#workerInfomationDialog').html(
			'<table id="workerInfomationTable" cellspacing="0" cellpadding="0">'
		+'<tr>'
			+'<th rowspan="2" style="width:150px;height:200px;"><img src="/ASTI/Temp/'+data.worker_picture_id+'"></th>'
			+'<th style="width:50px;height:140px;">성명</th><td style="width:300px;height:140px;">'+data.worker_name+'</td>'
		+'</tr>'
		+'<tr>'
			+'<th style="width:50px;height:60px;">부서</th><td style="width:300px;height:60px;">'+data.worker_department_name+'</td>'
		+'</tr>'
		+'<tr>'
			+'<th style="width:150px;height:50px;">연구/전공 분야</th>'
			+'<td colspan="2" style="width:350px;height:50px;">'+data.worker_major+'</td>' 
		+'</tr>'
		+'<tr>'
			+'<th style="width:150px;height:50px;">연락처</th>'
			+'<td colspan="2" style="width:350px;height:50px;">'+'TEL : '+data.worker_phone_number
			+ ',' + ' FAX : ' + data.worker_fax_number + '<br>' 
			+ 'E-MAIL : ' + data.worker_email + '</td>'
		+'</tr>'		
		+'</table>'		
			);
		}
	});
}