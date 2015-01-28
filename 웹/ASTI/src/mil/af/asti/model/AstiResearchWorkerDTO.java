package mil.af.asti.model;
/*연구원 관리 테이블 모델*/
public class AstiResearchWorkerDTO {
	/*ASTI_CODE 에 필요한 부분*/
	String code_id;
	String code_name;
	public String getCode_id() {
		return code_id;
	}

	public void setCode_id(String code_id) {
		this.code_id = code_id;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	Integer row_number;
	
	Integer row_count;
		
	public Integer getRow_number() {
		return row_number;
	}

	public void setRow_number(Integer row_number) {
		this.row_number = row_number;
	}

	public Integer getRow_count() {
		return row_count;
	}

	public void setRow_count(Integer row_count) {
		this.row_count = row_count;
	}

	/*ASTI_RESEARCH_WORKER 테이블의 pk.*/
	Integer worker_id;
	
	/*연구원 이름. not null 제약사항이 있음*/
	String worker_name;
	
	String worker_department;
	
	String worker_department_name;
	

	String worker_detail_info;
	
	/*ASTI_RESEARCH_WORKER 테이블의 uk. 난수+worker_id 들어갈것*/
	String worker_picture_id;
	
	String worker_picture_name;
	
	String worker_major;
	
	String worker_phone_number;
	
	String worker_fax_number;
	
	String worker_email;
	
	
	public String getWorker_department_name() {
		return worker_department_name;
	}
	
	public void setWorker_department_name(String worker_department_name) {
		this.worker_department_name = worker_department_name;
	}

	public Integer getWorker_id() {
		return worker_id;
	}

	public void setWorker_id(Integer worker_id) {
		this.worker_id = worker_id;
	}

	public String getWorker_name() {
		return worker_name;
	}

	public void setWorker_name(String worker_name) {
		this.worker_name = worker_name;
	}

	public String getWorker_department() {
		return worker_department;
	}

	public void setWorker_department(String worker_department) {
		this.worker_department = worker_department;
	}

	public String getWorker_detail_info() {
		return worker_detail_info;
	}

	public void setWorker_detail_info(String worker_detail_info) {
		this.worker_detail_info = worker_detail_info;
	}

	public String getWorker_picture_id() {
		return worker_picture_id;
	}

	public void setWorker_picture_id(String worker_picture_id) {
		this.worker_picture_id = worker_picture_id;
	}

	public String getWorker_picture_name() {
		return worker_picture_name;
	}

	public void setWorker_picture_name(String worker_picture_name) {
		this.worker_picture_name = worker_picture_name;
	}

	public String getWorker_major() {
		return worker_major;
	}

	public void setWorker_major(String worker_major) {
		this.worker_major = worker_major;
	}

	public String getWorker_phone_number() {
		return worker_phone_number;
	}

	public void setWorker_phone_number(String worker_phone_number) {
		this.worker_phone_number = worker_phone_number;
	}

	public String getWorker_fax_number() {
		return worker_fax_number;
	}

	public void setWorker_fax_number(String worker_fax_number) {
		this.worker_fax_number = worker_fax_number;
	}

	public String getWorker_email() {
		return worker_email;
	}

	public void setWorker_email(String worker_email) {
		this.worker_email = worker_email;
	}

	
	
	
	
}
