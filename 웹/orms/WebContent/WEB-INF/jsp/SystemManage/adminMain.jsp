<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	#adminFlightGroupList{
		width:95%;
		margin-top:40px;
		margin-left:15px;
		border:1px solid #C18C96;
	}
	#adminFlightGroupList tr{
		height:30px;
		border:1px solid #C18C96;
	}
	#adminFlightGroupList th{
		background: #C18C96;
	}

	.flightGroup{
		width:70px;
		font-size:13px;
		font-weight:bold;
		text-align: center;
		border:1px solid #ffffff;
 	}

	a{
		color:#000000;
		text-decoration:none;
	}

	a:active{
		color:#FFFF00
		text-decoration:none;
	}	

	a:hover{
		color:#3399FF
		text-decoration:none;
	}

 	.squadron{
		border:1px solid #C18C96;
		text-align: left;
	}
	#main_body_layout{
		text-align:center;
	}
	#flightDatePicker{
	}
</style>
<script>
	
	var detailResultDialog;
	$(function(){
		detailResultDialog=createDialog('#detailResultDialog','',true,700,600);

		
	});
	function showDetailResult(flightGroup,squadron){
 		$("#detailResultDialog").empty();
		$("#detailResultDialog").append("<iframe id='diagnosisResultIframe' src='${cp}/SystemManage/view/showFlightGroupStatus.do?flightGroup="+flightGroup+"&squadron="+squadron+"'></iframe>");
		detailResultDialog.dialog("open");
	}
</script>
<br>
<img src="${cp }/images/title/systemManage_Main.gif"/>
 <table id="adminFlightGroupList" style="margin-top:10px;">
<c:forEach var="flightGroup" items="${flightGroupTree}" varStatus="i">
	<c:if test="${i.index%2 eq 0}"><tr></c:if>
		<th class="flightGroup">
			<c:choose>
				<c:when test="${flightGroup.state eq 'Y'}">
					<a href="javascript:showDetailResult('${flightGroup.unit_code }','')">
					${flightGroup.unit_name }
					</a>
				</c:when>
				<c:otherwise>
					${flightGroup.unit_name }
				</c:otherwise>
			</c:choose>
		</th>
		<td class="squadron">
			<c:forEach var="squadron" items="${flightGroup.children}">
				<c:choose>
					<c:when test="${squadron.state eq 'Y'}">
						<a href="javascript:showDetailResult('${flightGroup.unit_code }','${squadron.unit_code }')">
							${squadron.unit_name }
						</a>
					</c:when>
					<c:otherwise>
						${squadron.unit_name }
					</c:otherwise>
				</c:choose>
				
			</c:forEach>
		</td>
	<c:if test="${i.index%2 eq 1}"></tr></c:if>
</c:forEach>
</table>
<div id="detailResultDialog" class="dialog">
</div>