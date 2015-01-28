/**
	 * 제한 사이즈 초과시 에러 메시지 출력
	 */
	function overSize( limitSize )
	{
		var message = "허용 업로드 사이즈는 " + limitSize + "입니다.";

		alert( message );
	}

	/**
	 * 플래쉬 파일 리스트에 추가된 파일을 전송
	 */
	function fileUpload()
	{
		var movie = window.document.upload;
		
		var totalSize = movie.GetVariable("totalSize");

		// 업로드된 파일이 있을 경우 실행
		if( totalSize > 0 )
		{
			movie.SetVariable( "fileUpload", "" );
		}
		else
		{
			// 업로드 완료 후 처리 메쏘드 실행
			send();
		}
	}
	
	function onlyfileUpload()
	{
		var movie = window.document.upload;
		
		var totalSize = movie.GetVariable("totalSize");

		// 업로드된 파일이 있을 경우 실행
		if( totalSize > 0 )
		{
			movie.SetVariable( "fileUpload", "" );
		}
	}

	/**
	 * 파일 업로드 완료 후 처리 메쏘드
	 */
	function send()
	{
		document.forms[0].submit();
	}

	/**
	 * 허용하지 않은 형식의 파일일 경우 에러 메시지 출력
	 */
	function fileTypeError( notAllowFileType )
	{
		alert("확장자가 " + notAllowFileType + "인 파일들은 업로드 할수 없습니다.");
	}

	/**
	 * 플래쉬 버전이 8 미만일 경우 에러 메시지 출력
	 */
	function versionError()
	{
		alert("플래쉬 버전을 확인하여 주십시오.( 버전 8 이상만 가능합니다. )\n이미 설치하신 경우는 브라우저를 전부 닫고 다시 시작하여 주십시오.");
	}

	/**
	 * http 에러 발생시 출력 메시지
	 */
	function httpError(msg)
	{
		alert("네트워크 에러가 발생하였습니다. 잠시후 다시 시도하여 주십시오. " + msg);
	}

	/**
	 * 파일 입출력 에러 발생시 출력 메시지
	 * ( 주로 업로드 하려는 파일을 다른 프로그램에서 사용중일 경우 발생 )
	 */
	function ioError()
	{
		alert("입출력 에러가 발생하였습니다.\n( 다른 프로그램에서 이 파일을 사용하고 있는지 확인하신 후 다시 시도하여 주십시오. )");
	}
	function Embed()
	{
		document.write('<embed src="../js/util/upload.swf?url_gubun=insert&appli_name=lsms&appli_no=0&config=%2Flsms%2Fjs%2Futil%2Fxmldata%2Fconfig" quality="high" bgcolor="#ffffff" width="400" height="200" name="upload" align="middle"/>');
		//lsms일 때
//		document.write('<embed src="../js/util/upload.swf?url_gubun=insert&appli_name=L6S&appli_no=0&config=%2FL6S%2Fjs%2Futil%2Fxmldata%2Fconfig" quality="high" bgcolor="#ffffff" width="400" height="200" name="upload" align="middle"/>');
		//L6S일 때
//		document.write('<br><font color="#3879a0">※ 파일추가 버튼을 누른후 여러개의 파일을 드래그 하여 동시에 선택해 올릴 수 있습니다.</font>');
//		document.write('<br><font color="#3879a0">※ 파일 목록에서 파일을 제거하려면 대상 파일을 클릭하고 우측상단에 파일제거를 클륵하십시오.</font>');
//		document.write('<br><font color="#3879a0">※ 업로드 가능한 파일 확장자는 gif,jpg,hwp,doc,docx,ppt,pptx,xls,pdf,txt,gux,hox,xlsx,nxl,hpt 입니다.</font>');
//		document.write('<br><font color="#3879a0">※ 파일 추가, 삭제 버튼이 동작하지 않을시,<br>&nbsp;&nbsp;&nbsp;사용하고 있는 Flash Player 가 version 8 이상인지 확인하여 주십시오.<br>&nbsp;&nbsp;&nbsp;<a href="http://oper2.hq.af.mil:8888/UNIT_INFO/com_info/program/intranet_application/flash.htm" target="_blank" onfocus="blur();" class="flash_a_tag">(Flash Player Download)</a></font><br><br>');
	}