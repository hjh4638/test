<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	.title{
		text-align: center;
		font-family: Myriad;
		font-size: 14px ;
	}
</style>
<script src="${cp}/js/jquery.PrintArea.js4.js" language="javascript"></script>
<!-- rMateChart 관련 include -->
<script src="${cp}/rmate/Samples/JS/AC_OETags.js" language="javascript"></script>
<script src="${cp}/rmate/Samples/JS/rMateChart.js" language="javascript"></script>
<script src="${cp}/rmate/LicenseKey/rMateChartLicense.js" language="javascript"></script>
<script type="text/javascript">

var statusDialog;
$(function(){
	statusDialog=createDialog('#showTodayStatusGraphDetailDialog','',true,800,400);
});
function showStatusDialog(th){
	var flight_date= $(th).attr("flight_date");
	
	flight_date=flight_date.replace(".","");
	flight_date=flight_date.replace(".","");
	var unit_code = $("#squadron").val();
	
	$("#showTodayStatusGraphDetailDialog").empty();
	$("#showTodayStatusGraphDetailDialog").append("<iframe style='width:790px; height:380px;' id='showTodayStatusGraphDetailDialog' src='${cp}/DiagnosisStatus/view/showTodayStatusGraphDetail.do?flight_date="+flight_date+"&unit_code="+unit_code+"'></iframe>");
	statusDialog.dialog("open");
	
}

$(function(){
	//인쇄시 레이아웃 제거
	var printParam='${param.print}';
	if(printParam!=''){
		/* $("#main_body_layout_td").css("width","700px"); */
		$("#main_layout_table").css("width","700px");
		$("#main_top_layout_td").hide();
		$("#main_footer_layout_td").hide();
		$("#main_menu_layout_td").hide();
		$("#printButton").hide();
		$("#status_submit").hide();
	} 
});
window.onload = function() {
	// rMateChart 초기화
	rMateChartInit();
};
/*
//챠트에서 item클릭시 불려지는 함수 설정
//layout XML 에서 Chart 속성을 넣을때 itemClickJsFunction를 주고,만든 javascript 함수명을 넣어줍니다
//예) <Column3DChart showDataTips="true" itemClickJsFunction="chartClick">
//
//파라메터 설명
//seriesId : layout XML에서 부여한 series의 id가 있을 경우, 해당 id를 보내줍니다.
//displayText : 화면상에 보여주는 dataTip(마우스 올라갔을때 보여주는 박스-tooltip)의 내용
//index : 클릭된 item(막대나 파이조각등)의 index 번호 - 맨 왼쪽 또는 맨 위 것이 0번입니다
//data : 해당 item의 값을 표현하기 위해 입력된 data(row값에 해당 - data로 입력된 종류에 따라 XML의 내용 또는 배열이 됩니다)
//values : 해당 item의 값 (배열로 전달되며, 챠트 종류에 따라 아래와 같이 들어옵니다.)
         ColumnSeries  0:x축값 1:y축값
*/
function chartClick(seriesId, displayText, index, data, values){
       alert("seriesId:"+seriesId+"\ndisplayText:"+displayText+"\nindex:"+index+"\ndata:"+data+"\nvalues:"+values);
}
<%--
차트의 제목(Caption) 부분을 동적 생성하기 위해 레이아웃을 jsp 에 정의
--%>
function submitResult(){
	var a = document.getElementById('chart1');
	var flight_date = resultList[0].flight_date;
	alert(a+"//"+flight_date);
	/* 
	var unit=$("#unitList").val();
	var scheduleDate=$("#scheduleDate").val();
	scheduleDate=scheduleDate.replace("년 ","");
	scheduleDate=scheduleDate.replace("월 ","");
	scheduleDate=scheduleDate.replace("일","");
	$("#scheduleDateVal").val(scheduleDate);
	location.href='${cp}/DiagnosisResult/showDiagnosisResultList.do?scheduleDate='+scheduleDate+'&unit='+unit; */
}
/* alert('${resultList}'
		) ;*/
var resultList=${resultList};
function generateLayoutStr(index,fontSize){
	var layoutStr =
		'<rMateChart backgroundColor="0xFFFFFF">'
		+ '<Options>'
		+ '<Caption/>'
		+ '</Options>'
		+ '<CurrencyFormatter id="vAxis1" currencySymbol=" 명" alignSymbol="right"/>'
		+ '<Column2DChart fontSize="'+fontSize+'"  showDataTips="true">'
		+ '<horizontalAxis><CategoryAxis categoryField="result_name"/></horizontalAxis>'
		+ '<verticalAxis><LinearAxis formatter="{vAxis1}" id="vAxis1" minimum="0" interval="10"/></verticalAxis>'
		+ '<series>'
		+ '<Column2DSeries labelPosition="outside" fontFamily="Myriad" yField="count" itemRenderer="BoxItemRenderer">'
		+ '<showDataEffect>' 
		+'<SeriesInterpolate/>' 
		+'</showDataEffect> '
		+ '<fills>'
		+ '<SolidColor color="0xFF6600"></SolidColor>'
		+ '<SolidColor color="0xFFFF00"></SolidColor>'
		+ '<SolidColor color="0x008000"></SolidColor>'
		+ '</fills>'
		+'</Column2DSeries>'
		+ '</series>'
		+ '</Column2DChart>'
		+ '</rMateChart>';
	return layoutStr;
}
	
// 차트 레이아웃 데이터
	

	// rMate Chart와 스크립트가 동기화가 완료된 후 Chart가 함수를 호출합니다.
	// 이 함수를 통하여 차트와 통신하기 때문에 배열형태로 데이터를 삽입할 경우 반드시
	// 정의하여야 합니다.
	var rMateOnLoadCallFunction = "rMateChartOnLoad";
	var flashVars = "&rMateOnLoadCallFunction="+rMateOnLoadCallFunction;

	var chartComplete = "displayCompleteHandler";

	 
	function displayCompleteHandler()
	{
		var printParam='${param.print}';
		if(printParam!=''){
			print();
		}
	}
	// 디버그 모드 사용
	flashVars += "&debugMode=true";
	

	// 차트에 표시할 데이터

	// 스크립트와 차트와의 동기화가 완료된 후 호출할 함수로 사용자가 정의한 함수입니다.
	// setData 함수를 통해 차트에 데이터를 전달하십시오.
	// setData 함수는 rMate 차트가 배열을 통해 데이터를 받기 위해 열어 놓은 함수입니다.
	// 이 함수의 파라메터는 곧 차트의 데이터입니다.
	function rMateChartOnLoad() {
		for(var i=0;i<resultList.length;i++){
			document.getElementById('chart'+i).setLayout(generateLayoutStr(i,13));
			document.getElementById('chart'+i).setData(resultList[i].resultWithCountList);
		}
	
	}
	
	
</script>
<jsp:include page="paramDiv.jsp"/>
<table width="100%">
	<div align="right" ><input type="button" id="printButton" onClick="printGraph('${cp}/DiagnosisStatus/showTodayStatusGraph.do')"/></div>
<%-- 	<tr>
		<td colspan="4" align="center">
			<div class="title"><b>${ resultList[0].flight_date}</b></div>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart0','${cp}/rmate/Component/rMateChart', flashVars, 700, 200, '#FFFFFF');
			</script>
		</td>
	</tr> --%>
	<tr>
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart0','${cp}/rmate/Component/rMateChart', flashVars, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;" onClick="showStatusDialog(this)" flight_date="${ resultList[0].flight_date}" class="title"><b>${ resultList[0].flight_date}</b></div>
		</td>
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart1','${cp}/rmate/Component/rMateChart', flashVars, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;"  onClick="showStatusDialog(this)" flight_date="${ resultList[1].flight_date}" class="title"><b>${ resultList[1].flight_date}</b></div>
		</td>
	</tr>
	<tr>
		
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart2','${cp}/rmate/Component/rMateChart', flashVars, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;"  onClick="showStatusDialog(this)" flight_date="${ resultList[2].flight_date}" class="title"><b>${ resultList[2].flight_date}</b></div>
		</td>
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart3','${cp}/rmate/Component/rMateChart', flashVars+"&displayCompleteCallFunction="+chartComplete, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;"  onClick="showStatusDialog(this)" flight_date="${ resultList[3].flight_date}" class="title"><b>${ resultList[3].flight_date}</b></div>
		</td>
	</tr>
	<tr>
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart4','${cp}/rmate/Component/rMateChart', flashVars, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;"  onClick="showStatusDialog(this)" flight_date="${ resultList[4].flight_date}" class="title"><b>${ resultList[4].flight_date}</b></div>
		</td>
		<td>
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart5','${cp}/rmate/Component/rMateChart', flashVars, 350, 200, '#FFFFFF');
			</script>
			<div style="cursor:pointer;"  onClick="showStatusDialog(this)" flight_date="${ resultList[5].flight_date}" class="title"><b>${ resultList[5].flight_date}</b></div>
		</td>
	</tr>
</table>

<div id="showTodayStatusGraphDetailDialog" class="dialog">
</div>