package mil.af.L6S.component.endsubject;

import java.util.List;

import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.common.User;
import mil.af.L6S.component.subject.BaseVO;
import mil.af.L6S.component.subject.SubjectExcelView;
import mil.af.L6S.component.subject.SubjectFormAndDataVO;
import mil.af.L6S.component.subject.SubjectService;
import mil.af.L6S.component.subject.SubjectVO;
import mil.af.common.util.UploadAndDownloadUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/endsubject")
public class EndSubjectController {
	private UploadAndDownloadUtil upAndDown;
	private SubjectService subjectService;

	@Autowired
	void subjectcontroller(UploadAndDownloadUtil upAndDown,
			SubjectService subjectService,
			ApprovalService approvalService,
			SubjectExcelView subjectExcelView) {
		this.upAndDown = upAndDown;
		this.subjectService = subjectService;
	}
	/**
	 * 사후관리 목록
	 */
	@RequestMapping("/endsubjectList.do")
	public void endsubjectList(Model model,
			@ModelAttribute(value = "subjectVO") SubjectVO subjectVO,
//			@RequestParam(required=false) String year,
			User user) {
		/* 셀렉트박스 항목 구해오는 code */
		/*과제유형*/
		List<SubjectFormAndDataVO> subjectTypeItem = subjectService
				.getFormByType("SUBJECT_TYPE");
		model.addAttribute("subjectTypeItem", subjectTypeItem);
		/*과제 구분*/
		List<SubjectFormAndDataVO> subjectSectionItem = subjectService
				.getFormByType("SUBJECT_SECTION");
		model.addAttribute("subjectSectionItem", subjectSectionItem);
		/*성과구분*/
		List<SubjectFormAndDataVO> subjectResultSection = subjectService
				.getFormByType("RESULT_SECTION");
		model.addAttribute("subjectResultSection", subjectResultSection);
		/*분야별 유형*/
		List<SubjectFormAndDataVO> subjectFieldType = subjectService
				.getFormByType("FIELD_TYPE");
		model.addAttribute("subjectFieldType", subjectFieldType);
		/*소속*/
		List<BaseVO> allBase = subjectService.getBaseAll();
		model.addAttribute("allBase", allBase);

		/* 검색해서 나온 결과물 구해오는 code */
		/*사람검색(팀원,리더,챔피언,부서장,지도위원) 코드로 구분*/
		subjectService.setSelection(subjectVO);
		
		subjectVO.setEndsubject("true");
		
//		subjectVO.setRegister_day(year);
		/*구분된 코드로 과제 조회*/
		List<SubjectVO> sub = subjectService.searchSubject(subjectVO);
		model.addAttribute("allSubject", sub);
	}

	@RequestMapping(value = "/enddetailSubjectList.do")
	public void mySubject(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		
		/*해당 과제코드 과제*/
		SubjectVO mainSubject = subjectService.getSubjectBySeq(seq);
		model.addAttribute("mainSubject", mainSubject);
		
		String c04=subjectService.getOneDataByCode("C04", seq+"");
		String e03=subjectService.getOneDataByCode("E03", seq+"");;
		String e05=subjectService.getOneDataByCode("E05", seq+"");;
		model.addAttribute("C04", c04);
		model.addAttribute("E03", e03);
		model.addAttribute("E05", e05);
		
		List<AfterSubjectVO> after=subjectService.getAfter(seq+"");
		model.addAttribute("after", after);
		
		List<Integer> sub_codes=user.getSubject_code();
		boolean is_mystep = sub_codes.contains(seq);
		model.addAttribute("is_mine", is_mystep);
	}
	
	@RequestMapping(value="InAndChange.do",method=RequestMethod.POST)
	@ResponseBody
	public String inAndChange(Integer subject_code,Integer price,String content,Integer title,Integer seq,String mode){
		AfterSubjectVO param = new AfterSubjectVO();
		param.setSubject_code(subject_code);
		param.setPrice(price);
		param.setContent(content);
		param.setTitle(title);
		param.setSeq(seq);
		if("in".equals(mode)){
			param.setSeq(subjectService.getSeq());
			subjectService.inserAfter(param);
			return "success";
		}
		else if("change".equals(mode)){
			subjectService.updateAfter(param);
			return "success";
		}
		else{
			return "false";
		}
	}
	@RequestMapping(value="deleteAfter.do",method=RequestMethod.POST)
	@ResponseBody
	public String deleteAfter(Integer seq){
			subjectService.deleteAfter(seq+"");
		return "success";
	}
}
