package mil.af.orms.model;

import java.util.List;

import mil.af.orms.util.StringUtil;

public class QuestionVO {
	Integer lev;
	Integer id;
	Integer upper_id;
	Integer head_question;
	String question_name;
	String table_question_name;
	String question_yn;
	String question_group;
	String order_cd;
	String score;
	String checked="";
	String bigo;
	
	
	List<QuestionVO> children;

	
	//평가기준표 children을 만들기 위한 변수선언
	List<QuestionWithAllScoreVO> childrenForValuation;
	//
	
	public Integer getHead_question() {
		return head_question;
	}
	public void setHead_question(Integer head_question) {
		this.head_question = head_question;
	}
	public Integer getLev() {
		return lev;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	public void setLev(Integer lev) {
		this.lev = lev;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUpper_id() {
		return upper_id;
	}
	public void setUpper_id(Integer upper_id) {
		this.upper_id = upper_id;
	}
	public String getQuestion_name() {
		return question_name;
	}
	public String getTable_question_name(){
		String table_question_name=this.question_name;
		if(table_question_name!=null){
			if(StringUtil.getStringActualLength(table_question_name)>14){
				if(table_question_name.indexOf("(")>0){
					table_question_name=table_question_name.replace("(", "<br/>(");
				}else{
					table_question_name=table_question_name.replace(" ", "<br/>");
				}
				
				
				return table_question_name;
			}else{
				return table_question_name;
			}
		}else{
			return table_question_name;
		}
	}
	public void setQuestion_name(String question_name) {
		this.question_name = question_name;
	}
	public String getQuestion_yn() {
		return question_yn;
	}
	public void setQuestion_yn(String question_yn) {
		this.question_yn = question_yn;
	}
	public String getQuestion_group() {
		return question_group;
	}
	public void setQuestion_group(String question_group) {
		this.question_group = question_group;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public List<QuestionVO> getChildren() {
		return children;
	}
	public void setChildren(List<QuestionVO> children) {
		this.children = children;
	}
	public int getChildrenSize() {
		if(children!=null){
			return children.size();
		}else{
			return 0;
		}
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	
	//평가기준표를 위한 get,setchildrenForValuation 정의
	public List<QuestionWithAllScoreVO> getChildrenForValuation() {
		return childrenForValuation;
	}
	public void setChildrenForValuation(List<QuestionWithAllScoreVO> childrenForValuation) {
		this.childrenForValuation = childrenForValuation;
	}
	public int getChildrenForValuationSize() {
		if(childrenForValuation!=null){
			return childrenForValuation.size();
		}else{
			return 0;
		}
	}
	public int getAllChildrenForValuationSize(List<QuestionWithAllScoreVO> childrenForValuation){
		int result=0;
		if(childrenForValuation!=null){
			for(int i=0;i<childrenForValuation.size();i++){
				if(childrenForValuation.get(i).getChildrenForValuation().size()==0){
					result++;
				}
				result+=getAllChildrenForValuationSize(childrenForValuation.get(i).getChildrenForValuation());
			}
			return result;
		}else{
			return 0;
		}
	}
	public int getAllChildrenForValuationCount(){
		return getAllChildrenForValuationSize(childrenForValuation);
	}
	//
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	
}
