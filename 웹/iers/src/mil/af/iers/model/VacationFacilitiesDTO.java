package mil.af.iers.model;

public class VacationFacilitiesDTO {
	private Integer facilities_id;
	private String facilities_name;
	private String facilities_note;
	private String facilities_type;
	private String facilities_type_name;
	
	public String getFacilities_type() {
		return facilities_type;
	}
	public void setFacilities_type(String facilities_type) {
		this.facilities_type = facilities_type;
	}
	public String getFacilities_type_name() {
		return facilities_type_name;
	}
	public void setFacilities_type_name(String facilities_type_name) {
		this.facilities_type_name = facilities_type_name;
	}
	public Integer getFacilities_id() {
		return facilities_id;
	}
	public void setFacilities_id(Integer facilities_id) {
		this.facilities_id = facilities_id;
	}
	public String getFacilities_name() {
		return facilities_name;
	}
	public void setFacilities_name(String facilities_name) {
		this.facilities_name = facilities_name;
	}
	
	public String getFacilities_note() {
		return facilities_note;
	}
	public void setFacilities_note(String facilities_note) {
		this.facilities_note = facilities_note;
	}
	
}
