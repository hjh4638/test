<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<%--
차트의 제목(Caption) 부분을 동적 생성하기 위해 레이아웃을 jsp 에 정의
--%>
// 차트 레이아웃 데이터
	var layoutStr =
	'<rMateChart backgroundColor="0xFFFFFF">'
	+ '<Options>'
	+ '<Caption text="2011년 12월  대대별 평균 점수"/>'
	+ '</Options>'
	+ '<Column2DChart>'
	+ '<horizontalAxis><CategoryAxis categoryField="unitName"/></horizontalAxis>'
	+ '<verticalAxis><LinearAxis id="vAxis1" minimum="0" maximum="100" interval="10"/></verticalAxis>'
	+ '<series>'
	+ '<Column2DSeries labelPosition="outside" fontFamily="Myriad" yField="averageScore" itemRenderer="BoxItemRenderer">'
	+ '<fills>'
	+ '<SolidColor color="0xCC4643"></SolidColor>'
	+ '<SolidColor color="0x89B04E"></SolidColor>'
	+ '<SolidColor color="0x4572AA"></SolidColor>'
	+ '</fills>'
	+'</Column2DSeries>'
	+ '</series>'
	+ '</Column2DChart>'
	+ '</rMateChart>';

	// rMate Chart와 스크립트가 동기화가 완료된 후 Chart가 함수를 호출합니다.
	// 이 함수를 통하여 차트와 통신하기 때문에 배열형태로 데이터를 삽입할 경우 반드시
	// 정의하여야 합니다.
	var rMateOnLoadCallFunction = "rMateChartOnLoad";
	var flashVars = "&rMateOnLoadCallFunction="+rMateOnLoadCallFunction;

	// 디버그 모드 사용
	flashVars += "&debugMode=true";


	// 차트에 표시할 데이터
	var chartData = [{unitName:'테스트1',averageScore:'100',barColor:'#00AA00'},
	                 {unitName:'테스트2',averageScore:'40',barColor:'#0000AA'},
					 {unitName:'테스트3',averageScore:'75',barColor:'#AA0000'}];


	// 스크립트와 차트와의 동기화가 완료된 후 호출할 함수로 사용자가 정의한 함수입니다.
	// setData 함수를 통해 차트에 데이터를 전달하십시오.
	// setData 함수는 rMate 차트가 배열을 통해 데이터를 받기 위해 열어 놓은 함수입니다.
	// 이 함수의 파라메터는 곧 차트의 데이터입니다.
	function rMateChartOnLoad() {
		document.getElementById('chart').setLayout(layoutStr);
		document.getElementById('chart').setData(chartData);
	}


	$(function(){

		// 인쇄 버튼 이벤트
		$('#printBtn').click(function() {
			print();
		});
	});

</script>

<div id="chartDiv">
			<script language="javascript">
			
					// 차트 생성
					rMateChartCreate('chart','${cp}/rmate/Component/rMateChart', flashVars, 250, 240, '#FFFFFF');
			
			</script>
		</div>