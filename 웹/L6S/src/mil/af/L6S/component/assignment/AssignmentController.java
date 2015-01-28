package mil.af.L6S.component.assignment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *  과제 조회 및 등록, 과제 현황
 * @author 정성모 
 */
@Controller
@RequestMapping("/assignment")
public class AssignmentController {
	final Logger logger = LoggerFactory.getLogger(AssignmentController.class);

	private AssignmentService assignmentService;

	@Autowired
	private void config(AssignmentService assignmentService) {
		this.assignmentService = assignmentService;
	}

	/**
	 *  과제 조회
	 * @return model(assignment_register) 
	 */
	@RequestMapping("assignList.do")
	public ModelAndView AssignmentList(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/assignment_list");
		return model;
	}

	/**
	 *  Detail Item
	 * @param 항목 고유 num
	 * @return model(detail)
	 */
	@RequestMapping(value="/detail.do", method = RequestMethod.GET)
	public ModelAndView detail(@RequestParam(value="num", required=false) String str) {
		ModelAndView model = new ModelAndView("assignment/detail");
		model.addObject("Code", str);
		return model;
	}
	
	/**
	 *  자기것만 보는거 
	 * @return
	 */
	@RequestMapping("assignListMine.do")
	public ModelAndView AssignmentListMine(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/assignment_list_mine");
		return model;
	}
	
	/**
	 *  과제 등록
	 * @return model(assignment_register) 
	 */
	@RequestMapping("assignRegister.do")
	public ModelAndView AssignmentRegister(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/assignment_register");
		return model;
	}
	
	/**
	 *  D stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("dstage.do")
	public ModelAndView Dstage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_d");
		return model;
	}
	
	/**
	 *  D stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("mstage.do")
	public ModelAndView Mstage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_m");
		return model;
	}
	
	/**
	 *  D stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("astage.do")
	public ModelAndView Astage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_a");
		return model;
	}
	
	/**
	 *  D stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("istage.do")
	public ModelAndView Istage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_i");
		return model;
	}
	
	/**
	 *  D stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("cstage.do")
	public ModelAndView Cstage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_c");
		return model;
	}
	
	/**
	 *  E stage
	 * @return model(stage_d) 
	 */
	@RequestMapping("estage.do")
	public ModelAndView Estage(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/stage/stage_e");
		return model;
	}
		
	/**
	 *  검색 Popup창
	 * @return model(void)
	 */
	@RequestMapping("/popup/search.do")
	public ModelAndView PopupSearch(/* User user */) {
		ModelAndView model = new ModelAndView();
		return model;
	}

	/**
	 *  과제 현황
	 * @return model(assignment_result) 
	 */
	@RequestMapping("assignResult.do")
	public ModelAndView AssignmentResult(/* User user */) {
		ModelAndView model = new ModelAndView("assignment/assignment_result");
		return model;
	}
}
