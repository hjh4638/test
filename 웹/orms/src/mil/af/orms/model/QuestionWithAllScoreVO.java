package mil.af.orms.model;

import java.util.ArrayList;
import java.util.List;



public class QuestionWithAllScoreVO extends QuestionVO {
	String day_period1;
	String day_period2;
	String section1;
	String section2;
	String section3;
	String section4;
	String section5;
	String use_yn;
	public String getSection5() {
		return section5;
	}
	public void setSection5(String section5) {
		this.section5 = section5;
	}
	
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getDay_period1() {
		return day_period1;
	}
	public void setDay_period1(String day_period1) {
		this.day_period1 = day_period1;
	}
	public String getDay_period2() {
		return day_period2;
	}
	public void setDay_period2(String day_period2) {
		this.day_period2 = day_period2;
	}
	public String getSection1() {
		return section1;
	}
	public void setSection1(String section1) {
		this.section1 = section1;
	}
	public String getSection2() {
		return section2;
	}
	public void setSection2(String section2) {
		this.section2 = section2;
	}
	public String getSection3() {
		return section3;
	}
	public void setSection3(String section3) {
		this.section3 = section3;
	}
	public String getSection4() {
		return section4;
	}
	public void setSection4(String section4) {
		this.section4 = section4;
	}
	public List<String> getSectionList(){
		List<String> sectionList=new ArrayList<String>();
		sectionList.add(section1);
		sectionList.add(section2);
		sectionList.add(section3);

		/*평가항목 4개일시*/
		if(question_group.equals("01") || question_group.equals("02") || question_group.equals("03")||
				question_group.equals("04") || question_group.equals("05")|| question_group.equals("10")
				|| question_group.equals("20") || question_group.equals("21") || question_group.equals("25"))
			sectionList.add(section4);
		/*평가항목 5개일시*/
		if(question_group.equals("06") || question_group.equals("07") || question_group.equals("08")||
		   question_group.equals("09")|| question_group.equals("16")|| question_group.equals("17")
		   || question_group.equals("18") || question_group.equals("19")|| question_group.equals("22")
		   || question_group.equals("23") || question_group.equals("26")){
			sectionList.add(section4);
			sectionList.add(section5);
		}
		
		return sectionList;
	}
	public List<String> getDayPeriodList(){
		List<String> DayPeriodList=new ArrayList<String>();
		DayPeriodList.add(day_period1);
		DayPeriodList.add(day_period2);
		return DayPeriodList;
	}
}
