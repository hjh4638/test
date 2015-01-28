<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="cp" value="<%=request.getContextPath() %>" /><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>철매휴양소 예약관리체계</title>
<jsp:include page="import.jsp"></jsp:include>
<script>
$(function(){
	/*
	if($(document).height() >= 750)
	{
		$("#content").css("height",$(document).height()-163);
		$(".left").css("height",$(document).height()-163);
		$(".right").css("height",$(document).height()-163);
	}
	*/
	page('${url}');
	

});

function page(urlp) {
	
	if(urlp == 'reserveView.do') {
		<c:if test="${login eq null }">$(".left").attr("class", "left4");$(".right").css({"width":"60%","margin":"10px"});</c:if><c:if test="${login ne null }">
		$(".left").hide();$(".right").css({"width":"97%","margin":"10px"});</c:if>
	} else if(urlp == 'declareBoard.do' || urlp == 'qnaBoard.do') {$(".left").attr("class", "left1");$(".right").css({"width":"60%","margin":"10px"});		
	} else if(urlp == 'index.do') {
	} else if(urlp == 'usingInfo.do') {$(".left").attr("class", "left5");$(".right").css({"width":"60%","margin":"10px"});	
	} else if(urlp == 'roomInfo.do') {$(".left").attr("class", "left3");$(".right").css({"width":"60%","margin":"10px"});	
	} else if(urlp == 'mapInfo.do') {$(".left").attr("class", "left2");$(".right").css({"width":"60%","margin":"10px"});
	} else {$(".left").attr("class", "left4");$(".right").css({"width":"60%","margin":"10px"});	
	}

	$.ajax({
		  url: urlp,
		  data:{error: '${error}',
				auth_filter:'${param.auth_filter}',
				facilities_type:'${param.facilities_type}',
				reservation_day:'${param.reservation_day}',
				facilities_type:'${param.facilities_type}',
				year:'${param.year}',
				date:'${param.date}'
		
		  },
		  dataType:"html",
		  cache: false, 
		  beforeSend: function() {
			  $(".right").hide();
			  $("#loading").show();
		  },
		  success: function(data){
			  $(".right").html(data);
			  $(".right").show();
		  },
		  complete: function() {
			  setTimeout(function() {$("#loading").remove();}, 300);
		  }
	});
}
</script>
</head>
<body>
<div id="warp">
	<div id="top">
		<div class="logo">
			<a href="main.do"><img src="images/layout/logo.png" alt="사격지원대 철매휴양소"></a>
		</div>
		<div class="menu">
			<ul id="gnb">
				<c:if test="${login eq null }">
				<li><a href="main.do?type=login"><img src="images/layout/login_btn.gif" alt="로그인" /></a></li>
				<li><img src="images/layout/bar_btn.gif" alt="" /></li>
				<li><a href="main.do?type=member"><img src="images/layout/join_btn.gif" alt="회원가입" /></a></li>
				<li><img src="images/layout/bar_btn.gif" alt="" /></li>
				<li><a href="find.do"><img src="images/layout/find_btn.gif" alt="아이디/비밀번호찾기" /></a></li>
				</c:if>
				<c:if test="${login ne null }">
				<li><a href="logout.do"><img src="images/layout/logout_btn.gif" alt="로그아웃" /></a></li>
				<li><img src="images/layout/bar_btn.gif" alt="" /></li>
				<li><a href="main.do?type=member"><img src="images/layout/userinfo_btn.gif" alt="개인정보수정" /></a></li>
				<c:if test="${login.user_auth eq 'D03' or login.user_auth eq 'D04' }">
				<li><img src="images/layout/bar_btn.gif" alt="" /></li>
				<li><a href="admin.do?type=appList"><img src="images/layout/admin_btn.gif" alt="관리자" /></a></li>
				</c:if>
				</c:if>
			</ul>
			<ul id="lnb">
				<c:choose>
				<c:when test="${param.type eq null or param.type eq 'usingInfo' or param.type eq 'roomInfo' or param.type eq 'mapInfo'}">
				<li><a href="main.do"><img src="images/layout/menu1_on.gif" alt="철매휴양소"></a></li>
				<li><a href="main.do?type=reserveView"><img src="images/layout/menu2_off.gif" alt="실시간예약"></a></li>
				<li><a href="main.do?type=myReserve"><img src="images/layout/menu3_off.gif" alt="예약확인/취소"></a></li>
				<li style="margin-right:0px;"><a href="main.do?type=declareBoard"><img src="images/layout/menu4_off.gif" alt="공지&질의응답"></a></li>
				</c:when>
				<c:when test="${param.type eq 'reserveView' or param.type eq 'reserve'}">
				<li><a href="main.do"><img src="images/layout/menu1_off.gif" alt="철매휴양소"></a></li>
				<li><a href="main.do?type=reserveView"><img src="images/layout/menu2_on.gif" alt="실시간예약"></a></li>
				<li><a href="main.do?type=myReserve"><img src="images/layout/menu3_off.gif" alt="예약확인/취소"></a></li>
				<li style="margin-right:0px;"><a href="main.do?type=declareBoard"><img src="images/layout/menu4_off.gif" alt="공지&질의응답"></a></li>
				</c:when>
				<c:when test="${param.type eq 'myReserve'}">
				<li><a href="main.do"><img src="images/layout/menu1_off.gif" alt="철매휴양소"></a></li>
				<li><a href="main.do?type=reserveView"><img src="images/layout/menu2_off.gif" alt="실시간예약"></a></li>
				<li><a href="main.do?type=myReserve"><img src="images/layout/menu3_on.gif" alt="예약확인/취소"></a></li>
				<li style="margin-right:0px;"><a href="main.do?type=declareBoard"><img src="images/layout/menu4_off.gif" alt="공지&질의응답"></a></li>
				</c:when>
				<c:when test="${param.type eq 'declareBoard' or param.type eq 'qnaBoard'}">
				<li><a href="main.do"><img src="images/layout/menu1_off.gif" alt="철매휴양소"></a></li>
				<li><a href="main.do?type=reserveView"><img src="images/layout/menu2_off.gif" alt="실시간예약"></a></li>
				<li><a href="main.do?type=myReserve"><img src="images/layout/menu3_off.gif" alt="예약확인/취소"></a></li>
				<li style="margin-right:0px;"><a href="main.do?type=declareBoard"><img src="images/layout/menu4_on.gif" alt="공지&질의응답"></a></li>
				</c:when>
				<c:otherwise>
				<li><a href="main.do"><img src="images/layout/menu1_off.gif" alt="철매휴양소"></a></li>
				<li><a href="main.do?type=reserveView"><img src="images/layout/menu2_off.gif" alt="실시간예약"></a></li>
				<li><a href="main.do?type=myReserve"><img src="images/layout/menu3_off.gif" alt="예약확인/취소"></a></li>
				<li style="margin-right:0px;"><a href="main.do?type=declareBoard"><img src="images/layout/menu4_off.gif" alt="공지&질의응답"></a></li>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>

	</div>
	<div id="content">
		<div class="left">
		</div>
		<div id="loading">
			<div class="loading-indicator">
	            <img src="images/common/loading.gif" width="32" height="32" style="margin-right:8px;float:left;vertical-align:top;"/>사격지원대 철매휴양소
	            <br /><span id="loading-msg">데이터를 가져오고 있습니다. 잠시만 기다려 주세요..</span>
	        </div>
		</div>
		<div class="right">
			<div class="contents">
			</div>
		</div>
	</div>
	<div id="bottom">
	</div>
</div>
</body>
</html>