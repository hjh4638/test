<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
//*******************************************************************************
//
// 리얼 타임 차트 서버사이드 예제.
//
//----------------------------------------------------------------------------------
// 예제 작동 방식 설명
//----------------------------------------------------------------------------------
//
// 본 예제는 DB 데이터가 아닌 임의의 랜덤 데이터를 기반으로 합니다.
// requestAllData 속성과 무관하게 엊그제 23 시 부터 오늘 00시 00분 까지 3분 단위 데이터를 생성합니다.
// 따라서 차트 레이아웃의 RPCItem 노드의 interval 값은 지정하지 않습니다.
// interval 이 지정되지 않은 경우에는 다음 갱신시간에 모든 데이터가 refresh 됩니다.
// 즉, <nextInitDate> 값에 설정된 시간이 되면 모든 데이터를 삭제하고 다시 요청하게 됩니다.(refresh)
//
//
//---------------------------------------------------------------------------------
// 파라메터 설명.
//----------------------------------------------------------------------------------
//
// requestAllData : 차트가 모든 데이터를 요청하는 플래그입니다.
//					즉, 현재 차트에 뿌려진 데이터를 갱신하고자 할 때 사용합니다.
//					requestAllData=true 로 설정되어 호출하는 순간은 다음과 같습니다.
//					
//					1. 처음 차트가 로딩되어 처음 RPC 요청할 때.
//					2. 현재 시간이 <nextInitDate> 보다 커진 경우 true 로 설정되어 RPC 요청합니다.
//					
//					requestAllData=true 로 설정된 경우 서버사이드는 다음과 같이 작업을 할 필요가 있습니다.
//					이는 요청 후 응답으로 받은 데이터가 정확하다는 서로간의 통신법입니다.
//					<infoMsg> 태그 밑에 <isInitData>true</isInitData> 로 설정.
//					requestAllData=false 인 경우 <isInitData>false</isInitData> 여야 합니다.
//
// index : 차트가 최근에 받은 자료의 index를 나타냅니다.
//			이는 서버사이드에서 응답으로 전달해준 자료입니다.
//			index 를 통하여 서버와 클라이언트 간 자료 중복을 줄일 수 있습니다.
//			다시 말해 차트가 이전에 받은 자료의 index를 다음 호출 때 파라메터로 넘겨줌으로써
//			서버는 index 다음 자료를 쉽게 넘겨줄 수 있습니다.
//
// dummy : 이 값은 IE 의 캐시 문제를 피하기 위해 넣은 더미값입니다.
//			경우에 따라서는 유용하게 쓰일 수 있습니다.
//			1970년 1월 1일 00시 부터 현재 차트가 RPC 를 보낸 순간까지의 밀리섹컨드를 나타냅니다.
//			이 값은 서버의 시간 기준이 아닌 클라이언트 시간 기준입니다.
//
//
//-----------------------------------------------------------------------------------
// XML 작성 규칙.
//-----------------------------------------------------------------------------------
//
// 클라이언트가 응답으로 가져갈 XML 은 다음 규칙을 따라야 합니다.
//
// 규칙 1. 루트 노드 다음으로 <infoMsg> 노드 정보 및 서브 노드 정보는 반드시 필요합니다. (이름 변경 불가)
// 규칙 2. 차트가 뿌릴 데이터에 해당되는 노드는 반드시 <item> 이여야 합니다. (이름 변경 불가)
//
//
//------------------------------------------------------------------------------------
// 예제 XML 설명.
//------------------------------------------------------------------------------------
//
// 현재 예제는 랜덤으로 값을 나타냅니다. (DB 데이터 값이 아님)
// 
// requestAllData 파라메터의 true/false 에 따라 다르게 XML 이 출력시킬 수 있습니다.
// 그러나 현재 샘플은 항상  엊그제를 23:00 를 기준으로 25시간의 데이터(즉, 엊그제 23:00:00 ~ 어제 23:59:00)를 표현합니다.(샘플에선 requestAllData 옵션 무시함)
//
// <infoMsg> 노드에 대한 설명.
//
//		1. <index> 노드.
//				현재 샘플에선 index 파라메터를 사용하여 샘플이 작성되지 않았습니다.
//				그러나 이 노드는 현재 서버가 작성한 데이터의 고유값을 삽입하면 유리합니다.
//				차트는 항상 RPC 요청 시 차트가 최근에 응답으로 받아간 index를 갖고 요청을 합니다.
//				그렇기 때문에 이 파라메터를 이용하면 다음 데이터를 쉽게 전달해 줄 수 있습니다.
//				처음 차트 로딩 시(즉, 이전에 받아간 데이터 없을 경우)엔 init 임.
//
//		2. <timeNow> 노드.
//				서버의 현재 시간을 나타냅니다. 이는 데이터를 갱신(초기화)할 때 사용됩니다.
//				모든 클라이언트의 데이터를 일괄적으로 갱신(초기화) 하기를 원할 때 서버의 현재 시간을 삽입하여 주십시오.
//				이 노드를 생략한다면 모든 클라이언트의 로컬 시간을 기준으로 endDate 와 비교하여 갱신됩니다.
//				즉, <timeNow> 가 없다면 갱신되는 시간은 클라이언트마다 다를 수 있습니다.
//
//		3. <isInitData> 노드.
//				requestAllData = true 로 파라메터를 받은 경우 isInitData 노드를 true 로 설정하세요.
//				이는 서버와 클라이언트간 규약입니다.
//
//		4. <startDate> 노드.
//				차트에 표시되는 시간의 초기 시간입니다. 이 노드가 없다면 처음 데이터를 기준으로 처음 시간이 뿌려집니다.
//
//		5. <endDate> 노드.
//				차트에 표시할 시간의 마지막입니다. 이는 데이터가 앞으로 표현될 시간입니다.(현재 시간과 무관, 단순 데이터의 시간임.)
//
//		6. <nextInitDate> 노드.
//				이 값보다 현재 시간이 커진다면 차트는 갱신을 시도합니다. 
//				이 말은 현재 차트에 뿌려진 데이터를 모두 지우고
//				새로 서버에 초기 데이터를 요청하는 requestAllData=true 파라메터로 요청을 합니다.
//				이 값은 실제 현재 시간과 관련이 있습니다. 또한 timeNow 노드 값과 깊은 관련이 있습니다.(timeNow 참고)
//				예를 들어 한달전 데이터를 현재 10분 주기로 보여주고 있는데 특정 시점에서 차트의 <endDate> 값까지 출력한 경우
//				이 시간을 참조하여 초기화를 요청하게 됩니다. (초기화는 requestAllData=true 파라메터 설정임).
//		
//****************************************************************************************************************************



	response.setHeader( "Content-Type" ,"text/xml" );

	Random myRandom = new Random();
	
	// 데이트 포맷 형식은 반드시 "2010/02/15 20:30:00" 형태로 하여주십시오.
	SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy/MM/dd HH:mm");

	String requestAllData = request.getParameter("requestAllData");
	
	Date date = new Date();

	int data1;

	out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
    out.println("<items>");
	out.println("<infoMsg>");

	// 현재 index 노드는 샘플에서 사용하지 않음.(클라이언트 응답으로 보내고, 클라이언트는 요청시 최근의 index 를 파라메터로 첨부하는 역할은 함)
	out.println("<index>"+dateFmt.format(date)+"</index>");
	out.println("<timeNow>"+dateFmt.format(date)+"</timeNow>");

	// 현재 시간의 hour(시)를 구해 + 1 시킴. 이는 어제의 23시를 찾기 위함.
	int baseHour = date.getHours() + 1;

	// 현재 시간의 minute(분)을 구함.
	int baseMinutes = date.getMinutes();
	
	// 데이터 시작 시간 : 엊그제의 23시.
	long startDateTime = date.getTime() - (baseHour * 60 * 60 * 1000) - (baseMinutes * 60 * 1000) - (1000 * 60 * 60 * 24);

	Date startDate = new Date(startDateTime);

	// 데이터 끝나는 시간 : 어제의 23시 59분.
	long endDateTime = date.getTime() - ((baseHour-1) * 60 * 60 * 1000) - (baseMinutes * 60 * 1000) - (1000 * 60);

	// 차트가 표현할 데이터의 마지막 시간. 
	Date endDate = new Date(endDateTime);
	
	// 차트가 데이터를 모두 초기화 할 시간(즉, 현재 시간이 설정한 nextInitDate를 지난 경우 requestAllData=true 요청을 시도함.
	Date nextInitDate = new Date();
	nextInitDate.setHours(23);
	nextInitDate.setMinutes(59);

	long gap = endDate.getTime() - startDateTime;
	
	// 클라이언트에서 requestAllData 파라메터를 true 로 설정하여 RPC 요청한 경우엔 반드시 isInitData = true 설정.
	out.println("<isInitData>"+true+"</isInitData>");

	// 현재 데이터를 모두 갱신하는 시간 설정.(실제 시간)
	out.println("<nextInitDate>"+dateFmt.format(nextInitDate)+"</nextInitDate>");

	// 단순히 최초 데이터의 Date
	out.println("<startDate>"+dateFmt.format(startDate)+"</startDate>");

	// 단순히 마지막 데이터의 Date
	out.println("<endDate>"+dateFmt.format(endDate)+"</endDate>");
	out.println("</infoMsg>");

	for(int i=0; i<=gap; i+=1000*60*3) //3분단위 데이터.
	{
		// 랜덤 데이터 생성.
		data1 = 100 + myRandom.nextInt(500)/2;

		long nextTime = startDateTime + i;
		Date baseDate = new Date(nextTime);
		
		// 차트에 표시할 데이터
		out.println("<item>");
		out.println("<date>"+dateFmt.format(baseDate)+"</date>");
		out.println("<yesTotalData>"+data1+"</yesTotalData>");
		out.println("</item>");
	}
    out.println("</items>");
%>