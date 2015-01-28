<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<!-- rMateChart 관련 include -->
<script src="${cp}/rmate/Samples/JS/AC_OETags.js" language="javascript"></script>
<script src="${cp}/rmate/Samples/JS/rMateChart.js" language="javascript"></script>
<script src="${cp}/rmate/LicenseKey/rMateChartLicense.js" language="javascript"></script>
<script type="text/javascript">


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
var resultList=${resultList};
var layoutStr =
	'<rMateChart backgroundColor="0xFFFFFF">'
	+ '<Options>'
	+ '<Caption text="${param.year}년 ${param.month}월 대대별 진단현황"/>'
	+ '</Options>'
	+ '<Column2DChart fontSize="13"  showDataTips="true" itemClickJsFunction="chartClick">'
	+ '<horizontalAxis><CategoryAxis categoryField="title"/></horizontalAxis>'
	+ '<verticalAxis><LinearAxis id="vAxis1" minimum="0" interval="10"/></verticalAxis>'
	+ '<series>'
	+ '<Column2DSeries labelPosition="outside" fontFamily="Myriad" yField="result03" itemRenderer="BoxItemRenderer">'
	+ '<showDataEffect>' 
	+'<SeriesInterpolate/>' 
	+'</showDataEffect> '
	+'<fill>' 
	+'<SolidColor color="0xFF6600" alpha="0"/>' 
	+'</fill>' 
	+'</Column2DSeries>'
	+ '<Column2DSeries labelPosition="outside" fontFamily="Myriad" yField="result02" itemRenderer="BoxItemRenderer">'
	+ '<showDataEffect>' 
	+'<SeriesInterpolate/>' 
	+'</showDataEffect> '
	+'<fill>' 
	+'<SolidColor color="0xFFFF00" alpha="0"/>' 
	+'</fill>' 
	+'</Column2DSeries>'
	+ '<Column2DSeries labelPosition="outside" fontFamily="Myriad" yField="result01" itemRenderer="BoxItemRenderer">'
	+ '<showDataEffect>' 
	+'<SeriesInterpolate/>' 
	+'</showDataEffect> '
	+'<fill>' 
	+'<SolidColor color="0x008000" alpha="0"/>' 
	+'</fill>' 
	+'</Column2DSeries>'
	+ '</series>'
	+ '</Column2DChart>'
	+ '</rMateChart>';
// 차트 레이아웃 데이터
	

	// rMate Chart와 스크립트가 동기화가 완료된 후 Chart가 함수를 호출합니다.
	// 이 함수를 통하여 차트와 통신하기 때문에 배열형태로 데이터를 삽입할 경우 반드시
	// 정의하여야 합니다.
	var rMateOnLoadCallFunction = "rMateChartOnLoad";
	var flashVars = "&rMateOnLoadCallFunction="+rMateOnLoadCallFunction;

	// 디버그 모드 사용
	flashVars += "&debugMode=true";
	

	// 차트에 표시할 데이터

	// 스크립트와 차트와의 동기화가 완료된 후 호출할 함수로 사용자가 정의한 함수입니다.
	// setData 함수를 통해 차트에 데이터를 전달하십시오.
	// setData 함수는 rMate 차트가 배열을 통해 데이터를 받기 위해 열어 놓은 함수입니다.
	// 이 함수의 파라메터는 곧 차트의 데이터입니다.
	function rMateChartOnLoad() {
		
			document.getElementById('chart0').setLayout(layoutStr);
			document.getElementById('chart0').setData(resultList);
		
	
	}


	$(function(){

		// 인쇄 버튼 이벤트
		$('#printBtn').click(function() {
			document.getElementById('chart0').printChart();
		});
	});

</script>
<jsp:include page="paramDiv.jsp"/>
<table width="100%">
	<tr>
		<td align="center">
			<script language="javascript">
			// 차트 생성
			rMateChartCreate('chart0','${cp}/rmate/Component/rMateChart', flashVars, 700, 400, '#FFFFFF');
			</script>
		</td>
	</tr>
	<tr><td align="center"><input id="printBtn" type="button" value="출력"/></td></tr>

</table>
