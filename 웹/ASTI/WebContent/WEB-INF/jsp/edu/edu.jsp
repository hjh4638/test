<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="<%=request.getContextPath() %>"/>
	<script>
	var on1='<img class="edubtn" src="<c:url value='/images/left/04/left_04_01_on.gif'/>"/>';
	var on2='<img class="edubtn" src="<c:url value='/images/left/04/left_04_02_on.gif'/>"/>';
	var on3='<img class="edubtn" src="<c:url value='/images/left/04/left_04_03_on.gif'/>"/>';
	var on4='<img class="edubtn" src="<c:url value='/images/left/04/left_04_04_on.gif'/>"/>';

	function GoEdu(code){
		if(code=='0'){
			$(".eduTabImage:eq(0)").children().remove();
			$(".eduTabImage:eq(0)").append(on1);
			$(".eduTabImage:not(:eq(0))").children().remove(); 
		}
		else if(code=='1'){
			$(".eduTabImage:eq(1)").children().remove();
			$(".eduTabImage:eq(1)").append(on2);
			$(".eduTabImage:not(:eq(1))").children().remove();
		} 
		else if(code=='2'){
			$(".eduTabImage:eq(2)").children().remove();
			$(".eduTabImage:eq(2)").append(on3);
			$(".eduTabImage:not(:eq(2))").children().remove();
		}
		else if(code=='3'){
			$(".eduTabImage:eq(3)").children().remove();
			$(".eduTabImage:eq(3)").append(on4);
			$(".eduTabImage:not(:eq(3))").children().remove();
		}
		
		$("#tabs").tabs("option", "active", code);
	}
	$(function() {
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
		
		var idx = 0;
		if('${param.code}'=='A07'){
			idx = 0;
			$(".eduTabImage:eq(0)").append(on1);
		}
		else if('${param.code}'=='A08'){
			idx = 1;
			$(".eduTabImage:eq(1)").append(on2);
		}
		else if('${param.code}'=='A09'){
			idx = 2;
			$(".eduTabImage:eq(2)").append(on3);
		}
		else if('${param.code}'=='A10'){
			idx = 3;
			$(".eduTabImage:eq(3)").append(on4);
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
		<li class="titleTab" style="width:205px;height:106px;"><img src="<c:url value='/images/left/04/left_04_00.gif'/>"/></li>
		<li>
			<a href="#tabs-1" style="background-image:url('${cp}/images/left/04/left_04_01_off.gif');padding:0;height:49px;width:205px;" class="tabname eduTabImage" onclick="GoEdu('0');">
				
			</a>
		</li>
		<li>
			<a href="#tabs-2" style="background-image:url('${cp}/images/left/04/left_04_02_off.gif');padding:0;width:205px;" class="tabname eduTabImage" onclick="GoEdu('1');">
				
			</a>
		</li>
		<li>
			<a href="#tabs-3" style="background-image:url('${cp}/images/left/04/left_04_03_off.gif');padding:0;width:205px;" class="tabname eduTabImage" onclick="GoEdu('2');">
				
			</a>
		</li>
		<li>
			<a href="#tabs-4" style="background-image:url('${cp}/images/left/04/left_04_04_off.gif');padding:0;width:205px;" class="tabname eduTabImage" onclick="GoEdu('3');">
				
			</a>
		</li>
	</ul>
	<div id="tabs-1">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_16.gif'/>"/></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d15[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-2">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_17.gif'/>"/></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d16[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-3">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_18.gif'/>"/></h2>
		<div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d17[0].page_picture_id}"/>" />
		</div>
	</div>
	<div id="tabs-4">
		<h2><img class="tabsTitle" src="<c:url value='/images/title/title_19.gif'/>"/></h2>
		 <div class="loadDiv">
			<img style="width:770px;height:553px;" src="<c:url value="/pageImage/${d18[0].page_picture_id}"/>" />
		</div>
	</div>

</div>
    