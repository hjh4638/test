function approval(rank, name, sosok, ass, sn) {
	var ApprovalSelect = parent.right.document.bb;
	if(sn==ApprovalSelect.sn0.value
			){
		alert("이미 추가된 결재자 입니다!");
	}
	else{
		if (ApprovalSelect.rank0.value == "") {
				ApprovalSelect.rank0.value = rank;
				ApprovalSelect.name0.value = name;
				ApprovalSelect.ass0.value = ass;
				ApprovalSelect.sn0.value = sn;
	
			}
		}
}
function DeleteLine(line) {
	var ApprovalSelect = parent.right.document.bb;
	var i = 0;

	if (line == 0) {
		ApprovalSelect.rank0.value = "";
		ApprovalSelect.name0.value = "";
		ApprovalSelect.ass0.value = "";
		ApprovalSelect.sn0.value = "";
	
	} 
}
function ReturnGubun(gubun) {
	return gubun;
}
function ReturnMax() {
	var i;
	for (i = 0; i < 5; i++) {
		var check = eval("document.bb.rank" + i);
		if (check.value = "")
			break;
	}
	return i;
}
