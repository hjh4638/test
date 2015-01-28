<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script>
	$(document).ready(function() {
		var a = document.URL.search("code");
		if(a!=-1){
			$(function(){
				var b = $('#belt').val();
				var c = $('input[name=beltstate]:checked').val();
				if(!(b=='GB'&&c==2)){
					$('#score').removeClass('ScoreBox').addClass('noScoreBox');
				}else{
					$('#score').removeClass('noScoreBox').addClass('ScoreBox');
				}
			});
		}
	});

	$(document).change(function(){
		var b = $('#belt').val();
		if(b == 'GB'){
			$('.selectOne').click(function() {
				var a = $('input[name=beltstate]:checked').val();
				if (a == 2) {
					$('#score').removeClass('noScoreBox').addClass('ScoreBox');	
				}else if(a != 2) {
					$('#score').val("");
					$('#score').removeClass('ScoreBox').addClass('noScoreBox');
				}
				;
			});
		}else if(b != 'GB'){
			$(function(){
				$('#score').val("");
				$('#score').removeClass('ScoreBox').addClass('noScoreBox');
			});
		}
	});
	
	$(document).ready(function() {
		$('#eduNum').keyup(function() {
			var eduNumVal = $('#eduNum').val();
			if (eduNumVal.length == 2) {
				eduNumVal += "-";
				$('#eduNum').val(eduNumVal);
			}
			if (eduNumVal.length >= 2) {
				if (eduNumVal.slice(0, 1) != "-"
					&& eduNumVal.slice(1, 2) != "-"
					&& eduNumVal.slice(2, 3) != "-"
					&& eduNumVal.slice(3, 4) != "-"
					&& eduNumVal.slice(4, 5) != "-") {
					$('#eduNum').val(
						eduNumVal.slice(0, 2) + "-"
						+ eduNumVal.slice(2, 5));
				}
			}
		});
	});
	
	$(document).ready(function() {
		$('#score').keyup(function() {
			var scoreVal = $('#score').val();
			trick:
			if (scoreVal.length == 2) {
				if(scoreVal=='10'){
				 break trick;
				}
				/* scoreVal += ".";
				$('#score').val(scoreVal); */
			}
			trick2:
			if (scoreVal.length > 2) {
				if(scoreVal=='100'){
					$('#score').val(scoreVal);
					break trick2;
				}
				
				 if (
					 scoreVal.slice(2, 3) == "."
					) {
					$('#score').val(
						scoreVal);						
					}
					else {
						$('#score').val('');
						alert("최대 100점을 넘을 수 없습니다.");
				}
			}
		});
	});
</script>
	
<script>
	var code = document.URL.search("code");
	
	function datumSubmit(th,type) {
		var form = document.forms[th];
		form.appCode.value = type;
		if(code == -1){
			form.action.value = "beltRegister.do";
			form._method.value = 'post';
		}else{
			
		}
			fileUpload();
	}
	
	$(function() {
		var dates = $('#eduStartDate, #eduEndDate').datepicker({
			dateFormat : 'yy-mm-dd',
			changeYear : true,
			width : 220,
			buttonImageOnly: true,
			buttonImage: '<c:url value="/js/cal_btn.gif"/>',
			onSelect : function(selectedDate) {
				var option = this.id == 'eduStartDate' ? 'minDate'
						: 'maxDate', instance = $(this).data("datepicker");
				date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
					   $.datepicker._defaults.dateFormat,
						selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
			}
		});
		$("#eduStartDate").datepicker(dates);
		$("#eduEndDate").datepicker(dates);
		$("#ui-datepicker-div").hide();
	});
	
	function showDetail(){
	    axisX = event.clientX;
	    axisY = event.clientY + document.body.scrollTop;
	    var div = $('#example');
		div.css("visibility","visible");
		div.css("left",axisX);
		div.css("top",axisY);
		
	    
	}
	function hideDetail(){
		var div = $('#example');
		div.css("visibility","hidden");
	}
</script>
<center>
	<h1 class="belt_register_title"> 벨트등록 </h1>
	
	<%
		String code = request.getParameter("code");
		String path = "beltRegister.do";
		
		if (code != null)
			path = path + "?code=" + code;
		
		request.setAttribute("path", path);	
	%>
	
	<form:form commandName="contentsVO" action="${path}" method="put" htmlEscape="true">
		<input type="hidden" id="Checkcode" value=""/>
		<form:input type="hidden" path="sn" value="${user.sn}"/>
		<form:input type="hidden" path="appCode" />
		<table class="beltRegister_table">
			<tr height="30">
				<th>벨트</th>
				<td>
					<form:select path="belt" htmlEscape="true">벨트
						<form:option value="MBB" htmlEscape="true">MBB</form:option>
						<form:option value="BB" htmlEscape="true">BB</form:option>
						<form:option value="GB" htmlEscape="true">GB</form:option>
						<form:option value="FEA" htmlEscape="true">FEA</form:option>
					</form:select>
				</td>
				<th>수료/자격여부</th>
				<td colspan="3">
					<form:radiobutton path="beltstate" value="1" label="미수료" cssClass="selectOne" htmlEscape="true" onfocus="blur();" />
					<form:radiobutton path="beltstate" value="2" label="수료 완료" cssClass="selectOne" htmlEscape="true" onfocus="blur();" />
					<form:radiobutton path="beltstate" value="4" label="자격 취득" cssClass="selectOne" htmlEscape="true" onfocus="blur();" />
					&nbsp;&nbsp;&nbsp;&nbsp; 					
							<form:label path="score">
							취득점수:
								<form:input	path="score" class="noScoreBox" type="text" maxlength="5" size="1"/>
							점
							</form:label>
				</td>
			</tr> 
			<tr height="30">
				<th width="14%">교육기관</th>
				<td width="16%">
					<form:select path="institution">교육기관
						<form:option value="KAI" htmlEscape="true"></form:option>
						<form:option value="국방부" htmlEscape="true"></form:option>
						<form:option value="교육사" htmlEscape="true"></form:option>
					</form:select>
				</td>
				<th width="14%" >교육차수</th>
				<td width="16%">
					<form:input path="eduNum" type="text" maxlength="5" size="3" onmouseover="showDetail();" onmouseout="hideDetail();"/>차
<!-- 					<span style="width: 16px; height: 16px;" class="ui-icon ui-icon-help">1</span> -->
				</td>
				<th width="12%">교육기간</th>
				<td>
					<form:input path="eduStartDate" id="eduStartDate" cssStyle="width: 65px;" readonly="true" />&nbsp;~&nbsp;
					<form:input	path="eduEndDate" id="eduEndDate" cssStyle="width: 65px;" readonly="true" />
				</td>
			</tr>
			<tr height="30">
				<th>자격/수료 인증</th>
				<td colspan="5">
					<br /><br />
					<c:if test="${code ne null}">
						<ul class="fileBox">
							<li style="height: 25px;">
								§ 등록된 파일 목록 §
							</li>
							<c:forEach items="${contentsVO.fileVO}" var="fileVO" varStatus="L">
								<li>
									<div id="file_<c:out value="${fileVO.sn}"/>">
										<a onfocus="blur();" class="download_aTag" href="javascript:download('<c:out value="${fileVO.sn }"/>');">
											<c:out value="${fileVO.name}" />
										</a>
										<!-- 군번 일치자만 삭제 가능 -->
										<a onfocus="blur();" href="#" class="file_delete_aTag" onclick="deleteFileData('<c:url value="/ajax/deleteFileData.do"/>', '<c:out value="${fileVO.sn }"/>');">
											[삭제]
										</a>
									</div>
								</li>	
							</c:forEach>
					</ul> 
					</c:if>
					<div style="clear: left;">
<!-- 						<script type="text/javascript" > -->
						<!--
// 							Embed();
						//-->
<!-- 						</script> -->
						<embed src="../js/util/upload.swf?url_gubun=insert&appli_name=lsms&appli_no=0&config=%2Flsms%2Fjs%2Futil%2Fxmldata%2Fconfig" quality="high" bgcolor="#ffffff" width="400" height="200" name="upload" align="middle"/>
						<br>
							<font color="#3879a0">※ 업로드 가능한 파일 확장자는 gif,jpg,hwp,doc,docx,ppt,pptx,xls,pdf,txt,gux,hox,xlsx,nxl,hpt 입니다.
							</font>
						<br><font color="#3879a0">※ 파일 추가, 삭제 버튼이 동작하지 않을시,<br>&nbsp;&nbsp;&nbsp;사용하고 있는 Flash Player 가 version 8 이상인지 확인하여 주십시오.<br>&nbsp;&nbsp;&nbsp;<a href="http://oper2.hq.af.mil:8888/UNIT_INFO/com_info/program/intranet_application/flash.htm" target="_blank" onfocus="blur();" class="flash_a_tag">(Flash Player Download)</a></font><br><br>
					</div>
				</td>
			</tr>
			<tr height="30">
				<td colspan="6">
					<a href="#" onclick="datumSubmit('<c:out value="contentsVO"/>','S');" >저장</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#" onclick="datumSubmit('<c:out value="contentsVO"/>','A');" >결재상신</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="beltListResult.do">취소</a>
				</td>
			</tr>
		</table>
		<div id="error_wrapper" class="unit_highlight_hide">
			<div class="ui-widget">
				<div class="ui-state-highlight ui-corner-all" style="padding: 0 .7em; width: 708px;"> 
					<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
					<p id="input_confirm_text" style="text-align: left;">
						<form:errors path="*"/>
					</p>
				</div>
			</div>
		</div>
	</form:form>
</center>
<div id="example" class="example_">
	<table>
		<tr>
			<td>
				입력 예시)<br />
				2012년 1차 일 경우 : 12-01
			</td>
		</tr>
	</table>
	
</div>

<script type="text/javascript">
<!--
	$(document).ready(function(){
		var text = $('#input_confirm_text').text();
		
		if(text != ''){
			$('#error_wrapper').removeClass('unit_highlight_hide');
			$('#error_wrapper').addClass('unit_highlight_show');
		}
	});
//-->
</script>