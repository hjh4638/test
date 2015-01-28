package mil.af.iers.model;

import org.springframework.beans.factory.annotation.Autowired;


public class UserDTO {
	
	private String user_id;
	private String user_sosok;
	private String user_rank;
	private String user_sosok_name;
	private String user_rank_name;
	private String user_name;
	private String user_cellular_phone;
	private String user_auth;
	private String user_auth_name;
//	입대일
	private String user_service_term;
	private String user_file_id;
	private String user_file_name;
	private String user_sosok_detail;
	private String user_password;
	private String password_confirm;
	private String origin_password;
	private Integer user_score;
		
	public String getOrigin_password() {
		return origin_password;
	}
	public void setOrigin_password(String origin_password) {
		this.origin_password = origin_password;
	}
	public String getPassword_confirm() {
		return password_confirm;
	}
	public void setPassword_confirm(String password_confirm) {
		this.password_confirm = password_confirm;
	}
	public String getUser_auth_name() {
		return user_auth_name;
	}
	public void setUser_auth_name(String user_auth_name) {
		this.user_auth_name = user_auth_name;
	}
	public String getUser_auth() {
		return user_auth;
	}
	public void setUser_auth(String user_auth) {
		this.user_auth = user_auth;
	}
	public String getUser_sosok_name() {
		return user_sosok_name;
	}
	public void setUser_sosok_name(String user_sosok_name) {
		this.user_sosok_name = user_sosok_name;
	}
	public String getUser_rank_name() {
		return user_rank_name;
	}
	public void setUser_rank_name(String user_rank_name) {
		this.user_rank_name = user_rank_name;
	}
	public void setUser_score(Integer user_score) {
		this.user_score = user_score;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_sosok() {
		return user_sosok;
	}
	public void setUser_sosok(String user_sosok) {
		this.user_sosok = user_sosok;
	}
	public String getUser_rank() {
		return user_rank;
	}
	public void setUser_rank(String user_rank) {
		this.user_rank = user_rank;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_cellular_phone() {
		return user_cellular_phone;
	}
	public void setUser_cellular_phone(String user_cellular_phone) {
		this.user_cellular_phone = user_cellular_phone;
	}
	public String getUser_service_term() {
		return user_service_term;
	}
	public void setUser_service_term(String user_service_term) {
		this.user_service_term = user_service_term;
	}
	public String getUser_file_id() {
		return user_file_id;
	}
	public void setUser_file_id(String user_file_id) {
		this.user_file_id = user_file_id;
	}
	public String getUser_file_name() {
		return user_file_name;
	}
	public void setUser_file_name(String user_file_name) {
		this.user_file_name = user_file_name;
	}
	public String getUser_sosok_detail() {
		return user_sosok_detail;
	}
	public void setUser_sosok_detail(String user_sosok_detail) {
		this.user_sosok_detail = user_sosok_detail;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public Integer getUser_score() {
		return user_score;
	}
	
}
