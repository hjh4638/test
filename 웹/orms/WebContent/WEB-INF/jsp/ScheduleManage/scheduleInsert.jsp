<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
.ajaxSearchedUserListResultTr{
		cursor:pointer;
	}

.deleteButton {
	width: 53px;
	height: 21px;
	border: 0px;
	cursor: pointer;
	background: url("${cp}/images/button/delete_button.gif");
	background-repeat: no-repeat;
}

select { /* behavior: url('${cp}/css/selectbox.htc'); */
	z-index: 0;
}

#hidden{
	display: none;
}
</style>
<img src="${cp }/images/title/scheduleManage.gif" />
<form style="width: 100%;" id="option">
	<img src="${cp }/images/dot.gif" /> 편대 <select style=" behavior: url('${cp}/css/selectbox.htc');" id="unitCode"
		name="squadron" onChange="optionSubmit()">
		<option value="">전체</option>
		<c:forEach var="unitCode" items="${unitCodeList}">
			<option value="${unitCode.sosokcode }"
				<c:if test="${unitCode.sosokcode eq param.squadron }">selected="selected"</c:if>>${unitCode.fullass
				}</option>
		</c:forEach>
	</select> <img src="${cp }/images/dot.gif" /> 시간대 <select  style=" behavior: url('${cp}/css/selectbox.htc');"id="timePeriod"
		name="timePeriod" onChange="optionSubmit()">
		<option value="">전체</option>
		<c:forEach var="timePeriod" items="${timePeriodList}">
			<option value="${timePeriod.code }"
				<c:if test="${timePeriod.code eq param.timePeriod }">selected="selected"</c:if>>${timePeriod.codename
				}</option>
		</c:forEach>
	</select>
	<div id="hidden">
	<input type="date" id="scheduleDate" class="date"
		onfocus="document.getElementById('box').style.display='block';"
		onblur="document.getElementById('box').style.display='none';">
	</div>
	<input type="hidden" id="flight_date_val" name="flight_date" />
</form>
<script>
	 	
	
	
	/* 인풋박스로 바꾸기 */
	function firstChangetoInput(th){
		
		var td=$(th).parent();//실제는 셀렉트박스가 들어있는 td한칸
		
		td.empty();
		
		var tt ="";
		
		tt += "<input type='hidden' name='seq1'>"
			   + "<input style='width: 110px;' type='text' id='position1' name='position1'>";

		td.html(tt);		
	}
	
	function secondChangetoInput(th){
		
		var td=$(th).parent();//실제는 셀렉트박스가 들어있는 td한칸
		
		td.empty();
		
		var tt ="";
		
		tt += "<input type='hidden' name='seq2'>"
			   + "<input style='width: 110px;' type='text' id='position2' name='position2'>";

		td.html(tt);		
	}
	
	/* 인풋박스 지우기 */
	function onlySelectBox(th){
		var td=$(th).parent();//실제는 셀렉트박스가 들어있는 td한칸
		td.find("#inputForSn").hide();
	}
	
	
	var insertForm;
	
	$(function(){
		
		insertForm=createDialog('#insertForm','사람찾기',true,400,300);	
	});

	
	/* 카테고리 변경시 */
	function changeCate( code )
	{
	    var cate = changeCateForm.cate.value;

	    if( !cate ){
	        self.location.href = "./List.do?bCODE="+code;
	    }else{
	        self.location.href = "./List.do?bCODE="+code+"&CATE="+cate;
	    }
	}
	
	function optionSubmit() {
		$("#option").submit();
	}
	var param_date = '${param.flight_date}';
	var param_calendar = getDate(param_date);
	if (param_date == '') {
		param_calendar = 0;
	}
	$(function() {
		$("#scheduleDate").dateinput({
			trigger : true,
			format : 'yyyy년 mm월 dd일'
		}).data("dateinput").setValue(param_calendar);
		var init_flight_date = $("#scheduleDate").val();
		init_flight_date = init_flight_date.replace("년 ", "");
		init_flight_date = init_flight_date.replace("월 ", "");
		init_flight_date = init_flight_date.replace("일", "");
		$("#flight_date_val").val(init_flight_date);
		$("#scheduleDate").change(function() {
			var flight_date = $("#scheduleDate").val();
			flight_date = flight_date.replace("년 ", "");
			flight_date = flight_date.replace("월 ", "");
			flight_date = flight_date.replace("일", "");
			$("#flight_date_val").val(flight_date);
			optionSubmit();
		});

	});

	var newRow = 0;
	/* 행 삽입 */
	function addNewSchedule() {
		var newTr = $("#newTr").clone();
		newTr.removeClass("sampleTr");
		newTr.addClass("scheduleRow");
		var nowLength = $("#resultListTable tr").length - 1;
		var num = $("#resultListTable tr").length * 2 - 2;
		var unitCode = document.getElementById("unitCode");
		var timePeriod = document.getElementById("timePeriod");

		var init_flight_date = $("#scheduleDate").val();
		init_flight_date = init_flight_date.replace("년 ", "");
		init_flight_date = init_flight_date.replace("월 ", "");
		init_flight_date = init_flight_date.replace("일", "");
		$("#flight_date").val(init_flight_date);
		var flight_date = $("#flight_date").val();

		var num = newTr.find("#num");
		num.html(nowLength);

		$('.deleteThisSchedule').click(deleteSchedule);
		$("#scheduleTableBody").append(newTr);
		newTr.fadeIn(500);

	}

	/* DB에서 행 삭제 */
	function deleteSchedule(th) {

		var tr = $(th).parent().parent();
		var id = tr.attr("value");
		if (id != null) {
			confirm('확인', '삭제하시겠습니까?<br/>저장되어있던 답안사항들도 모두 삭제됩니다.', function() {
				$.ajax({
					url : '${cp}/ScheduleManage/deleteSchedule.do',
					type : 'POST',
					dataType : 'json',
					data : {
						id : id
					},
					success : function() {
						alert("삭제되었습니다");
						tr.fadeOut(function() {
							tr.remove();
						});
					}
				});
			});
		} else {
			tr.fadeOut(function() {
				tr.remove();
			});
		}

	}

	/* DB에 업데이트 상황 저장 */
	function saveSchedule() {
		if (validateScheduleTable()) {

			confirm('확인창', '저장하시겠습니까?', function() {
				$(".sampleTr").remove();
				$.ajax({
					url : '${cp}/ScheduleManage/setSchedule.do',
					type : 'POST',
					dataType : 'json',
					data : $('#scheduleForm').serialize(),
					success : function() {
						alertMessage("알림", "저장 되었습니다", function() {
							location.reload();
						});

					},
					error : function() {
						alertMessage("알림", "저장 되었습니다", function() {
							location.reload();
						});
					}
				});
			}, function() {
				/* location.reload(); */
			});

		}
	}
	function validateScheduleTable() {
		/* alert($("tr .scheduleRow").length); */
		var result = true;
		$("tr .scheduleRow").each(function() {
			if ($(this).find("#unitCode").val() == '') {
				result = false;
			} else if ($(this).find("#timePeriod").val() == '') {
				result = false;
			} else if ($(this).find("#cs").val() == '') {
				result = false;
			} else if ($(this).find("#timePeriod").val() == '') {
				result = false;
			} else if ($(this).find("#position1").val() == '') {
				result = false;
			} else if ($(this).find("#section1").val() == '') {
				result = false;
			} else if ($(this).find("#weather1").val() == '') {
				result = false;
			}/*   else if ($(this).find("#position2").val() == '') {
				result = false;
			} else if ($(this).find("#section2").val() == '') {
				result = false;
			} else if ($(this).find("#weather2").val() == '') {
				result = false;
			} */
		});
		if (result == false) {
			alertMessage('알림', '입력 안된 항목이 있습니다.<br/>모든 항목을 입력하셔야합니다.');
			return false;
		} else {
			return true;
		}
	}
</script>

<form name="scheduleForm" id="scheduleForm"
	action="${cp }/ScheduleManage/setSchedule.do" method="post">
	<input type="hidden" id="flight_date" name="flight_date"
		value="${param.flight_date }">
	<table id="resultListTable" border="1" width="100%">
		<thead>
			<tr>
			<tr>
				<!-- <th rowspan="2">순번</th> -->
				<th rowspan="2">편대</th>
				<th rowspan="2">시간대</th>
				<th rowspan="2" width="30">C/S</th>
				<th colspan="3">전방석(정조종사)</th>
				<th colspan="3">후방석(부조종사)</th>
				<th style="width: 5%;" rowspan="2">삭제</th>
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

		<tbody id="scheduleTableBody">
			<c:forEach var="schedule" items="${scheduleForModifyList}">
				<tr class="scheduleRow" value='${schedule.id }'>
					<%-- <td>${schedule.num }</td> --%>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="unitCode" name="squadron">
							<c:forEach var="unitCode" items="${unitCodeList}">
								<option value="${unitCode.sosokcode }"
									<c:if test="${unitCode.sosokcode eq schedule.unit_code }">selected="selected"</c:if>>${unitCode.fullass
									}</option>
							</c:forEach>
					</select>
					</td>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="timePeriod" name="timePeriod">
							<c:forEach var="timePeriod" items="${timePeriodList}">
								<option value="${timePeriod.code }"
									<c:if test="${timePeriod.code eq schedule.period }">selected="selected"</c:if>>${timePeriod.codename
									}</option>
							</c:forEach>
					</select>
					</td>
					<td><input type="text" class="cs" id="cs" name="cs" size="1"
						value="${schedule.cs }" />
					</td>


					<td><input type="hidden" id="seq1" name="seq1"
						value="${schedule.seq1 }" /> <select style=" behavior: url('${cp}/css/selectbox.htc');" class="position" id="position1"
						name="position1">
							<option value="${schedule.sn1 }">
								<c:forEach var="allPilotList" items="${allPilotList}">
								<c:if test="${allPilotList.userid eq schedule.sn1 }">
									${allPilotList.rankname } ${allPilotList.name }
								</c:if>
								</c:forEach>
							</option>
							<option value=""></option>
							<c:forEach var="formationPilotList" items="${formationPilotList}">
								<option
									<c:if test="${formationPilotList.userid eq schedule.sn1 }">selected="selected"</c:if>
									value="${formationPilotList.userid }">
									${formationPilotList.rankname } ${formationPilotList.name }</option>
							</c:forEach>
					</select></td>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="section1" name="section1">
							<option value=""></option>
							<c:forEach var="section" items="${section1List}">
								<option
									<c:if test="${section.code eq schedule.section1 }">selected="selected"</c:if>
									value="${section.code }">${section.codename }</option>
							</c:forEach>
					</select></td>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="weather1" name="weather1">
							<option value=""></option>
							<c:forEach var="weather" items="${weatherConditionList}">
								<option
									<c:if test="${weather eq schedule.weather1 }">selected="selected"</c:if>
									value="${weather }">${weather }</option>
							</c:forEach>
					</select></td>
					<td><input type="hidden" name="seq2" value="${schedule.seq2 }" />
						<select style=" behavior: url('${cp}/css/selectbox.htc');" id="position2" name="position2" class="position" >
							<option value="${schedule.sn2 }" selected="selected">
								<c:forEach var="allPilotList" items="${allPilotList}">
								<c:if test="${allPilotList.userid eq schedule.sn2 }"> 
									${allPilotList.rankname } ${allPilotList.name }
								</c:if>
								</c:forEach>
							</option>
							<option value="0" <c:if test="${schedule.sn2 eq 0 }">selected="selected"</c:if>
							>없음</option>
							<c:forEach var="formationPilotList" items="${formationPilotList}">
								<option
									<c:if test="${formationPilotList.userid eq schedule.sn2 }">selected="selected"</c:if>
									value="${formationPilotList.userid }">
									${formationPilotList.rankname } ${formationPilotList.name }</option>
							</c:forEach>
					</select></td>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="section2" name="section2">
							<option value="0">-</option>
							<c:forEach var="section" items="${section2List}">
								<option
									<c:if test="${section.code eq schedule.section2 }">selected="selected"</c:if>
									value="${section.code }">${section.codename }</option>
							</c:forEach>
					</select></td>
					<td><select style=" behavior: url('${cp}/css/selectbox.htc');" id="weather2" name="weather2">
							<option value="0">-</option>
							<c:forEach var="weather" items="${weatherConditionList}">
								<option
									<c:if test="${weather eq schedule.weather2 }">selected="selected"</c:if>
									value="${weather }">${weather }</option>
							</c:forEach>
					</select></td>
					<td><input type="button" class="deleteButton"
						onClick="deleteSchedule(this)" /></td>
				</tr>
			</c:forEach>
			<tr id="newTr" style="display: none;" class="sampleTr">
				<!-- <td id="num"></td> -->
				<td id="viewUnitCode"><select id="unitCode" name="squadron">
						<option value=""></option>
						<c:forEach var="unitCode" items="${unitCodeList}">
							<option value="${unitCode.sosokcode }"
								<c:if test="${unitCode.sosokcode eq param.squadron }">selected="selected"</c:if>>${unitCode.fullass
								}</option>
						</c:forEach>
				</select></td>
				<td id="viewTimePeriod"><select id="timePeriod"
					name="timePeriod">
						<option value=""></option>
						<c:forEach var="timePeriod" items="${timePeriodList}">
							<option value="${timePeriod.code }"
								<c:if test="${timePeriod.code eq param.timePeriod }">selected="selected"</c:if>>${timePeriod.codename
								}</option>
						</c:forEach>
				</select></td>
				<td><input type="text" id="cs" name="cs" size="1" value="" />
				</td>
				<td><input type="hidden" name="seq1" />
					<input id="inputForSn" style="width: 110px;" type="button" value="군번으로입력" onclick="firstChangetoInput(this)">
					<select onchange="onlySelectBox(this)" id="position1"
					name="position1" class="position" >
						<option value=""></option>
						<c:forEach var="formationPilotList" items="${formationPilotList}">
							<option value="${formationPilotList.userid }">
								${formationPilotList.rankname } ${formationPilotList.name }</option>
						</c:forEach>
				</select></td>
				<td><select id="section1" name="section1">
						<option value=""></option>
						<c:forEach var="section" items="${section1List}">
							<option value="${section.code }">${section.codename }</option>
						</c:forEach>
				</select></td>
				<td><select id="weather1" name="weather1">
						<option value=""></option>
						<c:forEach var="weather" items="${weatherConditionList}">
							<option value="${weather }">${weather }</option>
						</c:forEach>
				</select></td>
				<td><input type="hidden" name="seq2" /> 
					<input id="inputForSn" style="width: 110px;" type="button" value="군번으로입력" onclick="secondChangetoInput(this)">
					<select onchange="onlySelectBox(this)" id="position2"
					name="position2" class="position ">
						<option value="0">없음</option>
						<c:forEach var="formationPilotList" items="${formationPilotList}">
							<option value="${formationPilotList.userid }">
								${formationPilotList.rankname } ${formationPilotList.name }</option>
						</c:forEach>
				</select></td>
				<td><select id="section2" name="section2">
						<option value="0">-</option>
						<c:forEach var="section" items="${section2List}">
							<option value="${section.code }">${section.codename }</option>
						</c:forEach>
				</select></td>
				<td><select id="weather2" name="weather2">
						<option value="0">-</option>
						<c:forEach var="weather" items="${weatherConditionList}">
							<option value="${weather }">${weather }</option>
						</c:forEach>
				</select></td>
				<td><input type="button" class="deleteButton"
						onClick="deleteSchedule(this)" /></td>
			</tr>
		</tbody>
	</table>
</form>
<table width="100%" >
<tr><td  align="right"><a href="javascript:addNewSchedule()"><img src="${cp }/images/button/add_button.gif"/></a><a href="javascript:saveSchedule()"><img src="${cp }/images/button/save_button.gif"/></a></td></tr>
</table>
