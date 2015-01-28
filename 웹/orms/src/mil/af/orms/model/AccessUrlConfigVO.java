package mil.af.orms.model;

import java.util.List;

/**
 * 권한별 접근 가능 URL 설정
 */
public class AccessUrlConfigVO {
	UserRole role;
	List<String> accessUrlList;
	public UserRole getRole() {
		return role;
	}
	public void setRole(UserRole role) {
		this.role = role;
	}
	public List<String> getAccessUrlList() {
		return accessUrlList;
	}
	public void setAccessUrlList(List<String> accessUrlList) {
		this.accessUrlList = accessUrlList;
	}
	
}
