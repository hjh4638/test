function pageMove(page){
	var form = document.forms.astiBoardSearchDTO;
	var board_type = form.board_type.value;
	var searchDetail = form.searchDetail.value;
	var searchType = form.searchType.value;
	$("#Code"+board_type)
		.empty()
		.load("/ASTI/board/board.do?currentPage="+page+"&board_type="+board_type+"&searchType="+searchType+"&searchDetail="+searchDetail);
}

function searchFreeBoard(){
	var form = document.forms.astiBoardSearchDTO;
	var searchDetail = form.searchDetail.value;
	var board_type = form.board_type.value;
	var searchType = form.searchType.value;
	if(searchDetail==null || searchDetail==""){
		alert("검색어를 입력해주시기 바랍니다.");
	}
	else{
		$("#Code"+board_type)
			.empty()
			.load("/ASTI/board/board.do?currentPage="+"1"+"&board_type="+board_type+
					"&searchType="+searchType+"&searchDetail="+searchDetail);
	}
	
}

function gotoInsertPage(board_type){
	$.ajax({
		  url: "/ASTI/board/insert.do",
		  data:{board_type:board_type},
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#Code"+board_type).html(data);
		  }
		});
//	$("#Code"+board_type)
//		.empty()
//		.load("/ASTI/board/insert.do?board_type="+board_type);
//	
//	location.href="insert.do?board_type="+board_type;
}

function LoadBoard(code){
//IE에서 게시판 입력하면 다시 켜지 않는한 LIST 보이지 않는 문제 때문에 수정함
//cache:false가 주요함
/*	$("#Code"+code)
	.empty()
	.load("/ASTI/board/board.do?board_type="+code); */
	/*$("#Code"+code).empty();
	$("#Code"+code).load("/ASTI/board/board.do?board_type="+code);*/
	$.ajax({
		  url: "/ASTI/board/board.do",
		  data:{board_type:code},
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#Code"+code).html(data);
		  }
		});
	
}
function LoadView(board_id,board_type) {
//		
//	$("#Code"+board_type).load("/ASTI/board/view.do?board_id="+board_id+"&board_type="+board_type);
//		view.do?board_id=${freeBoardContents.board_id }&board_type=${board_type }
	$.ajax({
		  url: "/ASTI/board/view.do",
		  data:{board_id:board_id,board_type:board_type},
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#Code"+board_type).html(data);
		  }
		});
}

function replyComment(add_id){
	$('.view_CommentReplyZone').hide();
	$('#view_CommentReply_'+add_id).css("display","table-row");
	alert("test");
}

function replyCommentSubmit(board_id,add_id){
	var form = document.forms.insertReply;
	form.board_id.value = board_id; 
	form.add_writer.value = $('#add_writer_'+add_id).val(); 
	form.add_upper_id.value = add_id;
	form.add_content.value = $('#add_content_'+add_id).val();
	
	form.submit();	 
}  

function insertComment(){
	var form = document.forms.insertComment;
	var board_id = form.board_id.value;
	var add_writer = form.add_writer.value;
	var board_type = form.board_type.value;
	var add_content = form.add_content.value;
}

function LoadUpdate(board_id,board_type){
//	$("#Code"+board_type)
//	.empty()
//	.load("/ASTI/board/insert.do?board_id="+board_id+"&board_type="+board_type);
	$.ajax({
		  url: "/ASTI/board/insert.do",
		  data:{board_id:board_id,board_type:board_type},
		  dataType:"html",
		  cache: false,
		  success: function(data){
			  $("#Code"+board_type).html(data);
		  }
		});
}
//마우스 오버
function onboard(cnt) {
	$("#bgcol"+cnt).css("color","#2159b0");
}
function outboard(cnt){
	$("#bgcol"+cnt).css("color","black");
}

function gotoDelete(id,url){
	var board_id =id;
	if(confirm("정말로 삭제하시겠습니까?")){
		$.post("/ASTI/ajax/boardDelete.do",{board_id:board_id},function(isValid){
			if(isValid == "success"){
				location.href=url;
			}else{
				alert("삭제실패");
			}
		});
	}
}
//기고문 삭제할때 패스워드도 필요해서리;;
function gotoDeleteByB07(id,url,password){
	var board_id =id;
	var board_password = password;
	var board_type = 'B07';
	if(confirm("정말로 삭제하시겠습니까?")){
		$.post("/ASTI/ajax/boardDelete.do",{board_id:board_id,board_password:board_password,board_type:board_type},function(isValid){
			if(isValid == "success"){
				location.href=url;
			}else{
				alert("삭제실패");
			}
		});
	}
}

function downloadFile(form){
	var file_id = $(form).find('input[name=filename]').val();
	$.post("/ASTI/ajax/downloadCheck.do",{file_id:file_id},function(isValid){
		if(isValid == "success"){
			form.submit();				
		}
		else{
			alert("다운로드 권한이 없습니다.");
		}
	});
}

function enterKeyPress()
{
	var key;
	if(window.event)
	{
		key = window.event.keyCode;
		if(key==13){
			searchFreeBoard();
			return false;
		}
	}
} 
