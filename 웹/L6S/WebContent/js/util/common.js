/**
 * Pop up opener
 * 
 * @param url
 *            보낼주소
 * @param width
 *            가로길이
 * @param heigth
 *            세로길이
 */
function openPopup(url, width, height) {
	var option = 'width='
			+ width
			+ ', height='
			+ height
			+ ', location=no, menubar=no, toolbar=no, scrollbars=yes, resizable=no, status=no';

	var opener = window.open(url, '', option);

	opener.focus();
}

function SetComma(obj){
	obj.value = Number(String(obj.value).replace(/\..*|[^\d]/g,'')).toLocaleString().slice(0, -3);
}

function goUpdate(url,data){
	var answer = confirm("인사자료 업데이트는 사용자들의 인사정보 변경(전속, 전역 등)을 본 체계에 적용 시키는 항목입니다. \n\n업데이트 하시겠습니까?");
	if(answer){
		var DATA = {
				'authority' : data
			};
		$(document).ready(function() {
			$.postJSON(url, DATA, function(result) {
				if (result == 'success') {
					alert("인사자료 업데이트가 완료 되었습니다.");
				}
			});
		});
	}else{
		return false;
	}
}

/**
 * Pop up Closer
 */
function closePopup() {
	opener.location.reload(true);

	self.close();
}

/**
 * 빈칸 또는 null Check
 */
function validateCheckNull(value) {

	if (value == '' || value == null || value == ' ')
		return false;
	else
		return true;
}

/**
 * 파일 다운로드
 * 
 * @param sn
 *            파일 고유넘버
 */
function download(filesn) {
	var url = "../main/download.do?filesn=" + filesn;

	location.href = url;
}

/**
 * 파일 삭제 Ajax post
 * 
 * @param fielUniqueNum
 */
function deleteFileData(url, sn) {
	if (confirm('파일을 삭제하시겠습니까?')) {
		var data = {
			'sn' : sn
		};

		$(document).ready(function() {
			$.postJSON(url, data, function(result) {
				if (result == 'success') {
					$('#file_' + sn).remove();
				}
			});
		});
	}
}

function returnFalse() {
	return false;
}

/**
 * 숫자만가능한 정규표현식
 * 
 * @param value
 *            값
 * @returns
 */
function checkDateRegExp(value) {
	var regExp = new RegExp('^[0-9]*$');
	var ok = regExp.exec(value);

	return ok;
}

/**
 * 작성일자와 완료일자를 비교
 * 
 * @param write
 * @param complete
 * @returns {Boolean}
 */
function writeDayCompareCompletDay(write, complete) {
	// 작성일
	var wYear = parseInt(write.substr(0, 4));
	var wMonth = parseInt(write.substr(4, 2));

	// 완료예정일
	var completArray = complete.split('-');
	var cYear = parseInt(completArray[0]);
	var cMonth = parseInt(completArray[1]);

	var bool = true;

	if (validateCheckNull(cYear) || validateCheckNull(cMonth)) {
		// 년도가 작을수는 없음
		if (wYear > cYear) {
			bool = false;
		} else if (wYear == cYear) {
			if (wMonth > cMonth) {
				bool = false;
			}
		} else {
			bool = true;
		}
	}

	return bool;
}

function goToDisposalMain(uniqueNum) {
	location.href = "promote/list.do?uniqueNum=" + uniqueNum;
}

function alertNotDelete() {
	alert('사용중임으로 삭제 또는 수정이 불가능합니다.');
}