package mil.af.orms.model;

public class UserAuthVO {
	
	public static final String FORMATION_MANAGER="01";
	public static final String SQUADRON_MANAGER="02";
	public static final String GROUP_MANAGER="03";
	public static final String CQ="04";
	public static final String SYSTEM_ADMIN="05";
	
	String sosokcode;
	String unit_code;
	String sn;
	String role_code;
	public String getSosokcode() {
		return sosokcode;
	}
	public void setSosokcode(String sosokcode) {
		this.sosokcode = sosokcode;
	}
	public String getUnit_code() {
		return unit_code;
	}
	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getRole_code() {
		return role_code;
	}
	public void setRole_code(String role_code) {
		this.role_code = role_code;
	}
	
}
