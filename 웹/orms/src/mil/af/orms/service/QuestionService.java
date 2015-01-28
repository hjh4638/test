package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.QuestionDAO;
import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.ScoreVO;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Service;

/**
 * ORMS 문항 관련 Service
 */
@Service("QuestionService")
public class QuestionService {
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@Resource(name="QuestionDAO")
	QuestionDAO questionDAO;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;

	/*
	public List<QuestionVO> getQuestionListByLevel(String airplane) throws SQLException{
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("airplane", airplane);
		return questionDAO.getQuestionListByLevel(parameterMap);
	}

	public List<QuestionVO> getQuestionListByLevel(String airplane,Integer levelLimit) throws SQLException{
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("airplane", airplane);
		parameterMap.put("level", levelLimit);
		return questionDAO.getQuestionListByLevel(parameterMap);
	}*/
	
	/**
	 * 진단표 문항중 진단 항목에 해당 하는 것 까지만 가져옴
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionVO> getHeadQuestionList(String airplane) throws SQLException{
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("airplane", airplane);
		parameterMap.put("level", 6);
		return questionDAO.getQuestionListByLevel(parameterMap);
	}
	
	/**
	 * 진단표 문항중 진단 항목에 해당 하는 것 만 가져옴
	 * @return
	 */
	public List<QuestionVO> getHeadQuestionOnlyList(String airplane) throws SQLException{
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("airplane", airplane);
		parameterMap.put("level", 2);
		return questionDAO.getQuestionListByOneLevel(parameterMap);
	}
	
	
	/**
	 * 진단표 문항을 Level에 따라  점수와 함께 가져옴
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionVO> getQuestionListWithScoreByLevel(String period,String section,String airplane) throws SQLException{
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("day_period", codeService.getDayPeriod(period));
		parameterMap.put("section", section);
		parameterMap.put("airplane",airplane);
		return questionDAO.getQuestionListWithScoreByLevel(parameterMap);
	}
	
	/**
	 * 진단표 문항을 트리 구조의 객체로 가져옴
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionVO> getQuestionListByLevelTree(List<QuestionVO> questionByLevel) throws SQLException{
		List<QuestionVO> questionByLevelTree=new ArrayList<QuestionVO>();
		int size=questionByLevel.size();
		for(int i=0;i<size;i++){
			QuestionVO tempQuestionVO=questionByLevel.get(i);
			if(tempQuestionVO.getUpper_id()==null){
				questionByLevelTree.add(getQuestionVOWithChild(tempQuestionVO,questionByLevel));
			}
		}
		
		return questionByLevelTree;
	}

	/**
	 * 문항의 Child를 검색해 children 변수에 Child 문항을 넣어줌
	 * @param headQuestionVO 
	 * @param questionByLevel
	 * @return
	 */
	private QuestionVO getQuestionVOWithChild(QuestionVO headQuestionVO,
			List<QuestionVO> questionByLevel) {
		int size=questionByLevel.size();
		List<QuestionVO> childList=new ArrayList<QuestionVO>();
		for(int i=0;i<size;i++){
			QuestionVO child=questionByLevel.get(i);
			if((headQuestionVO.getId()).equals(child.getUpper_id())){
				childList.add(getQuestionVOWithChild(child,questionByLevel));
			}
		}
		headQuestionVO.setChildren(childList);
		return headQuestionVO;
	}

	public boolean validateQuestionCount(String airplane,String answers) throws SQLException {
		String[] answerArray=answers.split(",");
		int headQuestionCount=questionDAO.getHeadQuestionCount(airplane);
		if(headQuestionCount==answerArray.length){
			return true;
		}else{
			return false;
		}
	}

	public HashMap<Integer, QuestionVO> getHashMapFromQuestionList(
			List<QuestionVO> questionList) {
		HashMap<Integer,QuestionVO> hashMap=new HashMap<Integer,QuestionVO>();
		int size=questionList.size();
		for(int i=0;i<size;i++){
			QuestionVO questionVO=questionList.get(i);
			hashMap.put(questionVO.getId(),questionVO);
		}
		return hashMap;
	}

	public List<QuestionVO> setCheckedAnswer(
			List<QuestionVO> questionListByLevel, List<ScoreVO> scoreList) {
		int questionSize=questionListByLevel.size();
		for(int i=0;i<questionSize;i++){
			QuestionVO questionVO=questionListByLevel.get(i);
			if("Y".equals(questionVO.getQuestion_yn())){
				int scoreSize=scoreList.size();
				for(int j=0;j<scoreSize;j++){
					ScoreVO scoreVO=scoreList.get(j);
					
					if((questionVO.getId()).equals(scoreVO.getId())){
						questionVO.setChecked("Y");
					}
					
				}
				questionListByLevel.set(i,questionVO);
			}
			
		}
		return questionListByLevel;
	}
	private int[] setSubjectsToN(List<QuestionVO> questionTree, String root, String child){
		int[] iAndj = new int[2];
		for(int i=0;i<questionTree.size();i++){
			if(questionTree.get(i).getQuestion_name().equals(root)){
				iAndj[0] = i;				
				for(int j=0;j<questionTree.get(i).getChildren().size();j++)
				  {
					  if(questionTree.get(i).getChildren().get(j).getQuestion_name().equals(child)){
					  iAndj[1] = j;
					  for(int k=0;k<questionTree.get(i).getChildren().get(j).getChildren().size();k++){
						 if(questionTree.get(i).getChildren().get(j).getChildren().get(k).getChecked().equals("Y")){
							 questionTree.get(i).getChildren().get(j).getChildren().get(k).setChecked("N");
							 
						 }
					  }
					  }
				  }
			}
		}
		return iAndj;
	}
	public void setRecentFlight_date(String lastFlight_date, int diffDay,
			List<QuestionVO> questionTree) {
		// TODO Auto-generated method stub
						int[] iAndj = setSubjectsToN(questionTree, "인적관리", "최종비행");
						int i=iAndj[0];
						int j=iAndj[1];
						 /**
						  *  diffDay 에 따라 
						  *  questionTree.get(i).getChildren().get(j).getChildren() 애들 찾아서 setChecked("Y")해주기
						  *
						  */
						if(diffDay<=3){
							questionTree.get(i).getChildren().get(j).getChildren().get(0).setChecked("Y");
						}
						else if(diffDay >3 && diffDay <=7){
							
							if(questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==3409){
								questionTree.get(i).getChildren().get(j).getChildren().get(0).setChecked("Y");
							}
							else{
								questionTree.get(i).getChildren().get(j).getChildren().get(1).setChecked("Y");
							}
						}
						else if(diffDay >7 && diffDay<=14){
							if(questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==3409){
								questionTree.get(i).getChildren().get(j).getChildren().get(1).setChecked("Y");
							}
							else{
								questionTree.get(i).getChildren().get(j).getChildren().get(2).setChecked("Y");
							}
						}
						
						else if(diffDay >14 && diffDay<=21){
							if(questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==3409){
								questionTree.get(i).getChildren().get(j).getChildren().get(2).setChecked("Y");
							}
							else{
								questionTree.get(i).getChildren().get(j).getChildren().get(3).setChecked("Y");
							}
						}
						else{
							if(questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==3409){
								questionTree.get(i).getChildren().get(j).getChildren().get(3).setChecked("Y");
							}
							else{
								if(!(questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==2410 || 
								 questionTree.get(i).getChildren().get(j).getChildren().get(0).getUpper_id()==2610))
								{
									questionTree.get(i).getChildren().get(j).getChildren().get(4).setChecked("Y");
								}
							}		
						}
					  // 최종비행일 구현 2013.6.21  
					  
						 
					 }
					 

	public void setNumberOfFlight(List<ScheduleVO> voForflight_date,
			ScheduleVO schedule, List<QuestionVO> questionTree) {
		// TODO Auto-generated method stub
					  int[] iAndj = setSubjectsToN(questionTree, "인적관리", "일일비행횟수");
					  int i=iAndj[0];
					  int j=iAndj[1];
					 
					  if(voForflight_date.size()==1){
						  questionTree.get(i).getChildren().get(j).getChildren().get(0).setChecked("Y");
					  }
					  else if(voForflight_date.size()==2){
						  if(voForflight_date.get(0).getSeq().equals(schedule.getSeq())){
							  questionTree.get(i).getChildren().get(j).getChildren().get(1).setChecked("Y");
						  }
						  else{
							  questionTree.get(i).getChildren().get(j).getChildren().get(0).setChecked("Y");
						  }
					  }
					  else{
						  if(voForflight_date.get(0).getSeq().equals(schedule.getSeq())){
							  questionTree.get(i).getChildren().get(j).getChildren().get(2).setChecked("Y");
						  }else if(voForflight_date.get(1).getSeq().equals(schedule.getSeq())){
							  questionTree.get(i).getChildren().get(j).getChildren().get(1).setChecked("Y");
						  }else{
							  questionTree.get(i).getChildren().get(j).getChildren().get(0).setChecked("Y");
						  }
					  }
					  }
				  
			 // 일일비행횟수 구현 2013.06.24
		
	
		public int getIdforSubject(List<QuestionVO> questionTree) {
			// TODO Auto-generated method stub
			int idfs=0;
			for(int i=0;i<questionTree.size();i++){
				if(questionTree.get(i).getQuestion_name().equals("인적관리")){
					
					for(int j=0;j<questionTree.get(i).getChildren().size();j++)
					  {
						  if(questionTree.get(i).getChildren().get(j).getQuestion_name().equals("동일과목")){
							  idfs = questionTree.get(i).getChildren().get(j).getId();
						  }
					  }
				}
			}
			return idfs;
}

		public int getSeqOfChild(String gunbun,
				String subjectId, int idForSubject) throws SQLException {
			//subjectId : 내가 선택(클릭)한 과목의 id, idForSubject : 내 현재 스케줄 의 '동일과목'의 id
			int checkForChild=0;
			
			String question_name = questionDAO.getQuestion_name(idForSubject);
			int keyForName = Integer.parseInt(question_name.substring(0, 1)); // 2 ,3 ,4 ,5
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("sn", gunbun);
			map.put("subjectId",subjectId);
			String lastChecked_Date = questionDAO.getlastChecked_Date(map);
			System.out.println("DEBUGING lastChecked: " + lastChecked_Date);
			int numberOfChecked = questionDAO.getnumberOfChecked(map);
			
			int diffDay = scheduleService.getDiffDay(lastChecked_Date); // : 오늘날짜랑 마지막 동일과목선택한 날짜와의 날짜차
			if(keyForName==2){
				if(diffDay<=14)
					checkForChild=1;
				else if(diffDay>14 && diffDay<=21)
					checkForChild=2;
				else if(diffDay>=21 && diffDay<28)
					checkForChild=3;
				else
					checkForChild=4;
			}else if(keyForName==4){
				if(diffDay<=28)
					checkForChild=1;
				else if(diffDay>28 && diffDay<=42)
					checkForChild=2;
				else if(diffDay>42 && diffDay<=56)
					checkForChild=3;
				else
					checkForChild=4;
			}else if(keyForName==3){
				if(numberOfChecked>=3)
					checkForChild=1;
				else if(numberOfChecked==2)
					checkForChild=2;
				else
					checkForChild=3;
			}else{
				if(numberOfChecked>=5)
					checkForChild=1;
				else if(numberOfChecked>=2 && numberOfChecked<=4)
					checkForChild=2;
				else
					checkForChild=3;
			}
			return checkForChild;
		}

		public void setSameSubject(List<QuestionVO> questionTree) {
			// TODO Auto-generated method stub
			int[] iAndj = setSubjectsToN(questionTree, "인적관리", "동일과목");
//			int i=iAndj[0];
//			int j=iAndj[1];
//			if(checkedChild!=0)
//			questionTree.get(i).getChildren().get(j).getChildren().get(checkedChild).setChecked("Y");
			
		
		}
}


	
