package mil.af.orms.model;

public class ScoreVO {
	public static final String GREEN="green";
	public static final String YELLOW="yellow";
	public static final String ORANGE="orange";
	public static final String RESULT_NORMAL="01";
	public static final String RESULT_MANAGE="02";
	public static final String RESULT_CANCEL="03";
	int id;
	String section_1;
	String section_2;
	String question_name;
	
	String score;
	
	String color;
	
	String initial_color;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSection_1() {
		return section_1;
	}
	public void setSection_1(String section_1) {
		this.section_1 = section_1;
	}
	public String getSection_2() {
		return section_2;
	}
	public void setSection_2(String section_2) {
		this.section_2 = section_2;
	}
	
	
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getColor(){
		return getColor(score);
	}
	public String getInitial_color(){
		StringBuffer str=new StringBuffer(getColor(score));
		String intial = str.substring(0,1);
		return intial.toUpperCase();
	}
		public String getQuestion_name() {
		return question_name;
	}
	public void setQuestion_name(String question_name) {
		this.question_name = question_name;
	}
	public static String getColor(String score){
		switch(Integer.parseInt(score)){
		case 0:
		case 1:
			return GREEN;
		case 2:
			return YELLOW;
		case 3:
			return ORANGE;
		default:
			return null;
		}
	}
	public static String getResult(int score){
		switch(score){
		case 0:
		case 1:
			return RESULT_NORMAL;
		case 2:
			return RESULT_MANAGE;
		case 3:
			return RESULT_CANCEL;
		default:
			return null;
				
		}
	}
	
}
