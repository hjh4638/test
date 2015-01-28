<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="<c:url value='/js/top_sub/top_sub.js'/>"></script>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<%-- <script type="text/javascript" src="<c:url value='js/jquery.validate.min.js'/>"></script> --%>
       <script>
	   $(document).ready(function(){
		   
// 			$(".navigation").mouseenter(function() {
// 				var subid = $(this).attr('subid');
// 				$('.topSubBar[subid=' + subid + ']').show();
// 				$('.topSubBar[subid!=' + subid + ']').hide();
// 			});	
// 			var list = [ "subject", "belt", "board"];
// 			var found = -1;
// 			for (var i = 0; i < 3; i++) {
// 				var search = list[i];
// 				if (location.href.indexOf(search) != -1) {
// 					found = i;
// 					break;
// 				}
// 			}
// 			if (found != -1) {
// 				found++;
// 				$('.topSubBar[subid=' + found + ']').show();
// 				$('.topSubBar[subid!=' + found + ']').hide();
				
// 			}
// 			$("#topmenu2").mouseleave(function() {
// 				$(".topSubBar").hide();
// 			});

			$(".navigation").click(function() {
				$(".topSubBar").toggle("blind");
			});	
			$("#topmenu2").mouseleave(function() {
				$(".topSubBar").hide("blind");
			});
			
	
    

			$("#user_birth_date").datepicker({
				dateFormat : 'yy/mm/dd',
				changeMonth: true,
				changeYear: true,
				yearRange: "c-100:c",
				showOn: "both",
				showAnim: '',
				duration: '',
				buttonImage: "../images/calender.gif",
				buttonImageOnly: true,
				numberOfMonths: 1
// 				,
// 				onClose: function(selectedDate){
// 					$("#user_birth_date").datepicker("option", "minDate", selectedDate);
// 				}
			});
			
			$("#user_id").focusout(function(){
				var user_id = $("#user_id").val(); //이메일
				
				if(user_id != null){
					$.get("isUserIdDup.do",{user_id:user_id},function(isDup){
						if(isDup == "true"){
							$("#dup").text("사용불가능");
						}else{
							$("#dup").text("사용가능");
						}
					});
				}
			});
			
// 			$("#signupForm").validate({
// 				rules:{
// 					user_id : { 
// 						required: true,
// 						email:true
// 					},
// 					user_name : "required",
// 					password: {
// 						required: true,
// 						minlength: 8
// 					},
// 					confirm_password: {
// 						required: true,
// 						minlength: 8,
// 						equalTo: "#user_password"
// 					},
// 					user_birth_date : "required"
// 				},
// 				messages:{
// 					user_id : "이메일 오류",
// 					user_name: "이름이 필요합니다.",
// 					password: {
// 						required: "비밀번호를 입력해주세요",
// 						minlength: "비밀번호는 8자리 이상"
// 					},
// 					confirm_password: {
// 						required: "비밀번호를 입력해주세요",
// 						minlength: "비밀번호는 8자리 이상",
// 						equalTo: "비밀번호가 다릅니다."
// 					},
// 					user_birth_date : "생년월일을 입력해세요"
// 				}
// 			});
// 			$("#signUpDiv").dialog({
// 				autoOpen : false,
// 				height: 300,
// 				width: 350,
// 				modal: true,
// 				buttons:{
// 					"계정생성" : function(){
// 						$("#submitBtn").click();
// 					},
// 					"닫기" : function(){
// 						$(this).dialog("close");
// 					}
// 				}
// 			});
			$("#joinBtn").click(function(){
				location.href="${cp}/main/signUp.do";
			});
			
			$("#signInDiv").dialog({
				resizable: false,
				autoOpen : false,
				height: 165,
				width: 300,
				modal: true,
				buttons:{
					"로그인" : function(){
						var user_id = $("#sign_user_id").val();
						var user_password = $("#sign_user_password").val();
						$.post("/ASTI/main/isValidSignIn.do",{user_id:user_id,user_password:user_password},function(isValid){
							if(isValid == "true"){
								alert("로그인성공");
// 								window.location.href="index.do";
								location.href="${cp}/main/index.do";
							}
							else if(isValid == "notApproval")
								alert("계정승인이 아직 이루어지지 않았습니다.");
							else{
								alert("아이디와 비밀번호를 다시확인 하여주십시오");
							}
						});
					},
					"닫기" : function(){
						$(this).dialog("close");
					}
				}
			});
			$("#signinBtn").click(function(){
				$("#signInDiv").dialog("open");
			});
			
		});
		
		$(function(){
			$("#signoutBtn").click(function(){
				window.location.href="/ASTI/main/sign_out.do";
			});
			$("#changeInfoBtn").click(function(){
				/* var user_id = $("#log_user_id").val(); */
				location.href="${cp}/main/signUp.do";
			});
			
// 			$("#changeInfoDiv").dialog({
// 				autoOpen : false,
// 				height: 300,
// 				width: 350,
// 				modal: true,
// 				buttons:{
// 					"수정" : function(){
						
// 					},
// 					"취소" : function(){
// 						$(this).dialog("close");
// 					},
// 					"탈퇴" : function(){
// 						jQuery.ajax({
// 							url:"/ASTI/ajax/removeMember.do",
// 							type:"get",
// 							success:function(data){
// 								alert("탈퇴가 완료되었습니다");
// 								location.reload(true);
// 							}
// 						});
// 					}
// 				}
// 			});
		});
		
// 	function GoBoard(code) {
//  		alert(code);
// 		window.location.href ="/ASTI/board/board.do?board_type="+code;
// 	}
	function GoMain() {
		window.location.href ="/ASTI/main/index.do";
	}
	function GoDept(code) {
		window.location.href ="/ASTI/dept/dept.do?code="+code;
	}
	function GoInfoPage(code){
		window.location.href ="/ASTI/info/info.do?code="+code;
	}
	function GoJournal(code){
		window.location.href="/ASTI/journal/journal.do?code="+code;
	}
	function GoEdu(code){
		window.location.href="/ASTI/edu/edu.do?code="+code;
	}
	function GoEduPage(code){
		window.location.href="/ASTI/edu/edu.do?code="+code;
	}
	function GoNotif(code){
		window.location.href="/ASTI/notif/notif.do?code="+code;
	}
</script>



<div id="menu">
	<div id="topmenu1">
		<div style="width:202px;height:77px;float:left;">
			<img style="margin-left:8px;margin-top:13px;width:137px;height:46px;float:left;cursor: pointer;" src="<c:url value="/images/main/yonsei.gif"/>"/>
		</div>
		<div style="width:509px;height:77px;float:left;">
			<img style="width:150px;height:60px;float:right;cursor: pointer;margin-right:124px;" onclick="GoMain()" src="<c:url value="/images/main/ASTI.gif"/>"/>
		</div>
		<div style="width:311px;height:77px;float:left;">
			<c:choose>
				<%-- <c:when test="${USERINFO.user_id ne ''}">
	<!-- 				<script> alert("${signed}");</script> -->
					<c:if test="${USERINFO.user_authority eq 'Z00' }">
						<a href="/ASTI/admin/auth.do">관리자 페이지</a> 
					</c:if>
					<button id="signoutBtn"> 로그아웃</button>
					<button id="changeInfoBtn"> 회원정보수정 </button>
				<jsp:include page="../member/modify.jsp"/>	
				</c:when>
				<c:otherwise>
	<!-- 			<script> alert("${signed}");</script> -->
					<button id="joinBtn">회원가입</button>
					<button id="signinBtn"> 로그인</button>
				<jsp:include page="../member/join.jsp"/>
				<jsp:include page="../member/login.jsp"/>
				</c:otherwise> --%>
				<c:when test="${USERINFO.user_id eq null}">  
	<!-- 			<script> alert("${signed}");</script> -->
<!-- 					<button id="joinBtn">회원가입</button> -->
<!-- 					<button id="signinBtn"> 로그인</button> -->
<!-- 				<div class="logDiv"> -->  
					<div class="logDivContent" style="margin-right:11px;" id="joinBtn" title="회원가입"><img src="<c:url value='/images/userbtn-kr/register.gif'/>"/></div>
					<div class="logDivLine"><img src="<c:url value='/images/main/line_02.gif'/>"/></div>
					<div class="logDivContent" id="signinBtn" title="로그인"><img src="<c:url value='/images/userbtn-kr/log-in.gif'/>"/></div>
<!-- 				</div> -->
				<%-- <jsp:include page="../member/join.jsp"/> --%>
				<jsp:include page="../member/login.jsp"/>
				</c:when>
				<c:otherwise>
	<!-- 				<script> alert("${signed}");</script> -->
				
<!-- 					<button id="signoutBtn"> 로그아웃</button> -->
<%-- 					<button id="changeInfoBtn" value="${USERINFO.user_id }"> 회원정보수정 </button> --%>
<!-- 					<div class="logDiv"> -->
						<input type="hidden" id="log_user_id" value="${USERINFO.user_id }"/>
						<div class="logDivContent" style="margin-right:11px;" id="signoutBtn" title="로그아웃"><img src="<c:url value='/images/userbtn-kr/log-out.gif'/>"/></div>
						<div class="logDivLine"><img src="<c:url value='/images/main/line_02.gif'/>"/></div>
						<div class="logDivContent" id="changeInfoBtn" title="회원정보수정"><img src="<c:url value='/images/userbtn-kr/my-info.gif'/>"/></div>
						<c:if test="${USERINFO.user_authority eq 'Z00' }">
	<!-- 						<a href="/ASTI/admin/auth.do">관리자 페이지</a>  -->
							<div class="logDivLine" ><img src="<c:url value='/images/main/line_02.gif'/>"/></div>
							<div class="logDivContent"><a href="/ASTI/admin/auth.do" title="관리자 메뉴"><img src="<c:url value='/images/userbtn-kr/admin-page.gif'/>"/></a></div>
						</c:if>
<!-- 					</div> -->
				<%-- <jsp:include page="../member/modify.jsp"/>	 --%>
				</c:otherwise>
			</c:choose>
<!-- 		<div style="width:252px; height:52px;margin-right:-34px;margin-top:26px;"> -->
<%-- 			<img style="width:252px;height:52px;" src="<c:url value='/images/main/Airforce_logo.gif'/>"> --%>
<!-- 		</div> -->
		</div>
	</div>
	<div id="topmenu2">
		<div id="topmenu3" style="cursor:pointer">
			<div class="navigation" subid="0" style="margin-left:1px;"></div>
			<div class="navigation" subid="1"></div>
			<div class="navigation" subid="2"></div>
			<div class="navigation" subid="3"></div>
			<div class="navigation" subid="4"></div>
			<div id="line_title">
				<img style="margin-left:1px;" src="<c:url value='/images/main/line_title_01.gif'/>"/>
			</div>
		</div>
		<div class="topSubBar">
			<div class="mainMenutitle" style="margin-left:2px;">
				<div class="Menutitle" style="height:42px" onclick="GoInfoPage('A00');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_01_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoInfoPage('A01');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_02_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoInfoPage('A02');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_03_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoInfoPage('A03');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_04_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoInfoPage('A04');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_05_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoInfoPage('A05');"><img class="top_sub_01" src="<c:url value='/images/top_sub/top_sub_01_06_off.gif'/>"/></div>
			</div>
			<div class="mainMenutitle">
				<div class="Menutitle" style="height:42px" onclick="GoDept('C00');"><img class="top_sub_02" src="<c:url value='/images/top_sub/top_sub_02_01_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoDept('C01');"><img class="top_sub_02" src="<c:url value='/images/top_sub/top_sub_02_02_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoDept('C02');"><img class="top_sub_02" src="<c:url value='/images/top_sub/top_sub_02_03_off.gif'/>"/></div>
			</div>
			<div class="mainMenutitle">
				<div class="Menutitle" style="height:42px" onclick="GoJournal('B00');"><img class="top_sub_03" src="<c:url value='/images/top_sub/top_sub_03_01_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoJournal('B01');"><img class="top_sub_03" src="<c:url value='/images/top_sub/top_sub_03_02_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoJournal('B02');"><img class="top_sub_03" src="<c:url value='/images/top_sub/top_sub_03_03_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoJournal('B03');"><img class="top_sub_03" src="<c:url value='/images/top_sub/top_sub_03_04_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoJournal('A06');"><img class="top_sub_03" src="<c:url value='/images/top_sub/top_sub_03_05_off.gif'/>"/></div>
			</div>
			<div class="mainMenutitle">
				<div class="Menutitle" style="height:42px" onclick="GoEduPage('A07');"><img class="top_sub_04" src="<c:url value='/images/top_sub/top_sub_04_01_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoEduPage('A08');"><img class="top_sub_04" src="<c:url value='/images/top_sub/top_sub_04_02_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoEduPage('A09');"><img class="top_sub_04" src="<c:url value='/images/top_sub/top_sub_04_03_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoEduPage('A10');"><img class="top_sub_04" src="<c:url value='/images/top_sub/top_sub_04_04_off.gif'/>"/></div>
			</div>
			<div class="mainMenutitle">
				<div class="Menutitle" style="height:42px" onclick="GoNotif('B04');"><img class="top_sub_05" src="<c:url value='/images/top_sub/top_sub_05_01_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoNotif('B05');"><img class="top_sub_05" src="<c:url value='/images/top_sub/top_sub_05_02_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoNotif('B06');"><img class="top_sub_05" src="<c:url value='/images/top_sub/top_sub_05_03_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoNotif('B07');"><img class="top_sub_05" src="<c:url value='/images/top_sub/top_sub_05_04_off.gif'/>"/></div>
				<div class="Menutitle" onclick="GoNotif('B08');"><img class="top_sub_05" src="<c:url value='/images/top_sub/top_sub_05_05_off.gif'/>"/></div>
			</div>
		</div>
	</div>
</div>