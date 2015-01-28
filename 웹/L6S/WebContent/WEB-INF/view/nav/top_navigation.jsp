<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script type="text/javascript">
<!--
 	$(document).ready(function(){
		
 		//$('.navigation_lyn6_intro').mouseenter(function(){
			/*$('.top_sub_navigation_three').hide();
			$('.top_sub_navigation_two').hide();
			$('.top_sub_navigation').hide();
 			*/
 			//$('.topSubBar').hide();
			
// 			$('.navigation_lyn6_intro').
// 				css("background-image", 'url("../images/main/top/top_aboutL6S_on.gif")');
// 			$('.navigation_project_manage').
// 				css("background-image", 'url("../images/main/top/top_assignmanage.gif")');
// 			$('.navigation_belt_manage').
// 				css("background-image", 'url("../images/main/top/top_beltmanage.gif")');
// 			$('.navigation_room').
// 				css("background-image", 'url("../images/main/top/top_board.gif")');
 		//});
 		
		//$('.navigation_project_manage').mouseenter(function(){
			/*$('.top_sub_navigation_two').hide();
			$('.top_sub_navigation_three').hide();
			$('.top_sub_navigation').show();*/
			//$('.topSubBar[subid=1]').show();
			//$('.topSubBar[subid!=1]').hide();
			
// 			$('.navigation_lyn6_intro').
// 				css("background-image", 'url("../images/main/top/top_aboutL6S.gif")');
// 			$('.navigation_project_manage').
// 				css("background-image", 'url("../images/main/top/top_assignmanage_on.gif")');
// 			$('.navigation_belt_manage').
// 				css("background-image", 'url("../images/main/top/top_beltmanage.gif")');
// 			$('.navigation_room').
// 				css("background-image", 'url("../images/main/top/top_board.gif")');
		//});
		
		//$('.navigation_belt_manage').mouseenter(function(){
			/*$('.top_sub_navigation').hide();
			$('.top_sub_navigation_three').hide();
			$('.top_sub_navigation_two').show();
			*/

			//$('.topSubBar[subid=2]').show();
			//$('.topSubBar[subid!=2]').hide();
// 			$('.navigation_lyn6_intro').
// 				css("background-image", 'url("../images/main/top/top_aboutL6S.gif")');
// 			$('.navigation_project_manage').
// 				css("background-image", 'url("../images/main/top/top_assignmanage.gif")');
// 			$('.navigation_belt_manage').
// 				css("background-image", 'url("../images/main/top/top_beltmanage_on.gif")');
// 			$('.navigation_room').
// 				css("background-image", 'url("../images/main/top/top_board.gif")');
		//});
		
		//$('.navigation_room').mouseenter(function(){
			/*$('.top_sub_navigation').hide();
			$('.top_sub_navigation_two').hide();
			$('.top_sub_navigation_three').show();*/

			//$('.topSubBar[subid=3]').show();
			//$('.topSubBar[subid!=3]').hide();
			
// 			$('.navigation_lyn6_intro').
// 				css("background-image", 'url("../images/main/top/top_aboutL6S.gif")');
// 			$('.navigation_project_manage').
// 				css("background-image", 'url("../images/main/top/top_assignmanage.gif")');
// 			$('.navigation_belt_manage').
// 				css("background-image", 'url("../images/main/top/top_beltmanage.gif")');
// 			$('.navigation_room').
// 				css("background-image", 'url("../images/main/top/top_board_on.gif")');
		//});
		
		$(".navigation").mouseenter(function() {
			var subid = $(this).attr('subid');
			$('.topSubBar[subid=' + subid + ']').show();
			$('.topSubBar[subid!=' + subid + ']').hide();
		});
		
		var list = [ "subject", "belt", "board"];
		var found = -1;
		for (var i = 0; i < 3; i++) {
			var search = list[i];
			if (location.href.indexOf("end") != -1) {
				found=3;
				break;
			}
			else if (location.href.indexOf(search) != -1) {
				found = i;
				break;
			}
		}
		if (found != -1) {
			found++;
			$('.topSubBar[subid=' + found + ']').show();
			$('.topSubBar[subid!=' + found + ']').hide();
			
		}
	
	});
	
//-->

</script>

<ul class="top_navigation_ul">
	<li>
		<a class="navigation_lyn6_intro navigation" subid=0 href="<c:url value="/main/intro.do"/>" onfocus="blur();" >
<!-- 		린6시그마 소개 -->
		</a>	
	</li>
	<li>
		<a class="navigation_project_manage navigation" subid=1 href="#" onfocus="blur();">
<!-- 		과제관리 -->
		</a>
	</li>
	<li>
		<a class="navigation_project_manage navigation" subid=4 href="<c:url value="/endsubject/endsubjectList.do"/>" onfocus="blur();">
<!-- 		사후관리 -->
		</a>
	</li>
	<li>
		<a class="navigation_belt_manage navigation" subid=2 href="#" onfocus="blur();">
<!-- 		벨트관리 -->
		</a>
	</li>
	<li>
		<a class="navigation_room navigation" subid=3 href="#" onfocus="blur();">
<!-- 		게시판 -->
		</a>
	</li>
</ul>

<%-- <c:url value=""/> --%>

<ul class="top_sub_navigation topSubBar" subid=1>
	<li>
		<a class="navigation_sub_project_register" href="<c:url value="/subject/subjectRegister.do"/>" onfocus="blur();">
<!-- 		과제등록 -->
		</a>
	</li>
	<li>
		<a class="navigation_sub_project_list" href="<c:url value="/subject/subjectList.do"/>" onfocus="blur();">
<!-- 		과제조회 -->
		</a>
	</li>
	<li>
		<a class="navigation_sub_project_state" href="<c:url value="/statistics/subjectStatistics.do"/>" onfocus="blur();">
<!-- 		과제현황 -->
		</a>
	</li> 
</ul>

<ul class="top_sub_navigation_two topSubBar" subid=2>
	<li>
		<a class="navigation_sub_process_register" href="<c:url value="/belt/beltRegister.do"/>" onfocus="blur();">
<!-- 		벨트등록 -->
		</a>
	</li>
	<li>
		<a class="navigation_sub_process_listresult" href="<c:url value="/belt/beltListResult.do"/>" onfocus="blur();">
<!-- 		벨트조회 -->
		 </a>
	</li>
 	<li>
 		<a class="navigation_sub_process_state" href="<c:url value="/statistics/beltStatistics.do"/>" onfocus="blur();">
<!--  		벨트현황 -->
 		</a>
	</li>  
</ul> 

<ul class="top_sub_navigation_three topSubBar" subid=3>
	<li>
		<a class="navigation_sub_room_notice" href="<c:url value="/board/boardNotice.do"/>" onfocus="blur();">
<%-- 		<img src="<c:url value="/images/main/sub/sub_notice.gif"/>"> --%>
		</a>
	</li>
 	<li>
 		<a class="navigation_sub_room_data" href="<c:url value="/board/boardData.do"/>" onfocus="blur();">
<%--  		<img src="<c:url value="/images/main/sub/sub_dataroom.gif"/>"> --%>
 		</a>
	</li>  
</ul>
<!-- <ul class="top_sub_navigation_four topSubBar" subid=4> -->
<!-- 	<li> -->
<%-- 		<a class="navigation_sub_room_notice" href="<c:url value="/board/boardNotice.do"/>" onfocus="blur();"> --%>
<%-- 		<img src="<c:url value="/images/main/sub/sub_notice.gif"/>"> --%>
<!-- 		</a> -->
<!-- 	</li> -->
<!--  	<li> -->
<%--  		<a class="navigation_sub_room_data" href="<c:url value="/board/boardData.do"/>" onfocus="blur();"> --%>
<%--  		<img src="<c:url value="/images/main/sub/sub_dataroom.gif"/>"> --%>
<!--  		</a> -->
<!-- 	</li>   -->
<!-- </ul> -->
