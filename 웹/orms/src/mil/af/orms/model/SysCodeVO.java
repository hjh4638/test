package mil.af.orms.model;

/**
 * 코드관리 VO
 */
public class SysCodeVO {
	int id;
	String m_code;
	String code;
	String m_codename;
	String codename;
	String order_cd;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getM_code() {
		return m_code;
	}
	public void setM_code(String m_code) {
		this.m_code = m_code;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getM_codename() {
		return m_codename;
	}
	public void setM_codename(String m_codename) {
		this.m_codename = m_codename;
	}
	public String getCodename() {
		return codename;
	}
	public void setCodename(String codename) {
		this.codename = codename;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	
	
}
