<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	#mainTable{
		width:100%;
		height:550px;
		overflow:auto;
	/*	border:1px solid #FFFFFF;*/
	}
	#mainScheduleTable{
		width:95%;
		margin-top:40px;
		margin-left:15px;
		border:1px solid #C18C96;
	}
	#mainScheduleTable tr{
		height:30px;
 	}
	#mainScheduleTable th{
		background: #C18C96;
		color:#FFFFFF;
		border:1px solid #FFFFFF;
	}
	.timePeriodTab{
		padding-top:3px;
		float:left;
		width:60px;
		height:30px;
		text-align:left;
 		font-weight: bold;
		vertical-align: top;
		border-top:0px solid #AFAFAF;
		border-right:0px solid #AFAFAF;
		border-bottom:0px;
		cursor:pointer;
	}
	.tabClick{
 		color:#FFFFFF;
 		
 		}
	#mainButtons{
	 	margin-top:15px;
	}
	#mainButtons img{
		 cursor:pointer;
		 margin-right:5px;
	}
	#dateInfo{
		padding-top:3px;
		float:right;
		width:170px;
		height:30px;
		text-align:center;
 		font-weight: bold;
		vertical-align:text-bottom;
		border-top:0px solid #AFAFAF;
		border-right:0px solid #AFAFAF;
		border-bottom:0px;
		font-size: 13px;
		color:#982C48;
	}
</style>
<script>
	$(function(){
		$("#mainScheduleTableBody tr").each(function(){
			//alert($(this).attr("value"));
		});
		$("#replaceTab00,#replaceTab01,#replaceTab02,#replaceTab03,#replaceTab04").hide();
		
	});
	
	/*매뉴얼 FileDownload*/
   	function ormDownload(){
	   	frm.action = "ormManual.do";
   		frm.submit();
   	}
	
	function showAllSchedule(){
		var index=0;
		$(".timePeriodTab").each(function(){
			$(this).removeClass("tabClick");
		});
		$("#tab00").addClass("tabClick").hide();
		$("#replaceTab01,#replaceTab02,#replaceTab03,#replaceTab04").hide();
		$("#tab01,#tab02,#tab03,#tab04").show();
		$("#replaceTab00").show();
		$("#mainScheduleTableBody tr").each(function(){
			
			$(this).removeClass("hidden");
			$(this).find(".index").html(index+1);
			index++;
		
		});
		
	}
	function showPeriodSchedule(period){
		var index=0;
		var userUnitCode='${UserVO.unit_code}';
		$(".timePeriodTab").each(function(){
			$(this).removeClass("tabClick");
		});
		$("#replaceTab00,#replaceTab01,#replaceTab02,#replaceTab03,#replaceTab04").hide();
		$("#tab"+period).addClass("tabClick").hide();
		$("#replaceTab"+period).show();
		if(period=='01'){
		$("#tab00,#tab02,#tab03,#tab04,#tab05").show();			
		}
		else if(period=='02'){
		$("#tab00,#tab01,#tab03,#tab04,#tab05").show();			
		}
		else if(period=='03'){
		$("#tab00,#tab01,#tab02,#tab04,#tab05").show();			
		}
		else if(period=='04'){
		$("#tab00,#tab01,#tab02,#tab03,#tab05").show();			
		}
		
		$("#mainScheduleTableBody tr").each(function(){
			var value=$(this).attr("value");
			if(value==period ){

				$(this).removeClass("hidden");
				$(this).find(".index").html(index+1);
				index++;
			}else{
				$(this).addClass("hidden");
			}
		});
	}
	function MailSend(ID) {
		
		var url = 'http://www.mail.hq.af.mil:8088/sso2_dec.do?userid=${encryptSn}&url=write.do?to_send='+ID;
		
		window.open(url,'mail_form','width=1024,height=600,resizable=yes');

		
	}
	function toTongHap(){
		var url='http://www.hq.af.mil:9999/gamchal/new_Safety/new_Safety_index.jsp';
		window.open(url,'tonghap','width=1024,height=600,resizable=yes');
	}
	
</script>
<div id="mainTable">
<div id="main_top" style="margin-left:15px;">
<div class="timePeriodTab" id="tab00" onClick="showAllSchedule()"><img src="${cp }/images/button/main_all.jpg" />&nbsp;</div>
<div class="timePeriodTab" id="replaceTab00" ><img src="${cp }/images/button/main_all_roll.jpg" />&nbsp;</div>
<div class="timePeriodTab" id="tab01" onClick="showPeriodSchedule('01')"><img src="${cp }/images/button/main_1st.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="replaceTab01" ><img src="${cp }/images/button/main_1st_roll.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="tab02" onClick="showPeriodSchedule('02')"><img src="${cp }/images/button/main_2nd.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="replaceTab02" ><img src="${cp }/images/button/main_2nd-roll.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="tab03" onClick="showPeriodSchedule('03')"><img src="${cp }/images/button/main_3rd.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="replaceTab03" ><img src="${cp }/images/button/main_3rd-roll.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="tab04" onClick="showPeriodSchedule('04')"><img src="${cp }/images/button/main_night.jpg"/>&nbsp;</div>
<div class="timePeriodTab" id="replaceTab04" ><img src="${cp }/images/button/main_night-roll.jpg"/>&nbsp;</div>
<div id="dateInfo">${dateInfo }</div>
</div>
<table id="mainScheduleTable" border="1" bordercolor="#C18C96">
	<thead>
		<tr height="25px">
			<th>순번</th>
			<th>편대</th>
			<th>시간대</th>
			<th>계급/성명</th>
			<th>C/S</th>
			<th>조종위치</th>
			<th>작성여부</th>
		</tr>
	</thead>
	<tbody id="mainScheduleTableBody">
		<c:set var="count" value="0"/>
		<c:forEach var="myUnitSchedule" items="${myUnitScheduleList}" varStatus="i">
		
			<c:set var="count" value="${count+1}"/>
			<tr id="mainScheduleTableTr" class="schedule" unitCode="${myUnitSchedule.unit_code}" value="${myUnitSchedule.period }" align="center" height="30px">
				<td class="index">${count }</td>
				<td>${myUnitSchedule.unit_codename }</td>
				<td>${myUnitSchedule.period_codename }</td>
				<td>${myUnitSchedule.rankname }</td>
				<td>${myUnitSchedule.cs }</td>
				<td>${myUnitSchedule.position_codename }</td>
				<td>
					<c:choose>
						<c:when test="${myUnitSchedule.result ne null}">
							<%-- <c:choose>
								<c:when test="${myUnitSchedule.sn eq UserVO.userid}">
									작성<a href="${cp }/DiagnosisTableCreate/showDiagnosisTable.do?scheduleId=${myUnitSchedule.seq }">(수정)</a>
								</c:when>
								<c:otherwise>
									작성(확인완료)
								</c:otherwise>
							</c:choose> --%>
							<c:choose>
								<c:when test="${myUnitSchedule.sn eq UserVO.userid and myUnitSchedule.confirm_result_fix eq null}">
									<a href="${cp }/DiagnosisTableCreate/showDiagnosisTable.do?scheduleId=${myUnitSchedule.seq }">작성</a>
								</c:when>
								<c:otherwise>
									작성
								</c:otherwise>
							</c:choose>	
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${myUnitSchedule.sn eq UserVO.userid}">
									<a href="${cp }/DiagnosisTableCreate/showDiagnosisTable.do?scheduleId=${myUnitSchedule.seq }">미작성</a>
								</c:when>
								<c:otherwise>
									미작성
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
					
		</c:forEach>
		<c:if test="${count eq 0}">
			<tr><td colspan="7" align="center">금일 등록된 스케쥴이 없습니다.</td></tr>
		</c:if>
	</tbody>
</table>
</div>
<div id="mainButtons">
	<!-- 메일 보내기 담당자 주소 지정 -->
	<img src="${cp }/images/button/send_mail_button.gif" onClick="MailSend('daeho@af.mil')"/><a href="javascript:toTongHap()"><img src="${cp }/images/button/tonghap_button.gif"/></a><a href="${cp }/images/ormManual.pdf"><img src="${cp }/images/button/manual_button.gif"/></a>
</div>