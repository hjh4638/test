<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<script type="text/javascript">
<!--
	 $(function(){
		$('#dialog').dialog({
			autoOpen: false,
			width: 330,
			buttons:{ 
				"기각": function() {
					var form = document.forms['appVO'];
					form.submit();					
					$(this).dialog("close");
				},
				"취소": function() { 
					$(this).dialog("close"); 
				} 
			}
		});
	});
	
// 	function openPop(seq){
// 		var form = document.forms['appVO'];
// 		form.file_seq.value = seq;
// 		alert(seq);
// 	} 
	function deleteContents(code, seq){
		var answer = confirm("삭제 하시겠습니까?");
		if(answer){
			location.href = "<c:url value='/approval_line/withdrawalBelt.do?code='/>"+code;
			var form = document.forms['beltVO'];
			form._method.value = 'delete';
			form.pn.value = seq;
			form.dummy.value = code;
			form.submit();			
		}else{   
			return false;
		}
	} 
	
	function updateContents(seq, code){
		location.href = "<c:url value='/belt/beltRegister.do?code='/>"+seq;
	}
	
	function approvalBelts(code){
		var answer = confirm("결재 하시겠습니까?");
		if(answer)
		location.href = "<c:url value='/approval_line/approvalBelt.do?code='/>"+code;
		
	}
	
	function withdrawal(code,ppl){
		var answer = confirm("회수 하시겠습니까?");
		if(answer)
			location.href = "<c:url value='/approval_line/withdrawalBelt.do?code='/>"+code+"&ppl="+ppl;
// 			var form = document.forms['beltVO'];
// 			form._method.value = 'get';
// 			form.pn.value = seq;
	}
	function rejection(code){
		var answer = confirm("기각 하시겠습니까?");
		if(answer)
		{
			var form = document.forms['appVO'];
			form.file_seq.value = code;
			$('#dialog').dialog('open');
			return false;
// 			location.href = "<c:url value='/approval_line/rejectionBelt.do?code='/>"+code;
// 			openPop(code);
		}else{
			return false;
		}
	}
	
//-->
</script>

<center>
	<h1 class="belt_detail_title">벨트조회세부정보</h1>
	<br />
	<h2 class="belt_detail_sub_title1">등록자 정보</h2>
	<form:form commandName="beltVO" action='detail.do' htmlEscape="true" method="put">
		<form:input path="sosokCode" type="hidden" />
		<form:input path="dummy" type="hidden"/> <form:input path="pn" type="hidden"/>
		<table class="beltData_table">
			<tr>
				<th width="14%">성명</th>
				<td width="16%">
					<form:input path="name"	value="${beltList.name}"
						cssStyle="width: 90px; text-align: center; border: 0px;"
						readonly="readonly" />
				</td>
				<th width="14%">계급</th>
				<td width="16%">
					<form:input path="rank"	value="${beltList.rank}"
						cssStyle="width: 90px; text-align: center; border: 0px;"
						readonly="readonly" />
				</td>
				<th width="12%">군번</th>
				<td>
					<form:input path="sn" value="${beltList.sn}"
						cssStyle="width: 150px; text-align: center; border: 0px;"
						readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>소속</th>
				<td colspan="5">
					<form:input type="text" path="sosokName" value="${beltList.sosokName}"
						style="width: 91%; border: 0px; text-align: center;"
						readonly="true" />
				</td>
			</tr>
			
		</table>
		<br /> <br />
		<h2 class="belt_detail_sub_title2">벨트 정보</h2>
		<br /> 
		<c:forEach items="${beltList.beltDatum}" var="contentsVOs">
			<c:if test="${(user.sn == beltList.sn || user.authority eq 'A')&& !(contentsVOs.appState == 0 ||contentsVOs.appState == 1)
							&& (contentsVOs.beltstate==2 || contentsVOs.beltstate==4 || contentsVOs.beltstate==1)}">
				<ul class="belt_sub_menu">
					<li>
						<a class="detail_menu_del" onfocus="blur();" href="#" 
							onclick="javascript:deleteContents('<c:out value="${contentsVOs.file_seq}"/>','<c:out value="${beltList.pn}"/>');">
							<img src="<c:url value="/images/button/delete.gif"/>">
						</a>
					</li>
					<li>
						<a class="detail_menu_edit" onfocus="blur();" href="#" 
							onclick="javascript:updateContents('<c:out value="${contentsVOs.file_seq}"/>','<c:out value="${beltList.pn}"/>');">
						
							<img src="<c:url value="/images/button/modify.gif"/>">
						</a>
					</li>
				</ul>
			</c:if>
			<c:if test="${ user.sn == beltList.sn && contentsVOs.appState == 0}"> 
				<ul class="belt_sub_menu">
					<li>
						<a class="detail_menu_withdrawal" onfocus="blur();" href="#" 
							onclick="javascript:withdrawal('<c:out value="${contentsVOs.file_seq}"/>','<c:out value="${beltList.pn}"/>');">
							<img src="<c:url value="/images/button/btn_back.gif"/>">
						</a>
					</li>
				</ul>
 			</c:if> 
			<table class="beltContents_table">
				<tr>
					<th width="18%">벨트</th>
					<td>
						<input id="contentsVOs-belt" value='<c:out value ="${contentsVOs.belt}"/>'
							style="width: 90px; text-align: center; border: 0px;"
							readonly="readonly" />
					</td>
					<th width="18%">교육기간</th>
					<td>
						<input id="contentsVOs-eduStartDate" value='<c:out value="${contentsVOs.eduStartDate}"/>'
							style="width: 90px; text-align: center; border: 0px;"
							readonly="readonly" /> - 
						<input id="contentsVOs-eduEndDate" value='<c:out value="${contentsVOs.eduEndDate}"/>'
							style="width: 90px; text-align: center; border: 0px;"
							readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>교육차수</th>
					<td width="18%">
						<input id="contentsVOs-eduNum" value='<c:out value="${contentsVOs.eduNum}"/>'
							style="width: 90px; text-align: center; border: 0px;"
							readonly="readonly" />
					</td>
					<th>수료/자격여부</th>
					<td>
						<input id="contentsVOs-beltState" value='<c:out value="${contentsVOs.beltStateString}"/>'
							style="text-align: center; border: 0px;" readonly="readonly" />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<c:out value="${contentsVOs.sn}"/>
						<c:if test="${user.sn eq beltList.sn || user.authority eq 'A'}">
							<c:if test="${contentsVOs.belt == 'GB'}">
								<c:if test="${contentsVOs.beltstate == 2 || contentsVOs.beltstate == 3}">
									점수 :
									<input id="contentsVOs-score" value='<c:out value="${contentsVOs.score}"/>'
										maxlength="2" size="1" style="text-align: center; border: 0px;"
										readonly="readonly" />점
								</c:if>
							</c:if>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>자격/수료 증명 파일</th>
					<td colspan="5">
						<c:choose>
							<c:when test="${File ne '[]'}">
								<c:set var="flag" value="0"/>
								<c:forEach items="${File}" var="fileVO" varStatus="L">
									<c:if test="${fileVO.seq eq contentsVOs.file_seq}">
										<c:set var="flag" value="1"/>
									</c:if>
								</c:forEach>
								<c:forEach items="${File}" var="fileVO" varStatus="L">
									<c:choose>
										<c:when test="${fileVO.seq eq contentsVOs.file_seq}">
											<div id="file_<c:out value="${fileVO.sn}"/>">
												<a onfocus="blur();" class="download_aTag" href="javascript:download('<c:out value="${fileVO.sn }"/>');">
													<c:out value="${fileVO.name}" />
												</a>
											</div>
										</c:when>
										<c:otherwise>
											<c:if test="${flag == 0 }">
												등록된 파일 없음
												<c:set var="flag" value="1"/>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								등록된 파일 없음
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>결재 상태</th>
					<td colspan="5">
						<b>
							${contentsVOs.app_str}
							<font color="red">
								${contentsVOs.comment}
							</font>
						</b>
					</td>
				</tr>
			</table>
			<c:if test="${user.authority eq 'A' && contentsVOs.appState == 0}">
				<ul class="belt_sub_menu">
					<li>
						<a href="#" onclick="javascript:rejection(${contentsVOs.file_seq});" onfocus="blur();">
							<img src="<c:url value="/images/button/btn_disapp.gif"/>">
						</a>
					</li>
					<li>
						<a href="#" onfocus="blur();" onclick="javascript:approvalBelts(${contentsVOs.file_seq});">
							<img src="<c:url value="/images/button/btn_app.gif"/>">
						</a>
					</li>
				</ul>
			</c:if>
			<br /> <br /> <br />
		</c:forEach>
	</form:form>
</center>

<div id="dialog" title="기각 사유" style="width: 50px; display: none;">
	<form:form commandName="appVO" action="../approval_line/rejectionBelt.do?code=" method="post">
		<form:textarea path="comment" cols="40" rows="8"/>
		<form:hidden path="file_seq" value=""/>
	</form:form>
</div> 
 