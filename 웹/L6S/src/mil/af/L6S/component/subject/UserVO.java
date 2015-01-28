package mil.af.L6S.component.subject;

public class UserVO {
	Integer subject_code;
	String sn;
	String role_name;
	String name;
	String department;
	String is_leader;
	
	public String getIs_leader() {
		return is_leader;
	}
	public void setIs_leader(String is_leader) {
		this.is_leader = is_leader;
	}
	/*avs테이블전용 변수*/
	String userid;
	String rankname;
	String intrasosokname;
	String intrasosokcode;
	

	public String getIntrasosokcode() {
		return intrasosokcode;
	}
	public void setIntrasosokcode(String intrasosokcode) {
		this.intrasosokcode = intrasosokcode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRankname() {
		return rankname;
	}
	public void setRankname(String rankname) {
		this.rankname = rankname;
	}
	
	public String getIntrasosokname() {
		return intrasosokname;
	}
	public void setIntrasosokname(String intrasosokname) {
		this.intrasosokname = intrasosokname;
	}
	public Integer getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(Integer subject_code) {
		this.subject_code = subject_code;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	@Override
	public String toString() {
		return super.toString() + "{ sn: " + sn + ", role_name:" + role_name +", name: " + name + ", department: " + department + " }"; 
 	}
	
	
	
}
