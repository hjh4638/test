<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@page import="java.util.*"%>
<%@page import="mil.af.L6S.component.subject.SubjectVO"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page
	import="mil.af.L6S.component.statistics.SubjectStatisticsService"%>
	<%@page	import="mil.af.L6S.component.subject.SubjectService"%>
	<%@page	import="mil.af.L6S.component.common.User"%>
<%

ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(
		request.getSession().getServletContext());
		
SubjectStatisticsService field = context.getBean(SubjectStatisticsService.class);

Calendar calendar = new GregorianCalendar();
String year = new String();
if(request.getParameter("year") == null || request.getParameter("year").equals("")){
	year =calendar.get(Calendar.YEAR)+"";
}
else year = request.getParameter("year");

List<SubjectVO> field_count = field.getSubjectFieldCount(year);
int fsize =field_count.size();
SubjectService sservice = context.getBean(SubjectService.class);
User e =(User)request.getSession().getAttribute("login");
List<Integer> seq= sservice.getMySubjectCode(e.getSn());
SubjectVO su = new SubjectVO();

if(seq.size() >0){
	su = sservice.getSubjectBySeq(seq.get(0));
}

%>
<c:set var="fi" value="<%=field_count %>" />
<c:set var="su" value="<%=su %>" />
<c:set var="fsize" value="<%=fsize %>" />
<items> 
<c:forEach var="field" items="${fi }">
	<c:if test="${field.field_type eq su.field_type }">
		<item> 
		<Field>${field.field_type }</Field>
		<Count>${field.subject_count}</Count> 
		</item>
	</c:if>
</c:forEach> 
<c:forEach var="field" items="${fi }" begin="0" end="8">
	<c:if test="${field.field_type ne su.field_type }">	
		<item> 
		<Field>${field.field_type }</Field>
		<Count>${field.subject_count}</Count> 
		</item>
	</c:if>
</c:forEach>
<c:if test="${fsize >9 }">
<c:set var="sum" value="0"/> 
<c:forEach var="field" items="${fi }" begin="9">
	<c:if test="${field.field_type ne su.field_type }">	
		<c:set var="sum" value="${sum+field.subject_count }"/>
	</c:if>
</c:forEach> 
		<item> 
		<Field>기타</Field>
		<Count>${sum }</Count> 
		</item>
</c:if>
</items>