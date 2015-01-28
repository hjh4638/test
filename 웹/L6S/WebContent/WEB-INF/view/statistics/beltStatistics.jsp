<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="<c:url value='/rmate/config/AC_OETags.js'/>"></script>
<script src="<c:url value='/rmate/config/rMateChart.js'/>"></script>
<!--rMate Chart 라이선스 등록 완료 모습 -->
<script src="<c:url value='/rmate/config/rMateChartLicense.js'/>"></script>
 
<!-- 사용자 정의 설정 시작 -->
<script type="text/javascript">
// ----------flashVars 설정 시작----------

//차트 레이아웃 URL 경로. 반드시 설정하십시오.
	var beltGraphLayoutURL = encodeURIComponent("<c:url value="/rmate/BeltGraphLayout.xml"/>");
	var beltGraphFlashVars = "layoutURL="+beltGraphLayoutURL;
	
//배열 형태로 데이터를 삽입할 경우 XML URL 입력부분은 주석처리나 삭제하십시오.

//rMate Chart와 스크립트간 동기화가 완료된 후 Chart가 함수를 호출합니다.
//이 함수를 통하여 차트와 통신하기 때문에 배열형태로 데이터를 삽입할 경우 반드시
//정의하여야 합니다.
	var rMateOnLoadCallFunction = "rMateChartOnLoad";
	beltGraphFlashVars += "&rMateOnLoadCallFunction="+rMateOnLoadCallFunction;
	
	
	var chartData = ${dataJSON};
	
	window.onload = function() {
		// rMateChart 초기화
		rMateChartInit();
	};
	
//스크립트와 차트간의 동기화가 완료된 후 호출할 함수로 사용자가 정의한 함수입니다.
//setData 함수를 통해 차트에 데이터를 전달하십시오.
//setData 함수는 rMate 차트가 배열을 통해 데이터를 받기 위해 열어 놓은 함수입니다.
//이 함수의 파라메터는 곧 차트의 데이터입니다.

	function rMateChartOnLoad(){
		beltGraph.setData(chartData);
	}
</script> 
<!-- 사용자 정의 설정 끝 --> 

<script type="text/javascript">
	$(document).ready(function(){
		$('#selectYear').change(function(){
			var frm = document.forms['searchFilter'];
			frm.action='beltStatistics.do';
			frm.submit();
		});
	});	
	
	$(document).ready(function(){
				
	});
	
	function valueSetting(belt,code,state){

	}
	
</script>

<center>
	<h1 class="statistics_belt_title">벨트현황</h1>
</center>

<form:form commandName="searchFilter">
	<form:select id="selectYear" path="year" cssClass="beltStatistics_year input_select_base_style">
		<form:option value="9999">전체</form:option>
		<c:if test="${searchFilter.year eq 9999}">
		<c:forEach varStatus="loop" begin="0" end="10" >
		<form:option value="${dummy-6+loop.count }"><c:out value="${dummy-6+loop.count }"/></form:option>
		</c:forEach>
		</c:if>
		<c:if test="${searchFilter.year ne 9999}">
		<c:forEach varStatus="loop" begin="0" end="8" >
			<form:option value="${searchFilter.year-6+loop.count}"><c:out value="${searchFilter.year-6+loop.count}"/>년</form:option>
		</c:forEach>
		</c:if>
	</form:select>
</form:form>

<center>
	<script>
	
		// 차트를 생성하고자 하는 위치에서 다음과 같이 함수 호출하십시오.
		// 파라메터 설명(순서대로)
		// 1. ID (임의로 정의하십시오)
		// 2. swf 파일 URL(확장자는 생략)
		// 3. URL 경로 등을 정의한 변수명.
		// 4. 차트 가로 사이즈.
		// 5. 차트 세로 사이즈.
		// 6. 차트 배경색.
		rMateChartCreate("beltGraph","<c:url value="/rmate/config/rMateChart"/>",beltGraphFlashVars, 905, 250, "#FFFFFF");
		//서버에 올릴 때 경로를 확인 합시다. 특히 프로젝트명 들어가는것 . 기존 L6S/rmate/config/rMateChart -> c:url 쓰니 연결이 되는듯?
	</script>
	
	<table class="statistics_beltTable">
		<tr>
			<td style="width: 12%; height: 50px;" rowspan="2" class="line"><img src="../images/diagonalLine.gif" class="me"/></td>
			<th colspan="2"> <b>MBB</b> </th>
			<th colspan="2"> <b>BB</b> </th>
			<th colspan="2"> <b>GB</b> </th>
			<th colspan="2"> <b>FEA</b> </th>
		</tr>
		<tr>
			<c:forEach begin="1" end="4">
				<th style="width: 11%"> 자격 </th>
				<th style="width: 11%"> 수료 </th>
			</c:forEach>
		</tr>
		<c:forEach begin="1" end="4" var="CODE">
			<c:if test="${CODE eq '1'}"> <c:set var="code" value="OFFICER"/></c:if>
			<c:if test="${CODE eq '2'}"> <c:set var="code" value="WARRANT"/></c:if>
			<c:if test="${CODE eq '3'}"> <c:set var="code" value="ENLISTED"/></c:if>
			<c:if test="${CODE eq '4'}"> <c:set var="code" value="ETC"/></c:if>		
			<tr>
				<th>
					<c:if test="${code=='OFFICER'}">장교</c:if>
					<c:if test="${code=='WARRANT'}">준사관</c:if>
					<c:if test="${code=='ENLISTED'}">부사관</c:if>
					<c:if test="${code=='ETC'}">군무원</c:if>
				</th>
				<c:forEach begin="1" end="4" var="BELT">
					<c:if test="${BELT eq '1'}"> <c:set var="belt" value="MBB"/></c:if>
					<c:if test="${BELT eq '2'}"> <c:set var="belt" value="BB"/></c:if>
					<c:if test="${BELT eq '3'}"> <c:set var="belt" value="GB"/></c:if>
					<c:if test="${BELT eq '4'}"> <c:set var="belt" value="FEA"/></c:if>
					
					<c:forEach begin="1" end="2" var="STATE">
						<c:if test="${STATE eq '1'}"> <c:set var="state" value="CERT"/></c:if>
						<c:if test="${STATE eq '2'}"> <c:set var="state" value="FIN"/></c:if>
						<td>
							<c:set var="flag" value="0"/>
							<c:forEach items="${tableData}" var="tabledata" varStatus="loop">
								<c:if test="${tabledata[code][belt][state]!=null}">
									<c:out value="${tabledata[code][belt][state]}"/>
									<c:set var="flag" value="1"/>
								</c:if>
								<c:if test="${loop.count==tableDataSize&&flag==0}">
									-
								</c:if>
							</c:forEach>								
						</td>
					</c:forEach>	
				</c:forEach>
			</tr>
		</c:forEach>
		<tr class="tableSUM">
			<td style="background-color: #e7f0f9;">
				<b>합계</b>
			</td>
			<c:forEach items="${tableSUM}" var="DATA">
				<td>
					<c:choose>
						<c:when test="${DATA.count2=='0'}"><b>-</b></c:when>
						<c:otherwise><b>${DATA.count2}</b></c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${DATA.count1=='0'}"><b>-</b></c:when>
						<c:otherwise><b>${DATA.count1}</b></c:otherwise>
					</c:choose>
				</td>
			</c:forEach>
		</tr>
	</table>
</center>