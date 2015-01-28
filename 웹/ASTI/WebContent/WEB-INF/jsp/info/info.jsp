<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- ${param.code } --%>
<c:set var="cp" value="<%=request.getContextPath() %>"/>
	<script>
	var on1='<img class="infobtn" src="<c:url value='/images/left/01/left_01_01_on.gif'/>"/>';
	var on2='<img class="infobtn" src="<c:url value='/images/left/01/left_01_02_on.gif'/>"/>';
	var on3='<img class="infobtn" src="<c:url value='/images/left/01/left_01_03_on.gif'/>"/>';
	var on4='<img class="infobtn" src="<c:url value='/images/left/01/left_01_04_on.gif'/>"/>';
	var on5='<img class="infobtn" src="<c:url value='/images/left/01/left_01_05_on.gif'/>"/>';
	var on6='<img class="infobtn" src="<c:url value='/images/left/01/left_01_06_on.gif'/>"/>';
	function GoInfo(code){
		if(code=='0'){
			$(".tabImage:eq(0)").children().remove();
			$(".tabImage:eq(0)").append(on1);
			$(".tabImage:not(:eq(0))").children().remove();
		}
		else if(code=='1'){
			$(".tabImage:eq(1)").children().remove();
			$(".tabImage:eq(1)").append(on2);
			$(".tabImage:not(:eq(1))").children().remove();
		} 
		else if(code=='2'){
			$(".tabImage:eq(2)").children().remove();
			$(".tabImage:eq(2)").append(on3);
			$(".tabImage:not(:eq(2))").children().remove();
		}
		else if(code=='3'){
			$(".tabImage:eq(3)").children().remove();
			$(".tabImage:eq(3)").append(on4);
			$(".tabImage:not(:eq(3))").children().remove();
		}
		else if(code=='4'){
			$(".tabImage:eq(4)").children().remove();
			$(".tabImage:eq(4)").append(on5);
			$(".tabImage:not(:eq(4))").children().remove();
		}
		else if(code=='5'){
			$(".tabImage:eq(5)").children().remove();
			$(".tabImage:eq(5)").append(on6);
			$(".tabImage:not(:eq(5))").children().remove();
		}
		$("#tabs").tabs("option", "active", code);
	}
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
				
		var idx = 0;
		if('${param.code}'=='A00'){
			idx=0;
			$(".tabImage:eq(0)").append(on1);
		}
		else if('${param.code}'=='A01'){
			idx=1;
			$(".tabImage:eq(1)").append(on2);
		} 
		else if('${param.code}'=='A02'){
			idx=2;
			$(".tabImage:eq(2)").append(on3);
		}
		else if('${param.code}'=='A03'){ 
			idx=3;
			$(".tabImage:eq(3)").append(on4);
		}
		else if('${param.code}'=='A04'){
			idx=4;
			$(".tabImage:eq(4)").append(on5);
		}
		else if('${param.code}'=='A05'){
			idx=5;
			$(".tabImage:eq(5)").append(on6);
		}
		
		$("#tabs").tabs("option", "active", idx);
		
		
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
	<ul style="background: #f7fbfe;padding:0; border-right: 1px solid #e4e4e4; border-top:0px; border-bottom:0px;border-left:0px;content: '.';display: block;height: 629px;clear: none;">
		<li class="titleTab" style="width:205px;height:106px;"><img src="<c:url value='/images/left/01/left_01_00.gif'/>"/></li>
		<li>
			<a href="#tabs-1" style="background-image:url('${cp}/images/left/01/left_01_01_off.gif');padding:0;width:205px;height:49px;" class="tabname tabImage" onclick="GoInfo('0');">
			</a>
		</li>
		<li>
			<a href="#tabs-2" style="background-image:url('${cp}/images/left/01/left_01_02_off.gif');padding:0;width:205px;" class="tabname tabImage" onclick="GoInfo('1');">
			
			</a>
		</li>
		<li>
			<a href="#tabs-3" style="background-image:url('${cp}/images/left/01/left_01_03_off.gif');padding:0;width:205px;" class="tabname tabImage" onclick="GoInfo('2');">
			
			</a>
		</li>
		<li>
			<a href="#tabs-4" style="background-image:url('${cp}/images/left/01/left_01_04_off.gif');padding:0;width:205px;" class="tabname tabImage" onclick="GoInfo('3');">
			
			</a>
		</li>
		<li>
			<a href="#tabs-5" style="background-image:url('${cp}/images/left/01/left_01_05_off.gif');padding:0;width:205px;" class="tabname tabImage" onclick="GoInfo('4');">
			
			</a>
		</li>
		<li>
			<a href="#tabs-6" style="background-image:url('${cp}/images/left/01/left_01_06_off.gif');padding:0;width:205px;" class="tabname tabImage" onclick="GoInfo('5');">
			
			</a>
		</li>
	</ul>
	<div id="tabs-1">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_01.gif'/>"/></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d02[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-2">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_02.gif'/>" /></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d03[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-3">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_03.gif'/>" /></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d04[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-4">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_04.gif'/>" /></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d05[0].page_picture_id}"/>" />
		</div>
	</div>

	<div id="tabs-5">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_05.gif'/>" /></h2>
		<div id="brochureDiv">
			<img style="margin-top:5px;" src="<c:url value="/pageImage/${d06[0].page_picture_id}"/>" />
<%-- 			<img style="margin-top:5px;" src="<c:url value='/images/main/asti_brochure_final_small.png'/>" /> --%>
		</div>
		<div style="float:left;margin-left:336px;margin-top:15px;">
			<a href="<c:url value='/images/main/brochure.pdf'/>" target="_blank">Brochure Download<img style="width:21px;height:21px;" src="<c:url value='/images/main/PDFbtn.gif'/>" /></a>
		</div>
	</div>
	<div id="tabs-6">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_06.gif'/>" /></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d07[0].page_picture_id}"/>" />
		</div>
	</div>
</div>
