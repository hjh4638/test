package mil.af.iers.model;

public class ReservationDTO {
	
//	facilities_id를 이용 VacationFacilitiesDTO 가져오는 메소드 생성하자!
//	user_id,user_sosok을 이용 UserDTO 객체 가져오는 메소드 생성하자!
	
	String facilities_type;
	String user_id;
	String user_sosok;
	String reservation_day;
	Integer reservation_period;
	String reservation_register_date;
	String reservation_state;
	Integer reservation_people_count;
	Integer reservation_id;
	String reservation_note;
	String user_name;
	String user_rank;
	
	String reservation_state_name;
	String facilities_type_name;
	String user_auth_name;
	
	String user_score;
	
	public String getUser_score() {
		return user_score;
	}
	public void setUser_score(String user_score) {
		this.user_score = user_score;
	}
	public String getUser_auth_name() {
		return user_auth_name;
	}
	public void setUser_auth_name(String user_auth_name) {
		this.user_auth_name = user_auth_name;
	}
	public String getReservation_state_name() {
		return reservation_state_name;
	}
	public void setReservation_state_name(String reservation_state_name) {
		this.reservation_state_name = reservation_state_name;
	}
	public String getFacilities_type_name() {
		return facilities_type_name;
	}
	public void setFacilities_type_name(String facilities_type_name) {
		this.facilities_type_name = facilities_type_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_rank() {
		return user_rank;
	}
	public void setUser_rank(String user_rank) {
		this.user_rank = user_rank;
	}
	Integer reservation_price;
	
	public Integer getReservation_price() {
		return reservation_price;
	}
	public void setReservation_price(Integer reservation_price) {
		this.reservation_price = reservation_price;
	}
	public String getReservation_note() {
		return reservation_note;
	}
	public void setReservation_note(String reservation_note) {
		this.reservation_note = reservation_note;
	}

	public String getFacilities_type() {
		return facilities_type;
	}
	public void setFacilities_type(String facilities_type) {
		this.facilities_type = facilities_type;
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
	public String getReservation_day() {
		return reservation_day;
	}
	public void setReservation_day(String reservation_day) {
		this.reservation_day = reservation_day;
	}
	public Integer getReservation_period() {
		return reservation_period;
	}
	public void setReservation_period(Integer reservation_period) {
		this.reservation_period = reservation_period;
	}
	public String getReservation_register_date() {
		return reservation_register_date;
	}
	public void setReservation_register_date(String reservation_register_date) {
		this.reservation_register_date = reservation_register_date;
	}
	public String getReservation_state() {
		return reservation_state;
	}
	public void setReservation_state(String reservation_state) {
		this.reservation_state = reservation_state;
	}
	public Integer getReservation_people_count() {
		return reservation_people_count;
	}
	public void setReservation_people_count(Integer reservation_people_count) {
		this.reservation_people_count = reservation_people_count;
	}
	public Integer getReservation_id() {
		return reservation_id;
	}
	public void setReservation_id(Integer reservation_id) {
		this.reservation_id = reservation_id;
	}
}
