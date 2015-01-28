package mil.af.L6S.component.admin;

import java.util.ArrayList;
import java.util.List;

import mil.af.L6S.component.common.User;
import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.common.CommonService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Administrator Controller 
 * @author 함준혁, 정성모
 */
@Controller
@RequestMapping("/admin")
public class AdministratorController {
	
	final Logger logger = LoggerFactory
			.getLogger(AdministratorController.class);

	private AdministratorService administratorService;
	private AdministratorValidator administratorValidator;
	
	@Autowired
	public void config(AdministratorService administratorService,
			AdministratorValidator administratorValidator,
			CommonService commonService) {
		this.administratorService = administratorService;
		this.administratorValidator = administratorValidator;
	}

	/**
	 * 관리자 List 
	 * @param user(사용자정보)
	 * @param searchVO(검색정보)
	 * @param administratorVO(관리자정보)
	 * @return model
	 */
	@RequestMapping(value = "/adminTable.do", method = RequestMethod.GET)
	public ModelAndView adminTable(User user,
			@ModelAttribute(value = "searchVO") AdministratorVO searchVO,
			@ModelAttribute(value = "administratorVO") AdministratorVO administratorVO) {

		ModelAndView model = new ModelAndView("admin/adminTable");

		List<AdministratorVO> list = administratorService
				.selectAdministratorList(user, searchVO);
		model.addObject("list", list);
		model.addObject("userInfo", user);
		return model;
	}
	
	/**
	 * 관리자 변경
	 * 
	 * @param user
	 *            체계분류 코드 - classification 정보
	 * @param searchVO
	 *            권한 코드 - authoirty 정보
	 * @param administratorVO
	 *            변경 할 정보를 담는 VO, 군번 sn 값
	 * 
	 * @return 전에 조회한 정보 그대로 유지
	 */
	@RequestMapping(value = "/adminTable.do", method = RequestMethod.PUT)
	public ModelAndView listChange(User user,
			@ModelAttribute AdministratorVO administratorVO) {
			
		ModelAndView model = new ModelAndView("redirect:adminTable.do");
		return model;
	}

	/**
	 *  인사정보 업데이트
	 * @return
	 */
//	@RequestMapping(value="/personnelUpdate.do")
//	public void personnelUpdate(){
//		ModelAndView model = new ModelAndView();
//		List<String> snList = administratorService.getConfirmedData();
//		administratorService.upDateData(snList);
//		
//		return model;
//	}
	
	/**
	 * 관리자 등록 - GET
	 * @param searchVO(검색정보)
	 * @param administratorVO(관리자정보)
	 * @return model
	 */
	@RequestMapping(value="/popup/addAdminView.do", method = RequestMethod.GET)
	public ModelAndView addAdminView(
			User userinfo,
			@RequestParam(value="code", required=true) String code,
			@ModelAttribute(value = "searchVO") AdministratorVO searchVO,
			@ModelAttribute AdministratorVO administratorVO) {
		
		ModelAndView model = new ModelAndView();
		
		searchVO.setQuarter(code);
		searchVO.setSn(userinfo.getSn());

		List<User> u0tList = administratorService.selectAvs11u0tToQuarter(searchVO);

		List<Integer> rankList = new ArrayList<Integer>();  
		int count=0;
		for(User user : u0tList){
			rankList.add(count,user.getRank().length());
			count++;
		}
		model.addObject("userInfo", userinfo);
		model.addObject("quarter", code);
		model.addObject("rankLength", rankList);
		model.addObject("u0t", u0tList);

		return model;
	}

	/**
	 * 관리자 등록 - POST
	 * @param user(사용자정보)
	 * @param searchVO(검색정보)
	 * @param administratorVO(관리자정보)
	 * @param result(Validation)   
	 * @return model 
	 */
	@RequestMapping(value = "/popup/addAdminView.do", method = RequestMethod.POST)
	public ModelAndView registerPost(User user,
			@ModelAttribute(value = "searchVO") AdministratorVO searchVO,
			@ModelAttribute AdministratorVO administratorVO,
			BindingResult result) {
		
		ModelAndView model = new ModelAndView();
			
		model.addObject("result", "true");
		administratorService.insertAdmin(administratorVO);
	
		return model;
	}
}
