package mil.af.orms.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.model.DayWithResultCountVO;
import mil.af.orms.model.DiagnosisStatusParamVO;
import mil.af.orms.model.GraphByResultVO;
import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.StatusByDateVO;
import mil.af.orms.model.StatusByMonthVO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.SystemVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.AnswerService;
import mil.af.orms.service.CodeService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.DiagnosisStatusService;
import mil.af.orms.service.QuestionService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.util.DateUtil;
import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 진단현황조회 Controller
 */
@Controller
@RequestMapping("/DiagnosisStatus")
public class DiagnosisStatusController {
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="AnswerService")
	AnswerService answerService;
	
	@Resource(name="QuestionService")
	QuestionService questionService;
	
	@Resource(name="DiagnosisStatusService")
	DiagnosisStatusService diagnosisStatusService;
	
	List<UnitVO> flightGroupList;
	/*비행단 리스트 ModelAttribute(Model 객체에 자동 삽입됨)*/
	@ModelAttribute("flightGroupList")
	public List<UnitVO> getFlightGroupList(HttpServletRequest request) throws SQLException{
		if(this.flightGroupList==null){
			this.flightGroupList=commonService.getAllFlightGroupList();
		}
		return this.flightGroupList;
	}
	
	/*선택할 년도 리스트 최근 3년을 가져옴*/
	@ModelAttribute("yearList")
	public List<String> getYearList(){
		List<String> yearList=new ArrayList<String>();
		int thisYear=Integer.parseInt(DateUtil.getToday("YYYY"));
		for(int i=thisYear;i>thisYear-3;i--){
			yearList.add(String.valueOf(i));
		}
		return yearList;
		
	}
	
	/*진단현황 메인페이지*/
	@RequestMapping("/showDiagnosisStatus.do")
	public void showDiagnosisStatus(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
		System.out.println(param.toString());		
		
	}
	
	/*임무당일 그래프 조회 페이지*/
	@RequestMapping("/showTodayStatusGraph.do")
	public void showTodayStatus(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param,
			@RequestParam(required=false) String print) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
		List<DayWithResultCountVO> resultList=diagnosisStatusService.getDayWithResultList(param);
		model.addAttribute("resultList", JSONArray.fromObject(resultList));
	}
	
	/*임무당일 그래프 세부내용 조회 팝업*/
	@RequestMapping("/view/showTodayStatusGraphDetail.do")
	public void showTodayStatusGraphDetail(HttpServletRequest request,Model model,
			@RequestParam(required=false) String print,
			@RequestParam String flight_date,
			@RequestParam String unit_code) throws Exception{
		/*String flight_date="20120105";
		String unit_code="A2200530-1";*/
		List<ScheduleVO> detailList = scheduleService.getScheduleByDate(flight_date,unit_code);
		
		model.addAttribute("flight_date", flight_date);
		model.addAttribute("unit_code", unit_code);
		model.addAttribute("detailList", detailList);
	}
	
	
	
	/*임무당일 전체 대대 그래프 조회 페이지[항안단 관리자 전용]*/
	@RequestMapping("/showTodayAllStatusGraph.do")
	public void showTodayAllStatus(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
		if(param.getSquadron().equals("")){
			
			List<DayWithResultCountVO> allSquadronList=diagnosisStatusService.getAllSquadronList(param, request);
			List<GraphByResultVO> allSquadronGraphList=diagnosisStatusService.getByResultList(allSquadronList);
			model.addAttribute("resultList", JSONArray.fromObject(allSquadronGraphList));
		}
	}
	
	/*월간 그래프 조회 페이지*/
	@RequestMapping("/showMonthStatusGraph.do")
	public void showMonthStatus(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
		List<DayWithResultCountVO> resultList=diagnosisStatusService.getDayWithResultList(param);
		List<GraphByResultVO> byResultList=diagnosisStatusService.getByResultList(resultList);
		System.out.println(resultList.size());
		model.addAttribute("resultList", JSONArray.fromObject(byResultList));
	}
	
	/*임무당일 표 조회 페이지*/
	@RequestMapping("/showTodayStatusTable.do")
	public void showTodayStatusTable(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
		String start_date=diagnosisStatusService.getRangeStartDate(param); //기간 시작일
		String end_date=diagnosisStatusService.getRangeEndDate(param); // 기간 종료일
		
		String form_start_date=DateUtil.getDayString(start_date,"YYYY-MM-DD");
		String form_end_date=DateUtil.getDayString(end_date,"YYYY-MM-DD");
		List<String> dateRange=DateUtil.getBetweenDays(form_start_date, form_end_date); // 두날짜 사이 범위 전체 리스트
		
		List<SysCodeVO> periodList=codeService.getTimePeriodList();
		
		List<StatusByDateVO> resultList=diagnosisStatusService.getStatusByDateList(param,periodList);
		System.out.println(resultList.size());
		
		model.addAttribute("startDate",start_date);
		model.addAttribute("endDate",end_date);
		model.addAttribute("dateRange",dateRange);
		model.addAttribute("periodList",periodList);
		model.addAttribute("periodListSize",periodList.size());
		model.addAttribute("resultList",resultList);
	}
	
	@RequestMapping("showMonthStatusTable.do")
	public void showMonthStatusTable(HttpServletRequest request,Model model,
			@ModelAttribute DiagnosisStatusParamVO param) throws Exception{
		UserVO userVO=commonService.getUserInfoFromSession(request);
		param=diagnosisStatusService.setUserSquadron(param,userVO);
				
		List<SysCodeVO> periodList=codeService.getTimePeriodList();
		
		List<StatusByMonthVO> pilotList=diagnosisStatusService.getStatusByMonth(param,periodList);
		
		model.addAttribute("periodList",periodList);
		model.addAttribute("pilotList", pilotList);
		model.addAttribute("pilotListSize", pilotList.size());
	}
	@RequestMapping("/view/showPersonalStatus.do")
	public void showPersonalStatus(HttpServletRequest request,Model model,
			@RequestParam String sn,
			@RequestParam String start_date,
			@RequestParam String end_date) throws Exception{
		
		
		UserVO pilot=commonService.getIntraUser(sn);
		String sosokcode=commonService.getUserSquadron(pilot.getSosokcode());
		String airplane=commonService.getUserPlane(sosokcode);
		List<QuestionVO> questionList=questionService.getHeadQuestionList(airplane);
		List<ScheduleVO> scheduleList=scheduleService.getScheduleWithResultList(sn,start_date,end_date);
		scheduleList=answerService.setResultToScheduleList(airplane,scheduleList);
		model.addAttribute("questionTree",questionService.getQuestionListByLevelTree(questionList));
		model.addAttribute("pilot", pilot);
		model.addAttribute("scheduleList", scheduleList);
		
	}
	
	@RequestMapping(value="/view/showMonthStatusByPerson.do", method=RequestMethod.GET)
	public void showMonthStatusByPerson(Model model, 
										@RequestParam String sn,
										@RequestParam String month,
										@RequestParam String year)
	{
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
	}
	
	
	
}