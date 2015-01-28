package mil.af.asti.model;

public class AstiNewMemberDTO {
	private String user_id;
	private String access;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAccess() {
		return access;
	}
	public void setAccess(String access) {
		this.access = access;
	}
	@Override
	public String toString() {
		return "AstiNewMemberDTO [user_id=" + user_id + ", access=" + access
				+ "]";
	}
	
	
}
