package mil.af.L6S.component.common;

/**
 * 파일업로드
 * 
 * @author 정성모
 * 
 */
public class FileVO {

	/**
	 * 파일 고유 코드
	 */
	private String sn;
	
	/**
	 * 파일 FK
	 */
	private String seq;

	/**
	 * 파일이름
	 */
	private String fileName;

	/**
	 * 저장한 파일이름
	 */
	private String saveName;

	/**
	 * 파일 타입
	 */
	private String type;

	public String getName() {
		return fileName;
	}

	public String getSaveName() {
		return saveName;
	}

	public String getSeq() {
		return seq;
	}

	public String getSn() {
		return sn;
	}

	public String getType() {
		return type;
	}

	public void setName(String fileName) {
		this.fileName = fileName;
	}

	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "FileVO [sn=" + sn + ", seq=" + seq + ", fileName=" + fileName
				+ ", saveName=" + saveName + ", type=" + type + "]";
	}

	
}
