package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.ValuationStandardDAO;


import mil.af.orms.model.QuestionWithAllScoreVO;
import mil.af.orms.model.ScoreVO;

import org.springframework.stereotype.Service;

@Service("ValuationStandardService")

public class ValuationStandardService {

	@Resource(name="ValuationStandardDao")
	ValuationStandardDAO valuationStandardDao;
	
	/**
	 * 진단표 문항을 Level에 따라 전체를 다 가져옴
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionWithAllScoreVO> getQuestionListWithAllScoreByLevel(String code)  throws Exception{
		return valuationStandardDao.getQuestionListWithAllScoreByLevel(code);
		
	}
	
	/**
	 * 진단표 문항을 트리 구조의 객체로 가져옴
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionWithAllScoreVO> getQuestionListByLevelTree(List<QuestionWithAllScoreVO> questionByLevel)  throws Exception{
		List<QuestionWithAllScoreVO> questionByLevelTree=new ArrayList<QuestionWithAllScoreVO>();
		int size=questionByLevel.size();
		for(int i=0;i<size;i++){
			QuestionWithAllScoreVO tempQuestionVO=questionByLevel.get(i);
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
	private QuestionWithAllScoreVO getQuestionVOWithChild(QuestionWithAllScoreVO headQuestionVO,
			List<QuestionWithAllScoreVO> questionByLevel) {
		int size=questionByLevel.size();
		List<QuestionWithAllScoreVO> childList=new ArrayList<QuestionWithAllScoreVO>();
		for(int i=0;i<size;i++){
			QuestionWithAllScoreVO child=questionByLevel.get(i);
			if((headQuestionVO.getId()).equals(child.getUpper_id())){
				childList.add(getQuestionVOWithChild(child,questionByLevel));
			}
		}
		headQuestionVO.setChildrenForValuation(childList);
		return headQuestionVO;
	}

	public void updateScore(QuestionWithAllScoreVO questionWithAllScoreVO,
			String gubun, String airCraftCode) throws SQLException {
			QuestionWithAllScoreVO questionVO1=new QuestionWithAllScoreVO();
			QuestionWithAllScoreVO questionVO2=new QuestionWithAllScoreVO();
			ScoreVO scoreVO1 =new ScoreVO();
			ScoreVO scoreVO2 =new ScoreVO();
			questionVO1.setUse_yn("1");
			questionVO2.setUse_yn("1");	
		if(valuationStandardDao.updateQuestion(questionWithAllScoreVO) ==0)
		{
			questionVO1.setLev(questionWithAllScoreVO.getLev()+1);
			questionVO2.setLev(questionWithAllScoreVO.getLev()+1);
			if(gubun.equals("ORM003"))
			{
				questionVO1.setQuestion_group(airCraftCode);
				if(airCraftCode.equals("01"))				
				questionVO1.setHead_question(126);
				else if(airCraftCode.equals("02"))
				questionVO1.setHead_question(128);
				else if(airCraftCode.equals("03"))
				questionVO1.setHead_question(179);
				else if(airCraftCode.equals("04"))
				questionVO1.setHead_question(230);
				
				
				if((questionVO1.getLev()) ==4)
				{
					questionVO1.setQuestion_yn("N");
				}
				else if((questionVO1.getLev()) ==5)
				{
					questionVO1.setQuestion_yn("Y");
				}
				questionVO1.setUpper_id(questionWithAllScoreVO.getUpper_id());
				questionVO1.setOrder_cd(questionWithAllScoreVO.getOrder_cd());
				questionVO1.setQuestion_name(questionWithAllScoreVO.getQuestion_name());
				valuationStandardDao.insertQuestion(questionVO1);
			}
			else if(gubun.equals("ORM004"))
			{
				//자격별 테이블의 임무별요소 그룹아아디를 01로 하기위한 조건문
				if(questionWithAllScoreVO.getUpper_id()==8 || questionWithAllScoreVO.getUpper_id()==9)
					questionVO2.setQuestion_group("01");
				else if(questionWithAllScoreVO.getUpper_id()==129 || questionWithAllScoreVO.getUpper_id()==130)
					questionVO2.setQuestion_group("02");
				else if(questionWithAllScoreVO.getUpper_id()==180 || questionWithAllScoreVO.getUpper_id()==181)
					questionVO2.setQuestion_group("03");
				else if(questionWithAllScoreVO.getUpper_id()==231 || questionWithAllScoreVO.getUpper_id()==232)
					questionVO2.setQuestion_group("04");
				
				else{
					questionVO2.setQuestion_group("05");
				}
				questionVO2.setHead_question(questionWithAllScoreVO.getUpper_id());
				questionVO2.setQuestion_yn("Y");
				questionVO2.setUpper_id(questionWithAllScoreVO.getUpper_id());
				questionVO2.setOrder_cd(questionWithAllScoreVO.getOrder_cd());
				questionVO2.setQuestion_name(questionWithAllScoreVO.getQuestion_name());
				valuationStandardDao.insertQuestion(questionVO2);
			}
					
		}
		
		
		if(questionWithAllScoreVO.getDay_period1()!=null && questionWithAllScoreVO.getDay_period2()!=null &&(questionWithAllScoreVO.getId()!=null))
		{
		scoreVO1.setId(questionWithAllScoreVO.getId());
		scoreVO1.setSection_1(gubun);
		scoreVO1.setSection_2("01");
		scoreVO1.setScore(questionWithAllScoreVO.getDay_period1());
		if(valuationStandardDao.updateScore(scoreVO1)==0){
			valuationStandardDao.insertScore(scoreVO1);
		}
				
		scoreVO1.setSection_2("02");
		scoreVO1.setScore(questionWithAllScoreVO.getDay_period2());		
		if(valuationStandardDao.updateScore(scoreVO1)==0){
			valuationStandardDao.insertScore(scoreVO1);
		}
		}
		
		
		else if((questionWithAllScoreVO.getSection1() !=null)&&(questionWithAllScoreVO.getSection2() !=null)&&(questionWithAllScoreVO.getSection3() !=null)&&(questionWithAllScoreVO.getSection4() !=null)&&(questionWithAllScoreVO.getId()!=null))
		{
			
		scoreVO2.setId(questionWithAllScoreVO.getId());
		scoreVO2.setSection_1(gubun);
		scoreVO2.setSection_2("01");
		scoreVO2.setScore(questionWithAllScoreVO.getSection1());
		if(valuationStandardDao.updateScore(scoreVO2)==0){
			valuationStandardDao.insertScore(scoreVO2);
			scoreVO2.setSection_2("05");
			valuationStandardDao.insertScore(scoreVO2);
		}
		else if(valuationStandardDao.updateScore(scoreVO2)!=0){
			scoreVO2.setSection_2("05");
			valuationStandardDao.updateScore(scoreVO2);
		}
		scoreVO2.setSection_2("02");
		scoreVO2.setScore(questionWithAllScoreVO.getSection2());
		if(valuationStandardDao.updateScore(scoreVO2)==0){
			valuationStandardDao.insertScore(scoreVO2);
			scoreVO2.setSection_2("06");
			valuationStandardDao.insertScore(scoreVO2);
		}
		else if(valuationStandardDao.updateScore(scoreVO2)!=0){
			scoreVO2.setSection_2("06");
			valuationStandardDao.updateScore(scoreVO2);
		}
		scoreVO2.setSection_2("03");
		scoreVO2.setScore(questionWithAllScoreVO.getSection3());
		if(valuationStandardDao.updateScore(scoreVO2)==0){
			valuationStandardDao.insertScore(scoreVO2);
			scoreVO2.setSection_2("07");
			valuationStandardDao.insertScore(scoreVO2);
		}
		else if(valuationStandardDao.updateScore(scoreVO2)!=0){
			scoreVO2.setSection_2("07");
			valuationStandardDao.updateScore(scoreVO2);
		}
		scoreVO2.setSection_2("04");
		scoreVO2.setScore(questionWithAllScoreVO.getSection4());
		if(valuationStandardDao.updateScore(scoreVO2)==0){
			valuationStandardDao.insertScore(scoreVO2);
			scoreVO2.setSection_2("08");
			valuationStandardDao.insertScore(scoreVO2);
		}
		else if(valuationStandardDao.updateScore(scoreVO2)!=0){
			scoreVO2.setSection_2("08");
			valuationStandardDao.updateScore(scoreVO2);
		}
		}
		
	}
	public void changeUseYn(int id) throws SQLException {
		valuationStandardDao.changeUseYn(id);
	}
}
	
	
	
	

