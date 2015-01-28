<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<tiles:insertAttribute name="include"/>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script language="javascript">
		function printOut(){
		window.print();
		}
		</script> 
		<title></title>					
	</head>
	
	<body>
		<tiles:insertAttribute name="content"/><br>
		<center>
		<ul class="assignment_list_menu_ul">
		 <li>
			<a class="menu_print" href="#" onfocus="blur();" onclick="printOut();">
			<img src="<c:url value="/images/button/print.gif"/>">
			</a>
		  </li>
		</ul>
		</center>	
	</body>
</html>
 