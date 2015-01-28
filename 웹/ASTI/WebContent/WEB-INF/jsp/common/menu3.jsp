<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<script>
	$(function() {
		$( "#tabs2" ).tabs();
		
		$(".atab2:eq(0)").click(function(){
			$(".tab2:eq(0)").attr("src","<c:url value='/images/main/content/content_03_01_on.gif'/>");
			$(".tab2:eq(1)").attr("src","<c:url value='/images/main/content/content_03_02_off.gif'/>");
			$(".tab2:eq(2)").attr("src","<c:url value='/images/main/content/content_03_03_off.gif'/>");
			$("#jourval").val("B00");
		});
		$(".atab2:eq(1)").click(function(){
			$(".tab2:eq(1)").attr("src","<c:url value='/images/main/content/content_03_02_on.gif'/>");
			$(".tab2:eq(0)").attr("src","<c:url value='/images/main/content/content_03_01_off.gif'/>");
			$(".tab2:eq(2)").attr("src","<c:url value='/images/main/content/content_03_03_off.gif'/>");
			$("#jourval").val("B01");
		});
		$(".atab2:eq(2)").click(function(){
			$(".tab2:eq(2)").attr("src","<c:url value='/images/main/content/content_03_03_on.gif'/>");
			$(".tab2:eq(0)").attr("src","<c:url value='/images/main/content/content_03_01_off.gif'/>");
			$(".tab2:eq(1)").attr("src","<c:url value='/images/main/content/content_03_02_off.gif'/>");
			$("#jourval").val("B02");
		});
		
		
	});
	
	function moreJour(){
		var code=$("#jourval").val();
		window.location.href="<c:url value='/journal/journal.do?code="+code+"'/>";
	}
	function menu3View(board_id,code){
		location.href="<c:url value='/journal/journal.do?code="+code+"&board_id="+board_id+"'/>";
	}
	</script>

	
<input id="jourval" type="hidden" value="B00"/> 
<div id="tabs2" style="width:320px;height:204px;margin-left:10px;border: 1px solid #b6b6b6;background: white;color: #222;">
	<ul style="margin-top:5px;border: 0px solid black;;background:#ffffff;color:#ffffff;">
		<li style="margin-left:5px;border: 0px solid black;background: white;"><a class="atab2" href="#tabs-4" style="padding:0;"><img class="tab2" src="<c:url value="/images/main/content/content_03_01_on.gif"/>"/></a></li>
		<li style="margin-left:4px;margin-top: 4px;"><img src="<c:url value="/images/main/line_02.gif"/>"/></li>
		<li style="margin-left:4px;border: 0px solid black;background: white;"><a class="atab2" href="#tabs-5" style="padding:0;"><img class="tab2" src="<c:url value="/images/main/content/content_03_02_off.gif"/>"/></a></li>
		<li style="margin-left:4px;margin-top: 4px;"><img src="<c:url value="/images/main/line_02.gif"/>"/></li>
		<li style="margin-left:4px;border: 0px solid black;background: white;"><a class="atab2" href="#tabs-6" style="padding:0;"><img class="tab2" src="<c:url value="/images/main/content/content_03_03_off.gif"/>"/></a></li>
		<li style="margin-top: 2px;margin-left: 40px;cursor:pointer;" onclick="moreJour();"><img src="<c:url value="/images/main/more.gif"/>"/></li>
	</ul>
	<div>
		<img style="margin-top:6px;margin-left: 2px;width:318px;height:1px;" src="<c:url value="/images/main/line_01.gif"/>"/>
	</div>
	<div id="tabs-4">
		<div style="width:300px;height:158px;margin-left:-8px;margin-top:-7px;">
			<ul>
			<c:forEach var="issue1" items="${issue1 }">
				<li style="margin-left:21px;width:280px;height:25px;float:left;text-align:left;margin-top:1px;list-style:circle;">
					<a href="javascript:menu3View('${issue1.board_id }','B00')">
						<c:out value="${fn:substring(issue1.board_title ,0,20)}"/>
						<c:if test="${fn:length(issue1.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div id="tabs-5">
		<div style="width:300px;height:158px;margin-left:-8px;margin-top:-7px;">
			<ul>
			<c:forEach var="issue2" items="${issue2 }">
				<li style="margin-left:21px;width:280px;height:25px;float:left;margin-top:1px;text-align:left;list-style:circle;">
					<a href="javascript:menu3View('${issue2.board_id }','B01')">
						<c:out value="${fn:substring(issue2.board_title ,0,20)}"/>
						<c:if test="${fn:length(issue2.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div id="tabs-6">
		<div style="width:300px;height:158px;margin-left:-8px;margin-top:-7px;">
			<ul>
			<c:forEach var="issue3" items="${issue3 }">
				<li style="margin-left:21px;width:280px;height:25px;float:left;margin-top:1px;text-align:left;list-style:circle;">
					<a href="javascript:menu3View('${issue3.board_id }','B02')">
						<c:out value="${fn:substring(issue3.board_title ,0,20)}"/>
						<c:if test="${fn:length(issue3.board_title) >=20 }">
						...
						</c:if> 
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
</div>

