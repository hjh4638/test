package mil.af.orms.model;

import java.util.Map;

public class AccessUrlConfigMapVO {
	Map<UserRole,AccessUrlConfigVO> accessConfigMap;

	public Map<UserRole, AccessUrlConfigVO> getAccessConfigMap() {
		return accessConfigMap;
	}

	public void setAccessConfigMap(Map<UserRole, AccessUrlConfigVO> accessConfigMap) {
		this.accessConfigMap = accessConfigMap;
	}

	
	
}
