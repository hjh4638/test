<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- '${param.code }' --%>
<script src="<c:url value='/js/board/board.js'/>"></script>

	<script>
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );

		if('${param.code}'=='C00'){
			var idx = 0;
			$(".deptbtn:eq(0)").attr("src","<c:url value='/images/left/02/left_02_01_on.gif'/>");
			
		}
		else if('${param.code}'=='C01'){
			var idx = 3;
			$(".deptbtn:eq(3)").attr("src","<c:url value='/images/left/02/left_02_01_on.gif'/>");
		}
		else if('${param.code}'=='C02'){
			var idx = 6;
			$(".deptbtn:eq(6)").attr("src","<c:url value='/images/left/02/left_02_01_on.gif'/>");
		}
		else if('${param.code}'=='A11'){
			var idx = 1;
			$(".deptbtn:eq(1)").attr("src","<c:url value='/images/left/02/left_02_02_on.gif'/>");
		}
		else if('${param.code}'=='B09'){
			var idx = 2;
			$(".deptbtn:eq(2)").attr("src","<c:url value='/images/left/02/left_02_04_on.gif'/>");
		}
		else if('${param.code}'=='A14'){
			var idx = 4;
			$(".deptbtn:eq(4)").attr("src","<c:url value='/images/left/02/left_02_02_on.gif'/>");
		}
		else if('${param.code}'=='B10'){
			var idx = 5;
			$(".deptbtn:eq(5)").attr("src","<c:url value='/images/left/02/left_02_04_on.gif'/>");
		}
		else if('${param.code}'=='A17'){
			var idx = 7;
			$(".deptbtn:eq(7)").attr("src","<c:url value='/images/left/02/left_02_02_on.gif'/>");
		}
		else if('${param.code}'=='B11'){
			var idx = 8;
			$(".deptbtn:eq(8)").attr("src","<c:url value='/images/left/02/left_02_04_on.gif'/>");
		}
		
		if('${board_id}' == 'init' && '${board_form}' =='init') {
			LoadBoard('${param.code}');
		}
		else if('${board_form}' == 'insert') {
			
			gotoInsertPage('${param.code}');
		}
		else if('${board_form}' == 'update') {
			
			LoadUpdate('${board_id}','${param.code}');
		}
		
		$("#tabs").tabs("option", "active", idx);
		
		var param = '${param.code}';
		if(param == 'A11'){
			param = 'C00';
			$("#Code${param.code}")
			.empty()
			.load("/ASTI/dept/deptworker.do?code="+param);
		}
		else if(param=='A14'){
			param = 'C01';
			$("#Code${param.code}")
			.empty()
			.load("/ASTI/dept/deptworker.do?code="+param);
		}
		else if(param=='A17'){
			param = 'C02';
			$("#Code${param.code}")
			.empty()
			.load("/ASTI/dept/deptworker.do?code="+param);
		}
		else{
		$("#Code"+param)
			.empty()
			.load("/ASTI/dept/deptworker.do?code="+param);
		}
// 		if(${param.code=='C00'}){
// 			$("#tabs-5").attr("aria-selected","true");
// 		}
// 		else if(${param.code=='C01'}){
// 			$("#tabs-5").attr("aria-selected","true");
// 		}
// 		else if(${param.code=='C02'}){
// 			$("#tabs-5").attr("aria-selected","true");
// 		}
// 		aria-selected="true"

	});
// 	function Showload(code){
// 		alert("code:"+code);
// 		$("#Code"+code)
// 			.empty()
// 			.load("/ASTI/dept/deptworker.do?code="+code);

// 	}
	</script>


<div id="tabs" style="background:white;">
	<ul style="background: #f7fbfe;padding:0; border-right: 1px solid #e4e4e4; border-top:0px; border-bottom:0px;border-left:0px;content: '.';display: block;height: 629px;clear: none;">
		<li class="titleTab" style="width:205px;height:106px;"><img src="<c:url value='/images/left/02/left_02_00.gif'/>"/></li>
		<li class="subTitleTab" style="height:46px;"><img class="deptSubbtn" src="<c:url value='/images/left/02/left_02_11_on.gif'/>"/></li>
		<li><a href="#tabs-1" style="padding:0;height:30px;" class="tabname" onclick="GoDept('C00')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_01_off.gif'/>"/></a></li>
		<li><a href="#tabs-2" style="padding:0;height:30px;" class="tabname" onclick="GoDept('A11')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_02_off.gif'/>"/></a></li>
		<li><a href="#tabs-3" style="padding:0;height:30px;" class="tabname" onclick="GoDept('B09')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_04_off.gif'/>"/></a></li>
		<li class="subTitleTab"><img class="deptSubbtn" src="<c:url value='/images/left/02/left_02_12_on.gif'/>"/></li>
		<li><a href="#tabs-4" style="padding:0;height:30px;" class="tabname" onclick="GoDept('C01')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_01_off.gif'/>"/></a></li>
		<li><a href="#tabs-5" style="padding:0;height:30px;" class="tabname" onclick="GoDept('A14')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_02_off.gif'/>"/></a></li>
		<li><a href="#tabs-6" style="padding:0;height:30px;" class="tabname" onclick="GoDept('B10')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_04_off.gif'/>"/></a></li>
		<li class="subTitleTab"><img class="deptSubbtn" src="<c:url value='/images/left/02/left_02_13_on.gif'/>"/></li>
		<li><a href="#tabs-7" style="padding:0;height:30px;" class="tabname" onclick="GoDept('C02')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_01_off.gif'/>"/></a></li>
		<li><a href="#tabs-8" style="padding:0;height:30px;" class="tabname" onclick="GoDept('A17')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_02_off.gif'/>"/></a></li>
		<li><a href="#tabs-9" style="padding:0;height:30px;" class="tabname" onclick="GoDept('B11')"><img class="deptbtn" src="<c:url value='/images/left/02/left_02_04_off.gif'/>"/></a></li>
	</ul>
	<div id="tabs-1">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_31.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d08[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeC00" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-2">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_31.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d08[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeA11" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-3">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_10.gif'/>"/></h2>
		<div id="CodeB09" class="loadDiv">
		</div>
		
	</div>
	<div id="tabs-4">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_32.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d10[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeC01" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-5">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_32.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d10[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeA14" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-6">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_10.gif'/>"/></h2>
		<div id="CodeB10" class="loadDiv">
		</div>
	</div>
	<div id="tabs-7">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_33.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d12[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeC02" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-8">
		<img style="margin-left:-55px;" class="tabsTitle" src="<c:url value='/images/title/title_33.gif'/>"/>
		<div style="float:left;width:792px; height:590px;overflow-x:hidden;overflow-y:auto;margin-left:14px;">
			<br>
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_08.gif'/>"/></h2>
			<img style="width:770px;" src="<c:url value="/pageImage/${d12[0].page_picture_id}"/>" />
			<h2><img class="tabsTitle" src="<c:url value='/images/title/title_07.gif'/>"/></h2>
			<div id="CodeA17" class="deptloadDiv"></div>
		</div>
	</div>
	<div id="tabs-9">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_09.gif'/>"/></h2>
		<div id="CodeB11" class="loadDiv">
		</div>
	</div>  
</div>
