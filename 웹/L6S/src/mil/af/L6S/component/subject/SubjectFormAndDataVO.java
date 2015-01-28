package mil.af.L6S.component.subject;

public class SubjectFormAndDataVO {
	String title;
	String data_type;
	String filename;
	
	/*step변수를 생성하면 절대 안됨(단계 입력시 데이터 1개만 입력됨)*/
	/*데이터 등록시 사용하는 변수*/
	Integer step_code;
	String form_id;
	String subkey;
	String data;
	
	/*데이터와 스텝리스트 가져올때와
	 * D,M,A,I,C 단계 진행현황때 사용*/
	String step_view;
	Integer fnd_count;
		
	String bigo;
	
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public Integer getFnd_count() {
		return fnd_count;
	}
	public void setFnd_count(Integer fnd_count) {
		this.fnd_count = fnd_count;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getStep_view() {
		return step_view;
	}
	public void setStep_view(String step_view) {
		this.step_view = step_view;
	}
	public Integer getStep_code() {
		return step_code;
	}
	public void setStep_code(Integer step_code) {
		this.step_code = step_code;
	}
	public String getSubkey() {
		return subkey;
	}
	public void setSubkey(String subkey) {
		this.subkey = subkey;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getForm_id() {
		return form_id;
	}
	public void setForm_id(String form_id) {
		this.form_id = form_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
}
