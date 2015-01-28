package mil.af.L6S.component.belt;
import mil.af.L6S.component.common.FileVO;
import mil.af.L6S.util.CodeUtil;

import java.util.List;

/**
 *  ContentsVO Part
 *  		( BeltVO - List<ContentsVO> beltDatum ) 
 * @author 정성모
 */
public class ContentsVO{
	/**
	 * 군번 
	 */
	private String sn;
	
	/**
	 * 벨트 종류 
	 */
	private String belt;
	
	/**
	 * 파일 SEQ
	 */
	private int file_seq;
	
	/**
	 * 교육 기관
	 */
	private String institution;

	/**
	 * 교육 기간 (시작)
	 */
	private String eduStartDate;

	/**
	 * 교육 기간 (끝)
	 */
	private String eduEndDate;
	
	/**
	 * 교육 차수 
	 */
	private String eduNum;
	
	/**
	 * 첨부 파일 
	 */
	private List<FileVO> fileVO;
	
	/**
	 * 수료/자격 상태
	 * 미수료:1, 수료:2	 수료인증:3, 자격:4	자격인증:5 
	 */
	private int beltstate=0;
	
	/**
	 * 코드->문자열
	 */
	private String beltStateString;
	
	/**
	 * 벨트의 우선순위 설정
	 */
	private int level;

	/**
	 * 점수
	 */
	private String score;
	
	/**
	 * 보조 변수 
	 */
	private String appCode;
	
	private String appState;
	
	private String app_str;
	
	private String comment;
	
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getApp_str() {
		return app_str;
	}

	public void setApp_str(String appState) {
		if(this.appState.equals("0")){
			app_str = "결재 대기";
		}else if(this.appState.equals("1")){
			app_str = "결재";
		}else if(this.appState.equals("2")){
			app_str = "기각 사유 : ";
		}else if(this.appState.equals("3")){
			app_str = "회수";
		}else
			app_str = "Wrong Input data";
	}

	public String getAppCode() {
		return appCode;
	}

	public String getAppState() {
		return appState;
	}

	public String getBelt() {
		return belt;
	}

	public int getBeltstate() {
		return beltstate;
	}

	public String getBeltStateString() {
		return CodeUtil.beltStatToName(this.beltstate);
	}

	public String getEduEndDate() {
		return eduEndDate;
	}

	public String getEduNum() {
		return eduNum;
	}

	public String getEduStartDate() {
		return eduStartDate;
	}

	public int getFile_seq() {
		return file_seq;
	}
	
	public List<FileVO> getFileVO() {
		return fileVO;
	}

	public String getInstitution() {
		return institution;
	}

	public int getLevel() {
		return level;
	}

	public String getScore() {
		return score;
	}

	public String getSn() {
		return sn;
	}

	public void setAppCode(String appCode) {
		this.appCode = appCode;
	}
	
	public void setAppState(String appState) {
		this.appState = appState;
	}

	public void setBelt(String belt) {
		this.belt = belt;
		setLevel();
	}

	public void setBeltstate(int beltstate) {
		this.beltstate = beltstate;
	}

	public void setBeltStateString(String beltstatestring) {
		this.beltStateString = beltstatestring;
	}

	public void setEduEndDate(String eduEndDate) {
		this.eduEndDate = eduEndDate;
	}

	public void setEduNum(String eduNum) {
		this.eduNum = eduNum;
	}

	public void setEduStartDate(String eduStartDate) {
		this.eduStartDate = eduStartDate;
	}

	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}

	public void setFileVO(List<FileVO> fileVO) {
		this.fileVO = fileVO;
	}

	public void setInstitution(String institution) {
		this.institution = institution;
	}

	/**
	 * 권한별 Level <- Integer로 변환할 경우  범위 처리가 용이해짐
	 */
	public void setLevel() {
		if (this.belt.equals("FEA")) {
			level = 4;
		} else if (this.belt.equals("GB")) {
			level = 3;
		} else if (this.belt.equals("BB")) {
			level = 2;
		} else if (this.belt.equals("MBB")){
			level = 1;
		}
	}

	public void setScore(String score) {
		this.score = score;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	@Override
	public String toString() {
		return "ContentsVO [sn=" + sn + ", belt=" + belt + ", file_seq="
				+ file_seq + ", institution=" + institution + ", eduStartDate="
				+ eduStartDate + ", eduEndDate=" + eduEndDate + ", eduNum="
				+ eduNum + ", fileVO=" + fileVO + ", beltstate=" + beltstate
				+ ", beltStateString=" + beltStateString + ", level=" + level
				+ ", score=" + score + ", appCode=" + appCode + ", appState="
				+ appState + ", app_str=" + app_str + ", comment=" + comment
				+ "]";
	}

}
