package mil.af.orms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.ScheduleService;
import mil.af.orms.util.DateUtil;
import net.sf.json.JSONArray;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 메인 컨트롤러
 */
@Controller
public class MainController {
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@RequestMapping("/main.do")
	public ModelAndView redirectMainByRole(HttpServletRequest request) throws Exception{
		ModelAndView model=new ModelAndView();
		UserVO userVO=commonService.getUserInfoFromSession(request);
		
		
		UserRole role=userVO.getRole();
		if(role==UserRole.SYSTEMADMIN){
			model.setViewName("redirect:/SystemManage/adminMain.do");
		}else if(role==UserRole.CQ){
			model.setViewName("redirect:/ScheduleManage/scheduleManage.do");
		}else{
			System.out.println("@DEBUGING");
			model.setViewName("redirect:/normalMain.do");
		}
		return model;
	}
	
	@RequestMapping("/normalMain.do")
	public void showMain(HttpServletRequest request,Model model) throws Exception{
		
		UserVO userVO=commonService.getUserInfoFromSession(request);
				
		String flight_date=DateUtil.getToday("YYYYMMDD");
		//String sosokcode=commonService.getUserSquadron(userVO.getSosokcode());
		//String period=null;
		String sn= userVO.getUserid();		
		
		/*120214 중사 황예찬 수정
		 * 메인화면
		 * 편대소속 되어 있는 조종사 : 자신의 편대 + 스케줄이 잡혀있는 편대
		 * 편대소속이 되어 있지 않은 조종사 : 군번으로 스케줄이 잡혀잇는 편대 보여줌 
		*/  
		UserAuthVO userAuthVO=commonService.getUserAuth(userVO);
		userVO.setRole(commonService.getUserRole(userAuthVO,userVO));
		
		String sosokcode=userVO.getUnit_code();
		if(userAuthVO==null){ 
			//편대소속되어 있지 않은 조종사
			if(userVO.getUnit_code()== null){
				sosokcode = "-";
				sn = userVO.getUserid();				
				//System.out.println("편대속해있지 않은 조종사" +sn + userVO.getUnit_code());	 
			} 			
		}	
		
		String encryptSn=commonService.getEncryptSn(userVO.getUserid());			
	//	List<ScheduleVO> myUnitScheduleList=scheduleService.getMyUnitScheduleList(flight_date,sosokcode,period,sn);
		List<ScheduleVO> myUnitScheduleList=scheduleService.getMainScheduleList(flight_date,sosokcode,sn);
		model.addAttribute("myUnitScheduleList",myUnitScheduleList);
		String dateInfo=DateUtil.getDayString(flight_date, "YYYY.MM.DD")+"("+DateUtil.getDayName(flight_date)+")";
		model.addAttribute("dateInfo",dateInfo);
		model.addAttribute("encryptSn",encryptSn);
		model.addAttribute("UserVO",userVO);  	
		
	}
	
	public static void main(String[] args){
		JSONArray a=JSONArray.fromObject("[{'flightGroup':'asdf'}]");
		System.out.println(a.getJSONObject(0).get("flightGroup"));
	}
	
	/*매뉴얼 다운로드*/
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/images/ormDownload.do")
	public ModelAndView download(
			HttpServletResponse response, HttpServletRequest request)
			throws IOException {

		String urlPath = request.getRealPath("upload");
		
		File file = new File(urlPath, "ormManual.hwp");
		response.setBufferSize(4096);
		response.setContentType("application/haansofthwp");
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "attachment;filename="
				+ URLEncoder.encode("ormManual.hwp", "UTF-8"));
		IOUtils.copy(new FileInputStream(file), response.getOutputStream());
		return null;
	}
}
