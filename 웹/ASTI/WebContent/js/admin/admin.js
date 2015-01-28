function pageMove(page){
	var searchDetail = $('#searchDetail').val();
	var searchType = $('#searchType').val();
	$("#memManage")
		.empty()
		.load("/ASTI/admin/membermanage.do?currentPage="+page+"&searchType="+searchType+"&searchDetail="+searchDetail);
}

function searchAdminBoard(){
	var searchDetail = $('#searchDetail').val();
	var searchType = $('#searchType').val();
//	if((searchDetail==null || searchDetail=="")){
//		alert("검색어를 입력해주시기 바랍니다.");
//	}
		$("#memManage")
			.empty()
			.load("/ASTI/admin/membermanage.do?currentPage="+"1"+
					"&searchType="+searchType+"&searchDetail="+searchDetail);
	
}

function changeAuth()
{ 
	document.forms.authChange.submit();
}

function enterKeyPress()
{
	var key;
	if(window.event)
	{
		key = window.event.keyCode;
		if(key==13){
			searchAdminBoard();
//			return false;
		}
	}
} 

function deleteMember(id)
{
	if(confirm("삭제시 복구할 수 없습니다. 삭제하시겠습니까?")){
		location.href="deleteMember.do?id="+id;
	}
}