<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-1.8.2.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery.validate.min.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.9.1.custom.min.js'/>"></script> --%>
<script src="<c:url value='/js/board/insert.js'/>"></script>
<style>

#insert{
	width: 500px;
	height: 400px;
}
#insert,.ttr,.tth,.ttd{
	border: 1px solid #cccccc;
	border-collapse: collapse;
	border-spacing: 0;
}
.tth{
	background:#f7f7f7;
	color:#2159b0;
}

</style>
<script> 
$(function(){
	$("#board_register_date").datepicker({
		dateFormat : 'yy/mm/dd', 
		changeMonth: true,
		changeYear: true,
		yearRange: "c-100:c",
		showOn: "both",
		showAnim: '',
		duration: '', 
		buttonImage: "<c:url value="/images/calender.gif"/>",
		buttonImageOnly: true,
		numberOfMonths: 1,
		onClose: function(selectedDate){
			$("#board_register_date").datepicker("option", "minDate", selectedDate);
		}
	});
// 	$("#astiBoardDTO").validate({
// 		rules:{
// 			board_writer :{
// 				required: true
// 			},
// 			board_title : {
// 				required: true,
// 				maxlength: 100
// 			},
// 			board_register_date:{
// 				required: true
// 			},
// 			board_content: {
// 				required: true,
// 				maxlength: 2000
// 			}
// 		},
// 		messages:{
// 			board_writer :{
// 				required:"이름을 입력해주세요."
// 			},
// 			board_title: {
// 				required: "제목을 입력해주세요.",
// 				maxlength: "100자를 초과하였습니다."
// 			},
// 			board_register_date: {
// 				required:"날짜를 입력해주세요."
// 			},
// 			board_content: {
// 				required: "내용을 입력해주세요.",
// 				maxlength: "2000자를 초과하였습니다."
// 			}
// 		}
// 	});
});

function Binsert(){
	$("#astiBoardDTO").submit();
}

</script>

<%-- <h1 style="margin-top:10px;font-size: 72px;">${boardSign }</h1>  --%>
<jsp:useBean id="now" class="java.util.Date"/>


<!-- 로그인한 사람이 입력시 -->
<form:form commandName="astiBoardDTO" method="post" action="/ASTI/board/insert.do" enctype="multipart/form-data"> 
<table id="insert" class="freeBoardTable">
	<tr class="ttr">
		<th class="tth">
			<c:choose>
				<c:when test="${param.board_type eq 'B08' }">
				언론사
				</c:when>
				<c:otherwise>
				저자
				</c:otherwise>
			</c:choose>
		</th>
		<td id="ttd">
		<form:input readonly="readonly" value="${USERINFO.user_name}" path="board_writer"/>
		<form:errors path="board_writer"/>
		<form:hidden path="user_id" value="${USERINFO.user_id}"/>
		<form:hidden path="board_type" value="${param.board_type}"/>
		<form:hidden path="board_id" value="${param.board_id}"/>
		<input type="hidden" name="insertUrl" value="${nowUrl }"/>
		</td>
		<th class="tth">
			권한
		</th>
		<td class="ttd">
		<form:select path="board_authority">
			<c:forEach var="authority" items="${authorityList }">
				<form:option value="${authority.code_id }">${authority.code_name }</form:option>
			</c:forEach>
		</form:select>
		</td>		
	</tr>
	<tr id="ttr">
	<c:choose>
		<c:when test="${param.board_type eq 'B00' or
					  param.board_type eq 'B01' or
					  param.board_type eq 'B02' or
					  param.board_type eq 'B03' }">
			<th class="tth">
			제목
			</th>
			<td class="ttd" >
				<form:input path="board_title"/>
				<form:errors path="board_title"/>
			</td>
			<th class="tth">
			 발행일
			</th>
			<td class="ttd"> 
			<form:input path="board_register_date"/>
			<form:errors path="board_register_date"/>
			</td>
		</c:when>
		<c:otherwise>
			<th class="tth">
			제목
			</th>
			<td colspan="3" id="ttd" >
				<form:input path="board_title"/>
				<form:errors path="board_title"/>
				<input type="hidden" name="board_register_date" value="<fmt:formatDate value="${now }" type="both" pattern="yyyy/MM/dd"/>"/>
			</td>
		</c:otherwise> 
	</c:choose>
	</tr>
	<tr class="ttr">
		<td colspan="4" class="ttd" >
			<form:textarea rows="20" cols="80" path="board_content"></form:textarea>	
			<form:errors path="board_content"/>	
		</td>
	</tr>
	<tr class="ttr">
		<td colspan="4" class="ttd">
			<c:forEach var="file" items="${boardFile }" varStatus="i">
				<p>기존파일 ${i.index+1}: <c:out value="${file.filename }"/></p>
			</c:forEach>
			<a href="javascript:fileappend()"><img src="<c:url value='/images/btn/btn_04.gif'/>"></a>
			<a href="javascript:fileDelete()"><img src="<c:url value='/images/btn/btn_04_0320.gif'/>"></a>
			<div id="fileDiv">
			파일첨부:
			<p><input type="file" id="file" name="file"></p>
			</div>
		</td>
	</tr>
</table>
<c:if test="${USERINFO.user_id eq '' or USERINFO.user_id eq null}">
	비밀번호 : <input type="password" name="board_password">
</c:if>
<a onclick="Binsert()"><img src="<c:url value='/images/btn/btn_02_0320.gif'/>"></a>
<!-- <input type="button" value="입력" onclick="submit()"> -->
</form:form>