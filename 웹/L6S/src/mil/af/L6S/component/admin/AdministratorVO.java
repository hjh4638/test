package mil.af.L6S.component.admin;

import mil.af.L6S.util.CodeUtil;
import mil.af.L6S.util.AbstractListFilter;

public class AdministratorVO extends AbstractListFilter{

	/**
	 *  부대 코드 
	 */
	private String code;
	
	/**
	 * 부대 이름
	 */
	private String name;

	/**
	 * 부대 관리자 정보 - 군번
	 */
	private String sn;

	/**
	 *  직책
	 */
	private String position;
	
	/**
	 * 관리자 성명 
	 */
	private String sn_name;
	
	/**
	 * 관리자 계급 
	 */
	private String sn_rank;
	
	/**
	 * 부대 부서
	 */
	private String quarter;

	/**
	 * 관리자 정보 - 권한
	 * A : 본부 	B : 사령부  C : 부대(BB)
	 */
	private String authority;

	/**
	 * 관리자 검색시 입력하는 이름
	 */
	private String searchName;

	/**
	 * 5:일반사용자   3:부대(BB) 2:사령부  1:본부	
	 */
	private int level;

	public void calculateLevel() {
		if (this.authority == null) {
			level = 5;
			return;
		}
		if (this.authority.equals("C")) {
			level = 3;
		} else if (this.authority.equals("B")) {
			level = 2;
		} else if (this.authority.equals("A")){
			level = 1;
		}
		else {
			level = 5;
		}
	}

	public String getAuthority() {
		return authority;
	}

	/**
	 * 권한 코드를 한글로 바꾸어 출력
	 * 
	 * @return 
	 */
	public String getAuthorityName() {
		return CodeUtil.autorityCodeToName(this.authority);
	}

	public String getCode() {
		return code;
	}

	public int getLevel() {
		return level;
	}

	public String getName() {
		return name;
	}
	
	public String getPosition() {
		return position;
	}
	
	public String getQuarter() {
		return quarter;
	}
	
	public String getSearchName() {
		return searchName;
	}



	public String getSn() {
		return sn;
	}

	public String getSn_name() {
		return sn_name;
	}

	public String getSn_rank() {
		return sn_rank;
	}

	public void setAuthority(String authority) {
		if (authority != null && authority.equals(""))
			authority = null;

		this.authority = authority;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public void setSn_name(String sn_name) {
		this.sn_name = sn_name;
	}


	public void setSn_rank(String sn_rank) {
		this.sn_rank = sn_rank;
	}

	@Override
	public String toString() {
		return "AdministratorVO [code=" + code + ", name=" + name + ", sn="
				+ sn + ", position=" + position + ", sn_name=" + sn_name
				+ ", sn_rank=" + sn_rank + ", quarter=" + quarter
				+ ", authority=" + authority + ", searchName=" + searchName
				+ ", level=" + level + "]";
	}


}
