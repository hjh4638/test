<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	body{
		width:96%;
	}
	.confirm_time{
		font-size:11px;
	}
	#flightDatePicker{
		float: right
	}
	#closeButton{
		background:url("${cp}/images/button/close_button.gif");
		background-repeat:no-repeat;
		width:60px;
		height:22px;
		border:0;
		cursor:pointer;
	}
 </style>
<script>
	var flightGroup='${param.flightGroup}';
	var squadron='${param.squadron}';
	var param_date='${param.flight_date}';
	var param_calendar=getDate(param_date);
	if(param_date==''){
		param_calendar=0;
	}
	$(function(){
		var flight_date_input=$("#flight_date").dateinput({
			trigger:true,
			format:'yyyy년 mm월 dd일'
		}).data("dateinput").setValue(param_calendar);
		var init_flight_date=$("#flight_date").val();
		init_flight_date=init_flight_date.replace("년 ","");
		init_flight_date=init_flight_date.replace("월 ","");
		init_flight_date=init_flight_date.replace("일","");
		$("#flight_date_val").val(init_flight_date);
		$("#flight_date").change(function(){
			var flight_date=$("#flight_date").val();
			flight_date=flight_date.replace("년 ","");
			flight_date=flight_date.replace("월 ","");
			flight_date=flight_date.replace("일","");
			$("#flight_date_val").val(flight_date);
			submit(flight_date);
		});
	});
	function submit(flight_date){
		location.href=
	'${cp}/SystemManage/view/showFlightGroupStatus.do?flightGroup=${param.flightGroup}&squadron=${param.squadron}&flight_date='+flight_date;
	}
</script>
<div id="flightDatePicker"><input type="date" id="flight_date" class="date" ><input type="hidden" name="flight_date" id="flight_date_val"/></div>
<h3>${flghtGroupName } 비행단</h3>
<hr/>
<table border="1" id="resultListTable" width="650px">
	<c:forEach var="status" items="${ flightGroupStatusList}">
		<tr>
			<th rowspan="4" width="80px;">${status.unit_codename }</th>
			<th colspan="3">진단현황</th>
			<th colspan="3">진단결과</th>
		</tr>
		<tr height="20px">
			<td class="center" width="50px;">미작성</td>
			<td class="center" width="50px;">작성</td>
			<td class="center" width="50px%">종합</td>
			<td class="center" width="50px;">정상</td>
			<td class="center" width="50px;">주의</td>
			<td class="center" width="50px%">위험</td>
			
		</tr>
		<tr  height="20px">
			<td class="center">${status.notCreateDiagnosisCount }</td>
			<td class="center">${status.createDiagnosisCount }</td>
			<td class="center">${status.notCreateDiagnosisCount+status.createDiagnosisCount}</td>
			<td>${dignosisCount[0].count }</td>
			<td>${dignosisCount[1].count }</td>
			<td>${dignosisCount[2].count }</td>
		</tr>
		<tr>
			<td colspan="3" height="50%" >
				<table width="100%" border="0" id="flightTable">
					<tr  height="20px">
						<th colspan="3" style="border:1px solid #C18C96;">처리현황</th>
					</tr>
					<tr  height="20px">
						<td class="center"  width="75px" style="border-left:1px solid #ffffff;">정상비행</td>
						<td class="center" width="75px;" style="border-right:1px solid #ffffff;">비행취소</td>
					 </tr>
					<tr  height="20px">
						<td class="green center" style="border-left:1px solid #6E9E00;">${status.normalFlightCount }</td>
						<td class="orange center" style="border-right:1px solid #E86400;">${status.cancelFlightCount }</td>
					</tr>
				</table>
			</td>
			<td colspan="3" height="50%">
				<table width="100%" border="0" id="flightTable">
					<tr>
						<th style="border:1px solid #C18C96;">비행취소 의견</th>
					</tr>
					<tr>
						<td rowspan="3" border="1">
						<div style="width:100%;height:100px;overflow:auto;">
						<c:forEach var="confirm" items="${status.confirmList}" varStatus="i">
						<p><b>${confirm.pilot_rankname }</b> : ${confirm.opinion}<span class="confirm_time"> [${confirm.confirm_date }]</span></p>
						</c:forEach>
						</div>
						</td> 
					</tr>
				</table>
			</td>
		</tr>
	</c:forEach>
</table>
<br>
<div style="text-align:center"><input type="button" id="closeButton" onClick="parent.detailResultDialog.dialog('close')"/></div>