<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<style>
	.authDelete{
		border:0px;
		background:url("${cp }/images/button/delete_button_s.gif");
		width:45px;
		height:22px;
		cursor:pointer;
	}
	
	.ajaxSearchedUserListResultTr{
		cursor:pointer;
	}
</style>
<script>


/*사람 리스트를 가져오는 ajax*/
function ajaxSearchedUserList(){
	var searchName = $('.ajaxSearchedUserListSearchName').val();
	$.ajax({
		url:		'${cp}/SystemManage/getSearchedUserList.do',
		type:		'POST',
		dataType:	'json',
 		data: {
 			searchName:searchName
 		},
 		success:function(data){
 			
 			var table = $('.ajaxSearchedUserListResultTable');
 			
 			
 			table.empty();
 			var tt ="";
 			for(var i=0;i<data.length;i++){
	 			tt += "<tr gunbun='" + data[i].gunbun +"' "
	 				    + "sosokcode='" + data[i].sosokcode +"' "
	 				    + "rankname='" + data[i].rankname +"' "
	 				    + "sosok='" + data[i].intrasosokname + "' "
	 				    + "name='" + data[i].name + "' "
	 				    + "class='ajaxSearchedUserListResultTr'>";
	 			tt += "<td>" + data[i].intrasosokname + "</td>";
	 			tt += "<td>" + data[i].name + "</td>";
	 			tt += "<td>" + data[i].fullass + "</td>";
	 			tt += "</tr>";
 			}
 			table.html(tt);
 			
 			$('.ajaxSearchedUserListResultTr').click(ajaxSearchedUserListResultTrClick);
 		}
 		
	});
}

/*사람 리스트 화면에 뿌려주기*/
function ajaxSearchedUserListResultTrClick() {
	$('#sosokcode').val($(this).attr('sosokcode'));
	$('#sn').val($(this).attr('gunbun'));
	$('#sosok').val($(this).attr('sosok'));
	$('#name').val($(this).attr('name'));
	$('#insertForm').dialog('close');
}
 
/*관리자 추가*/
function insertAuthManage(){
	 confirm('확인창','추가하시겠습니까?',
		function() {
		 $.ajax({
				url:		'${cp}/SystemManage/insertAuthList.do',
				type:		'POST',
				dataType:	'json',
	 			data: {
	 				sosokcode : $('#sosokcode').val(),
	 				sn : $('#sn').val(),
	 				role_code : $('#role_code').val()
	 			},
				success : function() {
					document.location.reload();						
				},
				error : function() {
					alertMessage("알림", "해당자가 체계관련부대가 아닙니다.");
					document.location.reload();
				}
	 		});
		});
}

/*추가라인 나타나게*/
var insertForm;
$(function(){
	
	insertForm=createDialog('#insertForm','사람찾기',true,400,300);	
});
function addNewLine(){
	$("#newLine").fadeIn(500);
	insertForm.dialog('open');
}
/*관리자 삭제*/
function deleteAuthList(btn){
	var tr = $(btn).parent().parent();
	var sn = $(btn).attr("sn");
	if(sn == null){
		sn=0;
	}
	confirm('확인창',
			'삭제하시겠습니까?',
			function(){
				$.ajax({
					url:		'${cp}/SystemManage/deleteAuthList.do',
					type:		'POST',
					dataType:	'json',
					data: {
						sn : sn
					},
					success : function() {
						alert("삭제되었습니다.");
						tr.fadeOut(function() {
							tr.remove();
						});
					}
				});
			},
			function(){
				
			});
}


/* 대대별 검색 */
function searchAuthViewList(val){
	var squadron = val;
		/* alert(squadron); */
	$.ajax({
		url:		'${cp}/SystemManage/searchAuthViewList.do',
		type:		'POST',
		dataType:	'json',
			data: {
				sosokcode : squadron
			},
		success : function(data){
 			
 			$('.ajaxSearchAuthViewList').remove();
 			
 			
 			var table = $(".ajaxSearchAuthViewListContainer");
 			
 			var foot = table.html();
 			
 			var tt ="";
 			for (var i = 0; i < data.length; i++) {
 				var auth = data[i];
		 		tt += "<tr>";
		 		tt += "<td>" + auth.sosok + "</td>";
		 		tt += "<td>" + auth.name + "</td>";
		 		tt += "<td>" + auth.role_code +"</td>";
		 		tt += "<td ><input onclick='deleteAuthList(this)' class='authDelete' style='cursor: pointer;' type = 'button' id = 'authDelete' value ='' style='font-size:9pt' sn='" + auth.userid +"'/></td>";
		 		
		 		tt += "</tr>";
 			}
 			
 			table.html(tt/*  + foot */);
 				 					
		}
		});
		
}
	
	</script>
<img src="${cp }/images/title/authorityManage.gif" />
<div style="width: 100%;margin-top:10px;">
<img src="${cp }/images/dot.gif"/> 비행단/전대 &nbsp;
<select id="flightGroup" onChange="location.href='${cp }/SystemManage/authorityManage.do?flightGroupCode='+this.value">
	<c:forEach var="flightGroup" items="${flightGroupList}">
		<option value="${flightGroup.sosokcode }" <c:if test="${flightGroup.sosokcode eq flightGroupCode }">selected="selected"</c:if>>${flightGroup.fullass }</option>
	</c:forEach>
</select>
&nbsp;&nbsp;&nbsp;
<img src="${cp }/images/dot.gif"/> 대대 &nbsp;
<select id="squadron" onchange="searchAuthViewList(this.value)">
	<c:forEach var="squadron" items="${squadronList}">
		<option value="${squadron.sosokcode }" >${squadron.fullass }</option>
	</c:forEach>
</select>
</div>

<table id="resultListTable" border="1" style="width: 100%;margin-top:10px;">
	<thead>
		
		<th>대대</th>
		<th>계급/성명</th>
		<th>권한</th>
		<th style="width: 5%;"></th>
		</thead>
		<tbody class="ajaxSearchAuthViewListContainer">
			<c:forEach var="auth" items="${searchAuthViewList}">
				<tr class="ajaxSearchAuthViewList">
					<td>${auth.sosok } </td>
					<td>${auth.name }</td>
					<td>${auth.role_code }</td>
					<td><input type="button" class="authDelete"  onclick="deleteAuthList(this)" id = "authDelete" sn="${auth.userid }"/></td>
				</tr>
			</c:forEach>
		</tbody>
		<tbody>
			<tr id="newLine" style="display: none;">
			<td ><input readonly="readonly" onClick="insertForm.dialog('open')"  type = text size=40 id = "sosok"></td>
			<td ><input readonly="readonly" onClick="insertForm.dialog('open')" type = text size=15 id="name">
				 <input readonly="readonly" type = "hidden" size=15 id="sosokcode" >
				 <input readonly="readonly" type = "hidden" size=15 id="unit_code">
				 <input readonly="readonly" type = "hidden" size=15 id="sn">
			</td>
			<td >
			<select id="role_code" name="author" onchange=change(); >
					<option value="01" selected="selected">안전편대장</option>
					<option value="02">비행대대장/대장</option>
					<option value="03">단장/전대장</option>
					<option value="04">대대CQ</option>
					<option value="05">시스템관리자</option>
			</select>
			</td>
			<td><a href="javascript:insertAuthManage()"><img style="cursor: pointer;" src = "${cp }/images/button/add_button_s.gif" id = "authInsert" /></a></td>
		</tr>
		</tbody>
</table>
<br>
<a href="javascript:addNewLine()"><img id = "addNewLine" src="${cp }/images/button/addadmin_button.gif" align="right"/></a>


<div id="insertForm" class="dialog">
	<table style="border: 1px, solid;">
	<thead>
	<tr style="background-color: #C18C96;">
		<td colspan="2">이름 : 
		<input id="searchName" class = "ajaxSearchedUserListSearchName"/></td>
		<td>
			<a href="javascript:ajaxSearchedUserList()"><img id = "addNewLine" src="${cp }/images/button/search_button.gif" align="right"/></a>
		</td>
	</tr>	
	<tr style="width: 100%;">
				<th style="width: 50%;">소속</th>
				<th style="width: 20%;">계급/성명</th>
				<th style="width: 30%;">보직</th>
			</tr>
	</thead>
		<tbody class = "ajaxSearchedUserListResultTable">
		</tbody>

</table>
</div>