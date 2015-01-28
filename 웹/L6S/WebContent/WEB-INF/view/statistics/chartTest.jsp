<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="<c:url value='/rmate/config/AC_OETags.js'/>"></script>
<script src="<c:url value='/rmate/config/rMateChart.js'/>"></script>
<!--rMate Chart 라이선스 등록 완료 모습 -->
<script src="<c:url value='/rmate/config/rMateChartLicense.js'/>"></script>
 
<script>
//차트 레이아웂 URL 경로를 설정하십시오.
var fieldGraphLayoutURL = encodeURIComponent("/L6S/rmate/FieldGraphLayout.xml");
var fieldGraphFlashVars = "layoutURL="+fieldGraphLayoutURL;

// 차트 데이타 URL 경로를 설정하십시오.
var fieldGraphDataURL =encodeURIComponent("/L6S/rmate/FieldGraphData.jsp");
fieldGraphFlashVars += "&dataURL="+fieldGraphDataURL;

window.onload = function() {
	// rMateChart 초기화
	rMateChartInit();
};
</script> 
<!-- 사용자 정의 설정 끝 --> 

<table border="1">
	<tr>
		<td>
			<script>
			
			// 차트를 생성하고자 하는 위치에서 다음과 같이 함수 호춗하십시오.
			// 파라메터 설명(순서대로)
			// 1. ID (임의로 정의하십시오)
			// 2. swf 파일 URL(확장자는 생략)
			// 3. URL 경로 등을 정의한 변수명.
			// 4. 차트 가로 사이즈.
			// 5. 차트 세로 사이즈.
			// 6. 차트 배경색.
			rMateChartCreate("chart1","/L6S/rmate/config/rMateChart",fieldGraphFlashVars, 700, 400, "#FFFFFF");
		
			</script>
		</td>
	</tr>
</table>