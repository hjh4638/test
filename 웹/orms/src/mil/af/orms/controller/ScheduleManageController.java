package mil.af.orms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.model.ScheduleForModifyVO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.SystemVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.CodeService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.util.DateUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ScheduleManage")

public class ScheduleManageController {

	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@SuppressWarnings("unused")
	@RequestMapping("/scheduleManage.do")
	public void system_scheduleManage(HttpServletRequest request,Model model
			,@RequestParam(required=false) String squadron
			,@RequestParam(required=false) String timePeriod,
			@RequestParam(required=false) String flight_date) throws Exception {
		if(flight_date==null){
			flight_date=DateUtil.getToday("YYYYMMDD");
		}
		UserVO userVO=commonService.getUserInfoFromSession(request);
		String squadronFor = userVO.getSosokcode();
		String unit_code =  commonService.getUnitCode(squadronFor);
		List<UnitVO> unitCodeList=commonService.getUnitCodeList(unit_code);// 편대 코드 리스트
		List<SysCodeVO> timePeriodList=codeService.getTimePeriodList();// 시간대 코드 리스트
		
		if(squadron == null || "".equals(squadron)){
			/*if(userVO.getRole()==UserRole.SYSTEMADMIN){
				squadron=""; //전체 검색
			}else{*/
				squadron=unit_code;
			/*}*/
		}
		
		
		if("".equals(timePeriod)){
			timePeriod=null;
		}
		/*System.out.println(squadron+"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");*/
		List<ScheduleForModifyVO> scheduleForViewList=scheduleService.getScheduleForViewList(squadron,timePeriod,flight_date);
		model.addAttribute("unitCodeList",unitCodeList);
		model.addAttribute("timePeriodList",timePeriodList);
		model.addAttribute("scheduleForViewList",scheduleForViewList);
	}
	
	@RequestMapping("/scheduleInsert.do")
	public void showSystemManageInsert(HttpServletRequest request,Model model
			,@RequestParam String squadron
			,@RequestParam String timePeriod,
			@RequestParam String flight_date) throws Exception {

		UserVO userVO=commonService.getUserInfoFromSession(request);
		if("".equals(timePeriod)){
			timePeriod=null;
		}
		if("".equals(squadron)){
			if(userVO.getRole()==UserRole.SYSTEMADMIN){
				squadron=""; //전체 검색
			}else{
				squadron=userVO.getUnit_code();
			} 
		}
		
		String squadronFor = userVO.getSosokcode();
		String unit_code =  commonService.getUnitCode(squadronFor);
		List<UnitVO> unitCodeList=commonService.getUnitCodeList(unit_code);// 편대 코드 리스트
		for(int i=0;i<unitCodeList.size();i++){
			System.out.println("DEBUGING:: unitCode : " + unitCodeList.get(i).getUnit_code());
			System.out.println("DEBUGING:: sosokCode : " + unitCodeList.get(i).getSosokcode());
		}
		
		/*List<UnitVO> unitCodeList=commonService.getUnitCodeList(userVO);// 편대 코드 리스트
*/		List<UserVO> formationPilotList=commonService.getFormationPilotList(squadron);//편대 조종사 리스트
		List<UserVO> allPilotList=commonService.getFormationPilotList("");//전체 조종사 리스트
		List<SysCodeVO> timePeriodList=codeService.getTimePeriodList();// 시간대 코드 리스트
		List<SysCodeVO> positionList=codeService.getPositionList();    // 조종위치 코드 리스트
		List<SysCodeVO> section1List=codeService.getSectionList("01",squadron,null); // 전방석 자격 코드 리스트
		List<SysCodeVO> section2List=codeService.getSectionList("02",squadron,null); // 후방석 자격 코드 리스트
		List<String> weatherConditionList=codeService.getWeatherConditionList();
		List<ScheduleForModifyVO> scheduleForModifyList=scheduleService.getScheduleForModifyList(squadron,timePeriod,flight_date);
		model.addAttribute("unitCodeList",unitCodeList);
		model.addAttribute("formationPilotList",formationPilotList);
		model.addAttribute("allPilotList",allPilotList);
		model.addAttribute("timePeriodList",timePeriodList);
		model.addAttribute("positionList",positionList);
		model.addAttribute("section1List",section1List);
		model.addAttribute("section2List",section2List);
		model.addAttribute("weatherConditionList",weatherConditionList);
		model.addAttribute("scheduleForModifyList",scheduleForModifyList);
	}
	

	
	/**
	 * 스케쥴 입력,수정 메소드(Ajax요청에 사용)
	 */

	@RequestMapping(value="setSchedule.do",method=RequestMethod.POST)
	@ResponseBody
	public String setSchedule(HttpServletRequest request,
			@RequestParam String[] squadron,
			@RequestParam String[] timePeriod,
			@RequestParam Integer[] seq1,
			@RequestParam Integer[] seq2,
			@RequestParam String[] cs,
			@RequestParam String[] position1,
			@RequestParam String[] position2,
			@RequestParam String[] section1,
			@RequestParam String[] section2,
			@RequestParam String[] weather1,
			@RequestParam String[] weather2,
			@RequestParam String flight_date) throws Exception{
		ArrayList<ScheduleForModifyVO> scheduleList=new ArrayList<ScheduleForModifyVO>();
		int scheduleSize = Math.max(position1.length, position2.length);
		
		System.out.println("s = " + scheduleSize + ", " + position1.length + ", " + position2.length);

		int newRow=0;
		for(int i=0;i<scheduleSize;i++){
			ScheduleForModifyVO schedule=new ScheduleForModifyVO();
			schedule.setSeq1(seq1.length > i ? seq1[i] : null);
			schedule.setSeq2(seq2.length > i ? seq2[i] : null);
			schedule.setCs(cs.length > i ? cs[i] : null);
			schedule.setSn1(position1.length > i ? position1[i] : null);
			schedule.setSn2(position2.length > i ? position2[i] : null);
			schedule.setSection1(section1.length > i ? section1[i] : null);
			schedule.setSection2(section2.length > i ? section2[i] : null);
			schedule.setWeather1(weather1.length > i ? weather1[i] : null);
			schedule.setWeather2(weather2.length > i ? weather2[i] : null);
			schedule.setPeriod(timePeriod.length > i ? timePeriod[i] : null);
			schedule.setUnit_code(squadron.length > i ? squadron[i] : null);
			
			if(schedule.getSeq1()==null&&schedule.getSeq2()==null){
				schedule.setId(String.valueOf(scheduleService.getAvailNewId()+newRow));
				newRow++;
			}
			
			System.out.println("Schedule"+i+":"+schedule.toString());
			scheduleList.add(schedule);
		}
		
		scheduleService.setResultToSchedule(scheduleList,flight_date);
		
		return "Success";
	}
	
	
	/**
	 * 스케줄 삭제쿼리(Ajax요청에 이용)
	 */
	@RequestMapping(value="/deleteSchedule.do",method=RequestMethod.POST)
	@ResponseBody
	public Object deleteSchedule(HttpServletRequest request, @RequestParam String id) throws Exception{
		HashMap<String, String> p = new HashMap<String, String>();
		p.put("num", id);
		scheduleService.deleteSchedule(p);
		scheduleService.deleteAnswers(p);
		return true;
		
	}
	
}
