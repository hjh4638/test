package mil.af.L6S.component.common;

import org.springframework.web.multipart.MultipartFile;

/**
 * 파일업로드 VO
 * 
 * @author 정성모
 *
 */
public class UploadVO {

	private MultipartFile filedata;

	public MultipartFile getFiledata() {
		return filedata;
	}

	public void setFiledata(MultipartFile filedata) {
		this.filedata = filedata;
	}


}
