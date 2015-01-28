package mil.af.L6S.component.subject;

public class SubjectExcelVO {
	/**
	 * 소속
	 */
	String Position;
	
	/**
	 * 과제명
	 */
	String Subject_Name;
	
	/**
	 * 계급
	 */
	String Rank;
	
	/**
	 * 이름
	 */
	String Name;
	
	/**
	 * 과제유형
	 */
	String Subject_Section;
	
	/**
	 * 개선 전 
	 */
	String Before;
	
	/**
	 * 개선 후
	 */
	String After;
	
	/**
	 * 등록일자
	 */
	String RegisterDay;
	
	public String getAfter() {
		return After;
	}
	
	public String getBefore() {
		return Before;
	}
	
	public String getName() {
		return Name;
	}
	
	public String getPosition() {
		return Position;
	}
	
	public String getRank() {
		return Rank;
	}
	
	public String getRegisterDay() {
		return RegisterDay;
	}
	
	public String getSubject_Name() {
		return Subject_Name;
	}
	
	public String getSubject_Section() {
		return Subject_Section;
	}
	
	public void setAfter(String after) {
		After = after;
	}
	
	public void setBefore(String before) {
		Before = before;
	}
	
	public void setName(String name) {
		Name = name;
	}
	
	public void setPosition(String position) {
		Position = position;
	}
	
	public void setRank(String rank) {
		Rank = rank;
	}
	
	public void setRegisterDay(String registerDay) {
		RegisterDay = registerDay;
	}
	
	public void setSubject_Name(String subject_Name) {
		Subject_Name = subject_Name;
	}
	
	public void setSubject_Section(String subject_Section) {
		Subject_Section = subject_Section;
	}
	
	@Override
	public String toString() {
		return "SubjectExcelVO [Position=" + Position + ", Subject_Name="
				+ Subject_Name + ", Rank=" + Rank + ", Name=" + Name
				+ ", Subject_Section=" + Subject_Section + ", Before=" + Before
				+ ", After=" + After + ", RegisterDay=" + RegisterDay + "]";
	}
}
