package mil.af.L6S.component.approvalLine;

public class ApprovalMemberVO {
	//avs11c0t 테이블 참조
	private String sosokcode;           // 결재자 소속이름
	private String sosokname;           // 결재자 소속이름
	private String ass;                 // 직책이름 
	private String rankname;            // 계급
	private String name;                // 이름
	private String userid;              // 결재자 군번 
	public String getsosokname() {
		return sosokname;
	}
	public void setsosokname(String sosokname) {
		this.sosokname = sosokname;
	}
	public String getAss() {
		return ass;
	}
	public void setAss(String ass) {
		this.ass = ass;
	}
	public String getRankname() {
		return rankname;
	}
	public void setRankname(String rankname) {
		this.rankname = rankname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		if(name == null){
			return;
		}
		if(rankname != null){
		if(rankname.contains("중장") || rankname.contains("소장") || rankname.contains("준장")){
			name = "****";
		}}
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSosokcode() {
		return sosokcode;
	}
	public void setSosokcode(String sosokcode) {
		this.sosokcode = sosokcode;
	}
	
}
