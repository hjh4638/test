package mil.af.iers.model;

public class SettlementDTO {
//	facilities_id를 이용 VacationFacilitiesDTO 가져오는 메소드 생성하자!
	
	String settlement_day;
	Integer facilities_id;
	Integer settlement_people_count;
	Integer settlement_price;
	Integer settlement_total_price;
	String settlement_note;
	Integer settlement_add_price;	
	Integer settlement_reservation;
	String facilities_name;
	
	public String getFacilities_name() {
		return facilities_name;
	}
	public void setFacilities_name(String facilities_name) {
		this.facilities_name = facilities_name;
	}
	public Integer getSettlement_reservation() {
		return settlement_reservation;
	}
	public void setSettlement_reservation(Integer settlement_reservation) {
		this.settlement_reservation = settlement_reservation;
	}
	public Integer getSettlement_add_price() {
		return settlement_add_price;
	}
	public void setSettlement_add_price(Integer settlement_add_price) {
		this.settlement_add_price = settlement_add_price;
	}
	public String getSettlement_day() {
		return settlement_day;
	}
	public void setSettlement_day(String settlement_day) {
		this.settlement_day = settlement_day;
	}
	public Integer getFacilities_id() {
		return facilities_id;
	}
	public void setFacilities_id(Integer facilities_id) {
		this.facilities_id = facilities_id;
	}
	public Integer getSettlement_people_count() {
		return settlement_people_count;
	}
	public void setSettlement_people_count(Integer settlement_people_count) {
		this.settlement_people_count = settlement_people_count;
	}
	public Integer getSettlement_price() {
		return settlement_price;
	}
	public void setSettlement_price(Integer settlement_price) {
		this.settlement_price = settlement_price;
	}
	public Integer getSettlement_total_price() {
		return settlement_total_price;
	}
	public void setSettlement_total_price(Integer settlement_total_price) {
		this.settlement_total_price = settlement_total_price;
	}
	public String getSettlement_note() {
		return settlement_note;
	}
	public void setSettlement_note(String settlement_note) {
		this.settlement_note = settlement_note;
	}
}
