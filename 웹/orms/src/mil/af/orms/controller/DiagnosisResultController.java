package mil.af.orms.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.AnswerService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.ConfirmService;
import mil.af.orms.service.QuestionService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.util.DateUtil;
import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 진단결과 조회 Controller
 */
@Controller
@RequestMapping("/DiagnosisResult")
public class DiagnosisResultController {
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="ConfirmService")
	ConfirmService confirmService;
	
	@Resource(name="QuestionService")
	QuestionService questionService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="AnswerService")
	AnswerService answerService;
	
	@RequestMapping("/showDiagnosisResultList.do")
	public void showDiagnosisResult(HttpServletRequest request,Model model,
			@RequestParam(required=false) String scheduleDate,
			@RequestParam(required=false) String unit,
			@RequestParam(required=false) String period) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
				
		List<SysCodeVO> sys_period=commonService.getPeriod();
		//안전편대장, 비행대장/대대장만 편대별 조회 가능
		//편대 리스트 가져오기 (해당편대만 가져오기 수정 2012.02.09 중사 황예찬)
		if(userVO.getRole()!=UserRole.FORMATIONMANAGER&&userVO.getRole()!=UserRole.SQUADRONMANAGER){
			unit = "";
		} 
	
		if(scheduleDate==null){
			scheduleDate=DateUtil.getToday("YYYYMMDD");
		}
		long s =new Date().getTime();
		List<ScheduleVO> scheduleWithResult=scheduleService.getScheduleWithResultList(userVO,scheduleDate,unit, period);
		
		String airplane=userVO.getAirplane();
		
		if(scheduleWithResult.size()>0){
			scheduleWithResult=answerService.setResultToScheduleList(airplane,scheduleWithResult);
			model.addAttribute("scheduleWithResult", scheduleWithResult);
		}
		List<QuestionVO> questionList=questionService.getHeadQuestionList(airplane);
		model.addAttribute("questionTree",questionService.getQuestionListByLevelTree(questionList));
		
		//편대 리스트 가져오기 (해당편대만 가져오기 수정 2012.02.09 중사 황예찬)
		//List<UnitVO> unitList=commonService.getUnitCodeList(userVO);
		//model.addAttribute("unitList", unitList);
		UserAuthVO userAuthVO=commonService.getUserAuth(userVO);
		
		List<UnitVO> unitList;
		if(userVO.getRole()!=UserRole.FORMATIONMANAGER&&userVO.getRole()!=UserRole.SQUADRONMANAGER){
			unitList=commonService.getUnitCodeList(userVO);	
		}else {
			unit=userAuthVO.getUnit_code();
			unitList=commonService.getUnitCodeList(unit);
		}
		model.addAttribute("unitList", unitList);
		model.addAttribute("sys_period", sys_period);
		System.out.println("걸린시간="+(new Date().getTime()-s)+"ms");
	}
	
	@RequestMapping("/view/showDiagnosisResultList.do")
	public void showDiagnosisResultForPrint(HttpServletRequest request,Model model,
			@RequestParam(required=false) String scheduleDate,
			@RequestParam(required=false) String unit,
			@RequestParam(required=false) String period,
			@RequestParam String print) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		
		//안전편대장, 비행대장/대대장만 편대별 조회 가능
		if(userVO.getRole()!=UserRole.FORMATIONMANAGER&&userVO.getRole()!=UserRole.SQUADRONMANAGER){
			unit="";
		}
		
		if(scheduleDate==null){
			scheduleDate=DateUtil.getToday("YYYYMMDD");
		}
		List<ScheduleVO> scheduleWithResult=scheduleService.getScheduleWithResultList(userVO,scheduleDate,unit, period);
		String airplane=null;
		if(scheduleWithResult.size()>0){
			String sosokcode=scheduleWithResult.get(0).getUnit_code();
			airplane=commonService.getUserPlane(sosokcode);
		}
		List<QuestionVO> questionList=questionService.getHeadQuestionList(airplane);
		model.addAttribute("questionTree",questionService.getQuestionListByLevelTree(questionList));
		scheduleWithResult=answerService.setResultToScheduleList(airplane,scheduleWithResult);
		model.addAttribute("scheduleWithResult", scheduleWithResult);
		
		//편대 리스트 가져오기 (해당편대만 가져오기 수정 2012.02.09 중사 황예찬)
		//List<UnitVO> unitList=commonService.getUnitCodeList(userVO);
		//model.addAttribute("unitList", unitList);
		UserAuthVO userAuthVO=commonService.getUserAuth(userVO);		
		List<UnitVO> unitList;
		if(userVO.getRole()!=UserRole.FORMATIONMANAGER&&userVO.getRole()!=UserRole.SQUADRONMANAGER){
			unitList=commonService.getUnitCodeList(userVO);	
		}else {
			unit=userAuthVO.getUnit_code();
			unitList=commonService.getUnitCodeList(unit);
		}
		model.addAttribute("unitList", unitList);
	}
	
	@RequestMapping("/view/showPersonalDiagnosisResult.do")
	public void showPersonalDiagnosisResult (HttpServletRequest request,Model model,
			@RequestParam String scheduleSeq) throws Exception{
			
		ScheduleVO scheduleVO=scheduleService.getScheduleBySeq(scheduleSeq);
		scheduleVO=answerService.setResultToSchedule(scheduleVO);
		model.addAttribute("schedule", scheduleVO);
		
		String airplane=commonService.getUserPlane(scheduleVO.getUnit_code());
		List<QuestionVO> questionList=questionService.getHeadQuestionList(airplane);
		model.addAttribute("questionTree",questionService.getQuestionListByLevelTree(questionList));
		
		/*당일에만 수정가능하도록 하기위해 구현한 코드 2012.5.15 일병 함준혁*/
		String today=commonService.getToday();
		model.addAttribute("today", today);
		String dateToCompare=confirmService.getConfirmDateToCompare(scheduleSeq);
		model.addAttribute("dateToCompare", dateToCompare);

	}
	
	@RequestMapping(value="/confirmSchedule.do",method=RequestMethod.POST)
	@ResponseBody
	public String confirmSchedule(HttpServletRequest request,
			@RequestParam Integer scheduleId,
			@RequestParam String confirmOpinion,
			@RequestParam String confirmResult) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		return confirmService.confirmSchedule(scheduleId,confirmResult,confirmOpinion,userVO);
		
	}
}
