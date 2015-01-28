<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>"/>
SSO 로그인이 필요합니다.
<form action="${cp }/Test/ssoTest.do">
테스트용 로그인
 군번:<input type="text" name="userid"/><input type="submit"/>
</form>