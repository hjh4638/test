<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--
/**
* Title : Vertical Rolling Banner
* Author : Won Joso (http://blog.naver.com/josoblue , http://www.motionj.com)
* Email : joso@motionj.com
* Version : v1.0
* License : Free (사용범위는 제한이 없으나, js 파일의 주석을 제거하고나 재판매용으로 이용되서는 않됩니다.)
* Description :
*
* width : 배너 한개의 너비
* height : 배너 한개의 높이
* max_view : 초기 화면에 보여줄 배너 갯수
* speed : 1000 당 1초.
**/
-->

<style>
#roll li {list-style: none;}
</style>
	<script type="text/javascript" src="<c:url value='/js/jquery.motionj.rolling.js'/>"></script>
<script>
(function($){
	$(document).ready(function(){
		$('#rolling_box_01').motionj_rolling_vertical({
			width : 255, // 배너의 너비
			height : 152, // 배너의 높이
			max_view : 1, // 초기에 보일 배너의 갯수
			speed : 3000 // 속도
		});
	});
})(jQuery);
</script>
<div id="rolling_box_01">
	<ul id="roll" style="margin:0;padding:0;">
		<c:forEach var="dept" items="${departmentImageList }" begin="0" end="4">
			<li><a href="<c:url value='/notif/notif.do?code=B05&&board_id=${dept.board_id }'/>"><img width="255px" height="152px" src="<c:url value="/departmentImage/${dept.file_id }"/>" alt='' /></a></li>
		</c:forEach>
	</ul>
</div>
