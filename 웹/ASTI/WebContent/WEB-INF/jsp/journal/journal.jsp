<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<script src="<c:url value='/js/board/board.js'/>"></script>
	<script>
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
		
		var idx = 0;
		if('${param.code}'=='B00'){
			idx = 0;
			$(".jourbtn:eq(0)").attr("src","<c:url value='/images/left/03/left_03_01_on.gif'/>");
		}
		else if('${param.code}'=='B01'){
			idx = 1;
			$(".jourbtn:eq(1)").attr("src","<c:url value='/images/left/03/left_03_02_on.gif'/>");
		}
		else if('${param.code}'=='B02'){
			idx = 2;
			$(".jourbtn:eq(2)").attr("src","<c:url value='/images/left/03/left_03_03_on.gif'/>");
		}
		else if('${param.code}'=='B03'){
			idx = 3;
			$(".jourbtn:eq(3)").attr("src","<c:url value='/images/left/03/left_03_04_on.gif'/>");
		}
		else if('${param.code}'=='A06'){
			idx = 4;
			$(".jourbtn:eq(4)").attr("src","<c:url value='/images/left/03/left_03_05_on.gif'/>");
		}
		
		$("#tabs").tabs("option", "active", idx);
		
		if('${board_id}' == 'init' && '${board_form}' =='init') {
			LoadBoard('${param.code}');
		}
		else if('${board_form}' == 'insert') {
			
			gotoInsertPage('${param.code}');
		}
		else if('${board_form}' == 'update') {
			
			LoadUpdate('${board_id}','${param.code}');
		}
		else{
			
			LoadView('${board_id}','${param.code}');
		}
	});

// 	alert("board_form,board_id="+'${board_form }'+","+'${board_id }');
// 	function ShowBoard(code){
// 		alert("code:"+code);
// 		$("#Code"+code)
// 			.empty()
// 			.load("/ASTI/board/board.do?board_type="+code);

// 	}
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
	<ul style="background: #f7fbfe;padding:0; border-right: 1px solid #e4e4e4; border-top:0px; border-bottom:0px;border-left:0px;content: '.';display: block;height: 629px;clear: none;">
		<li class="titleTab" style="width:205px;height:106px;"><img src="<c:url value='/images/left/03/left_03_00.gif'/>"/></li>
		<li><a href="#tabs-1" style="padding:0;height:49px;" class="tabname" onclick="GoJournal('B00')"><img class="jourbtn" src="<c:url value='/images/left/03/left_03_01_off.gif'/>"/></a></li>
		<li><a href="#tabs-2" style="padding:0;" class="tabname" onclick="GoJournal('B01')"><img class="jourbtn" src="<c:url value='/images/left/03/left_03_02_off.gif'/>"/></a></li>
		<li><a href="#tabs-3" style="padding:0;" class="tabname" onclick="GoJournal('B02')"><img class="jourbtn" src="<c:url value='/images/left/03/left_03_03_off.gif'/>"/></a></li>
		<li><a href="#tabs-4" style="padding:0;" class="tabname" onclick="GoJournal('B03')"><img class="jourbtn" src="<c:url value='/images/left/03/left_03_04_off.gif'/>"/></a></li>
		<li><a href="#tabs-5" style="padding:0;" class="tabname" onclick="GoJournal('A06')"><img class="jourbtn" src="<c:url value='/images/left/03/left_03_05_off.gif'/>"/></a></li>
	</ul>
	<div id="tabs-1">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_11.gif'/>"/></h2>
		<div id="CodeB00" class="loadDiv">
			 
		</div>
	</div>
	<div id="tabs-2">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_12.gif'/>"/></h2>
		<div id="CodeB01" class="loadDiv">
			 
		</div>
	</div>
	<div id="tabs-3">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_13.gif'/>"/></h2>
		<div id="CodeB02" class="loadDiv">
			 
		</div>
	</div>
	<div id="tabs-4">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_14.gif'/>"/></h2>
		<div id="CodeB03" class="loadDiv">
			 
		</div>
	</div>
	<div id="tabs-5">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_15.gif'/>"/></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d14[0].page_picture_id}"/>" />
		</div>
	</div>
</div>

