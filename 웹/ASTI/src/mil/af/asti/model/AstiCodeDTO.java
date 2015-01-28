package mil.af.asti.model;
/*코드관리 테이블 모델*/
public class AstiCodeDTO {

	/*ASTI_CODE 테이블의 pk.*/
	String code_id;
	
	/*게시판 영역의 코드인지 권한 영역 코드인지 type 설정*/
	String code_type;
	
	String code_name;
	public String getCode_id() {
		return code_id;
	}
	public void setCode_id(String code_id) {
		this.code_id = code_id;
	}
	public String getCode_type() {
		return code_type;
	}
	public void setCode_type(String code_type) {
		this.code_type = code_type;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
}
