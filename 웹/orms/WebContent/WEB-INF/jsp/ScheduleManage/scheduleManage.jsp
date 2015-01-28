<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<img src="${cp }/images/title/scheduleManage.gif" />
<form id="param" method="get" action="${cp }/ScheduleManage/scheduleManage.do">
<BR>
<img src="${cp }/images/dot.gif"/> 편대 
<select id="squadron" name="squadron" onChange="submit()">
	<option value="">전체</option>
	<c:forEach var="unitCode" items="${unitCodeList}">
		<option value="${unitCode.sosokcode }" <c:if test="${unitCode.sosokcode eq param.squadron}">selected="selected"</c:if>>${unitCode.fullass }</option>
	</c:forEach>
</select>
&nbsp;&nbsp;&nbsp;
<img src="${cp }/images/dot.gif"/> 시간대 
<select id="timePeriod" name="timePeriod" onChange="submit()">
	<option value="">전체</option>
	<c:forEach var="timePeriod" items="${timePeriodList}">
		<option value="${timePeriod.code }" <c:if test="${timePeriod.code eq param.timePeriod}">selected="selected"</c:if>>${timePeriod.codename }</option>
	</c:forEach>
</select>
<input type="date" id="flight_date" class="date" >
<input type="hidden" name="flight_date" id="flight_date_val"/>
	<script>
	function submit(){
		$("#param").submit();
	}
	$(function(){
		var param_date='${param.flight_date}';
		var param_calendar=getDate(param_date);
		if(param_date==''){
			param_calendar=0;
		}
		
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
			$("#param").submit();
		});
	});

	function modifySchedule(){
		var squadron=$("#squadron").val();
		var timePeriod=$("#timePeriod").val();
		var flight_date=$("#flight_date_val").val();
		location.href='${cp}/ScheduleManage/scheduleInsert.do?squadron='+squadron+'&timePeriod='+timePeriod+'&flight_date='+flight_date;
	}

	
	/* 편대 시간대 없을시 경고 alert창 */
	function warningAlert(){
	
	    var squadron = $("#squadron").val();
		if(squadron == ""){
	    alert("편대를 선택해야 입력이 가능합니다.");
		}else{
		modifySchedule();
	}
	}
	
	</script>

</form>


<table width="100%" id="resultListTable" border="1" style="margin-top:10px;">
<thead>
<tr>
<th rowspan="2">순번</th>
<th rowspan="2">편대</th>
<th rowspan="2">시간대</th>
<th rowspan="2">C/S</th>
<th colspan="3">전방석(정조종사)</th>
<th colspan="3">후방석(부조종사)</th>
</tr>
<tr>
<th>조종사</th>
<th>자격</th>
<th>기상등급</th>
<th>조종사</th>
<th>자격</th>
<th>기상등급</th>
</tr>
</thead>	

<tbody>
	<c:forEach var="schedule" items="${scheduleForViewList}">
		<tr>
			<td>${schedule.num }</td>
			<td>${schedule.unit_codename }</td>
			<td>${schedule.period_codename }</td>
			<td>${schedule.cs }</td>
			<td>${schedule.name1 }</td>
			<td>${schedule.section1 }</td>
			<td>${schedule.weather1 }</td>
			<td>${schedule.name2 }</td>
			<td>${schedule.section2 }</td>
			<td>${schedule.weather2 }</td>
		</tr>
	</c:forEach>
</tbody>
</table>

<table width="100%" border="0" style="margin-top:10px;">
<tr><td align="right"><a href="javascript:warningAlert()"><img src="${cp }/images/button/write_button.gif" /></a><a href="javascript:warningAlert()"><img src="${cp }/images/button/retouch_button.gif" /></a></td></tr></table>