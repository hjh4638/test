<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시설물관리</title>
<script language="javascript">
	function table(tab){
		this.tab=tab;
		this.trLength=this.tab.children().children().length;
	}

	//'<input type="button" value="수정">'+
	//'<input type="button" value="삭제">'+
	function addLine(){
		var t = new table($("#facilTable"));
		var newline='<tr>'+
						'<td>'+(t.trLength)+'</td>'+
						'<td><input type="text"></td>'+
						'<td><input type="text"></td>'+
						'<td>'+
							'<span class="button medium"><button type="button">수정</button></span>'+
							'<span class="button medium"><button type="button">삭제</button></span>'+
						'</td>'+
					'</tr>';
		t.tab.children().append(newline);
	}
	function edit(i){
// 		int a = i;
		var line = $('input[f_id=facility'+i+']');
		var text = $('a[id=facil_text'+i+']');
		var edi = $('a[id=edi]');
		var sub = $('input[id=sub]');
		$(line).css("display","inline");
		$(line).css("width","80px");
		$(text).css("display","none");
		$(edi).css("display","none");
		$(sub).css("display","inline");
	}

	function del(id){
		
		$("#facil_id").attr("value", id);
		$("#facil")
		.attr("action", "admin/changeFacilitesd.do")
		.submit();

		
	}
	function showSettle(){
		$("#facilDiv").hide();
		$("#settleDiv").show();
	}
	function showFacil(){
		$("#settleDiv").hide();
		$("#facilDiv").show();
	}
	function updateFacil(id,th,section){
		var tr=th.parent().parent().parent().parent();
				
		$("#facilities_type_name").val(tr.find("td:eq(1)").attr("att"));
		$("#facilities_area").val(tr.find("td:eq(2)").attr("att"));
		$("#facilities_accommodation").val(tr.find("td:eq(3)").attr("att"));
		$("#facilities_max_accommodation").val(tr.find("td:eq(4)").attr("att"));
		$("#facilities_max_reservation").val(tr.find("td:eq(5)").attr("att"));
		$("#facilities_price").val(tr.find("td:eq(6)").attr("att"));
		$("#facilities_add_price").val(tr.find("td:eq(7)").attr("att"));
		$("#facilities_section").val(section);
		$("#facilities_type").val(id);
		
		$("#facilInputDiv").show();
	}
	function addFacil(){
		$("#facilities_type_name").val("");
		$("#facilities_area").val("");
		$("#facilities_accommodation").val("");
		$("#facilities_max_accommodation").val("");
		$("#facilities_max_reservation").val("");
		$("#facilities_price").val("");
		$("#facilities_add_price").val("");
		$("#facilities_section").val("");
		$("#facilities_type").val("");
		
		$("#facilInputDiv").show();
	}
	function exitFacilInput(){
		$("#facilInputDiv").hide();
	}	
</script>
</head>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert2">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert2">일일결산조회</span></a>
</div>
<span class="button medium"><button type="button" onclick="showFacil();">시설관리</button></span>
<span class="button medium"><button type="button" onclick="showSettle();">일일결산 항목관리</button></span>
<div id="facilDiv">
<table class="bbs_list">
<tr>
	<th>순번</th>
	<th>타입</th>
	<th>면적</th>
	<th>인원</th>
	<th>최대인원</th>
	<th>최대 예약일</th>
	<th>가격</th>
	<th>추가요금</th>
	<th></th>
</tr>
<c:forEach var="li" items="${fCodeList }" varStatus="i">
	<tr>
	<td>${i.index+1 }</td>
	<td att="${li.facilities_type_name }">${li.facilities_type_name }</td>
	<td att="${li.facilities_area }">${li.facilities_area }</td>
	<td att="${li.facilities_accommodation }">${li.facilities_accommodation }</td>
	<td att="${li.facilities_max_accommodation }">${li.facilities_max_accommodation }</td>
	<td att="${li.facilities_max_reservation  }">${li.facilities_max_reservation }</td>
	<td att="${li.facilities_price }">${li.facilities_price }</td>
	<td att="${li.facilities_add_price }">${li.facilities_add_price }</td>
	<td>
		<form action="admin/changeFacilitesCodeDelete.do" method="post">
			<input type="hidden" name="type" value="${li.facilities_type }">
			<span class="button medium"><button type="submit">삭제</button></span>
			<span class="button medium"><button type="button" onclick="updateFacil('${li.facilities_type}',$(this),'${li.facilities_section }')">수정</button></span>
		</form>
	</td>
	</tr>
</c:forEach>
</table>
<span class="button medium"><button type="button" onclick="addFacil();">추가</button></span>
<span class="button medium"><button type="button" onclick="exitFacilInput();">취소</button></span>

<form id="facilInput" action="admin/changeFacilitesCode.do" method="post">
	<div id="facilInputDiv" style="display: none;">
	<table class="bbs_list" >
	<tr>
		<th>시설종류명</th>
		<td><input type="text" name="facilities_type_name" id="facilities_type_name"></td>
	</tr>
	<tr>
		<th>시설종류</th>
		<td>
			<select name="facilities_section" id="facilities_section">
				<option value=""></option>
				<option value="normal">일반객실</option>
				<option value="admin">관리자 전용 객실</option>
				<option value="others">객실이외</option>
			</select>
		</td>
	</tr>	
	<tr>
		<th>면적</th>
		<td><input type="text" name="facilities_area" id="facilities_area"></td>
	</tr>
	<tr>
		<th>인원</th>
		<td>
			<select name="facilities_accommodation" id="facilities_accommodation">
				<option value=""></option>
				<c:forEach begin="1" end="100" varStatus="i">
					<option value="${i.index }">${i.index }명</option>	
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th>최대인원</th>
		<td>
			<select name="facilities_max_accommodation" id="facilities_max_accommodation">
				<option value=""></option>
				<c:forEach begin="1" end="100" varStatus="i">
					<option value="${i.index }">${i.index }명</option>	
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th>최대 예약일</th>
		<td>
			<select name="facilities_max_reservation" id="facilities_max_reservation">
				<option value=""></option>
				<c:forEach begin="1" end="100" varStatus="i">
					<option value="${i.index }">${i.index }일</option>	
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th>가격</th>
		<td>
			<select name="facilities_price" id="facilities_price">
				<option value=""></option>
				<c:forEach step="1000" begin="1000" end="100000" varStatus="i">
					<option value="${i.index }">${i.index }원</option>	
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>	
		<th>추가요금</th>
		<td>
			<select name="facilities_add_price" id="facilities_add_price">
				<option value=""></option>
				<c:forEach step="1000" begin="1000" end="100000" varStatus="i">
					<option value="${i.index }">${i.index }원</option>	
				</c:forEach>
			</select>
		</td>
	</tr>
	</table>
	<input type="hidden" name="facilities_type" id="facilities_type">
	
	<span class="button medium"><button type="submit">생성</button></span>
	</div>
</form>
</div>

<div id="settleDiv" style="display: none;">
<table class="bbs_list">
<tr>
	<th>순번</th>
	<th>시설명</th>
	<th>타입</th>
	<th>
<!-- 		<input type="button" value="추가" onclick="addLine()"> -->
	</th>
</tr>
	
	<c:forEach var="flist" items="${facilitiesList}" varStatus="i">
	<form:form id="facil" action="admin/changeFacilites.do" method="POST" commandName="vacationFacilitiesDTO" >
		<tr>
			<td>${i.index+1 }</td>
			<td>
				<form:input f_id="facility${i.index+1 }" type="text" path="facilities_name"value="${flist.facilities_name }"  style="display:none;"/>
				<a id="facil_text${i.index+1}">${flist.facilities_name }</a>
			</td>
<!-- 			<td> -->
<%-- 				<form:input f_id="facility${i.index+1 }" type="text" path="facilities_note"value="${flist.facilities_note }" style="display:none;"/> --%>
<%-- 				<a id="facil_text${i.index+1}">${flist.facilities_note }</a> --%>
<!-- 			</td> -->
			<td>
<%-- 				<form:input f_id="facility${i.index+1 }" type="text" path="facilities_type"value="${flist.facilities_type }" style="display:none;"/> --%>
				<a id="facil_text${i.index+1}">${flist.facilities_type_name }</a>
			</td>
			<td>
<%-- 				<a id="edi" href="#" onclick="javascript:edit('${i.index+1}')">수정</a> --%>
				<form:hidden id="facil_id" path="facilities_id" value="${flist.facilities_id}"/>
				
				<span id="sub" style="display:none;">
				<span class="button medium"><button type="submit">추가</button></span>
				</span>
				<span class="button medium"><button type="button" onclick="javascript:del('${flist.facilities_id}');">삭제</button></span>
			</td>
		</tr>
	</form:form>
	</c:forEach>
</table>
<form:form action="admin/changeFacilites.do" method="POST" commandName="vacationFacilitiesDTO" >
	<h6 class="memo">시설명 : <form:input path="facilities_name"/>
	<form:select path="facilities_type">
		<c:forEach var="li" items="${fCodeList }">
			<form:option value="${li.facilities_type}">${li.facilities_type_name }</form:option>
		</c:forEach>
	</form:select></h6>
	<span id="sub" >
		<span class="button medium"><button type="submit">추가</button></span>
	</span>
</form:form>
</div>

</body>
</html>