<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
 
</style>
<script>

function openPop(quarter){
	var url = '<c:url value="/admin/popup/addAdminView.do?code="/>'+quarter;
	openPopup(url, 500, 500);
}  
</script>
<br>
<div class="left_navigation_common">
	<div class="left_navigation_user_information" >
<%-- 		<c:if test="${login.authorityName eq null}"> --%>
<!-- 			<ul> -->
<%-- 				<li style="margin-top: 10px;"><c:out value="${login.splitPersonPositionName}"/></li> --%>
<%-- 				<li><c:out value="${login.rank}"/>&nbsp;<c:out value="${login.name}"/></li> --%>
<%-- 					<li><c:out value="(결재 : ${login.myAppInfo.waitingCount}건)"/></li> --%>
<%-- 					<li><c:out value="(기각 : ${login.myAppInfo.gigakCount}건)"/></li> --%>
<!-- 			</ul> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${login.authorityName ne null}">  --%>
<!-- 			<ul> -->
<%-- 				<li style="margin-top: 2px;"><c:out value="${login.splitPersonPositionName}"/></li> --%>
<%-- 				<li><c:out value="${login.rank}"/>&nbsp;<c:out value="${login.name}"/></li> --%>
<%-- 					<li><c:out value="${login.authorityName}"/></li> --%>
<%-- 					<li><c:out value="(결재 : ${login.myAppInfo.waitingCount}건)"/></li> --%>
<%-- 					<li><c:out value="(기각 : ${login.myAppInfo.gigakCount}건)"/></li> --%>
<!-- 			</ul>  -->
<%-- 		</c:if> --%>
		<ul>
			<c:if test="${login.authorityName eq null}">
				<li style="margin-top: 20px;"><c:out value="${login.splitPersonPositionName}"/></li>
				<li><c:out value="${login.rank}"/>&nbsp;<c:out value="${login.name}"/></li>
				<li>
				[ 
					<a href="<c:url value='/approval_line/approvalMain.do'/>" onfocus="blur();">
						<font color="blue">결재</font> : <b><c:out value="${login.myAppInfo.waitingCount}"/></b>건
					</a>
				,
					<a href="<c:url value='/subject/mySubject.do'/>" onfocus="blur();">
						<font color="red">기각</font> : <b><c:out value="${login.myAppInfo.gigakCount}"/></b>건
					</a> 
				]
				</li>
			</c:if>
			<c:if test="${login.authorityName ne null}">
				<li style="margin-top: 10px;"><c:out value="${login.splitPersonPositionName}"/></li>
				<li><c:out value="${login.rank}"/>&nbsp;<c:out value="${login.name}"/></li>
				<li><c:out value="${login.authorityName}"/></li>
				<li>
				[
					<a href="<c:url value='/approval_line/approvalMain.do'/>" onfocus="blur();"> 
						<font color="blue">결재</font> : <b><c:out value="${login.myAppInfo.waitingCount}"/></b>건
					</a>
				, 
					<a href="#" onfocus="blur();">
						<font color="red">기각</font> : <b><c:out value="${login.myAppInfo.gigakCount}"/></b>건
					</a> 
				]
				</li>
			</c:if>
		</ul> 
	</div>
	
		<!-- 사용자과제 -->
	<a href="<c:url value='/subject/mySubject.do'/>" onfocus="blur();">
		<div class="left_navigation_my_work">
		</div>
	</a>
	<a href="<c:url value="/approval_line/approvalMain.do"/>">
		<div class="left_navigation_approval1">
			
		</div>
	</a>
<%-- 	<c:if test="${!(login.authority==null||login.quarter=='false'||login.quarter==null)}"> --%>
<!-- 		<div class="left_navigation_approval2"> -->
<!-- 		</div> -->
<%-- 	</c:if> --%>
	
	<c:if test="${!(login.authority==null||login.quarter=='false'||login.quarter==null)}">
		
			<!--관리자 메뉴 -->
				<c:if test="${login.authority=='A'&&login.quarter!='false'}">
					<a href="<c:url value='/admin/adminTable.do'/>" onfocus="blur();">
						<div class="left_navigation_admin">
						</div>
					</a>
				</c:if>
				<c:if test="${(login.authority=='B'||login.authority=='C')&&login.quarter!='false'}">
					<a href="javascript:openPop('<c:out value="${login.quarter }"/>');" onfocus="blur();" >
						<div class="left_navigation_admin">
						</div>
					</a>
				</c:if>	
		
	</c:if>
	<c:if test="${login.authority=='A'&&login.quarter!='false'}">
		<a href="#" onclick="goUpdate('<c:url value="/ajax/personnelUpdate.do"/>', '<c:out value="${login.authority}"/>');" onfocus="blur();">
			<div class="left_navigation_standard_information">
			</div>
		</a>
	</c:if>
	<div class="left_navigation_phone">
	</div>
</div>
