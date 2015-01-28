<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<div class="main_contents">
	<script>
			embedFlashObject("<c:url value="${cp }/images/L6SF.swf"/>", 726, 226, "");
	</script>
	
	<br /><br /><br />
	<a href="http://www.hq.af.mil:9999/service/rgboard/RGBoard.jsp?brd_seq=1904&ss=&keyword=&lpp=&viewtype=&category=&select=&resize=&page=1" target="blank">
		<img src="${pageContext.request.contextPath}/images/gongGi.gif" width="360" height="26" alt="" >
	</a>
	<a href="http://www.hq.af.mil:9999/service/rgboard/RGBoard.jsp?brd_seq=1906&ss=&keyword=&lpp=&viewtype=&category=&select=&resize=&page=1" target="blank">
		<img src="${pageContext.request.contextPath}/images/dataStore.gif" width="360" height="26" alt="">
	</a>	
	<iframe name="noticeframe" src="http://www.hq.af.mil:9999/service/iframe/noticeIframe2.jsp?brd_seq=1904&lc=8&width=340&height=150&cutString=30" nowrap frameborder="0" scrolling="no" leftmargin="0" topmargin="0" width="360" height="200"></iframe>
	<iframe name="dataframe" src="http://www.hq.af.mil:9999/service/iframe/noticeIframe2.jsp?brd_seq=1906&lc=8&width=340&height=150&cutString=30" nowrap frameborder="0" scrolling="no" leftmargin="0" topmargin="0" width="360" height="200"></iframe>
</div>
