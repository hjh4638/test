package mil.af.orms.model;

import java.util.List;

public class UnitVO {
	Integer id;
	Integer upper_id;
	Integer lev;
	String unit_name;
	String unit_code;
	String airplane;
	Integer order_cd;
	String state;
	String sosokcode;
	String fullass;
	String ass;
	List<UnitVO> children;
	public String getSosokcode() {
		return sosokcode;
	}
	public void setSosokcode(String sosokcode) {
		this.sosokcode = sosokcode;
	}
	public String getFullass() {
		return fullass;
	}
	public void setFullass(String fullass) {
		this.fullass = fullass;
	}
	public String getAss() {
		return ass;
	}
	public void setAss(String ass) {
		this.ass = ass;
	}
	public List<UnitVO> getChildren() {
		return children;
	}
	public void setChildren(List<UnitVO> children) {
		this.children = children;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUpper_id() {
		return upper_id;
	}
	public void setUpper_id(Integer upper_id) {
		this.upper_id = upper_id;
	}
	public Integer getLev() {
		return lev;
	}
	public void setLev(Integer lev) {
		this.lev = lev;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	public String getUnit_code() {
		return unit_code;
	}
	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}
	public String getAirplane() {
		return airplane;
	}
	public void setAirplane(String airplane) {
		this.airplane = airplane;
	}
	public Integer getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(Integer order_cd) {
		this.order_cd = order_cd;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
