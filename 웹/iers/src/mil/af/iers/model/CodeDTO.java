package mil.af.iers.model;

public class CodeDTO {
	String code_id;
	String code_type;
	String code_name;
	Integer code_score;
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
	public Integer getCode_score() {
		return code_score;
	}
	public void setCode_score(Integer code_score) {
		this.code_score = code_score;
	}
}
