<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script language="javascript"> 
function openPop(page){
	var url = '<c:url value="/assignment/popup/';
	url += page+'.do"/>';
	alert(url);
	openPopup(url, 350, 300);
}

function goToAssignment(code){
	location.href="<c:url value='/assignment/detail.do?num='/>"+code;
}

function showSearchForm(){
	$('#SearchForm').removeClass('position_hide');
	$('#SearchForm').addClass('position_show');
}

function hideSearchForm(){
	$('#SearchForm').removeClass('position_show');
	$('#SearchForm').addClass('position_hide');
}

$(document).ready(function() {
	$('tbody tr').hover(function() {
		$(this).css('background', '#e0e0e0');
	}, function() {
		$(this).css('background', '#ffffff');
	});
});


</script>

<h1 class="page_sub_title_h1_promote_list"> ■ 벨트 조회</h1>
<!-- 
<ul class="assignment_register_menu_ul">
	<li>
		<a class="menu_search" onfocus="blur();" href="#" onclick="showSearchForm();">검색</a>
	</li>
	<li>
		<a class="menu_register" onfocus="blur();" href="assignRegister.do">등록</a>
	</li> -->
</ul>

<center>
	<div id="SearchForm">
		<table class="assignment_search" border="1" cellpadding="0" cellspacing="0" width="700">
			<thead>
			<tr height="30">
				<th width="90">성과타입</th>
				<td width="100">
					<select id="outcome_type">
					<option value>전체</option>
					<option value>재무</option>
					<option value>비재무</option>
					</select>
				</td>	
				<th width="80">과제급수</th>
				<td width="90">	
					<select id="project_grade">
					<option value>전체</option>
					<option value>Big-Y</option>
					<option value>BB</option>
					<option value>GB</option>
					<option value>SSS</option>
					</select>
				</td>
				<th width="80">과제분야</th>
				<td width="150">
					<select id="project_field">
					<option value>전체</option>
					<option value>조종</option>
					<option value>항공통제</option>
					<option value>방공포병</option>
					<option value>기상</option>
					<option value>정보통신</option>
					<option value>항공무기정비</option>
					<option value>보급수송</option>
					<option value>시설</option>
					<option value>관리</option>
					<option value>인사행정</option>
					<option value>정훈</option>
					<option value>교육</option>
					<option value>정보</option>
					<option value>헌병</option>
					<option value>법무</option>
					<option value>의무</option>
					</select>
				</th>
			</tr>
			<tr height="30">
					<th >과제유형 </th>
					<td width="130">
					<select id="project_type">
					<option value>전체</option>
					<option value>품질 개선</option>
					<option value>공정 개선</option>
					<option value>절차 개선</option>
					<option value>프로세스 개선</option>
					<option value>원가 절감</option>
					<option value>설계 변경</option>
					<option value>리드타임 단축</option>
					<option value>정비인시수 단축</option>
					</select>
				</td>
				<td>
					<select id="main_item">
						<option value>전체</option>
						<option value>이름</option>
						<option value>소속</option>
					</select>
				</td>
				<td colspan="2">
					<input type="text" size="20"/>
				</td>
				<td>
					<a href="#" onfocus="blur();">검색</a>
					<!--  <a href="#" onclick="hideSearchForm();" onfocus="blur();">취소</a> -->
				</td>
			</thead>
			<tfoot>

			</tfoot>
		</table>
		<br/>
	</div>
</center>

<center>
	<table class="assignment_list_table" border="1" cellpadding="0" cellspacing="0" height="300">
		<thead>
			<tr>
				<th style="width: 50px;">번호</th>
				<th style="width: 330px;">과제명</th>
				<th style="width: 70px;">분야</th>
				<th style="width: 110px;">과제리더</th>
				<th style="width: 80px;">진행단계</th>
				<th style="width: 110px;">최종수정일</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan="6" align="center">
					<a href="#" onfocus="blur();">처음</a>
					<a href="#" onfocus="blur();">이전</a>
	<%-- 				<c:forEach var="i" begin="${pagination.pageBegin}" end="${pagination.pageEnd}"> --%>
	<%-- 					<c:if test="${i == pagination.currentPage}"> --%>
	<%-- 						<strong>${i}</strong> --%>
	<%-- 					</c:if> --%>
	<%-- 					<c:if test="${i != pagination.currentPage}"> --%>
	<%-- 						<a class="pageLink" href="javascript:void(goToPage(${i}))" onfocus="blur();">${i}</a> --%>
	<%-- 					</c:if> --%>
	<%-- 				</c:forEach> --%>
					<a href="#" onfocus="blur();">다음</a>
					<a href="#" onfocus="blur();">끝</a>
				</td>
			</tr>
		</tfoot>
		<tbody>	
			<tr onclick="goToAssignment('A101');">
					<td style="width: 50px;">A101</td>
					<td style="width: 330px; text-align: left;">&nbsp;&nbsp;Test1</td>
					<td style="width: 70px;">기상</td>
					<td style="width: 110px;">중위 김지은</td>
					<td style="width: 80px;">I</td>
					<td style="width: 110px;">2012.06.04</td>
			</tr>
			<tr onclick="goToAssignment('A107');">
					<td style="width: 50px;">A107</td>
					<td style="width: 330px; text-align: left;">&nbsp;&nbsp;Test2</td>
					<td style="width: 70px;">정보</td>				
					<td style="width: 110px;">일병 정성모</td>
					<td style="width: 80px;">M</td>
					<td style="width: 110px;">2012.06.02</td>
			</tr>
			<c:forEach var="i" begin="1" end="6">
				<tr>
					<td style="width: 50px;">&nbsp;</td>
					<td style="width: 330px;">&nbsp;</td>
					<td style="width: 60px;">&nbsp;</td>
					<td style="width: 110px;">&nbsp;</td>
					<td style="width: 80px;">&nbsp;</td>
					<td style="width: 110px;">&nbsp;</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</center>