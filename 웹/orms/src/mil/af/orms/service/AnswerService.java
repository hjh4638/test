package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.AnswerDAO;
import mil.af.orms.model.AnswerWithHeadQuestionVO;
import mil.af.orms.model.CalVO;
import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.ScoreVO;

import org.springframework.stereotype.Service;

@Service("AnswerService")
public class AnswerService {
	@Resource(name="AnswerDAO")
	AnswerDAO answerDAO;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="QuestionService")
	QuestionService questionService;
	
	@Resource(name="CalService")
	CalService calService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	

	private List<AnswerWithHeadQuestionVO> getAnswerWithHeadQuestionList(
			HashMap<String, Object> parameterMap) throws SQLException {
		return answerDAO.getAnswerWithHeadQuestionList(parameterMap);
	}

	/**
	 * 사용자가 입력한 답안을 디비에 저장하고 결과를 분석해 저장
	 * @param schedule
	 * @param answers
	 * @throws SQLException
	 */
	public String insertDiagnosisTable(ScheduleVO schedule, String answers) throws Exception {
		
		HashMap<String,Object> scheduleParameterMap=new HashMap<String,Object>();
		scheduleParameterMap.put("id", schedule.getSeq());
		scheduleParameterMap.put("sn", schedule.getSn());
		
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		List<String> answerList=new ArrayList<String>();
		String[] answerArray=answers.split(",");
		for(int i=0;i<answerArray.length;i++){
			answerList.add(answerArray[i]);
		}
		parameterMap.put("sn", schedule.getSn());
		parameterMap.put("schedule_id", schedule.getSeq());
		parameterMap.put("answerList", answerList);
		parameterMap.put("day_period",codeService.getDayPeriod(schedule.getPeriod()));
		parameterMap.put("section", schedule.getSection());
		
		answerDAO.deleteDiagnosisTable(scheduleParameterMap);
		
		answerDAO.insertDiagnosisTable(parameterMap);
		List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList = null;
		if(schedule.getSn() != null || schedule.getSeq() != null){
			answerWithHeadQuestionList=getAnswerWithHeadQuestionList(scheduleParameterMap);
		}
		return setResultToSchedule(schedule,answerWithHeadQuestionList);
	}

	public String setResultToSchedule(
			ScheduleVO schedule,List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList) throws Exception {
		/*255대대 같은 비행기종 여러개 가져올시*/
		List<String> air_list = commonService.getUserPlaneList(schedule.getUnit_code());;
		String unit_code = schedule.getUnit_code();
		String last_str = unit_code.substring(unit_code.length()-1, unit_code.length());
		List<QuestionVO> questionListByLevel = new ArrayList<QuestionVO>();
		
		String airplane=commonService.getUserPlane(schedule.getUnit_code());
		if(last_str.equals("H")){
			airplane=commonService.getUserPlaneList(schedule.getUnit_code()).get(1);
		}
		
		String result=computateEvaluateResult(airplane,answerWithHeadQuestionList);
		
		System.out.println("result:"+result);
		int updateRow=scheduleService.setResultToSchedule(schedule,result);
		if(updateRow==1){
			return "Success";
		}else{
			return "Fail";
		}
	}

	/**
	 * 선택한 답안에 따른 결과 리턴 함수
	 * @param answerWithHeadQuestionList
	 * @return
	 * @throws SQLException 
	 */
	public String computateEvaluateResult(
			String airplane,List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList) throws SQLException {
		String resultFromColor=getResultFromColorCount(answerWithHeadQuestionList);
		String resultFromElementAnalyze=getResultFromElementAnalyze(airplane,answerWithHeadQuestionList);
		
		//둘중에 더 조치기준이 높은 것을 적용
		String result;
		result=setResult(resultFromColor,resultFromElementAnalyze);
		
		
		return result;
	}

	/**
	 * 항목의 색의 개수에 따라 결과 리턴 함수
	 * @param answerWithHeadQuestionList
	 * @return
	 */
	public String getResultFromColorCount(
			List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList) {
		int green=0;
		int yellow=0;
		int orange=0;
		
		
		int listSize=answerWithHeadQuestionList.size();
		for(int i=0;i<listSize;i++){
			AnswerWithHeadQuestionVO answerVO=answerWithHeadQuestionList.get(i);
			String color=answerVO.getColor();
			if(color.equals(ScoreVO.GREEN)){
				green++;
			}else if(color.equals(ScoreVO.YELLOW)){
				yellow++;
			}else if(color.equals(ScoreVO.ORANGE)){
				orange++;
			}
		}
		
		System.out.println("ORANGE:"+orange+", YELLOW:"+yellow+", GREEN:"+green);
		
		if(orange>2){ //오랜지색 3개 이상 : 비행 취소 고려
			return ScoreVO.RESULT_CANCEL;
		}else if(orange>1&&yellow>2){// 오랜지색 2개 이상, 노란색 3개 이상 : 비행 취소 고려
			return ScoreVO.RESULT_CANCEL;
		}else if(orange>1&&yellow>1){// 오랜지색 2개 이상, 노란색 2개 이상 : 위험완화/관리감독
			return ScoreVO.RESULT_MANAGE;
		}else if(orange>0&&yellow>4){// 오랜지색 1개 이상, 노란색 5개 이상 : 비행 취소 고려
			return ScoreVO.RESULT_CANCEL;
		}else if(orange>0&&yellow>3){// 오랜지색 1개 이상, 노란색 4개 이상 : 위험완화/관리감독
			return ScoreVO.RESULT_MANAGE;
		}else if(yellow>7){ //노란색 8개 이상 : 비행 취소 고려
			return ScoreVO.RESULT_CANCEL;
		}else if(yellow>5){ //노란색 6개 이상 : 위험완화/관리감독
			return ScoreVO.RESULT_MANAGE;
		}else{ //위 요건에 해당하지 않는 경우 : 정상비행
			return ScoreVO.RESULT_NORMAL;
		}
	}
	
	
	/**
	 * 평가 요소에 따른 결과 ORMS_CAL 테이블에 따름
	 * @param answerWithHeadQuestionList
	 * @return
	 * @throws SQLException 
	 */
	public String getResultFromElementAnalyze(
			String airplane,List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList) throws SQLException {
		System.out.println("--------평가요소에 따른 결과 실행!!-------------");
		List<QuestionVO> questionList=questionService.getHeadQuestionList(null);
		List<QuestionVO> questionTree=questionService.getQuestionListByLevelTree(questionList); 
		HashMap<Integer,QuestionVO> headQuestionHashmap=questionService.getHashMapFromQuestionList(questionTree);
		HashMap<Integer,AnswerWithHeadQuestionVO> answerHashMap=getHashMapFromAnswerList(answerWithHeadQuestionList);
 
		//조치 기준 받아오기  
		//기종정보를 넣어 조치기준테이블 자료 가져옴(수정) 2012.2.7 중사 황예찬
		//List<CalVO> calList=calService.getCalList();
		List<CalVO> calList=calService.getCalList(airplane);
		int calListSize=calList.size();
		String result="01";
		for(int i=0;i<calListSize;i++){
			CalVO calVO=calList.get(i);
			
			int headQuestionId=Integer.parseInt(calVO.getQuestion_id());
			String calResult=calVO.getScore();// 답안 조치 기준(01,02,03)
			AnswerWithHeadQuestionVO answer=answerHashMap.get(headQuestionId);
			String answerResult=ScoreVO.getResult(answer.getScore());
			if(calResult.equals(answerResult)){ //조치기준과 일치할 시
				if(("Y").equals(calVO.getConnection_yn())){ //타항목 연계 됬을시
					QuestionVO headQuestion=headQuestionHashmap.get(Integer.parseInt(calVO.getC_question_id()));
					if(headQuestion!=null){
						List<QuestionVO> questions=headQuestion.getChildren();
						int hqSize=questions.size();
						for( int j=0;j<hqSize;j++){ //항목 하위 답안들 전체를 점검
							QuestionVO question=questions.get(j);
							AnswerWithHeadQuestionVO childAnswer=answerHashMap.get(question.getId());
							if(!(question.getId()).equals(Integer.parseInt(calVO.getQuestion_id()))){ //조치할 항목과 하위 항목이 다를때만 비교
								Integer c_calResult=Integer.parseInt(calVO.getC_score()); 
								Integer childResult=Integer.parseInt(ScoreVO.getResult(childAnswer.getScore()));
								if(childResult>=c_calResult){
									result=setResult(result, calVO.getEnd_score());
									System.out.println("Question"+calVO.getQuestion_id()+"가 "+calVO.getScore()+"이고 항목"+calVO.getC_question_id()+"-"+question.getId()+"("+question.getQuestion_name()+")가 "+calVO.getC_score()+"를 넘어 "+result+"를 적용시킴");
								}
							}
						}
					}else{ //타항목 연계 + 최상위 항목이 아닐시 예외( 일반 문항과 연계)
						AnswerWithHeadQuestionVO cAnswer=answerHashMap.get(Integer.parseInt(calVO.getC_question_id()));
						if(cAnswer!=null){
							Integer c_calResult=Integer.parseInt(calVO.getC_score()); 
							Integer childResult=Integer.parseInt(ScoreVO.getResult(cAnswer.getScore()));
							if(childResult>=c_calResult){
								result=setResult(result, calVO.getEnd_score());
								System.out.println("Question"+calVO.getQuestion_id()+"가 "+calVO.getScore()+"이고 항목"+calVO.getC_question_id()+"("+cAnswer.getQuestion_name()+")가 "+calVO.getC_score()+"를 넘어 "+result+"를 적용시킴");
							}
						}
					}
				}else{ // 타항목과 연계 안됬을시 최종 조치 기준을 적용시킨다.
					
					result=setResult(result, calVO.getEnd_score());
					System.out.println("Question"+calVO.getQuestion_id()+"가 "+calVO.getScore()+"이여서 "+result+"를 적용시킴");
				}
			}
		}
		System.out.println("최종 결과:"+result);
		return result;
	}
	
	/**
	 * 조치기준이 더 높은 값일때만 적용 시켜서 반환해줌
	 * @param result
	 * @param setResult
	 * @return
	 */
	public String setResult(String result,String setResult){
		if(result==null){
			result=ScoreVO.RESULT_NORMAL;
		}
		if(setResult==null){
			setResult=ScoreVO.RESULT_NORMAL;
		}
		
		int resultInt= Integer.parseInt(result);
		int setResultInt= Integer.parseInt(setResult);
		
		return setResultInt>resultInt?setResult:result;
	}
	
	/**
	 * 답안리스트를 해쉬맵으로 변경해줌
	 * @param answerWithHeadQuestionList
	 * @return
	 */
	public HashMap<Integer, AnswerWithHeadQuestionVO> getHashMapFromAnswerList(
			List<AnswerWithHeadQuestionVO> answerWithHeadQuestionList) {
		HashMap<Integer, AnswerWithHeadQuestionVO> hashMap =new HashMap<Integer, AnswerWithHeadQuestionVO>();
		int listSize=answerWithHeadQuestionList.size();
		for(int i=0;i<listSize;i++){
			AnswerWithHeadQuestionVO answer=answerWithHeadQuestionList.get(i);
			hashMap.put(answer.getHead_question_id(), answer);
		}
		return hashMap;
	}

	/**
	 * 스케쥴 객체에 해당 스케쥴 작성자가 선택한 문항의 점수 리스트를 넣어줌
	 * @param scheduleVO
	 * @return
	 * @throws SQLException
	 */
	public ScheduleVO setResultToSchedule(ScheduleVO scheduleVO) throws SQLException{
		// 진단표 문항중 진단 항목에 해당 하는 것을 가져옴
		String airplane=commonService.getUserPlane(scheduleVO.getUnit_code());
		List<QuestionVO> headQuestionList=questionService.getHeadQuestionOnlyList(airplane);
		List<AnswerWithHeadQuestionVO> answerList = null;
		//스케쥴 목록에 해당하는 답안들은 가져옴
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		if(scheduleVO.getSeq() != null || scheduleVO.getSn() != null){
			parameterMap.put("id",scheduleVO.getSeq());
			parameterMap.put("sn",scheduleVO.getSn());
			answerList=getAnswerWithHeadQuestionList(parameterMap);
		}
		
		return setResultToScheduleVO(scheduleVO, headQuestionList, answerList);
	}

	/**
	 * 스케쥴 리스트에 각각의 스케쥴 작성자가 선택한 문항의 점수 리스트을 넣어줌
	 * @param scheduleWithResult
	 * @return
	 * @throws SQLException
	 */
	public List<ScheduleVO> setResultToScheduleList(
			String airplane,List<ScheduleVO> scheduleWithResult) throws SQLException {
		List<ScheduleVO> result=new ArrayList<ScheduleVO>();
		
		List<Integer> scheduleSeqList=getScheduleSeqList(scheduleWithResult); // 스케쥴의 SEQ목록을 가져옴>
		
		
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("schedule_seq_list",scheduleSeqList);
		
		// 진단표 문항중 진단 항목에 해당 하는 것을 가져옴
		List<QuestionVO> headQuestionList=questionService.getHeadQuestionOnlyList(null);
		
		//스케쥴 목록에 해당하는 답안들은 가져옴
		List<AnswerWithHeadQuestionVO> answerList = null;
		if(scheduleSeqList != null && !scheduleSeqList.isEmpty()){
			answerList=getAnswerWithHeadQuestionList(parameterMap);
		}
		//스케쥴 목록에 점수 정보를 추가시켜줌
		int listSize=scheduleWithResult.size();
		for(int i=0;i<listSize;i++){
			ScheduleVO scheduleVO=scheduleWithResult.get(i);
			scheduleVO=setResultToScheduleVO(scheduleVO,headQuestionList,answerList);
			
			result.add(scheduleVO);
		}
		return result;
	}
	
	public ScheduleVO setResultToScheduleVO(ScheduleVO scheduleVO,List<QuestionVO> headQuestionList,List<AnswerWithHeadQuestionVO> answerList){
		List<ScoreVO> scoreList=new ArrayList<ScoreVO>();
		int headListSize=headQuestionList.size();
		for(int j=0;j<headListSize;j++){
			QuestionVO questionVO=headQuestionList.get(j);
			int answerListSize = 0;
			if(answerList != null){
				answerListSize=answerList.size();
			}
				
			for(int k=0;k<answerListSize;k++){
				AnswerWithHeadQuestionVO answerVO=answerList.get(k);
				if(scheduleVO.getSeq()==answerVO.getId()){
					if(questionVO.getId().equals(answerVO.getHead_question_id())){
						ScoreVO scoreVO= new ScoreVO();
						scoreVO.setScore(String.valueOf(answerVO.getScore()));
						scoreVO.setId(answerVO.getQuestion_id());
						scoreVO.setQuestion_name(answerVO.getQuestion_name());
						scoreList.add(scoreVO);
					}
				}
			}
		}
		scheduleVO.setScoreList(scoreList);
		return scheduleVO;
	}
	
	public List<Integer> getScheduleSeqList(List<ScheduleVO> scheduleList){
		int listSize=scheduleList.size();
		List<Integer> scheduleSeqList=new ArrayList<Integer>();
		for(int i=0;i<listSize;i++){
			scheduleSeqList.add(scheduleList.get(i).getSeq());
		}
		return scheduleSeqList;
	}

}

