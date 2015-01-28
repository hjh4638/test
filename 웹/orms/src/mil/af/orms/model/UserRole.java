package mil.af.orms.model;

public enum UserRole {
	
	/**
	 * 일반 사용자 : 대대 조종사
	 */
	NORMAL,
	/**
	 * 권한 1: 안전편대장 (대대3편대장)
	 */
	FORMATIONMANAGER,
	/**
	 * 권한 2: 비행대대장/대장
	 */
	SQUADRONMANAGER,
	/**
	 * 권한 3: 단장/전대장
	 */
	GROUPMANAGER,
	/**
	 * 권한 4: 대대CQ
	 */
	CQ,
	/**
	 * 권한 5: 항안단(시스템관리자)
	 */
	SYSTEMADMIN,
	/**
	 * 권한 6: 스케줄장교
	 */
	SCHEDULEOFFICER
	
}
