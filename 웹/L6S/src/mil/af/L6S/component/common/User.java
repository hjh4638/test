package mil.af.L6S.component.common;

import java.util.List;
import java.util.Map;

import mil.af.L6S.util.CodeUtil;
import mil.af.L6S.util.StringUtil;

/**
 *  User Datum
 * 
 * @author 정성모
 * 
 */
public class User {

	/**
	 * 군번
	 */
	private String sn;

	/**
	 * 이름
	 */
	private String name;

	/**
	 * 계급
	 */
	private String rank;

	/**
	 * 진행 상태 A=진행 B=완료
	 */
	private String status;

	/**
	 * 관리자 정보 - 권한
	 * A : 본부 	B : 사령부
	 * C : 부대(BB)
	 */
	private String authority;

	/**
	 * 소속이름
	 */
	private String positionName;

	/**
	 * 소속코드
	 */
	private String positionCode;

	/**
	 * 인사소속이름
	 */
	private String insasosok;

	/**
	 * 인사소속코드
	 */
	private String personPositionCode;

	/**
	 * 인트라소속코드
	 */
	private String intrasosok;
	
	/**
	 * 특기코드
	 */
	private String specialityCode;

	/**
	 * 소속 부대 
	 */
	private String quarter;
	
	/**
	 * 과제코드
	 */
	private List<Integer> subject_code;
	private Map<String, String> myAppInfo;
	public Map<String, String> getMyAppInfo() {
		return myAppInfo;
	}

	public void setMyAppInfo(Map<String, String> myAppInfo) {
		this.myAppInfo = myAppInfo;
	}

	public String getAuthority() {
		return authority;
	}

	/**
	 * 권한 코드를 한글로 바꾸어 출력
	 * 
	 * @return  A:본부 B:사령	부  C:부대(BB)
	 */
	public String getAuthorityName() {
		return CodeUtil.autorityCodeToName(authority);
	}
		
	public String getInsasosok() {
		return insasosok;
	}
	public String getIntrasosok() {
		return intrasosok;
	}

	public String getName() {
		return name;
	}

	public String getPersonPositionCode() {
		return personPositionCode;
	}

	public String getPositionCode() {
		return positionCode;
	}

	public String getPositionName() {
		return positionName;
	}

	public String getQuarter() {
		return quarter;
	}

	public String getRank() {
		return rank;
	}

	public String getSn() {
		return sn;
	}

	public String getSpecialityCode() {
		return specialityCode;
	}

	/**
	 * 인트라소속이름
	 * 
	 * @return
	 */
	public String getSplitInsasosok() {
		if (intrasosok == null) {
			return null;
		}
		List<String> args = StringUtil.split(intrasosok, " ");
		return args.get(0);
	}

	public String getSplitPersonPositionName() {
		if (intrasosok == null) {
			return null;
		}
		List<String> args = StringUtil.split(intrasosok, " ");
		return args.get(0);
	}

	public String getStatus() {
		return status;
	}

	/**
	 * 상태코드를 한글로 변환
	 * 
	 * @return 진행, 완료
	 */
	public String getStatusName() {
		if (status != null && !status.equals(""))
			return CodeUtil.measureStatueCodeToName(status);
		return null;
	}

	public List<Integer> getSubject_code() {
		return subject_code;
	}

	public Integer getSubject_size(){
		return subject_code.size();
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public void setInsasosok(String insasosok) {
		this.insasosok = insasosok;
	}

	public void setIntrasosok(String intrasosok) {
		this.intrasosok = intrasosok;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPersonPositionCode(String personPositionCode) {
		this.personPositionCode = personPositionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public void setSpecialityCode(String specialityCode) {
		this.specialityCode = specialityCode;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setSubject_code(List<Integer> subject_code) {
		this.subject_code = subject_code;
	}
	
	@Override
	public String toString() {
		return "User [sn=" + sn + ", name=" + name + ", rank=" + rank
				+ ", status=" + status + ", authority=" + authority
				+ ", positionName=" + positionName + ", positionCode="
				+ positionCode + ", insasosok=" + insasosok
				+ ", personPositionCode=" + personPositionCode
				+ ", intrasosok=" + intrasosok + ", specialityCode="
				+ specialityCode + ", quarter=" + quarter + ", subject_code="
				+ subject_code + "]";
	}

}
