package mil.af.orms.controller;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.model.QuestionWithAllScoreVO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.UserVO;

import mil.af.orms.service.CodeService;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.ValuationStandardService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/ValuationStandardTable")

public class ValuationStandardController {

	@Resource(name="ValuationStandardService")
	ValuationStandardService valuationStandardService;
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@RequestMapping("/valuationStandardTable.do")
	public void showValuationStandardTable(HttpServletRequest request,Model model,
			@RequestParam(required=false,defaultValue="01") String airCraftCode)  throws Exception{
		
		UserVO userVO= commonService.getUserInfoFromSession(request);
		String userAirplane=commonService.getUserPlane(userVO.getSosokcode());
		userVO.setAirplane(userAirplane);
		
		/*if(userVO.getAirplane() !=null && airCraftCode.equals("01"))
		airCraftCode=userVO.getAirplane();*/
		
		List<QuestionWithAllScoreVO> questionListByLevelForAirCraft=valuationStandardService.getQuestionListWithAllScoreByLevel(airCraftCode);
		List<QuestionWithAllScoreVO> questionTreeForAirCraft=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForAirCraft);
		
		List<QuestionWithAllScoreVO> questionListByLevelForCommon=valuationStandardService.getQuestionListWithAllScoreByLevel("05");
		List<QuestionWithAllScoreVO> questionTreeForCommon=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForCommon);
					
		List<SysCodeVO> sectionTitleList=codeService.getSectionList("01",null,airCraftCode);
		
		model.addAttribute("UserVO",userVO);
		model.addAttribute("questionTreeForAirCraft", questionTreeForAirCraft);
		model.addAttribute("questionTreeForCommon", questionTreeForCommon);
		model.addAttribute("sectionTitleList", sectionTitleList);
		System.out.println("평가기준시작");
		}
	
	@RequestMapping("/view/valuationStandardTable.do")
	public void showValuationStandardTableForOnlyView(HttpServletRequest request,Model model,
			@RequestParam(required=false,defaultValue="01") String airCraftCode,
			@RequestParam(required=false) String print)  throws Exception{
		
		List<QuestionWithAllScoreVO> questionListByLevelForAirCraft=valuationStandardService.getQuestionListWithAllScoreByLevel(airCraftCode);
		List<QuestionWithAllScoreVO> questionTreeForAirCraft=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForAirCraft);
		
		List<QuestionWithAllScoreVO> questionListByLevelForCommon=valuationStandardService.getQuestionListWithAllScoreByLevel("05");
		List<QuestionWithAllScoreVO> questionTreeForCommon=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForCommon);
			
		model.addAttribute("questionTreeForAirCraft", questionTreeForAirCraft);
		model.addAttribute("questionTreeForCommon", questionTreeForCommon);
		System.out.println("평가기준시작");
		}
		
	@RequestMapping("/valuationStandardModify.do")
	public void valuationModify(HttpServletRequest request,Model model,
			@RequestParam(required=false,defaultValue="01") String airCraftCode) throws Exception{
		List<QuestionWithAllScoreVO> questionListByLevelForAirCraft=valuationStandardService.getQuestionListWithAllScoreByLevel(airCraftCode);
		List<QuestionWithAllScoreVO> questionTreeForAirCraft=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForAirCraft);
		
		List<QuestionWithAllScoreVO> questionListByLevelForCommon=valuationStandardService.getQuestionListWithAllScoreByLevel("05");
		List<QuestionWithAllScoreVO> questionTreeForCommon=valuationStandardService.getQuestionListByLevelTree(questionListByLevelForCommon);
			
		model.addAttribute("questionTreeForAirCraft", questionTreeForAirCraft);
		model.addAttribute("questionTreeForCommon", questionTreeForCommon);
	}
	
	@RequestMapping("/modifyQuestion.do")
	@ResponseBody
	public String modifyQuestion(HttpServletRequest request,
			@ModelAttribute QuestionWithAllScoreVO questionWithAllScoreVO,
			@RequestParam String gubun,
			@RequestParam(required=false,defaultValue="01") String airCraftCode
			) throws Exception{ 
		System.out.println(questionWithAllScoreVO.getQuestion_name());
		System.out.println(questionWithAllScoreVO.getId());
		System.out.println(questionWithAllScoreVO.getLev());
		System.out.println(questionWithAllScoreVO.getDay_period1());
		System.out.println(questionWithAllScoreVO.getDay_period2());
		System.out.println(airCraftCode);
		valuationStandardService.updateScore(questionWithAllScoreVO, gubun,airCraftCode);
		return "Success";
	}
	@RequestMapping("/deleteQuestion.do")
	@ResponseBody
	public String deleteQuestion(HttpServletRequest request,
			@RequestParam int id)throws Exception
	{
		System.out.println("id="+id);
		valuationStandardService.changeUseYn(id);
		return "Success";
		
	}
}
	
	
	
	

