package mil.af.iers.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mil.af.iers.component.facilities.FacilitiesService;
import mil.af.iers.component.util.ListVOUtil;
import mil.af.iers.component.util.ReservationFixed;
import mil.af.iers.component.util.ReservationSupport;
import mil.af.iers.component.util.UploadAndDownloadUtil;
import mil.af.iers.component.validator.ReservationValidator;
import mil.af.iers.dao.SettlementDao;
import mil.af.iers.model.CodeDTO;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.SettlementDTO;
import mil.af.iers.model.UserDTO;
import mil.af.iers.model.VacationFacilitiesDTO;
import mil.af.iers.service.CodeService;
import mil.af.iers.service.MemberService;
import mil.af.iers.service.ReservationService;
import mil.af.iers.service.SettlementService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class AdminController {
	
	@Resource
	private HttpServletRequest request;
	@Resource
	private MemberService memberService;
	@Resource
	private FacilitiesService facilitiesService;
	@Resource
	private CodeService codeService;
	@Resource
	private SettlementService settlementService;
	@Resource
	private ReservationService reservationService;
	@Resource
	private ReservationValidator reserveValidator;
	@Resource
	private HttpSession session;
	@Resource
	private ReservationSupport reserveSupport;
	@Resource
	private ReservationService reserveService;
	
	@RequestMapping("admin/adminMain.do")
	public ModelAndView adminMain(){
		return new ModelAndView("/view/admin/adminMain");
	}
	//예약자 확정 및 조회
	@RequestMapping(value="admin/appList.do")
	public ModelAndView appList(String reservation_day,String facilities_type){
		ModelAndView mav = new ModelAndView("/view/admin/appList");
		ReservationDTO reserve = new ReservationDTO();
		
		if("".equals(reservation_day) || reservation_day==null){
			reservation_day=ReservationFixed.getDay(0);
		}
				
		reserve.setReservation_day(reservation_day);
		reserve.setFacilities_type(facilities_type);
		
		System.out.println("★★ㅁ"+reserve.getReservation_day());
		List<ReservationDTO> reslist = reservationService.getReservationofDay(reserve);
		mav.addObject("reserve", reserve);
		System.out.println("★★"+reslist);
		mav.addObject("rank",codeService.getListOfCodeByType("rankscore"));
		mav.addObject("code",codeService.getListOfCodeByType("approval"));
		mav.addObject("reslist",reslist);
		mav.addObject("fCodeList", codeService.getFacilCodeBySectionExclude("others"));
		String url="admin/appList.do?reservation_day="+reservation_day+"&&facilities_type="+facilities_type;
		mav.addObject("url",url);
		return mav; 
	}
	
	@RequestMapping(value="admin/appList.do",method=RequestMethod.POST)
	public ModelAndView appListshow(@ModelAttribute ReservationDTO reservationDTO, BindingResult result,
			String date, String type)throws SQLException{
		ModelAndView mav = new ModelAndView(new RedirectView("/admin.do?type=appList&reservation_day="+date+"&facilities_type="+type,true));
		reservationService.updateState(reservationDTO);
		return mav;
	}
	//시설물 관리
	@RequestMapping("admin/changeFacilites.do")
	public ModelAndView changeFacilites() throws SQLException{
		List<VacationFacilitiesDTO> flist=facilitiesService.getFacilitiesList();
		VacationFacilitiesDTO vacationFacilitiesDTO = new VacationFacilitiesDTO();
		
		
		ModelAndView mav = new ModelAndView("view/admin/changeFacilites");
		mav.addObject("facilitiesList", JSONArray.fromObject(flist));
		String url="admin/changeFacilites.do";
		mav.addObject("url", url);
		mav.addObject("vacationFacilitiesDTO", vacationFacilitiesDTO);
		mav.addObject("fCodeList", codeService.getFacilCodeBySectionExclude("all"));
		return mav;
	}
//	시설물 체인지ㅣ~~~~
	@RequestMapping(value="admin/changeFacilites.do",method=RequestMethod.POST)
	public ModelAndView changeFacilitesR(@ModelAttribute VacationFacilitiesDTO vacationFacilitiesDTO,BindingResult result) throws SQLException{
		if(vacationFacilitiesDTO.getFacilities_id() == null){
			ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=changeFacilites",true));
			int seq = facilitiesService.getFacilitiesId();
			vacationFacilitiesDTO.setFacilities_id(seq);
			facilitiesService.mergeIntoFacilities(vacationFacilitiesDTO);
			System.out.println("★a"+seq);
			return mav;
		}
		System.out.println("★★");
		facilitiesService.mergeIntoFacilities(vacationFacilitiesDTO);
		
		
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=changeFacilites",true));
		return mav;
	}
//	시설물삭제
	@RequestMapping(value="admin/changeFacilitesd.do",method=RequestMethod.POST)
	public ModelAndView changeFacilitesD(@ModelAttribute VacationFacilitiesDTO vacationFacilitiesDTO,BindingResult result) throws SQLException{
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=changeFacilites",true));		
		int del_id = vacationFacilitiesDTO.getFacilities_id();
		System.out.println("★★"+del_id);
		facilitiesService.delFacilData(del_id);
		
		return mav;
	}
	//시설 종류 입력
	@RequestMapping(value="admin/changeFacilitesCode.do",method=RequestMethod.POST)
	public ModelAndView changeFacilitesCode(@ModelAttribute FacilitiesCodeDTO fCode,BindingResult result) throws SQLException{
		codeService.mergeIntoFacilitiesCode(fCode);		
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=changeFacilites",true));
		return mav;
	}
	//시설 종류 삭제
	@RequestMapping(value="admin/changeFacilitesCodeDelete.do",method=RequestMethod.POST)
	public ModelAndView changeFacilitesCodeDelete(String type) throws SQLException{
		codeService.deleteFacilitiesCode(type);		
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=changeFacilites",true));
		return mav;
	}
	@RequestMapping(value="admin/memberManage.do",method=RequestMethod.GET)
	public ModelAndView memberManage(String auth_filter) throws SQLException{
		ModelAndView mav=new ModelAndView("view/admin/memberManage");
		UserDTO userDTO = new UserDTO();
		userDTO.setUser_auth(auth_filter);
		List<UserDTO> userData = memberService.getListOfUser(userDTO);

		List<CodeDTO> authList = codeService.getListOfCodeByType("auth");
		mav.addObject("authList", authList);
		mav.addObject("userData", userData);
		
		return mav;
	}
	//회원관리
	@RequestMapping(value="admin/memberManage.do",method=RequestMethod.POST)
	public ModelAndView memberManagePost(String user_auth,String user_id,String user_sosok){
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=memberManage",true));
		memberService.updateAuthByAdmin(user_auth, user_id,user_sosok);
				
		return mav;
	}
	@RequestMapping("admin/reserveView.do")
	public ModelAndView reserveView() {
		ModelAndView mav = new ModelAndView("/view/admin/reserveView");
		List<FacilitiesCodeDTO> f_code=codeService.getFacilCodeBySectionExclude("others");
		List<ReservationCalendarDTO> calList=new ArrayList<ReservationCalendarDTO>();
		
		for(int i=0;i<f_code.size();i++){
			calList.addAll(reserveService.getDecisionListByTypeAndDate(f_code.get(i).getFacilities_type()));
		}
			
		mav.addObject("calData", JSONArray.fromObject(reserveService.compressCalListToAdmin(f_code,calList)));
		return mav;
	}
	@RequestMapping(value="admin/reserve.do",method=RequestMethod.GET)
	public ModelAndView reserve(String error,String facilities_type,String date){
		ModelAndView mav=new ModelAndView("/view/admin/reserve");
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(date);
		
		if(JSONUtils.mayBeJSON(error)){
			reserve =(ReservationDTO) JSONObject.toBean(JSONObject.fromObject(error), ReservationDTO.class);
		}
				
		mav.addObject("facilitiesList", codeService.getFacilCodeBySectionExclude("others"));
		mav.addObject("facility", codeService.getFacilCodeById(facilities_type));
		mav.addObject("reserveDTO", reserve);
		return mav;
	}
	@RequestMapping(value="admin/reserve.do",method=RequestMethod.POST)
	public ModelAndView reserve(@ModelAttribute ReservationDTO reserveDTO,BindingResult result) throws SQLException{
		reserveValidator.validateToAdmin(reserveDTO, result);
		UserDTO user=(UserDTO) session.getAttribute("login");
		if(result.hasErrors() || user==null){
			ModelAndView mav=new ModelAndView("/layout/layout");
			String url="admin/reserve.do";
			mav.addObject("error", JSONObject.fromObject(reserveDTO));
			mav.addObject("url", url);
						
			return mav;
		}
		reserveDTO.setUser_id(user.getUser_id());
		reserveDTO.setUser_sosok(user.getUser_sosok());
		reserveSupport.setReserve(reserveDTO);
		if(reserveDTO.getReservation_id()==null){
			reserveSupport.reserveAdminRoom();
		}
		else{
			reserveSupport.modifyApp();
		}
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do",true));
		return mav;
	}
	//일일결산
	@RequestMapping(value="admin/settlement.do",method=RequestMethod.GET)
	public ModelAndView settlement(){
		ModelAndView mav = new ModelAndView("/view/admin/settlement");
//		String url="admin/settlement.do";
//		mav.addObject("url", url);
//		VacationFacilitiesDTO vacationFacilitiesDTO = new VacationFacilitiesDTO();
//		SettlementDTO settlementDTO = new SettlementDTO();
		List<FacilitiesCodeDTO> facilitiesCodeDTO = codeService.getFacilCode();
		mav.addObject("facilitiesCodeDTO",facilitiesCodeDTO);
		return mav;
	}

	@RequestMapping(value="admin/settlement.do",method=RequestMethod.POST)
	public ModelAndView settlementPost(String settle_date) throws SQLException{
		ModelAndView mav=new ModelAndView(new RedirectView("/admin.do?type=settlementView",true));
		
		if("".equals(settle_date)||settle_date==null)
			settle_date=ReservationFixed.getDay(0);
		
		@SuppressWarnings("unchecked")
		List<SettlementDTO> li =(List<SettlementDTO>) ListVOUtil.getVOList(request, SettlementDTO.class);
		settlementService.mergeSettlement(li,settle_date);
		
		return mav;
	}
	@RequestMapping("admin/settlementView.do")
	public ModelAndView settlementView(String year){
		ModelAndView mav = new ModelAndView("/view/admin/settlementView");
		if(year==null || "".equals(year))
			year=ReservationFixed.getYear(0);
		mav.addObject("settleStatisticsGroup", settlementService.getSettleStatisticsGroup(year));
		mav.addObject("settleStatistics", settlementService.getSettleStatistics(year));
		return mav;
	}
	@RequestMapping("admin/settlementViewDetail.do")
	public ModelAndView settlementViewDetail(String date){
		ModelAndView mav = new ModelAndView("/view/admin/settlementViewDetail");
		if(date==null || "".equals(date))
			date=ReservationFixed.getDay(0);
		mav.addObject("settle", settlementService.getDetailSettlement(date));
		mav.addObject("reservation", settlementService.getDetailReservationSettlement(date));
		return mav;
	}
	@RequestMapping(value="admin/download.do",method=RequestMethod.GET)
	public void download(HttpServletRequest reqeust, HttpServletResponse response,
			String file_id) throws IOException, SQLException{
		UploadAndDownloadUtil down= new UploadAndDownloadUtil("WEB-INF/upload", "file");
		String file_name=memberService.getFileName(file_id);
		
			down.download(request, response, file_id, file_name);
		
	}
}
