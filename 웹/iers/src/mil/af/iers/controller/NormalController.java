package mil.af.iers.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mil.af.iers.component.util.ReservationFixed;
import mil.af.iers.component.util.ReservationSupport;
import mil.af.iers.component.util.UploadAndDownloadUtil;
import mil.af.iers.component.validator.ReservationValidator;
import mil.af.iers.component.validator.UserValidator;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.UserDTO;
import mil.af.iers.service.CodeService;
import mil.af.iers.service.MemberService;
import mil.af.iers.service.ReservationService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class NormalController {
	@Resource
	private HttpServletRequest request;
	@Resource
	private MemberService memberService;
	@Resource 
	private CodeService codeService;
	@Resource
	private UserValidator userValidator;
	@Resource
	private HttpSession session;
	@Resource
	private ReservationValidator reserveValidator;
	@Resource
	private ReservationSupport reserveSupport;
	@Resource
	private ReservationService reserveService;
	
	
	@RequestMapping("index.do")
	public ModelAndView index(){
		return new ModelAndView("/view/normal/main");
	}
//	회원가입
	@RequestMapping(value="member.do",method=RequestMethod.GET)
	public ModelAndView member(String error) throws SQLException{
		ModelAndView mav=new ModelAndView("/view/normal/member");
		UserDTO userDTO = new UserDTO();
		
		UserDTO user_session=(UserDTO) session.getAttribute("login");
		UserDTO user_sso=memberService.getSSOUserInfo(request);
		if(user_session !=null ){
			userDTO=memberService.getOneOfUser(user_session);
		}
//		user가 json이면 userDTO에 값을 넣음
		else if(JSONUtils.mayBeJSON(error)){
			userDTO =(UserDTO) JSONObject.toBean(JSONObject.fromObject(error), UserDTO.class);
		}
		else if(user_sso !=null){
			userDTO=user_sso;
		}
		
		mav.addObject("rankList", codeService.getListOfCodeByType("rankscore"));
		mav.addObject("sosokList", codeService.getListOfCodeByType("sosok"));
		mav.addObject("userDTO", userDTO);
		
		return mav;
	}
	@RequestMapping(value="member.do",method=RequestMethod.POST)
	public ModelAndView memberPost(	@ModelAttribute UserDTO userDTO,BindingResult result,
			HttpServletResponse response,
			HttpServletRequest request) throws SQLException{
		userValidator.validate(userDTO, result);
		if(result.hasErrors()){
			ModelAndView mav=new ModelAndView("/layout/layout");
			String url="member.do";
			mav.addObject("error", JSONObject.fromObject(userDTO));
			mav.addObject("url", url);
						
			return mav;
		}
		String file_id = (int) (Math.random()*1000000000)+userDTO.getUser_id();
		UploadAndDownloadUtil upload=new UploadAndDownloadUtil("WEB-INF/upload", "file");
		String file_name=upload.upload(request, response,file_id);
		
//		수정시 파일 올렸을때만 수정
		if(file_name !=null && !("".equals(file_name))){
			userDTO.setUser_file_id(file_id);
			userDTO.setUser_file_name(file_name);
		}
		memberService.mergeIntoUser(userDTO);
		
		ModelAndView mav=new ModelAndView(new RedirectView("/main.do",true));
		return mav;
	}
//	예약
	@RequestMapping(value="reserve.do",method=RequestMethod.GET)
	public ModelAndView reserve(String error,String facilities_type,String date){
		ModelAndView mav=new ModelAndView("/view/normal/reserve");
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(date);
		
		if(JSONUtils.mayBeJSON(error)){
			reserve =(ReservationDTO) JSONObject.toBean(JSONObject.fromObject(error), ReservationDTO.class);
		}
		mav.addObject("facilitiesList", codeService.getFacilCodeBySectionInclude("normal"));
		mav.addObject("facility", codeService.getFacilCodeById(facilities_type));
		mav.addObject("reserveDTO", reserve);
		return mav;
	}
	@RequestMapping(value="reserve.do",method=RequestMethod.POST)
	public ModelAndView reserve(@ModelAttribute ReservationDTO reserveDTO,BindingResult result) throws SQLException{
		UserDTO user=(UserDTO) session.getAttribute("login");
		reserveValidator.validate(reserveDTO, result);
		if(result.hasErrors() || user==null){
			ModelAndView mav=new ModelAndView("/layout/layout");
			String url="reserve.do";
			mav.addObject("error", JSONObject.fromObject(reserveDTO));
			mav.addObject("url", url);
						
			return mav;
		}
		String id=user.getUser_id();
		String sosok=user.getUser_sosok();
		String auth=user.getUser_auth();
		Integer reCount = reserveService.getMyReserveCount(id,sosok);
		
		if(!("D02".equals(auth)) || reCount>0){
			ModelAndView mav=new ModelAndView("/layout/layout");
			String url="reserve.do";
			mav.addObject("error", JSONObject.fromObject(reserveDTO));
			mav.addObject("url", url);
			System.out.println("D02권한 아니거나 올해 이미 예약을 해서 안됨");
			return mav;
		}
		
//		null포인터 에러 방지위해 여기 둠
		reserveDTO.setUser_id(user.getUser_id());
		reserveDTO.setUser_sosok(user.getUser_sosok());

		reserveSupport.setReserve(reserveDTO);
		if(reserveDTO.getReservation_id()==null){
			reserveSupport.reserveRoom();
		}
		else{
			reserveSupport.modifyApp();
		}
		ModelAndView mav=new ModelAndView(new RedirectView("/main.do",true));
		return mav;
	}
//	잔여객실 조회
	@RequestMapping("reserveView.do")
	public ModelAndView reserveView() {
		ModelAndView mav = new ModelAndView("/view/normal/reserveView");
		List<FacilitiesCodeDTO> f_code=codeService.getFacilCodeBySectionInclude("normal");
		List<ReservationCalendarDTO> calList=new ArrayList<ReservationCalendarDTO>();
		
		for(int i=0;i<f_code.size();i++){
			calList.addAll(reserveService.getDecisionListByTypeAndDate(f_code.get(i).getFacilities_type()));
		}
			
		mav.addObject("calData", JSONArray.fromObject(reserveService.compressCalList(f_code,calList)));
		return mav;
	}
	@RequestMapping("myReserve.do")
	public ModelAndView myReserve() throws SQLException{
		ModelAndView mav = new ModelAndView("/view/normal/myReserve");
		
		UserDTO user=(UserDTO) session.getAttribute("login");
		if(user!=null){
			List<ReservationDTO> myReserve=reserveService.getMyReservation(user.getUser_id(),user.getUser_sosok());
			mav.addObject("myReserve", JSONArray.fromObject(myReserve));
		}
		//reserveService.deleteOneAPP(Integer.parseInt(reservation_id));
		return mav;
	}
	@RequestMapping(value="reserveDel.do", method=RequestMethod.GET)
	public ModelAndView myReserveD(@RequestParam String reservation_id) throws SQLException{
		ModelAndView mav = new ModelAndView(new RedirectView("/main.do?type=myReserve",true));
//		UserDTO user=(UserDTO) session.getAttribute("login");
//		if(user!=null){
//			List<ReservationDTO> myReserve=reserveService.getMyReservation(user.getUser_id(),user.getUser_sosok());
//			mav.addObject("myReserve", myReserve);
//		}
		System.out.println("★☆★"+reservation_id);
		reserveService.deleteOneAPP(Integer.parseInt(reservation_id));
		return mav;
	}
}
