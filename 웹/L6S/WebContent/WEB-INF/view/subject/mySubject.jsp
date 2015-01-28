<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagination" value="${subjectData.pagination }"/>
<jsp:include page="subjectRegister_js.jsp"></jsp:include>
<style>

.select_bgcolor{
	background-color: #f8f9fb;
}
</style>
<script>
function gotoDetail(th){
	var seq=$(th).attr("seq");
	location.href="<c:url value="detailSubjectList.do"/>?seq="+seq;
}
function selectThis(th){
	$("tr").removeClass("select_bgcolor");
	$(th).addClass("select_bgcolor");
// 	$("th").css("color","#008bc8");
	
}
function openApproval(th){
		openPopup("<c:url value="/approval_line/popup/approvalProcessing.do"/>?seq="+th,750,500);
}
</script>

<!-- Page 처리 Script -->
<script type="text/javascript">
/* <![CDATA[ */
var numPagesPerScreen = <c:out value='${pagination.numPagesPerScreen}'/>;
var page = <c:out value='${pagination.currentPage}'/>;
var numPages = <c:out value='${pagination.numPages}'/>;

function goToNextPages() {
	goToPage(Math.min(numPages, page + numPagesPerScreen));
}

function goToPage(page) {
	var input = document.getElementById('page');
	input.value = page;
	
	var form = document.forms['subjectData'];
	form.submit();
}

function goToPreviousPages() {
	goToPage(Math.max(1, page - numPagesPerScreen));
}
function wantToReturn(seq){
	$.ajax({url:		'<c:url value="/ajax/getNowAppStep.do"/>',type:'POST',dataType:	'json',
 		data: {seq:seq},
 		success:function(data){
 			var availToReturn = data;
		if(availToReturn == 'Y'){
			$("input.returnSeq").val(seq);
			ans = confirm("정말로 회수하시겠습니까?");
			if(ans ==true)
				$("form.returnApp").submit();
		}
		else if(availToReturn == 'N') 
			alert("부대장 결재가 끝났으므로 회수가 불가능합니다.");
 		}
	});
	
}		
function updateUserSubmit(){
	$("#userUpdateForm").submit();
}
function getSubjectUser(th){
	$("#sub_user_form").submit();
}
/* ]]> */
</script>
<form class="returnApp" action = "<c:url value="/approval_line/returnSubject.do"/>" method="POST">
	<input class="returnSeq" type="hidden" value="" name="seq">
</form>
<center>
	<h1 class="mysubject">내 과제 관리</h1>
	<form:form commandName="subjectData" method="get" htmlEscape="true">
	<form:hidden path="page" value="${pagination.currentPage}" htmlEscape="true"/>
	<br>
 	<img align="left" style="margin-left:40px;" src="../images/assignment/subjlist.gif">
 	<br> 	
		<table class="beltRegister_table">
			<tr bgcolor="#f7f7f7">
				<th width="39%">과제명</th>
				<th width="12%">분야</th>
				<th width="15%">과제리더</th>
				<th width="12%">등록일</th>
				<th width="11%">결재현황</th>
				<th width="11%">과제회수	</th>
			</tr>
			<c:forEach var="msubject" items="${mySubject }">
			<tr  style="cursor:default;" OnMouseOver="selectThis(this)">
				<td seq="${msubject.subject_code }" onclick="gotoDetail(this)"><c:out value="${msubject.project_name }"/></td>
				<td seq="${msubject.subject_code }" onclick="gotoDetail(this)">${msubject.field_type }</td>
				<td seq="${msubject.subject_code }" onclick="gotoDetail(this)">${msubject.leader }</td>
				<td seq="${msubject.subject_code }" onclick="gotoDetail(this)">${msubject.register_day }</td>
				<td>
					<input type="image" src="<c:url value="/images/button/check.gif"/>" onclick="openApproval(${msubject.subject_code})">
				</td>
				<td>
<%-- 					<c:choose> --%>
						<c:if test="${msubject.sn eq login.sn }">
							<a class="detail_menu_withdrawal" href="#" onclick="wantToReturn(${msubject.subject_code})"><img src="<c:url value="/images/button/btn_back.gif"/>"></a>
						</c:if>
<%-- 						<c:otherwise> --%>
<!-- 							[회수]  -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 					<input type="button" value="회수" onclick="wantToReturn(${msubject.subject_code})"> --%>
				</td>
			</tr>	
			</c:forEach>
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
		</table>
	</form:form> 
	<br>
	<br>
	<img align="left" style="margin-left:40px;" src="../images/assignment/teamperson.gif">
	<br>
	<form id="sub_user_form" action="<c:url value="/subject/mySubject.do"/>" method="get">
		<select style="float:right; margin-right:40px;" onchange="getSubjectUser(this)" name="seq">
			<option value="">과제명</option>
				<c:forEach var="msubject" items="${mySubject }">
					<option 
					<c:if test="${param.seq eq msubject.subject_code}">selected</c:if>
					 value="${msubject.subject_code }">
					 <c:out value="${msubject.project_name }"/>
					</option>
				</c:forEach>
		</select>
	</form>
	
	<c:if test="${subject_user[0].sn eq login.sn }">
		<form id="userUpdateForm" action="<c:url value="/subject/updateUser.do"/>" method="POST">
			<input type="hidden" name="seq" value="${param.seq }">
			<table class="myTeam_table">
				<tr id="test" bgcolor="#f7f7f7">
					<th colspan="6" align="center">팀구성</th>
				</tr>
				<tr bgcolor="#f7f7f7">
					<th width="20%" align="center">성명</th>
					<th width="17%" align="center">군번</th>
					<th width="30%" align="center">부서</th>
					<th width="20%" align="center">역할</th>
					<th width="13%">
					<!-- 추가버튼 -->
					<a href="#" onclick="attachRow()" onfocus="blur();">
						<img src="<c:url value="/images/button/add.gif"/>">
					</a>
					</th>
				</tr>
				<c:if test="${param.seq ne ''}">
					<tr class="standardRow" id="2">
							<td><input id="2name" value="${subject_user[0].name }" name="name" type="text" maxlength="11" size="13" class="readonly"></td>
							<td><input id="2sn" value="${subject_user[0].sn }" name="sn" type="text" maxlength="11" size="12" class="readonly"></td>
							<td><input id="2department" value="${subject_user[0].department }" name="department" type="text" maxlength="50" size="40" class="readonly"></td>
							<td><input name="role_name" type="text" maxlength="25" size="20" value="${subject_user[0].role_name }" class="readonly">
								<input name="is_leader" type="hidden" value="${subject_user[0].is_leader }">
							</td>
							<td>
								<!-- 입력버튼 -->
<!-- 								<a href="#" onclick="openSearchUser(this)"> -->
<%-- 									<img src="<c:url value="/images/button/insert.gif"/>"> --%>
<!-- 								</a> -->
							</td>
					</tr>
				</c:if>
				<c:forEach var="user" items="${subject_user }" begin="1" varStatus="i">
					<tr class="standardRow" id="${i.index+2 }">
						<td><input id="${i.index+2}name" value="${user.name }" name="name" type="text" maxlength="11" size="13" class="readonly"></td>
						<td><input id="${i.index+2}sn" value="${user.sn }" name="sn" type="text" maxlength="11" size="12" class="readonly"></td>
						<td><input id="${i.index+2}department" value="${user.department }" name="department" type="text" maxlength="50" size="40" class="readonly"></td>
						<td><input name="role_name" type="text" maxlength="25" size="20" value="${user.role_name }">
							<input name="is_leader" type="hidden" value="${user.is_leader }">
						</td>
						<td class="deleteCollection">
							<!-- 입력버튼 -->
							<a href="#" onclick="openSearchUser(this)" onfocus="blur();">
								<img src="<c:url value="/images/button/insert.gif"/>">
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<a href="#" onclick="updateUserSubmit()" onfocus="blur();">
				<img src="<c:url value="/images/button/register.gif"/>">
			</a>
		</form>
	</c:if>
	<c:if test="${subject_user[0].sn ne login.sn }">
		<table class="myTeam_table">
			<tr id="test" bgcolor="#f7f7f7">
				<th colspan="6" align="center">팀구성</th>
			</tr>
			<tr bgcolor="#f7f7f7">
					<th width="20%" align="center">성명</th>
					<th width="17%" align="center">군번</th>
					<th width="43%" align="center">부서</th>
					<th width="20%" align="center">역할</th>
			</tr>
			<c:forEach var="user" items="${subject_user }" varStatus="i">
				<tr class="standardRow" id="${i.index+2 }">
					<td><input id="${i.index+2}name" value="${user.name }" name="name" type="text" maxlength="11" size="13" class="readonly"></td>
					<td><input id="${i.index+2}sn" value="${user.sn }" name="sn" type="text" maxlength="11" size="12" class="readonly"></td>
					<td><input id="${i.index+2}department" value="${user.department }" name="department" type="text" maxlength="50" size="40" class="readonly"></td>
					<td><input name="role_name" type="text" maxlength="25" size="20" value="${user.role_name }" class="readonly">
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	<table style="display:none;">
		<tr class="attachment">
			<td><input id="name" type="text" maxlength="11" size="13" class="readonly"></td>
			<td><input id="sn" type="text" maxlength="11" size="12" class="readonly"></td>
			<td><input id="department" type="text" maxlength="50" size="40" class="readonly"></td>
			<td>
				<input name="role_name" type="text" maxlength="25" size="20">
				<input name="is_leader" type="hidden" value="">
			</td>
			<td class="deleteCollection">
				<!-- 입력버튼 -->
				<a href="#" onclick="openSearchUser(this)" onfocus="blur();">
					<img src="<c:url value="/images/button/insert.gif"/>">
				</a>
			</td>
		</tr>
	</table>
</center>