package mil.af.orms.model;

public class ResultWithCountVO {
	public ResultWithCountVO(String result_code,String result_name,Integer count){
		this.result_code=result_code;
		this.result_name=result_name;
		this.count=count;
	}
	String result_code;
	String result_name;
	Integer count;
	
	public String getResult_code() {
		return result_code;
	}
	public void setResult_code(String result_code) {
		this.result_code = result_code;
	}
	public String getResult_name() {
		return result_name;
	}
	public void setResult_name(String result_name) {
		this.result_name = result_name;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
}
