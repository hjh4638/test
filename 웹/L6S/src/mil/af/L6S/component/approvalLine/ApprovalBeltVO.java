package mil.af.L6S.component.approvalLine;

public class ApprovalBeltVO {
	private int pn;
	private int app_id;
	private int app_state;
	private String app_str;
	private String sosokname;
	private String belt;
	private String beltstate;
	private String beltstr;
	private String name;
	private String rank;
	private String comment;
	private int file_seq;
	
	public int getApp_id() {
		return app_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getFile_seq() {
		return file_seq;
	}
	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}
	public int getApp_state() {
		return app_state;
	}
	
	public String getApp_str() {
		return app_str;
	}
	
	public String getBelt() {
		return belt;
	}
	public String getBeltstate() {
		return beltstate;
	}
	
	
	public String getBeltstr() {
		return beltstr;
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
	public String getSosokname() {
		return sosokname;
	}
	public void setApp_id(int app_id) {
		this.app_id = app_id;
	}
	public void setApp_str(int app_state) {
		if(this.app_state == 0){
			app_str = "결재 대기";
		}else if(this.app_state == 1){
			app_str = "결재";
		}else if(this.app_state == 2){
			app_str = "기각";
		}else if(this.app_state == 3){
			app_str = "회수";
		}else{
			app_str = "Wrong Input data";
		}
	}
	public void setBelt(String belt) {
		this.belt = belt;
	}
	public void setBeltstate(String beltstate) {
		this.beltstate = beltstate;
	}
	public void setBeltstr(String beltstate) {
		if(this.beltstate.equals("1")){
			beltstr="미수료";
		}
		else if(this.beltstate.equals("2")){
			beltstr="수료 중";
		}
		else if(this.beltstate.equals("3")){
			beltstr="수료 확인";
		}
		else if(this.beltstate.equals("4")){
			beltstr="자격취득 중";
		}
		else if(this.beltstate.equals("5")){
			beltstr="자격취득 확인";
		}else{
			beltstr="wrong Input data["+beltstate+"]!";
		}
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
	public void setSosokname(String sosokname) {
		this.sosokname = sosokname;
	}
	@Override
	public String toString() {
		return "ApprovalBeltVO [pn=" + pn + ", app_id=" + app_id
				+ ", app_state=" + app_state + ", app_str=" + app_str
				+ ", sosokname=" + sosokname + ", belt=" + belt
				+ ", beltstate=" + beltstate + ", beltstr=" + beltstr
				+ ", name=" + name + ", rank=" + rank + ", comment=" + comment
				+ ", file_seq=" + file_seq + "]";
	}
	

	
}
