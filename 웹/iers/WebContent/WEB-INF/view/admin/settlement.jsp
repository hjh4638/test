<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일일결산</title>
<script>
function sumPeople(th){
	var td=th.parent().parent().find("td:last");
	var people=Number(th.val());
	var reserve=td.parent().find("select[name=settlement_reservation]");
	var accomo=Number(td.find("input[name=facilities_accommodation]").val());
	
	var type=td.find("input[name=facilities_section]").val();
	var price=Number(td.find("input[name=settlement_price]").val());
	var add_price = Number(td.find("input[name=settlement_add_price]").val());
	var sum_price = td.find("input[name=settlement_total_price]");
	
	if(type == "others"){
		sum_price.val(people*price);
	}
	else{
		var psum=0;
		if(people>accomo)
			psum=(people-accomo)*add_price;
		sum_price.val((price+psum)*Number(reserve.val()));
// 		sum_price.val("");
// 		reserve.val("0");
	}
}
function sumReserve(th){
	var td=th.parent().parent().find("td:last");
	var people=Number(td.parent().find("select[name=settlement_people_count]").val());
	
	
	var reserve=Number(th.val());
	var accomo=Number(td.find("input[name=facilities_accommodation]").val());
	
	var type=td.find("input[name=facilities_section]").val();
	var price=Number(td.find("input[name=settlement_price]").val());
	var add_price = Number(td.find("input[name=settlement_add_price]").val());
	var sum_price = td.find("input[name=settlement_total_price]");
	
	if(type!="others"){
		var psum=0;
		if(people>accomo)
			psum=(people-accomo)*add_price;
		sum_price.val((price+psum)*reserve);
	}
	
}
$(function(){
	$( "#settlementDate" ).datepicker(
			{
				dateFormat:"yy-mm-dd"
			}
	);
});

</script>

</head>
<body>
<div style="width:600px; margin:10px 0 20px 10px;">
	<a href="admin.do?type=appList"><span class="ico_sort concert2">예약현황조회</span></a>
  	<a href="admin.do?type=changeFacilites"><span class="ico_sort concert2">시설물 관리</span></a>
  	<a href="admin.do?type=memberManage"><span class="ico_sort concert2">회원 관리</span></a>
  	<a href="admin.do?type=reserveView"><span class="ico_sort concert2">잔여객실조회</span></a>
  	<a href="admin.do?type=settlement"><span class="ico_sort concert">일일결산</span></a>
  	<a href="admin.do?type=settlementView"><span class="ico_sort concert2">일일결산조회</span></a>
</div>
<form action="admin/settlement.do" method="post">
<table class="bbs_list">
	<tr>
		<th>시설 이름
		</th>
		<th>이용 요금
		</th>
		<th>추가요금
		</th>
		<th>사용인원
		</th>
		<th>사용일수
		</th>
		<th>요금 합
		</th>
	</tr>
	<c:forEach var="facilCode" items="${facilitiesCodeDTO}" varStatus="i">
		<tr>
			<td>${facilCode.facilities_name}
			</td>
			<td>${facilCode.facilities_price}
			</td>
			<td>${facilCode.facilities_add_price}
			</td>
			<td>
				<c:if test="${facilCode.facilities_max_accommodation ne null }">
					<select name="settlement_people_count" onchange="sumPeople($(this))">
						<c:forEach var="co" begin="0" end="${facilCode.facilities_max_accommodation }" varStatus="i">
						<option value="${i.index }">${i.index }명</option>
						</c:forEach>
				</select>
				</c:if>
			</td>
			<td>
				<c:if test="${facilCode.facilities_max_reservation ne null }">
					<select name="settlement_reservation" onchange="sumReserve($(this))">
						<c:forEach var="co" begin="0" end="${facilCode.facilities_max_reservation }" varStatus="i">
						<option value="${i.index }">${i.index }일</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${facilCode.facilities_max_reservation eq null }">
					<input type="hidden" name="settlement_reservation" value="">
				</c:if>
			</td>
			<td>
			<input type="hidden" name="facilities_id" value="${facilCode.facilities_id }">
			<input type="hidden" name="settlement_price" value="${facilCode.facilities_price }">
			<input type="hidden" name="settlement_add_price" value="${facilCode.facilities_add_price }">
			<input type="hidden" name="facilities_section" value="${facilCode.facilities_section }">
			<input type="hidden" name="facilities_accommodation" value="${facilCode.facilities_accommodation }">
			<input type="text" name="settlement_total_price" size="5" readonly="readonly">
			</td>
			
		</tr>
	</c:forEach>
</table>
<h6 class="memo">결산일 <input type="text" id="settlementDate" name="settle_date">
<span class="button medium"><button type="submit">등록</button></span></h6> 
</form>
</body>
</html>