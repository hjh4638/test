package mil.af.L6S.component.belt;

import java.util.List;

import mil.af.L6S.util.AbstractListFilter;
import mil.af.L6S.util.CodeUtil;

/**
 *  BeltVO Part
 * @author 정성모
 */
public class BeltVO extends AbstractListFilter{
	/**
	 * Rnum (DB에는 저장 되지 않는 정보)
	 */
	private int pn;
	
	/**
	 * 벨트 등록자 군번
	 */
	private String sn;

	/**
	 * 벨트 등록자 계급 
	 */
	private String rank;

	/**
	 * 벨트 등록자 이름 
	 */
	private String name;
	
	/**
	 * 벨트 등록자 소속 코드
	 */
	private String sosokCode;
	
	/**
	 * 벨트 등록자 소속 명 
	 */
	private String sosokName;
	
	/**
	 * 등록자의 대표 벨트
	 */
	private String repreBelt;
	
	/**
	 * 등록자의 벨트 정보 
	 */
	private List<ContentsVO> beltDatum;

	/**
	 * 공개/비공개 
	 */
	private int viewState;

	/**
	 * 벨트 유무에 따른 belt 출력 변동 조건
	 * default:0	  조건 해당:1
	 */
	private int condition = 0;
	
	/**
	 * beltstate에 따른 belt 출력 변동 조건
	 * default:0 	조건 (1,2) 해당 :1	조건(3,4) 해당:2
	 */
	private int stateCondition = 0;
	
	/**
	 * 벨트 보유자 - 과제 Matching 
	 */
	private List<String> subject;
	
	/**
	 * 과제 수 
	 */
	private int subjectCount=0;
	
	/**
	 * 보조 변수 
	 */
	private String dummy;
	
	public List<ContentsVO> getBeltDatum() {
		return beltDatum;
	}

	public int getCondition() {
		return condition;
	}

	public String getDummy() {
		return dummy;
	}

	public String getName() {
		return name;
	}

	public int getPn() {
		return pn;
	}

	public String getRank() {
		return rank;
	}

	public String getRepreBelt() {
		return repreBelt;
	}

	public String getRepreBeltName(int code) {
		return CodeUtil.beltLevToName(code);
	}

	public String getSn() {
		return sn;
	}

	public String getSosokCode() {
		return sosokCode;
	}

	public String getSosokName() {
		return sosokName;
	}
	
	public int getStateCondition() {
		return stateCondition;
	}

	public List<String> getSubject() {
		return subject;
	}

	public int getSubjectCount() {
		return subjectCount;
	}

	public int getViewState() {
		return viewState;
	}

	public void setBeltDatum(List<ContentsVO> beltDatum) {
		this.beltDatum = beltDatum;
	}
	
	public void setCondition(int condition) {
		this.condition = condition;
	}
	
	public void setDummy(String dummy) {
		this.dummy = dummy;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public void setPn(int pn) {
		this.pn = pn;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}


	/**
	 *  RepreBelt는 BeltService에서 따로 입력을 위한 폼
	 * @param repreBelt
	 */
	public void setRepreBelt(int repreBelt) {
		this.repreBelt = getRepreBeltName(repreBelt);
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public void setSosokCode(String sosokCode) {
		this.sosokCode = sosokCode;
	}

	public void setSosokName(String sosokName) {
		this.sosokName = sosokName;
	}

	public void setStateCondition(int stateCondition) {
		this.stateCondition = stateCondition;
	}

	public void setSubject(List<String> subject) {
		this.subject = subject;
	}

	public void setSubjectCount(int subjectCount) {
		this.subjectCount = subjectCount;
	}

	public void setViewState(int viewState) {
		this.viewState = viewState;
	}

	@Override
	public String toString() {
		return "BeltVO [pn=" + pn + ", sn=" + sn + ", rank=" + rank + ", name="
				+ name + ", sosokCode=" + sosokCode + ", sosokName="
				+ sosokName + ", repreBelt=" + repreBelt + ", beltDatum="
				+ beltDatum + ", viewState=" + viewState + ", condition="
				+ condition + ", stateCondition=" + stateCondition
				+ ", subject=" + subject + ", subjectCount=" + subjectCount
				+ ", dummy=" + dummy + "]";
	}
	
}
