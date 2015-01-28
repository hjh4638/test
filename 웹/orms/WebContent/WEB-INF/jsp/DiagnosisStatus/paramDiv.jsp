<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<script>
/*처음 페이지 로딩시 가장 첫번째 비행단의 비행대대 리스트를 가져옴*/
$(function(){
	var initialFlightGroup=$("#flightGroup").val();
	var getAll=false;
	if('${UserVO.role}'=='SYSTEMADMIN'){
		getAll=false; // 임시로 전체 보기 제한
	}
	getDateInput($("#dateRangeSelect").val());
	ajaxSquadronList(initialFlightGroup,'#squadron','${param.squadron}',getAll);
	$("#status_submit").click(function(){
		var gubun=$("#dateRangeSelect").val();
		var resultType=0;
		$(".resultType").each(function(){
			
			if($(this).attr("checked")==true){
				resultType=$(this).val();
			}
		});
		var squadron=$("#squadron").val();
		if(gubun==0&&resultType==0&&squadron==''){
			$("#chooseOptionForm").attr("action","${cp}/DiagnosisStatus/showTodayAllStatusGraph.do");
		}else if(gubun==0&&resultType==0){
			$("#chooseOptionForm").attr("action","${cp}/DiagnosisStatus/showTodayStatusGraph.do");
		}else if(gubun==1&&resultType==0){
			$("#chooseOptionForm").attr("action","${cp}/DiagnosisStatus/showMonthStatusGraph.do");
		}else if(resultType==1){
			$("#chooseOptionForm").attr("action","${cp}/DiagnosisStatus/showTodayStatusTable.do");
		}
		$("#chooseOptionForm").submit();


		
	});
	
});
function printGraph(url){
	window.open(url+'?flightGroup=${param.flightGroup}&squadron=${param.squadron}&dateRangeGubun=${param.dateRangeGubun}&year=${param.year}&month=${param.month}&quarter=${param.quarter}&startDate=${param.startDate}&endDate=${param.endDate}&resultType=${param.resultType}&print=1','valuationTable','width=800,height=700,resizable=yes,scrollbars=yes');
}
function getDateInput(gubun){
	if(gubun==0){
		$(".rangeselect").fadeOut(300);
	}else if(gubun==1){
		$(".rangeselect").hide();
		$("#yearRange").fadeIn(300);
		$("#monthRange").fadeIn(300);
	}else if(gubun==2){
		$(".rangeselect").hide();
		$("#yearRange").fadeIn(300);
		$("#quarterYearRange").fadeIn(300);
	}else if(gubun==3){
		$(".rangeselect").hide();
		$("#yearRange").fadeIn(300);
	}else if(gubun==4){
		$(".rangeselect").hide();
		$("#customRange").fadeIn(300);
	}
	addOrRemoveAllOptionToSquadron(gubun);
	
}

/**
 * 시스템 관리자만 전체 대대 조회 가능
 */
function addOrRemoveAllOptionToSquadron(gubun){
	if('${UserVO.role}'=='SYSTEMADMIN'){
	if(gubun==0){
		if($("#squadron option[value='']").length==0){
			
				/*$("#squadron").prepend("<option value=''>전체</option>");
				전체 조회 기능 임시로 제한*/
			
		}
	}else{
		$("#squadron option[value='']").remove();
	}
	}
}

/**
* 시스템 관리자만 전체 대대 조회 가능
*/
function onResultTypeClick(th){
	if('${UserVO.role}'=='SYSTEMADMIN'){
	if($(th).val()=="1"){
		$("#squadron option[value='']").remove();
	}else{
		if($("#squadron option[value='']").length==0){
			if('${UserVO.role}'=='SYSTEMADMIN'){
				/*전체 조회 기능 임시로 제한
				$("#squadron").prepend("<option value=''>전체</option>");
				*/
				
			}
		}
	}

	
	}
}
</script>
<style>
	#chooseOptionDiv{
		border:1px solid #C18C96;
	}
	#chooseOptionDiv div{
		float:left;
	}
	#chooseOptionDiv tr{
		
	}
	#status_submit{
		border:0px;
		background:url("${cp}/images/button/inquiry_button.gif");
		width:60px;
		height:22px;
		cursor:pointer;
	}
</style>
<img src="${cp }/images/title/showDiagnosisStatus.gif"/>
<form  style="width: 100%;" id="chooseOptionForm">
<div  style="width: 99%;margin-top:10px;margin-left:0%;margin-right:1%;" id="chooseOptionDiv" >
<table style="width: 100%" style="margin-top:10px;margin-left:10px;margin-bottom:10px;">
	<c:choose>
		<c:when test="${UserVO.role eq 'SYSTEMADMIN'}">
			<tr> 
				<td colspan=2 ><img src="${cp }/images/dot.gif"/> 비행단/전대&nbsp;&nbsp;<select id="flightGroup" name="flightGroup"
				onChange="ajaxSquadronList(this.value,'#squadron','',false)">
				<c:forEach var="flightGroup" items="${flightGroupList}">
					<option value="${flightGroup.sosokcode }" <c:if test="${flightGroup.sosokcode eq param.flightGroup }">selected="selected"</c:if>>${flightGroup.fullass}</option>
				</c:forEach>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="${cp }/images/dot.gif"/> 대대&nbsp;&nbsp; <select id="squadron" name="squadron">
				</select></td>
			</tr>
		</c:when>
		<c:otherwise>
			<input type="hidden" id="flightGroup" name="flightGroup" value=""/>
			<input type="hidden" id="squadron" name="squadron" value="${UserVO.unit_code }"/>
		</c:otherwise>
	</c:choose>
	
	<tr>
		<td>
			<div id="dateRangeGubun">
			<img src="${cp }/images/dot.gif"/> 조회기간&nbsp;
			<select id="dateRangeSelect" name="dateRangeGubun" onChange="getDateInput(this.value)">
				<option value="0" <c:if test="${param.dateRangeGubun eq 0 }">selected</c:if>>임무당일</option>
				<option value="1" <c:if test="${param.dateRangeGubun eq 1 }">selected</c:if>>월간</option>
				<!-- <option value="2" <c:if test="${param.dateRangeGubun eq 2 }">selected</c:if>>분기간</option>
				<option value="3" <c:if test="${param.dateRangeGubun eq 3 }">selected</c:if>>연간</option>
				<option value="4" <c:if test="${param.dateRangeGubun eq 4 }">selected</c:if>>직접입력</option> -->
			</select>
			</div>
			<div id="yearRange" class="rangeselect hidden">
				<select name="year">
					<c:forEach var="year" items="${yearList}">
						<option value="${year }" <c:if test="${param.year eq year }">selected</c:if>>${year }년</option>
					</c:forEach>
				</select>
			</div>
			<div id="monthRange" class="rangeselect hidden">
				<select name="month">
					<c:forEach begin="1" end="12" varStatus="i">
						<option value="${i.index }"  <c:if test="${param.month eq i.index }">selected</c:if>>${i.index }월</option>
					</c:forEach>
				</select>
			</div>
			<div id="quarterYearRange" class="rangeselect hidden">
				<select name="quarter">
					<c:forEach begin="1" end="4" varStatus="i">
						<option value="${i.index }"  <c:if test="${param.quarter eq quarter }">selected</c:if>>${i.index }분기</option>
					</c:forEach>
				</select>
			</div>
			<div id="customRange" class="rangeselect hidden">
				<input name="startDate" size="8" type="text" value="${param.startDate }"/>~<input name="endDate" size="8" type="text" value="${param.endDate }"/>
			</div>
		</td>
		</tr>
		<tr>
		<td><img src="${cp }/images/dot.gif"/> 종류
			<input type="radio" class="resultType" onClick="onResultTypeClick(this)" name="resultType" value="0" checked="checked" <c:if test="${param.resultType eq 0 }">checked="checked" </c:if>>그래프 <input type="radio" onClick="onResultTypeClick(this)" class="resultType" name="resultType" value="1" <c:if test="${param.resultType eq 1 }">checked="checked" </c:if>>인원별
		</td>
		<td valign="bottom" align="center" ><input type="button" id="status_submit"/></td>
	</tr>
</table>
</div>
</form>