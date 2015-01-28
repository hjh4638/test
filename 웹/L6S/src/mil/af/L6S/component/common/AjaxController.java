package mil.af.L6S.component.common;

import java.util.List;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.admin.AdministratorService;
import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.approvalLine.ApprovalVO;
import mil.af.L6S.component.common.AjaxController;
import mil.af.L6S.component.common.CommonService;
import mil.af.L6S.component.common.FileVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("ajax")
public class AjaxController {
	final Logger logger = LoggerFactory.getLogger(AjaxController.class);

	private CommonService commonService;
	private AdministratorService administratorService;
	private ApprovalService approvalService;
	
	@Autowired
	public void config(CommonService commonService,
			AdministratorService administratorService,ApprovalService approvalService) {
		this.commonService = commonService;
		this.administratorService = administratorService;
		this.approvalService = approvalService;
	}
	
	/**
	 * 파일삭제
	 * 
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value = "/deleteFileData.do", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public String deleteFileData(@RequestBody FileVO fileVO) {

		logger.debug("fileSN =" + fileVO.getSn());

		commonService.deleteFileData(fileVO.getSn());

		logger.debug("delete 실행");

		return "success";
	}
	
	
	@RequestMapping(value="/personnelUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public String personnelUpdate(User user){
		List<String> snList = administratorService.getConfirmedData();
		administratorService.upDateData(snList);
		List<String> snList2 = administratorService.getConfirmedData2();
		administratorService.upDateData2(snList2);
		return "success";
	}
	@RequestMapping(value="/getNowAppStep.do")
	@ResponseBody
	@Transactional
	public String getNowAppStep(@RequestParam(required = true) Integer seq){
		return approvalService.withdrawalValidate(seq);
	}
}
