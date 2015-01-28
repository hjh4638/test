<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<script>
	$(function() {
		$( "#tabs" ).tabs();
		
		$(".atab1:eq(0)").click(function(){
			$(".tab1:eq(0)").attr("src","<c:url value='/images/main/content/content_02_01_on.gif'/>");
			$(".tab1:eq(1)").attr("src","<c:url value='/images/main/content/content_02_02_off.gif'/>");
			$(".tab1:eq(2)").attr("src","<c:url value='/images/main/content/content_02_03_off.gif'/>");
			$("#notifval").val("B04");
		});
		$(".atab1:eq(1)").click(function(){
			$(".tab1:eq(1)").attr("src","<c:url value='/images/main/content/content_02_02_on.gif'/>");
			$(".tab1:eq(0)").attr("src","<c:url value='/images/main/content/content_02_01_off.gif'/>");
			$(".tab1:eq(2)").attr("src","<c:url value='/images/main/content/content_02_03_off.gif'/>");
			$("#notifval").val("B06");
		});
		$(".atab1:eq(2)").click(function(){
			$(".tab1:eq(2)").attr("src","<c:url value='/images/main/content/content_02_03_on.gif'/>");
			$(".tab1:eq(0)").attr("src","<c:url value='/images/main/content/content_02_01_off.gif'/>");
			$(".tab1:eq(1)").attr("src","<c:url value='/images/main/content/content_02_02_off.gif'/>");
			$("#notifval").val("B08");
		});
		
		
	});
	
	
	function moreNotif(){
		var code=$("#notifval").val();
		window.location.href="<c:url value='/notif/notif.do?code="+code+"'/>";
	}
	function menu2View(board_id,code)
	{
		location.href="<c:url value='/notif/notif.do?code="+code+"&board_id="+board_id+"'/>";
	}
	</script>

<input id="notifval" type="hidden" value="B04"/>  
<div id="tabs" style="width:322px;height:204px;margin-left:1px;border: 1px solid #b6b6b6;background: white;color: #222;">
	<ul style="margin-top:5px;border: 0px solid black;;background:#ffffff;color:#ffffff;">
		<li style="margin-left:5px;border: 0px solid black;background: white;"><a class="atab1" href="#tabs-1" style="padding:0;"><img class="tab1" src="<c:url value="/images/main/content/content_02_01_on.gif"/>"/></a></li>
		<li style="margin-left:4px;margin-top: 4px;"><img src="<c:url value="/images/main/line_02.gif"/>"/></li>
		<li style="margin-left:4px;border: 0px solid black;background: white;"><a class="atab1" href="#tabs-2" style="padding:0;"><img class="tab1" src="<c:url value="/images/main/content/content_02_02_off.gif"/>"/></a></li>
		<li style="margin-left:4px;margin-top: 4px;"><img src="<c:url value="/images/main/line_02.gif"/>"/></li>
		<li style="margin-left:4px;border: 0px solid black;background: white;"><a class="atab1" href="#tabs-3" style="padding:0;"><img class="tab1" src="<c:url value="/images/main/content/content_02_03_off.gif"/>"/></a></li>
		<li style="margin-top: 2px;margin-left: 75px;cursor:pointer;" onclick="moreNotif();"><img src="<c:url value="/images/main/more.gif"/>"/></li>
	</ul>
	<div>
		<img style="margin-top:6px;margin-left: 2px;width:318px;height:1px;" src="<c:url value="/images/main/line_01.gif"/>"/>
	</div>
	<div id="tabs-1">
		<div style="width:300px;height:158px;margin-left:-9px;margin-top:-7px;">
			<ul>
			<c:forEach var="alamTable" items="${alamTable }">
				<li style="margin-top:1px;margin-left:21px;width:280px;height:25px;float:left;text-align:left;list-style: circle;">
					<a href="javascript:menu2View('${alamTable.board_id }','B04')">
						<c:out value="${fn:substring(alamTable.board_title ,0,20)}"/>
						<c:if test="${fn:length(alamTable.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div id="tabs-2">
		<div style="width:300px;height:158px;margin-left:-9px;margin-top:-7px;">
			<ul>
			<c:forEach var="broadTable" items="${broadTable }">
				<li style="margin-top:1px;margin-left:21px;width:280px;height:25px;float:left;text-align:left;list-style: circle;">
					<a href="javascript:menu2View('${broadTable.board_id }','B06')">
						<c:out value="${fn:substring(broadTable.board_title ,0,20)}"/>
						<c:if test="${fn:length(broadTable.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div id="tabs-3">
		<div style="width:300px;height:158px;margin-left:-9px;margin-top:-7px;">
			<ul>
			<c:forEach var="reportTable" items="${reportTable }">
				<li style="margin-top:1px;margin-left:21px;width:280px;height:25px;float:left;text-align:left;list-style: circle;">
					<a href="javascript:menu2View('${reportTable.board_id }','B08')">
						<c:out value="${fn:substring(reportTable.board_title ,0,20)}"/>
						<c:if test="${fn:length(reportTable.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
</div>

