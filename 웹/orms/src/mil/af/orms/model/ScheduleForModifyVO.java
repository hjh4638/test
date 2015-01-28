package mil.af.orms.model;

public class ScheduleForModifyVO {
	int num;
	String unit_code;
	String unit_codename;
	String period;
	String period_codename;
	String cs;
	Integer seq1;
	String sn1;
	String name1;
	String section1;
	String weather1;
	Integer seq2;
	String sn2;
	String name2;
	String section2;
	String weather2;
	String id;
	public String toString(){
		String result="";
		result+="seq1:"+seq1;
		result+=",seq2:"+seq2;
		result+=",cs:"+cs;
		result+=",sn1:"+sn1;
		result+=",weather1:"+weather1;
		result+=",section1:"+section1;
		result+=",sn2:"+sn2;
		result+=",weather2:"+weather2;
		result+=",section2:"+section2;
		result+=",id:"+id;
		return result;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUnit_code() {
		return unit_code;
	}
	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}
	public String getUnit_codename() {
		return unit_codename;
	}
	public void setUnit_codename(String unit_codename) {
		this.unit_codename = unit_codename;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getPeriod_codename() {
		return period_codename;
	}
	public void setPeriod_codename(String period_codename) {
		this.period_codename = period_codename;
	}
	public String getCs() {
		return cs;
	}
	public void setCs(String cs) {
		this.cs = cs;
	}
	public String getSn1() {
		return sn1;
	}
	public void setSn1(String sn1) {
		this.sn1 = sn1;
	}
	public String getSection1() {
		return section1;
	}
	public void setSection1(String section1) {
		this.section1 = section1;
	}
	public String getWeather1() {
		return weather1;
	}
	public void setWeather1(String weather1) {
		this.weather1 = weather1;
	}
	public String getSn2() {
		return sn2;
	}
	public void setSn2(String sn2) {
		this.sn2 = sn2;
	}
	public String getSection2() {
		return section2;
	}
	public void setSection2(String section2) {
		this.section2 = section2;
	}
	public String getWeather2() {
		return weather2;
	}
	public void setWeather2(String weather2) {
		this.weather2 = weather2;
	}
	public Integer getSeq1() {
		return seq1;
	}
	public void setSeq1(Integer seq1) {
		this.seq1 = seq1;
	}
	public Integer getSeq2() {
		return seq2;
	}
	public void setSeq2(Integer seq2) {
		this.seq2 = seq2;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
}
