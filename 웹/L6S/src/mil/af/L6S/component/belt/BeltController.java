package mil.af.L6S.component.belt;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpSession;

//import junit.framework.Assert;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.subject.SubjectService;
import mil.af.L6S.component.subject.BaseVO;
import mil.af.L6S.component.approvalLine.ApprovalBeltVO;
import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.common.CommonService;
import mil.af.L6S.component.common.FileVO;
import mil.af.L6S.component.common.User;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;


/**
 *  벨트 Controller
 * @author 정성모
 */
@Controller
@RequestMapping("/belt")
public class BeltController {
	final Logger logger = LoggerFactory.getLogger(BeltController.class);

	private BeltService beltService;
	private SubjectService subjectService;
	private CommonService commonService;
	private BeltExcelView beltExcelView;
	private ApprovalService approvalService;
	private RegisterValidator registerValidator;

	@Autowired
	public void config(BeltService beltService,
						SubjectService subjectService,
						RegisterValidator registerValidator,
						BeltExcelView beltExcelView,
						ApprovalService approvalService,
						CommonService commonService) {
		this.beltService = beltService;
		this.registerValidator = registerValidator;
		this.subjectService = subjectService;
		this.beltExcelView = beltExcelView;
		this.approvalService = approvalService;
		this.commonService = commonService;
	}

	/**
	 *  벨트 List 조회 V
	 * @return model(belt_listresult) 
	 */
	@RequestMapping(value = "beltListResult.do", method = RequestMethod.GET)
	public ModelAndView BeltListResult(User user,
			@ModelAttribute(value = "beltVO") BeltVO beltVO,
			@ModelAttribute(value = "searchFilter") SearchFilter searchFilter) {
		
		ModelAndView model = new ModelAndView("belt/belt_listresult");
		
		List<BeltVO> beltList = beltService.beltListInquiry(searchFilter,beltVO);
		
		if(searchFilter.getSearchBelt()==null||searchFilter.getSearchBelt()==""){

		}else{

		}
		
		model.addObject("user", user);
		model.addObject("beltList", beltList);
		model.addObject("beltListSize", beltList.size());
		return model;
	}
	
	/**
	 *  사용자/벨트 등록 선택 창 V
	 * @return model(belt_MenuList)
	 */
	@RequestMapping(value = "beltMenuList.do")
	public ModelAndView beltMenuList(User user){
		ModelAndView model = new ModelAndView("belt/belt_MenuList");
		int checkSN = beltService.checkSNinBase(user.getSn());
		model.addObject("checkSN",checkSN);
		model.addObject("user", user);
		return model;
	}
	
	/**
	 *  벨트 보유자 등록 Get V
	 * @param user
	 * @param beltVO
	 * @return model(belt_userRegister)
	 */
	@RequestMapping(value = "beltUserRegister.do", method = RequestMethod.GET)
	public ModelAndView beltUserRegisterGet(User user,
			@ModelAttribute(value = "searchFilter") SearchFilter searchFilter){
		ModelAndView model = new ModelAndView("belt/belt_userRegister");
		
		List<BaseVO> headBase = subjectService.getHeadBase();
		model.addObject("headBase", headBase);
	
		model.addObject("user",user);
		
		return model;
	}
	
	/**
	 *  신규 벨트 등록 Get V
	 * @param user
	 * @param beltVO
	 * @param contentsVO
	 * @return model(belt_Register)
	 */
	@RequestMapping(value = "beltRegister.do", method = RequestMethod.GET)
	public ModelAndView beltRegisterGet(User user,
			@ModelAttribute(value = "beltVO") BeltVO beltVO,
			@RequestParam(value="code", required=false) String code){
		
		ModelAndView model = new ModelAndView("belt/belt_Register");
		ContentsVO content;
			
		if(code == null){
			content = new ContentsVO();
		}else{
			List<FileVO> files = beltService.getFiles(code);
			content = beltService.getContent(code);
			content.setFileVO(files);
		}
		
		model.addObject("beltVO",beltVO);
		model.addObject("contentsVO", content);
		model.addObject("code", code);
		model.addObject("user", user);
		return model;
	}
	
	/**
	 *  신규 벨트 등록 Post V
	 * @param user
	 * @param beltVO
	 * @param contentsVO
	 * @return model(belt_Register)
	 * 
	 * Transactional 은 DB에서 Query를 Connection 시켜 줌.
	 */
	@Transactional
	@RequestMapping(value = "beltRegister.do", method = RequestMethod.POST)
	public ModelAndView beltRegisterPost(HttpSession session, User user,
			@ModelAttribute(value = "contentsVO") ContentsVO contentsVO,
			BindingResult result){
		
		ModelAndView model = new ModelAndView("belt/belt_Register");
		BeltVO beltVO = new BeltVO();
		
		this.registerValidator.validate(contentsVO, result);
		if(!result.hasErrors()){
									
			int checkSN = beltService.checkSNinBase(user.getSn());
			logger.debug("checkSN : "+checkSN);
			if(checkSN == 0){
				beltVO.setSn(user.getSn());
				beltVO.setName(user.getName());
				beltVO.setRank(user.getRank());
				beltVO.setSosokName(user.getIntrasosok());
				beltVO.setSosokCode(user.getPositionCode());
				beltService.beltPossessorInput(beltVO);
			}		
			beltService.beltInput(contentsVO);
			
			@SuppressWarnings("unchecked")
			List<FileVO> fileVOs = (List<FileVO>) session
					.getAttribute("fileVOList");
			commonService.insertFileUpload(fileVOs, null);
			session.setAttribute("fileVOList", null);
			
			int getseq = approvalService.getFileSeq();
			
			if(contentsVO.getAppCode().equals("A")){
				approvalService.insertBeltApproval(getseq);
				contentsVO.setFile_seq(getseq);
				approvalService.Belt_RegisterAPP(contentsVO);
			}
			
			System.out.println("☆★☆★"+contentsVO.getSn());
			
			model.addObject("user", user);
			model.addObject("beltVO",beltVO);
			model.addObject("contentsVO",contentsVO);
			return new ModelAndView(new RedirectView("beltListResult.do"));
		} else{
			model.setViewName("belt/belt_Register");
			return model;
		}
	}
	
	/**
	 *  벨트 상세 내용 Get V
	 * @param 순번 코드 num
	 * @return model(detail)
	 */
	@RequestMapping(value="/detail.do", method = RequestMethod.GET)
	public ModelAndView detailGet(User user,
			@RequestParam(value="num", required=false) String str,
			@ModelAttribute(value = "beltVO") BeltVO beltVO, 
			@ModelAttribute(value = "appVO") ApprovalBeltVO approvalBeltVO) {
		SearchFilter searchFilter = new SearchFilter();
		ModelAndView model = new ModelAndView("belt/detail");
				
		searchFilter.setPn(str);
		List<BeltVO> beltList = beltService.beltInquiry(searchFilter);
		searchFilter.setSn(beltList.get(0).getSn());
		List<FileVO> file_data = beltService.MatchFiles(searchFilter);
		
		for(ContentsVO contents : beltList.get(0).getBeltDatum()){
			String appState = approvalService.getApp_state(contents.getFile_seq());
			contents.setAppState(appState);
			contents.setComment(approvalService.getComment(contents.getFile_seq()));
			if(appState != null){
				contents.setApp_str(appState);
				
			}
		}
		
		model.addObject("user",user);
		model.addObject("beltList", beltList.get(0));
		model.addObject("File",file_data);
		logger.debug("BeltList = " + beltList);
		
		return model;
	}
	
	/**
	 *  벨트 상세 내용 Delete V
	 * @param 순번 코드 num
	 * @return model(detail)
	 */
	@RequestMapping(value="/detail.do", method = RequestMethod.DELETE)
	public ModelAndView detailDelete(User user,
			@RequestParam(value="num", required=false) String str,
			@ModelAttribute(value = "beltVO") BeltVO beltVO) {
		ModelAndView model = new ModelAndView("belt/detail");
		String target = beltVO.getDummy();
		beltService.deleteContent(target);
		model.addObject("user",user);
		return new ModelAndView(new RedirectView("detail.do?num="+beltVO.getPn()));
	}
	
	/**
	 *  벨트 상세 내용 Put 
	 * @param Code = file_seq
	 * @return model(detail)
	 */
	@Transactional
	@RequestMapping(value="/beltRegister.do", method = RequestMethod.PUT)
	public ModelAndView detailPut(HttpSession session, User user,
			@RequestParam(value="code", required=true) String code,
			@ModelAttribute(value = "contentsVO") ContentsVO contentsVO,
			BindingResult result) {
		
		ModelAndView model = new ModelAndView("belt/belt_Register");
		
		contentsVO.setFile_seq(Integer.parseInt(code));
		this.registerValidator.validate(contentsVO, result);
		contentsVO.setSn(beltService.getSNfromCode(code));
		beltService.updateContents(contentsVO);
		int num = beltService.getRnum(contentsVO.getSn());
		logger.debug("Error : "+result);
		if(!result.hasErrors()){
			
			@SuppressWarnings("unchecked")
			List<FileVO> fileVOs = (List<FileVO>) session
					.getAttribute("fileVOList");
			
			commonService.insertFileUpload(fileVOs, code);
			
			if(contentsVO.getAppCode().equals("A")){
			
				contentsVO.setFile_seq(Integer.parseInt(code));
				int fileseq= contentsVO.getFile_seq();
				String resu = approvalService.checkisexist(fileseq);
			
				if (resu != null) {
					approvalService.updaterejectedBelt(fileseq);
				}
				else{
					approvalService.insertBeltApproval(fileseq);
					approvalService.Belt_RegisterAPP(contentsVO);
				}
			}
			session.setAttribute("fileVOList", null);		
				
			return new ModelAndView(new RedirectView("detail.do?num="+num));
		}else{
			model.setViewName("belt/belt_Register");
			return model;
		}
	}
		
	/**
	 *  Excel 출력
	 *  	(성적순 GB 정렬)
	 * @return EXCEL VIEW
	 */
	@RequestMapping("excel/beltListExcel.do")
	public ModelAndView beltListExcel(){
		ModelAndView model = new ModelAndView(beltExcelView);
		
		Calendar calendar = new GregorianCalendar();
		List<BeltVO> beltVO = beltService.getBeltFiltering(calendar.get(Calendar.YEAR));
		model.addObject("beltVO", beltVO);

		return model;
	}
	@Test
	public void test(){
		
	}
}
