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

Calendar calendar = new GregorianCalendar();
String year = new String();
if(request.getParameter("year") == null || request.getParameter("year").equals("")){
	year =calendar.get(Calendar.YEAR)+"";
}
else year = request.getParameter("year");

SubjectStatisticsService sss = context.getBean(SubjectStatisticsService.class);
List<SubjectVO> baseCount = sss.getEachBaseCount(year);
int basize = baseCount.size(); 

SubjectService sservice = context.getBean(SubjectService.class);
User e =(User)request.getSession().getAttribute("login");
String mybase=sservice.getBaseNameBySn(e.getSn());

%>

<c:set var="baseCount1" value="<%=baseCount %>" />
<c:set var="baseCount2" value="<%=baseCount %>" />
<c:set var="baseCount3" value="<%=baseCount %>" />
<c:set var="mybase" value="<%=mybase %>" />
<c:set var="basize" value="<%=basize %>" />

<items> 
  <c:forEach var="baseCount" items="${baseCount1 }">
	<c:if test="${baseCount.sosok_gragh eq mybase }">
		<item> 
		<Sosok>${baseCount.sosok_gragh }</Sosok>
		<Count>${baseCount.subject_count}</Count> 
		</item>
	</c:if>
</c:forEach> 
<c:forEach var="baseCount" items="${baseCount2 }" begin="0" end="8">
	<c:if test="${baseCount.sosok_gragh ne mybase }">
		<item> 
		<Sosok>${baseCount.sosok_gragh }</Sosok>
		<Count>${baseCount.subject_count}</Count> 
		</item>
	</c:if>  
</c:forEach>  

<c:if test="${basize >9}">
<c:set var="sum" value="0"/> 
<c:forEach var="baseCount" items="${baseCount3 }" begin="9">
	<c:if test="${baseCount.sosok_gragh ne mybase}">	
		<c:set var="sum" value="${sum+baseCount.subject_count }"/>
	</c:if>
</c:forEach> 
		<item> 
		<Sosok>기타</Sosok>
		<Count>${sum }</Count> 
		</item>
</c:if> 
</items>



