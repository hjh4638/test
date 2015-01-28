package mil.af.orms.model;

public class AnswerWithHeadQuestionVO extends AnswerVO{
	int head_question_id;
	String head_question_name;
	String color;
	public int getHead_question_id() {
		return head_question_id;
	}
	public void setHead_question_id(int head_question_id) {
		this.head_question_id = head_question_id;
	}
	public String getHead_question_name() {
		return head_question_name;
	}
	public void setHead_question_name(String head_question_name) {
		this.head_question_name = head_question_name;
	}
	public String getColor() { //점수에 따라 색을 리턴시켜줌
		
		return ScoreVO.getColor(String.valueOf(score));
	}
	
	
}
