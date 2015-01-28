<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!-- 안내자료 삽입 연습 이의준 --> 
 <script>
 	$(function(){ 
		$('#tabs').tabs(); 
	}); 
 	
 	function loadDATA(data){
 		$("div#"+data).css('display','block');
 	}
</script> 

<center>
	<h1 class="Lean6SigmaIntro_TITLE">린6시그마 소개</h1>
	
	<div id="tabs" style="width: 715px; height: 475px; border-collapse: collapse;
		border-spacing: 0px; border: 0px; margin-left: 10px;">
		<ul>
			<li><a href="#tabs-1" onclick="loadDATA('tabs-1')"><font color="white">6시그마 소개</font></a></li>
			<li><a href="#tabs-2" onclick="loadDATA('tabs-2')"><font color="white">린 소개</font></a></li>
			<li><a href="#tabs-3" onclick="loadDATA('tabs-3')"><font color="white">스피디6시그마 소개</font></a></li>
		</ul>
	
		<div id="tabs-1">
			<object type="application/pdf" data="../attachment/pdf/6sigma.pdf" 
					style="width: 715px; height: 430px;
				 	border-collapse: collapse; border-spacing: 0px; margin-left: -17px; margin-top: -13px;">
			</object>
		</div>
		<div id="tabs-2" style="display: none;">
			<object type="application/pdf" data="../attachment/pdf/lean.pdf" 
					style="width: 715px; height: 430px;
				 	border-collapse: collapse; border-spacing: 0px; margin-left: -17px; margin-top: -12px;">
			</object>
		</div>
		<div id="tabs-3" style="display: none;">
			<object type="application/pdf" data="../attachment/pdf/s6s.pdf"
					style="width: 715px; height: 430px;
				 	border-collapse: collapse; border-spacing: 0px; margin-left: -17px; margin-top: -12px;">
			</object>
		</div>
	</div>
</center>

