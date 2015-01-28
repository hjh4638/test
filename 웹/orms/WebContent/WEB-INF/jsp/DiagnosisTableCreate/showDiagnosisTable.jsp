<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
 <style>
 
#questionTable th{
	background:#C18C96;
	border:2px solid #ffffff;
	color:#ffffff;  
 }

#headQuestionTable{
	border:2px solid #C18C96;
}

#headQuestionTable th{
	background:#C18C96;
	border:1px solid #ffffff;
	color:#ffffff;
	border-top:#C18C96 1px solid;
	border-left:#C18C96 1px solid;
}

  .question{
	padding-left:4px;
	padding-right:4px;
	padding-top:10px;
	padding-bottom:10px;
	background:#DAE6FE;
	margin-right: 5px;
	margin-bottom: 5px;
	font-weight: bold;
	cursor:pointer;
}
</style>
<script>
	$(function(){
		Nifty("div.question","transparent");
		$("div .question").hover(function(){
			if($(this).attr("value")=="0"){
				$(this).css("background","#C0E6FE");
			}	
		},function(){
			if($(this).attr("value")=="0"){
				$(this).css("background","#DAE6FE");
			}
		});
		$(".checked").each(function(){
			$(this).css("background","#368EC7");
			$(this).css("color","#FFFFFF");
			$(this).attr("value","1");
		});
		$("div .question").toggle(function(){
			checkValue($(this));
		},function(){
			if($(this).attr("value")=="0"){
				checkValue($(this));
			}else{
				$(this).css("background","#DAE6FE");
				$(this).css("color","#000000");
				$(this).attr("value","0");
			}
		});
	});
	function checkValue(div){
		var headClass=div.attr("class");
		headClass=headClass.replace("question","");
		headClass=headClass.replace("checked","");
		$("."+headClass).css("background","#DAE6FE");
		$("."+headClass).css("color","#000000");
		$("."+headClass).attr("value","0");
		div.css("background","#368EC7");
		div.css("color","#FFFFFF");
		div.attr("value","1");
	}
	function saveDiagnosisTable(){
		if(validateTable()){
			var answers='';
			$("div .question[value='1']").each(function(){
				
				var headClass=$(this).attr("class");
				headClass=headClass.replace("question","");
				if(answers==''){
					answers+=$(this).attr("seq");
				}else{
					answers+=','+$(this).attr("seq");
				}
			});
			var scheduleId='${param.scheduleId}';

			$.ajax({
				url:		'${cp}/DiagnosisTableCreate/insertDiagnosisTable.do',
				type:		'POST',
				dataType:	'json',
		 		data: {
			 		scheduleId:scheduleId,
			 		answers:answers
		 		},
		 		success:function(data){
			 		if(data=='Success'){
		 				location.href='${cp}/DiagnosisTableCreate/showMyScheduleList.do';
			 		}else{
				 		alertMessage("알림","입력에 실패했습니다.<br/>관리자에게 문의해주세요.",function(){
				 			location.href='${cp}/DiagnosisTableCreate/showMyScheduleList.do';
					 	});
			 		}
		 			
		 		}
			});
		}else{
			alertMessage("알림","선택하지 않은 문항이 있습니다.<br/>모든 문항을 선택해 주세요.");
		}
		

		
	}
	function validateTable(){
		var result=true;
		$("td .head").each(function(){
			
			if($(this).parent().find(".question[value='1']").length==0){
				if($(this).attr("value") != 'lev4'){
					$(this).css("background","#AAAAAA");
				}
				
				result=false;
				return ;
			}else{
				$(this).css("background","#FFFFFF");
			}
		});
		return result;
		
	}
</script>

<img src="${cp }/images/title/showMyScheduleList.gif">

<table id="questionTable" border="0" width="100%;" style="margin-top:10px;">
	<c:forEach var="question" items="${questionTree}">
		<tr>
			<th width="10" style="padding-left: 10px;padding-right: 10px;">${question.question_name}</th>
			<td>
				<table id="headQuestionTable"  width="100%">
					<c:forEach var="child1" items="${question.children}">
					<c:choose>
						<%-- Level 3까지만 항목이 있을시 --%>
						<c:when test="${child1.children[0].question_yn ne 'N'}">
							<tr>
								<th title="${child1.bigo }" style="width:100px;margin:0;" align="center" class="head">${child1.table_question_name }</th>
								<td style="width:682px;border:1px solid #C18C96;">
									<table>
									<tr>
									<c:forEach var="child2" items="${child1.children}" varStatus="i">
										<c:if test="${child2.score ne 'N' and child2.score ne null}">
										<td >
										<c:choose>
											<c:when test="${
											child1.id eq 4024 ||
											child1.id eq 3825 ||
											child1.id eq 27 ||
											child1.id eq 4227 ||
											child1.id eq 4425 ||
											child1.id eq 1026 ||
											child1.id eq 1225 ||
											child1.id eq 1425 ||
											child1.id eq 1625 ||
											child1.id eq 1825 ||
											child1.id eq 2025 ||
											child1.id eq 2225 ||
											child1.id eq 2426 ||
											child1.id eq 2626 ||
											child1.id eq 2825 ||
											child1.id eq 3023 ||
											child1.id eq 525 ||
											child1.id eq 637 ||
											child1.id eq 3227 ||
											child1.id eq 745 ||
											child1.id eq 3625 ||
											child1.id eq 3425
											}">
											test
											</c:when>
											<c:otherwise>
											뷁
											</c:otherwise>
											<div title="${child1.bigo }" value="0" seq="${child2.id }" class="head${child1.id } <c:if test="${child2.checked eq 'Y' }">checked</c:if> <c:if test="${child2.question_yn ne 'N' }">question</c:if>">
												 ${child2.question_name }
											</div>
										</c:choose>
										</td>
										</c:if>
									</c:forEach>
									</tr>
									</table>
								</td>
							</tr>
						</c:when>
						<%-- Level 4까지 항목이 있을시--%>
						<c:otherwise>
							<tr>								
								<td colspan="2" width="100%" class="head" value="lev4"  >
									<table border="0" width="100%" id="headQuestionTable">
										<c:forEach var="child2" items="${child1.children}" varStatus="i">
											<tr>
												<c:if test="${i.index eq 0}">
													<th width="30px" rowspan="${child1.childrenSize }" style="border-top:#ffffff 1px solid;">${child1.question_name }</th>
												</c:if>
												<th width="59px" >${child2.question_name }</th>
												<td style="border:1px solid #C18C96;">
												<table>
													<tr>
														<c:set var="tdCount" value="0"/>
														<c:forEach var="child3" items="${child2.children}">
															
															<c:choose>
																<c:when test="${child3.childrenSize eq 0}">
																	<c:set var="tdCount" value="${tdCount+1}"/>
																	<c:if test="${child3.score ne 'N' and child3.score ne null}">
																	<td>
																		<div value="0" seq="${child3.id }" class="head${child1.id } <c:if test="${child3.checked eq 'Y' and param.mode eq 'modify'}">checked</c:if> <c:if test="${child3.question_yn ne 'N' }">question</c:if>">
																			${child3.question_name }
																		</div>
																	</td>
																	</c:if>
																</c:when>
																<c:otherwise>
																	<c:forEach var="child4" items="${child3.children}">
																		<c:set var="tdCount" value="${tdCount+1}"/>
																		<c:if test="${child4.score ne 'N' and child4.score ne null}">
																		<td>
																			<div value="0" seq="${child4.id }" class="head${child1.id } <c:if test="${child4.checked eq 'Y' and param.mode eq 'modify' }">checked</c:if> <c:if test="${child4.question_yn ne 'N' }">question</c:if>">
																				<c:if test="${child3.question_name ne child4.question_name}">${child3.question_name } </c:if>${child4.question_name }
																			</div>
																		</td>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>
															
															<c:if test="${tdCount%5 eq 0}"></tr><tr></c:if>
														</c:forEach>
													</tr>
												</table>
												</td>
											</tr>
										</c:forEach>
									</table>
								</td>
							</tr>	
						</c:otherwise>
					</c:choose>
					</c:forEach>
				</table>
			</td>
		</tr>
	</c:forEach>
</table>

<div style="width=100%;text-align:right;margin-top:10px;">
<a href="javascript:saveDiagnosisTable()"><img src="${cp }/images/button/save_button.gif"/></a>
</div>