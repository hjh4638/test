package mil.af.orms.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.exception.NeedSSOLoginException;
import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.AnswerService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.QuestionService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.util.DateUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 진단표 작성 Controller
 */
@Controller
@RequestMapping("/DiagnosisTableCreate")
public class DiagnosisTableCreateController {
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="QuestionService")
	QuestionService questionService;
	
	@Resource(name="AnswerService")
	AnswerService answerService;
	
	@RequestMapping("/showMyScheduleList.do")
	public void showMyScheduleList(HttpServletRequest request,Model model,
			@RequestParam(required=false) String scheduleDate) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		scheduleDate=DateUtil.getToday("YYYYMMDD");
		String flight_date=scheduleDate;
		//20120216 본인 스케줄만 보여주기 중사 황예찬
		//String sosokcode=commonService.getUserSquadron(userVO.getSosokcode());
		String sosokcode = null;
		String period=null;
		List<ScheduleVO> myUnitScheduleList=scheduleService.getMyUnitScheduleList(flight_date,sosokcode,period,userVO.getUserid());
		model.addAttribute("myScheduleList",myUnitScheduleList);
	}
	
	@RequestMapping("/showDiagnosisTable.do")
	public void showDiagnosisTable(HttpServletRequest request,Model model
			,@RequestParam String scheduleId,@RequestParam(required=false, defaultValue="write") String mode) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		ScheduleVO schedule=scheduleService.getSchedule(scheduleId);
		String airplane=commonService.getUserPlane(schedule.getUnit_code());;
		if(schedule!=null){
			if(schedule.getConfirm_sn()==null||schedule.getConfirm_sn().equals("")){
				ScheduleVO answeredSchdule;
				//진단결과가 없을 시 최근 작성한 스케쥴의 진단표를 가져옴 
				if(schedule.getResult()==null||schedule.getResult().equals("")){
					answeredSchdule=scheduleService.getRecentScheduleWithResult(userVO);
					
				}else{ // 진단결과가 있을 시엔 작성한 진단표를 가져옴
					answeredSchdule=schedule;
				}
				
		
				String section = null;
				if(schedule.getSection().equals("05")){
					section = "01";
				}else if(schedule.getSection().equals("06")){
					section = "02";
				}else if(schedule.getSection().equals("07")){
					section = "03";
				}else if(schedule.getSection().equals("08")){
					section = "04";
				}else{
					section = schedule.getSection();
				}
				/*255대대 같은 비행기종 여러개 가져올시*/
				List<String> air_list = commonService.getUserPlaneList(schedule.getUnit_code());;
				String unit_code = schedule.getUnit_code();
				String last_str = unit_code.substring(unit_code.length()-1, unit_code.length());
				
				List<QuestionVO> questionListByLevel = new ArrayList<QuestionVO>();
				questionListByLevel=questionService.getQuestionListWithScoreByLevel(schedule.getPeriod(), section, airplane);
				if(last_str.equals("H")){
					questionListByLevel=questionService.getQuestionListWithScoreByLevel(schedule.getPeriod(), section, air_list.get(1));
				}
								
				if(answeredSchdule!=null){
					answeredSchdule=answerService.setResultToSchedule(answeredSchdule);
					questionListByLevel=questionService.setCheckedAnswer(questionListByLevel,answeredSchdule.getScoreList());
				}
			
				List<QuestionVO> questionTree=questionService.getQuestionListByLevelTree(questionListByLevel);
				
				/**
				 * 최근비행일가져오기
				 * ORMS_SCHEDULE 테이블에서 rownum=2 인 스케쥴의 비행날짜를 가져온다.
				 */
				String lastFlight_date = scheduleService.getLastflight_date(userVO.getGunbun());
				int diffDay = scheduleService.getDiffDay(lastFlight_date);
				int idForSubject = questionService.getIdforSubject(questionTree); // 동일과목의 Id 구하기
				
				/**
				 * 최근비행일 구현
				 * lastFlight_date(최근비행일)
				 * diffDay(최근비행일과 오늘 날짜의 차이
				 * 
				 */
				if(mode.equals("write")) // 
				{
					questionService.setRecentFlight_date(lastFlight_date,diffDay,questionTree);
				
				
				/**
				 * 일일 비행횟수 구현시작
				 * 1. flight_date 일치하는 데이터 찾기
				 * 2. voForflight_date의 size, 그밑의 내 데이터 위치(order by period desc)에 따라 구분하기
				 * 3. 2번여부에따라 setChecked("Y")해주기
				 */
				List<ScheduleVO> voForflight_date = scheduleService.getVOforFlight_date(schedule);
				// seq로 지금현재꺼 구분
				questionService.setNumberOfFlight(voForflight_date,schedule,questionTree);
				
				
				/**
				 * 동일과목에 대한 설정해주기 
				 * 동일 과목에 대해선 jsp에서 jquery로
				 * 
				 */
				questionService.setSameSubject(questionTree);
				}
				
				model.addAttribute("idForSubject", idForSubject);
				model.addAttribute("questionTree", questionTree);
			}else{
				throw new Exception("확인이 끝난 스케쥴 입니다.");
			}
		}
	}
	
	@RequestMapping("/insertDiagnosisTable.do")
	@ResponseBody
	public String insertDiagnosisTable(HttpServletRequest request,Model model,
			@RequestParam String scheduleId,@RequestParam String answers) throws Exception{
		
		UserVO userVO=commonService.getUserInfoFromSession(request);
		ScheduleVO schedule=scheduleService.getSchedule(scheduleId); //scheduleId : seq
		if(schedule.getConfirm_sn()==null||schedule.getConfirm_sn().equals("")){
			String sosokcode=commonService.getUserSquadron(schedule.getUnit_code());
			/*255대대 같은 비행기종 여러개 가져올시*/
			List<String> air_list = commonService.getUserPlaneList(schedule.getUnit_code());;
			String unit_code = schedule.getUnit_code();
			String last_str = unit_code.substring(unit_code.length()-1, unit_code.length());
			List<QuestionVO> questionListByLevel = new ArrayList<QuestionVO>();
			
			String airplane=commonService.getUserPlane(sosokcode);
			if(last_str.equals("H")){
				airplane=commonService.getUserPlaneList(sosokcode).get(1);
			}
			if(questionService.validateQuestionCount(airplane,answers)){
				if(schedule!=null){
					if((schedule.getSn()).equals(userVO.getUserid())){
						return answerService.insertDiagnosisTable(schedule,answers);
					}else{
						return "Fail";
					}
				}else{
					return "Fail";
				}
			}else{
				return "Fail";
			}
		}else{
			return "Fail";
		}
	}
	
	@RequestMapping(value="/view/cancelReason.do", method=RequestMethod.GET)
	public void cancelReason(Model model, @RequestParam Integer seq){
		model.addAttribute("seq",seq);
	}
	
	@RequestMapping(value="insertReason.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertReason(HttpServletRequest request, @RequestParam String cancelReason, @RequestParam Integer seq) throws SQLException{
		
		HashMap<String, String> seqAndReason = new HashMap<String, String>();
		seqAndReason.put("seq",seq.toString());
		seqAndReason.put("cancelReason", cancelReason);
		scheduleService.insertReason(seqAndReason);
		
		return "Success";
	}
	
	@RequestMapping(value="/checkSubject.do",method=RequestMethod.POST)
	@ResponseBody
	public Integer checkSubject(HttpServletRequest request,
								@RequestParam String scheduleId,
							    @RequestParam String subjectId,
							    @RequestParam int idForSubject) throws SQLException{
		/**
		 * 동일과목의 id(:자식들의 upper_id)에 따라 분류해야함 (기간 vs횟수)
		 * upper_id로 분류하고 몇번째 child가 setChecked("Y")되야 하는지까지 해서 리턴
		 * (return)jsp에서 checked랑 글자색배경색 해줘야될듯
		 */
		
		UserVO userVO=commonService.getUserInfoFromSession(request);
		int checkedChild=questionService.getSeqOfChild(userVO.getGunbun(),subjectId,idForSubject); // selected 될 child의 번호 부여할 변수
		
		return checkedChild;
	}
	
}
