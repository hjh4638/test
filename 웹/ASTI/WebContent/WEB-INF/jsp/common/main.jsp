<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
	
	<style>
	
	#container {
		overflow: hidden;
		position: relative;
		height: 375px;
		width: 984px;
	}

	.slideimg {
		position: absolute;
	}
	.slideimg.first{
 		z-index: 5; 
		width:600px;
		height:308px;
/* 		border:1px solid black; */
  		border-radius: 20px; 
		border:1px solid white;
	}
	.slideimg.first img{
		z-index: 5; 
		width:600px;
		height:308px;
		-webkit-filter: blur(0px);
/* 		cursor: pointer; */
		-webkit-border-radius: 20px;
	}
/* 	-webkit-filter: blur(2px); */
	.slideimg.second{
 		z-index: 1; 
		width:600px;
		height:308px;
/* 		border:1px solid black; */
		border-radius: 20px; 
	}
	
	.slideimg.second img{
		z-index: 3; 
		width:600px;
		height:308px;
		-webkit-filter: blur(3px); 
		-webkit-border-radius: 20px;
/*  		fliter:blur(add=13,direction=145,strength=10); */
		filter:progid:DXImageTransform.Microsoft.Blur(PixelRadius='4',MakeShadow='false',ShadowOpacity='0.75');
		
	}
	
	.slidebtn{
		width:49px;
		height:76px;
		font-size: 100px;
		cursor: pointer;
	}
	.slidebtn#next{
		margin-right:95px;
		float:right;
		z-index: 6;
		position: relative;
	}
	.slidebtn#previous{
		margin-left:95px;
		float:left;
		z-index: 6;
		position: relative;
	}
	</style>
	<script>
	var time_id;
	$(function(){
		time_id=setTimeout("autoSlide()",5000);
	});
	function autoSlide(){
		$('#arrow2').trigger('click');
		time_id=setTimeout("autoSlide()",5000); 
	}
	
	$(function() {
// 		TODO refactor into a widget and get rid of these plugin methods
//이부분이. 왼쪽 오른쪽 가운데 들어갈 것들의 좌표와 위치를 지정해주는것이야 
		$.fn.left = function( using ) {
			return this.position({
				my: "center center",
				at: "left+60 center-5",
				of: "#container",
				collision: "none",
				using: using
			});
		};
		$.fn.right = function( using ) {
			return this.position({
				my: "center center",
				at: "right-60 center-5",
				of: "#container",
				collision: "none",
				using: using
			});
		};
		$.fn.center = function( using ) {
			return this.position({
				my: "center center",
				at: "center center-15",
				of: "#container",
				using: using
			});
		};
		$.fn.other = function( using ) {
			return this.position({
				my: "left center",
				at: "right center-5",
				of: "#container",
				using: using
			});
		};

//그리고 그 좌표대로 초기 설정을 하는것이지
		
		$( ".slideimg:eq(0)" ).addClass('first').center();
		$( ".slideimg:eq(1)" ).addClass('second').right();
		$( ".slideimg:gt(1)" ).addClass('second').other();
		$( ".slideimg:last").addClass('second').left();
//이것은.. 무엇일까? 이게 자동적으로 돌리는건데 멈춰놓은걸까? 알아보자 이따
		function animate( to ) {
			$( this ).stop( true, false ).animate( to );
		}
//오른쪽으로 1보~
		function next( event ) {
			clearTimeout(time_id);
			event.preventDefault();
			$( ".slideimg:eq(1)" ).removeClass('second').addClass('first').css("z-index","5").center( animate );
			$( ".slideimg:eq(2)" ).removeClass('second').addClass('second').css("z-index","2").right( animate );
			$( ".slideimg:last" ).removeClass('second').addClass('second').css("z-index","1").other( animate );
			$( ".slideimg:eq(0)" ).removeClass('first').addClass('second').css("z-index","3").left( animate ).appendTo( "#container" );
			$("#slideindex")
			.load("/ASTI/main/slideindex.do?index="+$(".slideval:eq(0)").val());
		}
//왼쪽으로 1보~
		function previous( event ) {
			clearTimeout(time_id);
			event.preventDefault();
// 			$( ".slideimg:eq(0)" ).removeClass('second').addClass('first').css("z-index","5").center( animate );
// 			$( ".slideimg:eq(1)" ).removeClass('first').addClass('second').css("z-index","3").right( animate );
// 			$( ".slideimg:eq(2)" ).removeClass('second').addClass('second').css("z-index","1").other( animate );
// 			$( ".slideimg:last" ).removeClass('second').addClass('second').css("z-index","2").left( animate ).prependTo( "#container" );
			$( ".slideimg:eq(0)" ).removeClass('first').addClass('second').css("z-index","3").right( animate );
			$( ".slideimg:eq(1)" ).removeClass('second').addClass('second').css("z-index","1").other( animate );
			$( ".slideimg:last" ).removeClass('second').addClass('first').css("z-index","5").center( animate ).prependTo( "#container" );
			$( ".slideimg:last" ).removeClass('second').addClass('second').css("z-index","2").left( animate );

			$("#slideindex")
			.load("/ASTI/main/slideindex.do?index="+$(".slideval:eq(0)").val());
		}
		$( "#previous" ).click( previous );
		$( "#next" ).click( next );
//이거 그 .. (조건)?참:거짓 그식같은데,, 내가볼때는 0번째 그림을 눌렀을때만 왼쪽으로가고 아니면 오른쪽으로가라 이거같은데 그치?
//맞네 이거 그림 누르면 움직이는거 ㅋ 
// 		$( ".slideimg" ).click(function( event ) {
// 			$( ".slideimg" ).index( this ) === 0 ? next( event ) : next( event );
// 		});
//- .-;;? 뭐지?
// 		$( window ).resize(function() {
// 			$( ".slideimg:eq(0)" ).left( animate );
// 			$( ".slideimg:eq(1)" ).center( animate );
// 			$( ".slideimg:eq(2)" ).right( animate );
// 		});

		$(".slidebtn#next").mouseenter(function(){
			$("#arrow2").attr("src","<c:url value='/images/main/arrow2.png'/>");
		});
		$(".slidebtn#next").mouseleave(function(){
			$("#arrow2").attr("src","<c:url value='/images/main/arrow2_off.png'/>");
		});
		$(".slidebtn#previous").mouseenter(function(){
			$("#arrow1").attr("src","<c:url value='/images/main/arrow1.png'/>");
		});
		$(".slidebtn#previous").mouseleave(function(){
			$("#arrow1").attr("src","<c:url value='/images/main/arrow1_off.png'/>");
		});
		
// 		$("#menu2")
// 			.empty()
// 			.load("/ASTI/main/menu2.do");
// 		$("#menu3")
// 			.empty()
// 			.load("/ASTI/main/menu3.do");
// 		$("#sclimg")
// 			.empty()
// 			.load("/ASTI/main/scrollimg.do");
		$.ajax({
			  url: "/ASTI/main/menu2.do",
			   dataType:"html",
			  cache: false,
			  success: function(data){
				  $("#menu2").html(data);
			  }
		});

		$.ajax({
			  url: "/ASTI/main/menu3.do",
			   dataType:"html",
			  cache: false,
			  success: function(data){
				  $("#menu3").html(data);
			  }
		});

		$.ajax({
			  url: "/ASTI/main/scrollimg.do",
			   dataType:"html",
			  cache: false,
			  success: function(data){
				  $("#sclimg").html(data);
			  }
		});
		
		$("#slideindex")
			.empty()
			.load("/ASTI/main/slideindex.do?index="+$(".slideval:eq(0)").val());
		
// 			setTimeout(function() {
// 	   			$("#next").delay(5000).trigger('click');
// 	   			whiletrigger();
// 	   		}, 5000);
// 			function whiletrigger(){
// // 				$(this).delay(5000);
// // 				$("#next").delay(5000).trigger('click');
// 			}

		
	});
	function goDeptWorker(){
		location.href="<c:url value='/notif/notif.do?code=B05'/>";	
	}
	
// 	$("#next").focus(next);
	
// 	setTimeout(function(){$("div:eq(0)").hide();setTimeout(function(){$("div:eq(0)").show();}, 3000);}, 3000);
/* 	$(function(){
		setTimeout(slideAuto(), 3000);
	});
	function slideAuto(){
		$("div:eq(0)").prepend('test');
		setTimeout(slideAuto(), 3000);  
	} */
	function ChoiceImg(clkidx,nowidx){
		var idx=clkidx-nowidx;
		if(idx<0)
			idx +=Number('${length}');
		
		for(var i=0;i<idx;i++)
		{
			$( ".slideimg:eq(1)" ).removeClass('second').addClass('first').css("z-index","5").center( animate2 );
			$( ".slideimg:eq(2)" ).removeClass('second').addClass('second').css("z-index","2").right( animate2 );
			$( ".slideimg:last" ).removeClass('second').addClass('second').css("z-index","1").other( animate2 );
			$( ".slideimg:eq(0)" ).removeClass('first').addClass('second').css("z-index","3").left( animate2 ).appendTo( "#container" );
		}
		//이건 필요해. 찍을꺼니까.
		$("#slideindex")
		.load("/ASTI/main/slideindex.do?index="+$(".slideval:eq(0)").val());
		
	}
	function animate2( to ) {
		$( this ).stop( true, false ).animate( to );
	}
	
   	
	
	</script>
<div id="container">
<!-- 	<img src="images/earth.jpg" width="458" height="308" alt="earth"> -->
	<div style="width:984px;height:338px;float:left;">
		<div style="margin-top:140px;">	
			<div style="width:492px;height:80px;float:left;">
				<div class="slidebtn" id="previous"><img id="arrow1" src="<c:url value='/images/main/arrow1_off.png'/>"/></div>
			</div>
			<div style="width:492px;height:80px;float:left;">	
				<div class="slidebtn" id="next"><img id="arrow2" src="<c:url value='/images/main/arrow2_off.png'/>"/></div>
			</div>
		</div>
	</div>
	<div id="slideindex" style="margin-top:10px;width:982px;height:25px;float:left;text-align:center;">
		
	</div>
<%-- 		<c:forEach begin="0" end="7" varStatus="index" > --%>
<%-- 			<div id="b${index.count}" style="width:10px;height:30px;float:left;border:1px solid black;">${index.count}</div> --%>
<%-- 		</c:forEach> --%>
<%-- 	<div class="slideimg"><img src="<c:url value="/images/t1.jpg"/>"/></div> --%>
<%-- 	<div class="slideimg"><img src="<c:url value="/images/t2.jpg"/>"/></div> --%>
<%-- 	<div class="slideimg"><img src="<c:url value="/images/t3.jpg"/>"/></div>	 --%>
<%-- 	<div class="slideimg"><img src="<c:url value="/images/t4.jpg"/>"/></div> --%>
	
	<c:forEach var="d01" items="${d01 }" varStatus="d01cnt">
		<div class="slideimg">
			<input class="slideval" type="hidden" value="${d01cnt.count}"/>
			<img src="<c:url value="/pageImage/${d01.page_picture_id}"/>"/>
		</div>
	</c:forEach>
	
</div>
<div style="width:1024px;height:212.7px;overflow:hidden;">
	<div class="mainMenu1">
		<div class="menu1Image">
			<div style="float:left;width:295px;height:37px;">
				<div style="float:right;width:14px;height:14px;margin-right: 20px;margin-top: 14px;cursor: pointer;" onclick="goDeptWorker();"><img width="14px" height="14px" src="<c:url value='/images/main/more.gif'/>"/></div>
			</div>
			<div id="sclimg" class="menu1SlideImage">
			</div>




<!-- 	<h3 style="float: left">연구원 동정</h3><a style="float: right" href="/ASTI/notif/notif.do?code=B05"><h3>+</h3></a>	 -->
<!-- 		<div style="margin-left:10px;margin-top:10px;float:left;width:320px;height:180px;border:1px solid black"> -->
<%-- 			<c:forEach var="dept" items="${departmentImageList }" begin="0" end="0"> --%>
<%-- 				<img style="float: left" width="235" height="180" src="<c:url value="/departmentImage/${dept.file_id }"/>" > --%>
<%-- 			</c:forEach> --%>
<%-- 			<c:forEach var="dept" items="${departmentImageList }" begin="1" end="3"> --%>
<%-- 				<img style="margin-left:10px;float: left" width="75" height="60" src="<c:url value="/departmentImage/${dept.file_id }"/>" > --%>
<%-- 			</c:forEach> --%>
		</div>
	</div>
	
	<div class="mainMenu2" id="menu2"></div>
	<div class="mainMenu3" id="menu3"></div>
</div>
<!-- 	<a id="previous" href="#">Previous</a> -->
<!-- 	<a id="next" href="#">Next</a> --> 
