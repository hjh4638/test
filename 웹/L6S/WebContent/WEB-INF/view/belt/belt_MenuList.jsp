<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>

</script>
<br/><br/>
<h1><font size="5">Information Portal</font></h1>
<br/><br/>
<div>
	<h1>개인 정보 입력</h1>
	&nbsp;&nbsp;&nbsp;&nbsp;
	통계에 필요한 기본 개인 정보를 입력 합니다.
	<p align="right">
		<c:choose>
			<c:when test="${checkSN eq 1}">
				<!-- Validation 처리 해야함 -->
				바로 가기
			</c:when>
			<c:otherwise>
				<a href="beltUserRegister.do">바로 가기</a>
			</c:otherwise>
		</c:choose>
	</p>
	 
</div>
<br/><br/>
<div>
	<h1>벨트 정보 입력</h1>
	&nbsp;&nbsp;&nbsp;&nbsp;
	이용자가 보유하고 있는 벨트를 등록합니다.<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;
	개인 정보를 입력 하신 후에 입력 가능합니다.<br/>
	<p align="right">
	<c:choose>
		<c:when test="${checkSN eq 1}">
			<a href="beltRegister.do">바로 가기</a>
		</c:when>
		<c:otherwise>
			<!-- Validation 처리 해야함 -->
			바로 가기
		</c:otherwise>
	</c:choose>
	</p>
</div>