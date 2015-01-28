<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="<%=request.getContextPath() %>" />
<%
	String airCraftCode = request.getParameter("airCraftCode");
%>



<style>

	#printPage{

		border:0px;

		background:url("${cp}/images/button/print_button.gif");

		width:60px;

		height:22px;

		cursor:pointer;

	}

</style>

<script>

	$(function(){

	var printParam='${param.print}';

	if(printParam!=''){

		$("#printButton").hide();

		print();

	}

	});

	function openForPrint(){

		window.open('${cp}/ValuationStandardTable/view/valuationStandardTable.do?print=1','valuationTable','width=800,height=700,resizable=yes,scrollbars=yes');

	}
	function submitCode(){
		var airCraftCode= $("#airCraftCode").val();
		location.href='${cp}/ValuationStandardTable/valuationStandardTable.do?code=4&airCraftCode='+airCraftCode;
	}
	
</script>

<img src="${cp }/images/title/valuationStandardTable.gif"/>
<br>
<img src="${cp }/images/dot.gif"/> 비행환경별
<a href="javascript:openForPrint()" id="printButton"><input id="printPage" type="button" value=""/></a>

<select id="airCraftCode" onChange="submitCode()">
			 	<option value="01"  <%=("01".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-16</option>
				<option value="02"  <%=("02".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-15</option>
				<option value="03"  <%=("03".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-4</option>
				<option value="04"  <%=("04".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-5</option>
				<option value="06"  <%=("06".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>CN235</option>
				<option value="07"  <%=("07".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>C130</option>
				<option value="08"  <%=("08".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>헬기</option>
				<option value="09"  <%=("09".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>T-103</option>
				<option value="10"  <%=("10".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>KT-1</option>
				<option value="11"  <%=("11".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>T-50</option>
				<option value="12"  <%=("12".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>T-59</option>
				<option value="13"  <%=("13".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>TA-50</option>
				<option value="14"  <%=("14".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>F-5 CRT</option>
				<option value="15"  <%=("15".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>KF-16 CRT</option>
				<option value="16"  <%=("16".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>191대대</option>
				<option value="17"  <%=("17".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>192대대</option>
				<option value="18"  <%=("18".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>257대대(C형)</option>
				<option value="19"  <%=("19".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>257대대(H형)</option>
				<option value="20"  <%=("20".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>KA-1</option>
				<option value="21"  <%=("21".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>RC-800</option>
				<option value="22"  <%=("22".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>255대대(C형)</option>
				<option value="23"  <%=("23".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>255대대(H형)</option>
				<option value="24"  <%=("24".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>AN-2(L-2)</option>
				<option value="25"  <%=("25".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>RF-4</option>
				<option value="26"  <%=("26".equals(airCraftCode) ? "selected=\"selected\"" : "") %>>E-737</option>
</select>
<!-- 뎁스3 -->
<c:if test="${param.airCraftCode eq '05' or  param.airCraftCode eq '06' 
or param.airCraftCode eq '07' or param.airCraftCode eq '08' or param.airCraftCode eq '09'
or param.airCraftCode eq '18' or param.airCraftCode eq '19' or param.airCraftCode eq '22'
or param.airCraftCode eq '23' or param.airCraftCode eq '26' or param.airCraftCode eq '10' 
or param.airCraftCode eq '21' or param.airCraftCode eq '11' 
or param.airCraftCode eq '12' or param.airCraftCode eq '24'}">
<table border="1" id="resultListTable" style="text-align:center; width: 100%;margin-top:10px;">
<thead> 
<tr>
<th colspan="3" rowspan="2">평가요소 </th>
<th width="30%" colspan="6">비행환경</th>
<th width="50%" colspan="15">자격</th>
</tr>
<tr>
<th colspan="3">주간</th>
<th colspan="3">야간</th>
<c:forEach var="title" items="${sectionTitleList }">
	<th colspan="3">${title.codename }</th>
</c:forEach>

</tr>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }" varStatus="a">
		<c:forEach var="headQuestion" items="${valuation.childrenForValuation }" varStatus="b">
				<c:forEach var="finalChild" items="${headQuestion.childrenForValuation }" varStatus="c">
				<tr>
				<c:if test="${b.index eq 0 and c.index eq 0 }">
				<td rowspan="${valuation.allChildrenForValuationCount }">${valuation.question_name }</td>
				</c:if>
				<c:if test="${c.index eq 0 }">
				<td rowspan="${headQuestion.allChildrenForValuationCount }">${headQuestion.question_name }</td>
				</c:if>
				<td>${finalChild.question_name }</td>
				
				<c:forEach var="section" items="${finalChild.dayPeriodList}">
				<c:choose>
				<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:when test="${headQuestion.question_name ne '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>
				
				<c:forEach var="list" items="${finalChild.sectionList }">
				<c:choose>
				<c:when test="${list eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${list eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${list eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${list eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:when test="${headQuestion.question_name eq '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>				
				
				</tr>
				</c:forEach>
		</c:forEach>
</c:forEach>
</tbody> 
</table> 
</c:if>


<!-- 뎁스5 -->
<c:if test="${param.airCraftCode eq '14' or  param.airCraftCode eq '13' or param.airCraftCode eq '15'
or param.airCraftCode eq '15' or param.airCraftCode eq '20' or param.airCraftCode eq '16' 
or param.airCraftCode eq '17' or param.airCraftCode eq '25'}">
<table border="1" id="resultListTable" style="text-align:center; width: 100%;margin-top:10px;">
<thead> 
<tr>
<th colspan="5" rowspan="2">평가요소 </th>
<th width="20%" colspan="6">비행환경</th>
<th width="40%" colspan="15">자격</th>
</tr>
<tr>
<th colspan="3">주간</th>
<th colspan="3">야간</th>
<c:forEach var="title" items="${sectionTitleList }">
	<th colspan="3">${title.codename }</th>
</c:forEach>


</tr>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }" varStatus="a">
	<c:forEach var="headQuestion" items="${valuation.childrenForValuation }" varStatus="b">
		<c:forEach var="childQuestion" items="${headQuestion.childrenForValuation }" varStatus="c">
			<!-- 깊이가 3인것들 -->
			<c:if test="${headQuestion.question_name ne '임무과목'}">
				<tr>
					<c:if test="${b.index eq 0 and c.index eq 0 }">
					<td rowspan="${valuation.allChildrenForValuationCount }">${valuation.question_name }</td>
					</c:if>
					<c:if test="${c.index eq 0 }">
					<td colspan="2" rowspan="${headQuestion.allChildrenForValuationCount }">${headQuestion.question_name }</td>
					</c:if>
					<td colspan="2">${childQuestion.question_name }</td>
					<c:forEach var="section" items="${childQuestion.dayPeriodList}">
					<c:choose>
					<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
					<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
					<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
					<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
					<c:when test="${headQuestion.question_name ne '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
					<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
					</c:choose>
					</c:forEach>
					
					<c:forEach var="list" items="${childQuestion.sectionList }">
					<c:choose>
					<c:when test="${list eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
					<c:when test="${list eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
					<c:when test="${list eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
					<c:when test="${list eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
					<c:when test="${headQuestion.question_name eq '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
					<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
					</c:choose>
					</c:forEach>				
				</tr>
			</c:if>
			<c:forEach var="child" items="${childQuestion.childrenForValuation }" varStatus="d">
				<!-- 자식 문항이 없을시 (깊이가 4일때)-->
				<c:if test="${child.question_yn eq 'Y' }">
					<tr>
						<c:if test="${b.index eq 0 and c.index eq 0 and d.index eq 0 and a.index eq 0}">
						<td rowspan="${valuation.allChildrenForValuationCount }">${valuation.question_name }	</td>
						</c:if>
						<c:if test="${b.index eq 0 and c.index eq 0 and d.index eq 0 and a.index eq 0}">
						<td rowspan="${headQuestion.allChildrenForValuationCount}">${headQuestion.question_name }</td>
						</c:if>
						<c:if test="${d.index eq 0}">
						<td rowspan="${childQuestion.allChildrenForValuationCount}">${childQuestion.question_name }</td>
						</c:if>
							<c:if test="${childQuestion.question_yn eq 'N' }">
									<td colspan="2">${child.question_name }</td>
									<c:forEach var="section" items="${child.dayPeriodList}">
									<c:choose>
									<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
									<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
									<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
									<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
									<c:when test="${headQuestion.question_name ne '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
									<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
									</c:choose>
									</c:forEach>
									
									<c:forEach var="list" items="${child.sectionList }">
									<c:choose>
									<c:when test="${list eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
									<c:when test="${list eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
									<c:when test="${list eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
									<c:when test="${list eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
									<c:when test="${headQuestion.question_name eq '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
									<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
									</c:choose>
									</c:forEach>	
							</c:if>
					</tr>
				</c:if>
				<!-- 깊이가 5일때 -->
				<c:forEach var="finalChild" items="${child.childrenForValuation }" varStatus="e">
					<tr>
						<c:if test="${b.index eq 0 and c.index eq 0 and d.index eq 0 and a.index eq 0}">
						<td rowspan="${valuation.allChildrenForValuationCount }">${valuation.question_name }</td>
						</c:if>
						<c:if test="${b.index eq 0 and c.index eq 0 and d.index eq 0 and a.index eq 0}">
						<td rowspan="${headQuestion.allChildrenForValuationCount}">${headQuestion.question_name }</td>
						</c:if>
						<c:if test="${d.index eq 0 and e.index eq 0}">
						<td rowspan="${childQuestion.allChildrenForValuationCount}">${childQuestion.question_name }</td>
						</c:if>
							<c:if test="${childQuestion.question_yn eq 'N' }">
									<c:if test="${e.index eq 0}">
									<td rowspan="${child.allChildrenForValuationCount}">${child.question_name }</td>
									</c:if>
									<c:if test="${child.question_yn eq 'N' }">
										<td>${finalChild.question_name }</td>
										<c:forEach var="section" items="${finalChild.dayPeriodList}">
										<c:choose>
										<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
										<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
										<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
										<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
										<c:when test="${headQuestion.question_name ne '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
										<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
										</c:choose>
										</c:forEach>
										
										<c:forEach var="list" items="${finalChild.sectionList }">
										<c:choose>
										<c:when test="${list eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
										<c:when test="${list eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
										<c:when test="${list eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
										<c:when test="${list eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
										<c:when test="${headQuestion.question_name eq '임무과목' }"><td bgcolor="gray" colspan="3"></td></c:when>
										<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
										</c:choose>
										</c:forEach>
									</c:if>
							</c:if>
					</tr>
				</c:forEach>
			</c:forEach>
		</c:forEach>
	</c:forEach>
</c:forEach>
</tbody> 
</table> 
</c:if>


<!-- 전투기들 -->
<c:if test="${param.airCraftCode eq '01' or  param.airCraftCode eq '02' or param.airCraftCode eq '03' or param.airCraftCode eq '04'}">
<table border="1" id="resultListTable" style="text-align:center; width: 100%;margin-top:10px;">
<thead>
<tr>
<th colspan="5" rowspan="2">평가요소 </th>
<th width="30%" colspan="6">비행환경</th>
</tr>
<tr>
<th colspan="3">주간</th>
<th colspan="3">야간</th>
</tr>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }" varStatus="a">
		<c:forEach var="headQuestion" items="${valuation.childrenForValuation }" varStatus="b">
				<c:forEach var="childQuestion" items="${headQuestion.childrenForValuation }" varStatus="c">
						<c:forEach var="child" items="${childQuestion.childrenForValuation }" varStatus="d">
								<c:if test="${ child.question_yn eq 'N' and child.childrenForValuationSize ne 0}">
								<c:forEach var="finalChild" items="${child.childrenForValuation }" varStatus="e">
								<tr>
								<c:if test="${a.index eq 0 and b.index eq 0 and c.index eq 0 and d.index eq 0 and e.index eq 0 }">
								<td   rowspan="${ headQuestion.allChildrenForValuationCount}"  >${valuation.question_name } </td>
								<td  rowspan="${ headQuestion.allChildrenForValuationCount}"  >${headQuestion.question_name }</td>
								</c:if>
								 <c:if test="${d.index eq 0 and e.index eq 0 }">
								  <td  rowspan="${childQuestion.allChildrenForValuationCount }" >${childQuestion.question_name}</td>
								</c:if> 
								 <c:if test="${ e.index eq 0 }">
								<td   rowspan="${child.allChildrenForValuationCount }" >${child.question_name }</td>
								</c:if>
								<td>${finalChild.question_name }</td>
				<c:forEach var="section" items="${finalChild.dayPeriodList}">
				<c:choose>
				<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>				
								</tr>
								</c:forEach>
								</c:if>
								<c:if test="${ child.question_yn eq 'Y' or child.childrenForValuationSize eq 0}">
								<tr>
								<c:if test="${d.index eq 0  }">
								<td  rowspan="${childQuestion.childrenForValuationSize }" >${childQuestion.question_name}</td>
								</c:if>
								<td colspan="2">${child.question_name }</td>
				<c:forEach var="section" items="${child.dayPeriodList}">
				<c:choose>
				<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>
								</tr>
								</c:if>
						</c:forEach>
				</c:forEach>
		</c:forEach>
</c:forEach>
</tbody>
 </table>
</c:if>

<br>
<br>

<c:if test="${param.airCraftCode eq '01' or  param.airCraftCode eq '02' or param.airCraftCode eq '03' or param.airCraftCode eq '04'}">
<img src="${cp }/images/dot.gif"/> 자격별

<table  border="1" id="resultListTable" style="text-align:center; width: 100%;margin-top:10px;">
<thead>
<tr>
<th colspan="3" rowspan="2">평가요소 </th>
<th width="50%" colspan="12">자격</th>
</tr>
<tr>
<th colspan="3">IP</th>
<th colspan="3">4L</th>
<th colspan="3">2L</th>
<th colspan="3">WM</th>
</tr>
</thead>
<tbody>
<c:forEach var="valuation" items="${questionTreeForAirCraft }" varStatus="a">
		<c:set var="valuationRowspan" value="0"/>
		<c:forEach var="headQuestion" items="${valuation.childrenForValuation }" varStatus="b">
				<c:forEach var="finalChild" items="${headQuestion.childrenForValuation }" varStatus="c">
				<tr>
				<c:if test="${b.index eq 0 and c.index eq 0 }">
				<c:forEach var="i" items="${valuation.childrenForValuation }">
				<!--*********************************************************************************  -->
				<c:if test="${ (i.id ne 126) and (i.id ne 128) and (i.id ne 179) and (i.id ne 230)}">
				<!--*********************************************************************************  -->
				<c:set var="valuationRowspan" value="${valuationRowspan +i.allChildrenForValuationCount  }"/>
				</c:if>
				</c:forEach>
				<td rowspan="${valuationRowspan+3 }" >${valuation.question_name }</td>
				</c:if>
				<!--*********************************************************************************  -->
				<c:if test="${(headQuestion.id ne 126) and (headQuestion.id ne 128) and (headQuestion.id ne 179) and (headQuestion.id ne 230)}">
				<!--*********************************************************************************  -->
				<c:if test="${c.index eq 0 }">
				<td rowspan="${headQuestion.allChildrenForValuationCount }">${headQuestion.question_name }</td>
				</c:if>
			    </c:if>
				<!--*********************************************************************************  -->
				<c:if test="${(finalChild.upper_id ne 126) and (finalChild.upper_id ne 128) and (finalChild.upper_id ne 179) and (finalChild.upper_id ne 230)}">
				<!--*********************************************************************************  -->
				<td>${finalChild.question_name }</td>
				<c:forEach var="section" items="${finalChild.sectionList}">
				<c:choose>
				<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>
				</c:if>
				</tr>
				</c:forEach>
		</c:forEach>
</c:forEach>

<c:forEach var="valuation" items="${questionTreeForCommon }" varStatus="a">
		<c:forEach var="headQuestion" items="${valuation.childrenForValuation }" varStatus="b">
				<c:forEach var="finalChild" items="${headQuestion.childrenForValuation }" varStatus="c">
				<tr>
				<c:if test="${b.index eq 0 and c.index eq 0 }">
				<td rowspan="${valuation.allChildrenForValuationCount }">${valuation.question_name }</td>
				</c:if>
				<c:if test="${c.index eq 0 }">
				<td rowspan="${headQuestion.allChildrenForValuationCount }">${headQuestion.question_name }</td>
				</c:if>
				<td>${finalChild.question_name }</td>
				<c:forEach var="section" items="${finalChild.sectionList}">
				<c:choose>
				<c:when test="${section eq 0 }"><td bgcolor="#6E9E00">0</td><td></td><td></td></c:when>
				<c:when test="${section eq 1 }"><td bgcolor="#6E9E00">1</td><td></td><td></td></c:when>
				<c:when test="${section eq 2 }"><td></td><td bgcolor="#FFF58F">2</td><td></td></c:when>
				<c:when test="${section eq 3 }"><td></td><td></td><td bgcolor="#E86400">3</td></c:when>
				<c:otherwise><td colspan="3">N/A</td></c:otherwise> 
				</c:choose>
				</c:forEach>
				</tr>
				</c:forEach>
		</c:forEach>
</c:forEach>
</tbody>
</table>
</c:if>