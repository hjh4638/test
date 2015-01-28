package mil.af.orms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.SquadronStatusVO;
import mil.af.orms.model.SystemVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.CodeService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.service.SystemService;
import mil.af.orms.util.DateUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/SystemManage")

public class SystemManageController {
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="SystemService")
	SystemService systemService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	

	/**
	 * 항안단 메인
	 */
	@RequestMapping("/adminMain.do")
	public void showScheduleManage(HttpServletRequest request,Model model) throws Exception {
		List<UnitVO> unitList= commonService.getFlightGroupWithSquadronListByLevel();
		List<UnitVO> unitTree=commonService.getUnitListByLevelTree(unitList);
		model.addAttribute("flightGroupTree", unitTree);
		model.addAttribute("flightGroupTreeNum", unitTree.size());
	}
	
	/**
	 * 항안단 메인 비행단별 현황 조회
	 */
	@RequestMapping("/view/showFlightGroupStatus.do")
	public void showFlightGroupStatus(HttpServletRequest request,Model model,
			@RequestParam String flightGroup,
			@RequestParam(required=false) String squadron,
			@RequestParam(required=false) String flight_date) throws Exception{
		if("".equals(squadron)){
			squadron=null;
		}
		if(flight_date==null){
			flight_date=DateUtil.getToday("YYYYMMDD");
		}
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("flightGroup", flightGroup);
		parameterMap.put("squadron",squadron);
		parameterMap.put("flight_date",flight_date);
		List<SquadronStatusVO> flightGroupStatusList=scheduleService.getFlightGroupStatusList(flightGroup,squadron,flight_date, request);
		List<ScheduleVO> dignosisCount = scheduleService.getDignosisCount(parameterMap);
				
		model.addAttribute("flightGroupStatusList",flightGroupStatusList);
		model.addAttribute("flghtGroupName",commonService.getUnitName(flightGroup));
		model.addAttribute("dignosisCount", dignosisCount);
	}
	
	@RequestMapping(value = "/authorityManage.do", method=RequestMethod.GET)
	public void showAuthorityManageGet (HttpServletRequest request,Model model,
			@RequestParam(required=false) String flightGroupCode) throws Exception {
		
		UserVO userVO = commonService.getUserInfoFromSession(request);
		
		List<UnitVO> flightGroupList = new ArrayList<UnitVO>();
		List<UnitVO> squadronList = new ArrayList<UnitVO>();
		UnitVO flightGroup = new UnitVO();
		UnitVO squadron = new UnitVO();
		
		String squadronCode=null;	
		
	
		if(userVO.getRole().toString().equals("SYSTEMADMIN")){
			/**
			 * 유저가 관리자일경우 전체 비행단및 대대 표시
			 */
			flightGroupList=commonService.getAllFlightGroupList();
			
			if(flightGroupCode==null){
				if(flightGroupList.size()>0){
						flightGroupCode=flightGroupList.get(0).getSosokcode();
				}
			}
			
			squadronList=commonService.getSquadronList(flightGroupCode);
			if(squadronList.size()>0){
				squadronCode=squadronList.get(0).getSosokcode();
			}
		}
		
		else{
			/**
			 * 유저가 안전편대장일 경우 편대장소속 비행단-대대만 표시
			 */
			flightGroup = commonService.getFlightGroup(userVO);
			squadron = commonService.getSquadron(userVO.getUserid());
			squadronCode = squadron.getSosokcode();
		
		}
	

		List<SystemVO> authViewList=systemService.getAuthViewList();
		List<SystemVO> searchAuthViewList=systemService.searchAuthViewList(squadronCode);
		/*String insertAuthList=systemService.insertAuthList(systemVO);*/
		
		model.addAttribute("UserVO", userVO);
		model.addAttribute("flightGroupCode", flightGroupCode);
		model.addAttribute("flightGroupList", flightGroupList);
		model.addAttribute("flightGroup", flightGroup);
		model.addAttribute("squadronList",squadronList);
		model.addAttribute("squadron", squadron);
		model.addAttribute("authViewList", authViewList);
		model.addAttribute("searchAuthViewList", searchAuthViewList);
		
		
		
		
	}
	
	
	/**
	 * 비행단 별 비행대대를 가져오는 ResponseBody(Ajax요청에 이용)
	 */
	@RequestMapping(value="/getSquadronList.do",method=RequestMethod.POST)
	@ResponseBody
	public List<UnitVO> getSquadronList(HttpServletRequest request, @RequestParam String flightGroupCode) throws Exception{
		List<UnitVO> squadronList=commonService.getSquadronList(flightGroupCode);
		return squadronList;
	}
	
	/**
	 * 사람찾기 리스트를 가져오는 ResponseBody(Ajax요청에 이용)
	 */
	@RequestMapping(value="/getSearchedUserList.do",method=RequestMethod.POST)
	@ResponseBody
	public List<UserVO> getSearchedUserList(@RequestParam String searchName) throws Exception{
		List<UserVO> searchedUserList=commonService.getSearchedUserList(searchName);
		return searchedUserList;
	}
	
	/**
	 * 권한관리 추가쿼리(Ajax요청에 이용)
	 */
	@RequestMapping(value="/insertAuthList.do",method=RequestMethod.POST)
	@ResponseBody
	public Object insertAuthList(@RequestParam String sosokcode, String sn, String role_code) throws Exception{
		HashMap<String, String> p = new HashMap<String, String>();
		p.put("sn", sn);
		p.put("sosokcode", sosokcode);
		p.put("role_code", role_code);
		
		systemService.insertAuthList(p);
		
		return true;
		
	}
	
	/**
	 * 권한관리 삭제쿼리(Ajax요청에 이용)
	 */
	@RequestMapping(value="/deleteAuthList.do",method=RequestMethod.POST)
	@ResponseBody
	public Object deleteAuthList(HttpServletRequest request, @RequestParam String sn) throws Exception{
		HashMap<String, String> p = new HashMap<String, String>();
		p.put("sn", sn);
		systemService.deleteAuthList(p);
		
		return true;
		
	}
	
	/**
	 * 대대별 검색(Ajax요청에 이용)
	 */
	@RequestMapping(value="/searchAuthViewList.do",method=RequestMethod.POST)
	@ResponseBody
	public List<SystemVO> searchAuthViewList(@RequestParam String sosokcode) throws Exception{
		List<SystemVO> searchAuthViewList=systemService.searchAuthViewList(sosokcode);
		return searchAuthViewList;
	}
}