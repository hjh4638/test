<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����</title>
<script>
$(function() {
	$( "#reservation_day" ).datepicker(
			{ 
				minDate: +8, 
				maxDate: "+10D",
				showOtherMonths: true,
				selectOtherMonths: true,
				dateFormat:"yy-mm-dd"
// 				onClose: function( selectedDate ) {
// 					$( "#endDate" ).datepicker( "option", "minDate", selectedDate );
					
// 					var max_reservation=Number('${facility.facilities_max_reservation}')-1;
					
// 					var date = new Date(selectedDate);
// 					alert(date);
// 					alert(date.getFullYear());
					
// 					var year = date.getFullYear();
// 					var month = date.getMonth()+1;
// 					var day = date.getDate()+max_reservation;
// 					var lastDay=(new Date(year,month,0)).getDate();
// 					if(day>lastDay){
// 						day = day-lastDay;
// 						month=month+1;
// 					}
// 					alert(selectedDate);
// 					alert("year="+Number(year));					
// 					var maxDate = year+"-"+month+"-"+day;
// 					$( "#endDate" ).datepicker( "option", "maxDate", maxDate );
// 					alert("maxDate="+maxDate);
					
// 					var end = new Date($("#endDate").val());
// 					var begin = new Date(selectedDate);
// 					var period = (end.getTime()-begin.getTime())/1000/60/60/24+1;
// 					alert(end);
// 					if(end != 'Invalid Date'){
// 						$("#reservation_period").val(period);
// 					}
// 				}
			}
	);
// 	$( "#endDate" ).datepicker(
// 			{ 
// 				minDate: +8, 
// 				maxDate: "+12D",
// 				dateFormat:"yy-mm-dd",
// 				showOtherMonths: true,
// 				selectOtherMonths: true,
// 				onClose: function( selectedDate ) {
// 					var begin = new Date($("#reservation_day").val());
// 					var end = new Date(selectedDate);
// 					var period = (end.getTime()-begin.getTime())/1000/60/60/24+1;
					
// 					if(begin != 'Invalid Date'){
// 						$("#reservation_period").val(period);
// 					}
// 				}
// 			}
// 	);
});

function changeReserve(type){
// 	location.href='reserve.do?facilities_type='+type;
	var date='${param.date}';
	
	$.ajax({
		  url: "main.do",
		  type: "GET",
		  dataType:"html",
		  data:{
			    type: "reserve",
		    	facilities_type:type,
		    	date:date
		  },
		  success: function(data){
// 			  alert("success");
			 $("Body").html(data);
		  }
	});
// 	location.href='main.do?type=reserve&&facilities_type='+type+'&&date='+date;
}
// function checkMax(val){
// 	var max = Number('${facility.facilities_accommodation }');
// 	var max_addition=Number('${facility.facilities_max_accommodation }');
// 	if(max == val && max_addition>max){
// 		$("#addAccommodation").show();
// 		$("#addMessege").show();
// 	}
// 	else{
// 		$("#addAccommodation").hide();
// 		$("#addMessege").hide();
// 		$("#addAccommodation").val('0');
// 	}
// }
function checkPeopleCount(people_count){
	var accomo = Number('${facility.facilities_accommodation }');
	var count = Number(people_count);
	if(count>accomo)
		$("#addMessege").show();
	else
		$("#addMessege").hide();
}
function submitReserve(){
	var day_price=Number('${facility.facilities_price }');
	var reserve_count=Number($("#reservation_period").val());
	var standard_people_count = Number('${facility.facilities_accommodation }');
	var people_count = Number($("#reservation_people_count").val());
	var add_price =Number('${facility.facilities_add_price }');
	var add_people_count=0;
	
	var user_auth='${login.user_auth}';
	if(people_count>standard_people_count)
		add_people_count=people_count-standard_people_count;
	
	var sum=(day_price+(add_price*add_people_count))*reserve_count;
	
	if(!$("select:eq(0)").val())
    {
	  alert('�̿밴���� �������ּ���.');
	  $("select:eq(0)").focus();
      return false;
	} else if(!$("select:eq(2)").val()) {
    	alert('����ο��� �������ּ���.');
    	$("select:eq(2)").focus();
		return false;
	}
	
	if(user_auth == "D01"){
		alert("���Խ����� ���� �ʾҽ��ϴ�. �����ڿ��� �����ϼ���.");
		return;
	}
	
	if(confirm("�̿����� "+sum+"���Դϴ�. ������ �����Ͻðڽ��ϱ�?")){
		$("#reserveDTO").submit();
	}
}
function calculate(){
	var day_price=Number('${facility.facilities_price }');
	var reserve_count=Number($("#reservation_period").val());
	var standard_people_count = Number('${facility.facilities_accommodation }');
	var people_count = Number($("#reservation_people_count").val());
	var add_price =Number('${facility.facilities_add_price }');
	var add_people_count=0;
	if(people_count>standard_people_count)
		add_people_count=people_count-standard_people_count;
	
	var sum=(day_price+(add_price*add_people_count))*reserve_count;
	var day=$("#reservation_day").val();
	var period=$("#reservation_period").val();
	var people=$("#reservation_people_count").val();
	
	if(day !="" && period !="" && people!="")
		$("#reservation_price").val(sum);
	else
		$("#reservation_price").val("");
}

</script>
</head>
<body>
<h4 class="title">�ǽð�����</h4>
<h6 class="memo">���������� �Է��Ͻð�, �����ư�� �����ø� ������ �Ϸ�˴ϴ�.</h6>
<form:form commandName="reserveDTO" action="reserve.do" method="POST">
	<table class="bbs_list">
		<tr>
			<th>�̿밴��</th>
			<td>
				<select name="facilities_type" onchange="changeReserve($(this).val())">
					<option value=""></option>
					<c:forEach var="f_list" items="${facilitiesList }">
						<option value="${f_list.facilities_type }"
							<c:if test="${param.facilities_type eq f_list.facilities_type }">
							selected="selected"
							</c:if>>
							${f_list.facilities_type_name }
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th>������</th>
			<td>
				������ : <form:input path="reservation_day" size="8" onchange="calculate()"/>
<!-- 				���� : <input id="endDate" type="text" size="8"> -->
				<form:select path="reservation_period" onchange="calculate()">
					<c:forEach begin="1" end="${facility.facilities_max_reservation}" varStatus="i">
					<form:option value="${i.index }">${i.index }��</form:option>
					</c:forEach>
				</form:select>
<%-- 				<form:input path="reservation_period" size="2"/> �� --%>
			</td>
		</tr>
		<tr>
			<th>����ο�</th>
			<td>
<!-- 				<select onchange="checkMax($(this).val())"> -->
<%-- 					<c:forEach begin="0" end="${facility.facilities_accommodation }" varStatus="i"> --%>
<%-- 						<option>${i.index }</option> --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 				<div id="addMessege" style="display: none;">�߰��ο�</div> -->
				<form:select path="reservation_people_count" onchange="calculate()">
					<form:option value=""></form:option>
					<c:forEach begin="1" end="${facility.facilities_max_accommodation }" varStatus="i">
						<form:option value="${i.index }">${i.index }��</form:option>
					</c:forEach>
				</form:select>
		</tr>
		<tr>
			<th>�������</th>
			<td>
				1�� �̿�ݾ� : ${facility.facilities_price }��<br>
				${facility.facilities_accommodation }�� �ʰ� �δ� �߰��ݾ� : ${facility.facilities_add_price }��			
			</td>
		</tr>
		<tr>
			<th>����ݾ�</th>
			<td >
				<form:input path="reservation_price" readonly="true"/> ��
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td>��Ÿ</td> -->
<%-- 			<td><form:textarea rows="10" cols="40" path="reservation_note"></form:textarea>	</td> --%>
<!-- 		</tr> -->
	
	</table>
	<div style="width:90px; float:right; margin-top:10px;">
		<span class="btn_blue btn_short">
			<a href="#" onclick="javacript:submitReserve();">�����ϱ�</a>
		</span>
	</div>
</form:form>
</body>
</html>