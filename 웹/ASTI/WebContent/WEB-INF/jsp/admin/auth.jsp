<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${astiAdminSearchDTO.astiBoardPaginationDTO }"/>
<script src="<c:url value='/js/admin/admin.js'/>"></script>
<script src="<c:url value='/js/dept/deptworker.js'/>"></script>
<c:set var="cp" value="<%=request.getContextPath() %>" />
	<script>
	var on1='<img class="authbtn" src="<c:url value='/images/left_10/left_10_01_on.gif'/>"/>';
	var on2='<img class="authbtn" src="<c:url value='/images/left_10/left_10_02_on.gif'/>"/>';
	var on3='<img class="authbtn" src="<c:url value='/images/left_10/left_10_03_on.gif'/>"/>';
	var on4='<img class="authbtn" src="<c:url value='/images/left_10/left_10_04_on.gif'/>"/>';
	
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
		
		$(".tabAdminImage:eq(0)").append(on1);
		
 		if('${param.page_id}' != ''){
			$.ajax({
				  url: "${cp}/admin/pageManage.do",
				  data:{page_id:'${param.page_id}'},
				  dataType:"html",
				  cache: false,
				  success: function(data){
					  $("#pageManage").html(data);
					  $("#tabs").tabs("option", "active", 2);
				  }
			});
 		}
 		else{
 			$.ajax({
				  url: "${cp}/admin/pageManage.do",
				  dataType:"html",
				  cache: false,
				  success: function(data){
					  $("#pageManage").html(data);
				  }
			});
 		}
// 		if(${param.code=='A00'})
// 			var idx = 0;
// 		else if(${param.code=='A01'})
// 			var idx = 1;
// 		else if(${param.code=='A02'})
// 			var idx = 2;
// 		else if(${param.code=='A03'})
// 			var idx = 3;
// 		else if(${param.code=='A04'})
// 			var idx = 4;
// 		else if(${param.code=='A05'})
// 			var idx = 5;
		
// 		$("#tabs").tabs("option", "active", idx);
				
//		tab가 3이면 에러난거임 ㅋㅋ
		var tab = '${param.tab}';
	$("#tab1").click(function(){
		$(".tabAdminImage:eq(0)").children().remove();
		$(".tabAdminImage:eq(0)").append(on1);
		$(".tabAdminImage:not(:eq(0))").children().remove();
	});
	$("#tab3").click(function(){
		$(".tabAdminImage:eq(2)").children().remove();
		$(".tabAdminImage:eq(2)").append(on3);
		$(".tabAdminImage:not(:eq(2))").children().remove();
	});
	$("#tab4").click(function(){
		$(".tabAdminImage:eq(3)").children().remove();
		$(".tabAdminImage:eq(3)").append(on4);
		$(".tabAdminImage:not(:eq(3))").children().remove();
	});
	$("#tab2").click(function(){
// 			$("#workerAdmin")
// 			.empty()
// 			.load("/ASTI/admin/deptworkerAdmin.do");
			$(".tabAdminImage:eq(1)").children().remove();
			$(".tabAdminImage:eq(1)").append(on2);
			$(".tabAdminImage:not(:eq(1))").children().remove();
			
			loadDeptWorker();
			$("#tabs").tabs("option", "active", 1);
		});
		
		if(tab == '3'){
			var worker_id ='${param.worker_id}';
			
			$(".tabAdminImage:eq(1)").children().remove();
			$(".tabAdminImage:eq(1)").append(on2);
			$(".tabAdminImage:not(:eq(1))").children().remove();
						
			loadWorkerRegister(worker_id);
			$("#tabs").tabs("option", "active", 1);
		}
		else if(tab == '2'){
// 			$("#workerAdmin")
// 			.empty()
// 			.load("/ASTI/admin/deptworkerAdmin.do");

			$(".tabAdminImage:eq(1)").children().remove();
			$(".tabAdminImage:eq(1)").append(on2);
			$(".tabAdminImage:not(:eq(1))").children().remove();
						
			loadDeptWorker();
			$("#tabs").tabs("option", "active", 1);
		}
		else if(tab == '4'){
			$(".tabAdminImage:eq(3)").children().remove();
			$(".tabAdminImage:eq(3)").append(on4);
			$(".tabAdminImage:not(:eq(3))").children().remove();
						
			
			$("#tabs").tabs("option", "active", 3);
		}
		$("#memManage")
		.empty()
		.load("/ASTI/admin/membermanage.do");
		
		$.ajax({
			  url: "${cp}/admin/userDept.do",
			  dataType:"html",
			  cache: false,
			  success: function(data){
				  $("#userDept").html(data);
			  }
		});
		
	});
	</script>
	
	<style>
/* 	.ui-tabs-vertical { width: 55em; } */
/* 	.ui-tabs-vertical .ui-tabs-nav { padding: .2em .1em .2em .2em; float: left; width: 12em; } */
/* 	.ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; } */
/* 	.ui-tabs-vertical .ui-tabs-nav li a { display:block; } */
/* 	.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; border-right-width: 1px; } */
/* 	.ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 40em;} */
	</style>
<div id="tabs" style="background: white;">
	<ul style="background: #f7fbfe;padding:0; border-right: 1px solid #e4e4e4; border-top:0px; border-bottom:0px;border-left:0px;content: '.';display: block;height: 594px;clear: none;">
		<li class="titleTab" style="width:205px;height:106px;"><img src="<c:url value='/images/left_10/left_00_00.gif'/>"/></li>
		<li>
			<a id="tab1" href="#tabs-1" style="background-image:url('${cp}/images/left_10/left_10_01_off.gif');padding:0;height:49px;width:205px;" class="tabname tabAdminImage">
			</a>
		</li>
		<li>
			<a id="tab2" href="#tabs-2" style="background-image:url('${cp}/images/left_10/left_10_02_off.gif');padding:0;width:205px;" class="tabname tabAdminImage">
			</a>
		</li>
		<li>
			<a id="tab3" href="#tabs-3" style="background-image:url('${cp}/images/left_10/left_10_03_off.gif');padding:0;width:205px;" class="tabname tabAdminImage">
			</a>
		</li>
		<li>
			<a id="tab4" href="#tabs-4" style="background-image:url('${cp}/images/left_10/left_10_04_off.gif');padding:0;width:205px;" class="tabname tabAdminImage">
			</a>
		</li>

	</ul>
	<div id="tabs-1">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_25.gif'/>"/></h2>
		<div id="memManage" class="loadDiv"></div>
	</div>
	<div id="tabs-2">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_26.gif'/>"/></h2>
		<div class="loadDiv" id="workerAdmin">
		</div>
	</div>
	<div id="tabs-3">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_27.gif'/>"/></h2>
		<div class="loadDiv" id="pageManage">
		</div>
	</div>
	<div id="tabs-4">
		<%-- <h2><img class="tabsTitle" src="<c:url value='/images/title/title_27.gif'/>"/></h2> --%>
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_30.gif'/>"/></h2>
		<div class="loadDiv" id="userDept">
		</div>
	</div>

	
</div>
