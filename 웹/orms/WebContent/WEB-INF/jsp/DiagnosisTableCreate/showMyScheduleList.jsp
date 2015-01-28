<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />

<style>
	#myScheduleTable{
		width:100%;
		margin-top:30px;
		border:1px solid #C18C96;
	}
	#myScheduleTable th{
		background: #C18C96;
		border:1px solid #ffffff;
		color:#ffffff;
	} 	
	#myScheduleTable td{
 		border:1px solid #C18C96;
 		text-align: center;
	}
	#myScheduleTable tr{
		border:1px solid #C18C96;
		height:30px;
	}
	#myScheduleTools{
		float:right;
	}
</style>
<script>
/*var param_date='${param.scheduleDate}';
var param_calendar=getDate(param_date);
if(param_date==''){
	param_calendar=0;
}	
$(function(){
	$("#scheduleDate").dateinput({trigger:true,format:'yyyy년 mm월 dd일'}).data("dateinput").setValue(param_calendar);
	var scheduleDate=$("#scheduleDate").val();
	scheduleDate=scheduleDate.replace("년 ","");
	scheduleDate=scheduleDate.replace("월 ","");
	scheduleDate=scheduleDate.replace("일","");
	$("#scheduleDateVal").val(scheduleDate);
	$("#scheduleDate").change(function() {
		//날짜 선택시
		var scheduleDate=$("#scheduleDate").val();
		scheduleDate=scheduleDate.replace("년 ","");
		scheduleDate=scheduleDate.replace("월 ","");
		scheduleDate=scheduleDate.replace("일","");
		$("#scheduleDateVal").val(scheduleDate);
		location.href='${cp}/DiagnosisTableCreate/showMyScheduleList.do?scheduleDate='+scheduleDate;
	});
});*/
</script>
<img src="${cp }/images/title/showMyScheduleList.gif"/>
<div id="myScheduleTools">
	<!-- input type="date" id="scheduleDate" class="date" />
	<input type="hidden" id="scheduleDateVal"/-->
</div>
<table id="myScheduleTable" border="1">
	<thead>
		<tr>
			<th>순번</th>
			<th>편대</th>
			<th>시간대</th>
			<th>계급/성명</th>
			<th>C/S</th>
			<th>조종위치</th>
			<th>작성여부</th>
			<th>확인</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="count" value="0"/>
		<c:forEach var="mySchedule" items="${myScheduleList}" varStatus="i">
			<c:set var="count" value="${count+1}"/>
			<tr>
				<td>${i.index+1 }</td>
				<td>${mySchedule.unit_codename }</td>
				<td>${mySchedule.period_codename }</td>
				<td>${mySchedule.rankname }</td>
				<td>${mySchedule.cs }</td>
				<td>${mySchedule.position_codename }</td>
				<td>
					<c:choose>
						<c:when test="${mySchedule.result ne null}">
							<c:choose>
								<c:when test="${mySchedule.confirm_sn eq null and mySchedule.sn eq UserVO.userid}">
									작성<a href="${cp }/DiagnosisTableCreate/showDiagnosisTable.do?mode=modify&scheduleId=${mySchedule.seq }">(수정)</a>
								</c:when>
								<c:otherwise>
									작성(확인완료)
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${mySchedule.sn eq UserVO.userid}">
									<a href="${cp }/DiagnosisTableCreate/showDiagnosisTable.do?scheduleId=${mySchedule.seq }">미작성</a>
								</c:when>
								<c:otherwise>
									미작성
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:if test="${mySchedule.confirm_sn ne null}">
					${mySchedule.confirm_sosokcode }
				</c:if></td>
			</tr>
		</c:forEach>
		<c:if test="${count eq 0}">
			<tr><td colspan="8" align="center">등록된 오늘의 스케쥴이 없습니다.</td></tr>
		</c:if>
	</tbody>
</table>