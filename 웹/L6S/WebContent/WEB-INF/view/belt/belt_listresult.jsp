<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${beltVO.pagination }"/>

<script type="text/javascript"> 
	$(function(){
		//Dialog			
		$('#dialog').dialog({
			autoOpen: false,
			width: 500,
			buttons: {
				"Search": function() { 
					var form = document.forms["searchFilter"];
					form.submit();
					$(this).dialog("close"); 
				}, 
				"Cancel": function() { 
					$(this).dialog("close"); 
				} 
			}
		});
	
		// Dialog Link
		$('#dialog_link').click(function(){
			$('#dialog').dialog('open');
			return false;
		});
	});
</script>

<script type="text/javascript">
	function SearchDatum(){
		var form = document.forms["searchFilter"];
		form.page.value=1;
		form.submit();
	}

	function openPop(page){
		var url = '<c:url value="/belt/popup/';
		url += page+'.do"/>';
		alert(url);
		openPopup(url, 350, 300);
	}  
	
	function goToBelt(code){
		location.href="<c:url value='/belt/detail.do?num='/>"+code;
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
			$(this).css('background', '#f5f5f5');
		}, function() {
			$(this).css('background', '#ffffff');
		});
//		엔터키 누르면 조회 실행
		$("#searchFilter").keydown(function(event) {
			  if (event.keyCode == '13') {
				  SearchDatum();
			   }
			});
	});
	
	function showDetail(id){
	    axisX = event.clientX;
	    axisY = event.clientY + document.body.scrollTop;
	    var div = $('#detailCount_'+id);
		div.css("visibility","visible");
		div.css("left",axisX);
		div.css("top",axisY);
		
	    
	}
	function hideDetail(id){
		var div = $('#detailCount_'+id);
		div.css("visibility","hidden");
	}
	
	function BeltListExcel(){
		var url = '<c:url value="/belt/excel/beltListExcel.do"/>';	
		location.href=url;
	}
</script>

<%-- Page 처리 Script --%>
<script type="text/javascript">
/* <![CDATA[ */
var numPagesPerScreen = <c:out value='${pagination.numPagesPerScreen}'/>;
var page = <c:out value='${pagination.currentPage}'/>;
var numPages = <c:out value='${pagination.numPages}'/>;

function goToNextPages() {
	//일단 작동 되게
	goToPage(Math.min(numPages, page + 1));
// 	goToPage(Math.min(numPages, page + numPagesPerScreen));
}

function goToPage(page) {
	var input = document.getElementById('page');
	input.value = page;
	
	var form = document.forms['searchFilter'];
	form.submit();
}

function goToPreviousPages() {
	//일단 작동 되게
	goToPage(Math.max(1, page - 1));
// 	goToPage(Math.max(1, page - numPagesPerScreen));
}
/* ]]> */
</script>

<center>
	<h1 class="belt_list_title">벨트조회</h1>

	<br/>
	<form:form commandName="searchFilter" method="get" htmlEscape="true">
		<form:hidden path="page" value="${pagination.currentPage}" htmlEscape="true"/>
		<ul class="belt_search_menu">
			<li>
				<form:label path="searchBelt">벨트 등급</form:label>
				<form:select path="searchBelt" onfocus="blur();" cssClass="belt_select_belt_style">
					<form:option value="">전체</form:option>
					<form:option value="FEA">FEA</form:option>
					<form:option value="GB">GB</form:option>
					<form:option value="BB">BB</form:option>
					<form:option value="MBB">MBB</form:option>
				</form:select>
				<form:select path="searchBeltState" onfocus="blur();" cssClass="belt_sub_select_belt_style">
					<form:option value="">전체</form:option>
					<form:option value="1">미수료</form:option>
					<form:option value="3">수료완료</form:option>
					<form:option value="5">자격인증</form:option>
				</form:select>
			</li>
			<li>
				<form:label path="searchName" >이름</form:label>
				<form:input path="searchName" cssClass="belt_text_name_style" value="" />
			</li>
			<li>
				<form:label path="searchEduNum">교육 연도</form:label>
				<form:input path="searchEduNum" cssClass="belt_text_edunum_style" value=""/>
			</li>
			<li>
				<form:label path="searchSosok">소속</form:label>
				<form:input path="searchSosok" cssClass="belt_text_sosok_style" value=""/>
			</li>
			<li>
				<a class="menu_search" onfocus="blur();" href="#" onclick="javascript:SearchDatum();">
				<img src="<c:url value="/images/button/search2.gif"/>">
				</a>
			</li>
			<c:if test="${user.authority eq 'A'}">
				<li>
					<a class="menu_excel" onfocus="blur();" href="#" onclick="BeltListExcel();">
					<img src="<c:url value="/images/button/excel.gif"/>">
					</a>
					
				</li>
			</c:if>
		</ul>
	</form:form>
	
<!-- 	<br> -->
	<c:choose>
		<c:when test="${(searchFilter.searchBelt!=''||searchFilter.searchBeltState!=''||searchFilter.searchName!=''
					||searchFilter.searchEduNum!=''||searchFilter.searchSosok!='')&&
					(searchFilter.searchBelt!=null||searchFilter.searchBeltState!=null||searchFilter.searchName!=null
					||searchFilter.searchEduNum!=null||searchFilter.searchSosok!=null)}">
<%-- 					${beltListSize}개의 항목이 검색되었습니다. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
			"<b><c:out value="${searchFilter.searchBelt}"/>
			<c:choose>
				<c:when test="${searchFilter.searchBeltState==1}">
					<c:out value="미수료"/>
				</c:when>
				<c:when test="${searchFilter.searchBeltState==3}">
					<c:out value="수료완료"/>
				</c:when>
				<c:when test="${searchFilter.searchBeltState==5}">
					<c:out value="자격인증"/>
				</c:when>
				<c:otherwise>
					<c:out value=""/>
				</c:otherwise>
			</c:choose>
			<c:out value="${searchFilter.searchName}"/>
			<c:if test="${searchFilter.searchEduNum!=''&&searchFilter.searchEduNum!=null}">
				<c:out value="${searchFilter.searchEduNum}"/>년
			</c:if>
			<c:out value="${searchFilter.searchSosok}"/></b>에 대한 검색결과입니다. "
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	<table class="belt_table" >
		<thead>
			<tr>
				<th style="width: 6%;">번호 </th>
				<th style="width: 11%;">이름</th>
				<th style="width: 11%;">계급</th>
				<th style="width: 45%;">소속</th>
<!-- 				<th style="width: 11%;">최종 벨트 <br>수료/자격</th> -->
				<th style="width: 13%;">최종 인증벨트</th>
				<th style="width: 13%;">등록된 과제 </th>
			</tr>
		</thead>
		
		<tfoot>
			<tr>
				<td colspan="6">
					<a href="javascript:void(goToPage(1))" onfocus="blur();">처음</a>
					<a href="javascript:void(goToPreviousPages())" onfocus="blur();">이전</a>
					<c:forEach var="i" begin="${pagination.pageBegin}" end="${pagination.pageEnd}">
						<c:if test="${i == pagination.currentPage}">
							<strong>${i}</strong>
						</c:if>
						<c:if test="${i != pagination.currentPage}">
							<a class="pageLink" href="javascript:void(goToPage(${i}))" onfocus="blur();">${i}</a>
						</c:if>
					</c:forEach>
					<a href="javascript:void(goToNextPages())" onfocus="blur();">다음</a>
					<a href="javascript:void(goToPage(${pagination.numPages}))" onfocus="blur();">끝</a>
				</td>
			</tr>
		</tfoot>
		
		<tbody>	
			<c:forEach var="beltList" items="${beltList}" varStatus="loop">
				<tr style="cursor:default;" onclick="goToBelt('${beltList.pn}');">
					<td> <c:out value="${(pagination.currentPage - 1) * pagination.numItemsPerPage + loop.count}"/> </td>
					<td> <c:out value="${beltList.name}"/> </td>
					<td> <c:out value="${beltList.rank}"/> </td>
					<td> <c:out value="${beltList.sosokName}"/> </td>
					<c:choose>
						<c:when test="${beltList.repreBelt eq 'No Belt'}">
							<c:choose>
								<c:when test="${beltList.sn eq user.sn}">
									<td><a href="<c:url value='beltRegister.do'/>" onfocus="blur();"><c:out value="${beltList.repreBelt}"/></a></td>
								</c:when>
								<c:otherwise>
									<td> <c:out value="${beltList.repreBelt}"/> </td>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${beltList.condition eq 1}">
									<c:if test="${beltList.stateCondition eq 1}">
										<td>
											<font color="RED">
											 	<b> <c:out value="${beltList.repreBelt}"/> </b>
										 	</font> 
<%-- 											 <c:if test="${searchFilter.searchBelt == '' }"> --%>
<!-- 											 	/ (-) -->
<%-- 											 </c:if>  --%>
										</td>
									</c:if>		
									<c:if test="${beltList.stateCondition eq 2}">
										<td>
											<font color="BLUE">
												<b> <c:out value="${beltList.repreBelt}"/> </b>
											</font>
<%-- 											 <c:if test="${searchFilter.searchBelt == '' }"> --%>
<!-- 											 	/ (-) -->
<%-- 											 </c:if>  --%>
										</td>
										
									</c:if>		
								</c:when>
								<c:otherwise>
									<td>
										<B><c:out value="${beltList.repreBelt}"/></B>
<%-- 										 <c:if test="${searchFilter.searchBelt == '' }"> --%>
<!-- 										 	/ (-) -->
<%-- 										 </c:if>  --%>
									</td>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>	
					<td>
						<a onmouseover="javascript:showDetail('${loop.count}')" onmouseout="javascript:hideDetail('${loop.count}')">
							<c:out value="${beltList.subjectCount}" />
						</a>
						<div id="detailCount_${loop.count}" class="detail_">
							<table>	
								<c:forEach items="${beltList.subject}" var="subject" varStatus="Num">
									<tr> 
										<th>
											${Num.count}
										</th>
										<td>
											<c:out value="${subject}"/>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>						
					</td>			
				</tr>
			</c:forEach>
			<c:forEach var="i" begin="1" end="${10-beltListSize}">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
<!-- 	<div style="width: 718px; border: 2px solid black; padding: 3px; margin-top: 3px;"> -->
		<b>BELT</b> : 보유 하고 있는 최고 벨트 등급&nbsp;&nbsp;&nbsp; 
		<b><font color="red">BELT</font></b> : 수료 인증을 받기 전 상태&nbsp;&nbsp;&nbsp;
		<b><font color="blue">BELT</font></b> : 자격 인증을 받기 전 상태<br />
		(단, <b><font color="red">BELT</font></b> <b><font color="blue" >BELT</font></b>는 벨트 미 보유자에게만 적용)
<!-- 	</div> -->
</center>



