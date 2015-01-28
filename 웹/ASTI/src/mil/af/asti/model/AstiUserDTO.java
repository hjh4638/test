package mil.af.asti.model;
/*회원 테이블 모델*/
public class AstiUserDTO {

	public AstiUserDTO(){}
	public AstiUserDTO(String user_id,String user_authority){
		setUser_authority(user_authority);
		setUser_id(user_id);
	}
	
	/*ASTI_USER 테이블의 pk.*/
	String user_id;
	
	/*사용자 로그인 비밀번호. not null*/
	String user_password;
	
	/*사용자 확인 비밀번호. not null*/
	String confirm_password;
	
	/*회원정보 수정시 사용할 기존 비밀번호*/
	String origin_password;
	

	/*사용자 이름. not null*/
	String user_name;
	
	/*사용자 성별. not null*/
	String user_sex;
	
	String user_sex_name;
	

	/*사용자 생년월일. not null*/
	String user_birth_date;
	
	String user_job;
	
	/*사용자 권한. ASTI_CODE 테이블의 code_id를 참조하는 fk*/
	String user_authority;
	
	/*ASTI_USER 테이블의 user_authority 코드에 해당하는 ASTI_CODE의 code_name*/
	String user_authority_name;
	
	String user_phone_number;
	
	/*회원가입 날짜. not null*/
	String user_register_date;

	public String getOrigin_password() {
		return origin_password;
	}
	public void setOrigin_password(String origin_password) {
		this.origin_password = origin_password;
	}
	public String getUser_sex_name() {
		return user_sex_name;
	}
	public void setUser_sex_name(String user_sex_name) {
		this.user_sex_name = user_sex_name;
	}
	public String getUser_authority_name() {
		return user_authority_name;
	}
	public void setUser_authority_name(String user_authority_name) {
		this.user_authority_name = user_authority_name;
	}
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}

	public String getUser_birth_date() {
		return user_birth_date;
	}

	public void setUser_birth_date(String user_birth_date) {
		this.user_birth_date = user_birth_date;
	}

	public String getUser_job() {
		return user_job;
	}

	public void setUser_job(String user_job) {
		this.user_job = user_job;
	}

	public String getUser_authority() {
		return user_authority;
	}

	public void setUser_authority(String user_authority) {
		this.user_authority = user_authority;
	}

	public String getUser_phone_number() {
		return user_phone_number;
	}

	public void setUser_phone_number(String user_phone_number) {
		this.user_phone_number = user_phone_number;
	}

	public String getUser_register_date() {
		return user_register_date;
	}

	public void setUser_register_date(String user_register_date) {
		this.user_register_date = user_register_date;
	}
	public String getConfirm_password() {
		return confirm_password;
	}
	public void setConfirm_password(String confirm_password) {
		this.confirm_password = confirm_password;
	}
	@Override
	public String toString() {
		return "AstiUserDTO [user_id=" + user_id + ", user_password="
				+ user_password + ", user_name=" + user_name + ", user_sex="
				+ user_sex + ", user_birth_date=" + user_birth_date
				+ ", user_job=" + user_job + ", user_authority="
				+ user_authority + ", user_authority_name="
				+ user_authority_name + ", user_phone_number="
				+ user_phone_number + ", user_register_date="
				+ user_register_date + "]";
	}

	
}
