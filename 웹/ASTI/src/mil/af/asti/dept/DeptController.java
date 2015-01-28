package mil.af.asti.dept;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.asti.board.BoardService;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiUserDTO;
import mil.af.asti.model.AstiResearchWorkerDTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import util.PaginationUtil;


/**
 * 
 * @author 일병 이승호
 * 연구 센터
 * view / insert / update / delete 
 */
@Controller
@RequestMapping("dept")
public class DeptController {
	
	@Resource
	private DeptService deptService;
	
	@Resource
	private BoardService boardService;
	/**
	 * view place
	 */
	@RequestMapping("dept.do")
	public ModelAndView researchView(@RequestParam String code
			,HttpServletRequest request,ModelAndView model) {
		
		model.setViewName("menu/dept");
		/*model= new ModelAndView("menu/dept");*/
		request.getSession().setAttribute("nowUrl","dept");
		List<AstiResearchWorkerDTO> list = deptService.deptUserList(code);
//		if(code.equals("C01"))
//			model = new ModelAndView("dept/economy");
//		else if(code.equals("C02"))
//			model = new ModelAndView("dept/economy");
//		else if(code.equals("C03"))
//			model = new ModelAndView("dept/economy");
//		else
//			model = new ModelAndView("dept/economy");
		if(code.equals("B09") || code.equals("B10") || code.equals("B11") ){
		String board_id = "init";
		String board_form = "init";
		AstiBoardSearchDTO astiBoardSearchDTO = new AstiBoardSearchDTO();
		astiBoardSearchDTO.setBoard_id(board_id);
		/*if(boardService.getBoardContent(astiBoardSearchDTO) == null) 이건 왜 안돼냐 ㅡ.ㅡ 이 문제가 아니엇군 */
		/*해당 board_id 있는지 검사*/
		AstiBoardDTO boardContent=boardService.getBoardContent(astiBoardSearchDTO);
			if(boardContent==null)
				board_id = "init";
	
		model.addObject("board_id",board_id);
		model.addObject("board_form",board_form);
		}
		model.addObject("deptUser", list);
		
		return model;
	}
	/*연구원페이지*/
	@RequestMapping("deptworker.do")
	public ModelAndView worker(@RequestParam String code,
			@ModelAttribute AstiBoardSearchDTO searchDTO
			) {
		ModelAndView model = new ModelAndView ("deptworker");
		
		searchDTO.setWorker_department(code);
		/*searchDTO.setAstiBoardPaginationDTO(PaginationUtil.pageSetter(
				currentPage , deptService.getWorkerCount(searchDTO)));*/
		
		List<AstiResearchWorkerDTO> workerList = deptService.getWorkerList(searchDTO);
		model.addObject("workerList", workerList);
						
		return model;
	}
	
	
	
	/**
	 * insert place
	 */
	@RequestMapping()
	public ModelAndView researchInsert() {
		return new ModelAndView(new RedirectView("dept.do"));
	}
	
	/**
	 * delete place
	 */
	
	@RequestMapping()
	public ModelAndView researchDelete() {
		return new ModelAndView(new RedirectView("dept.do"));
	}
	
	/**
	 * update place
	 */
	
	@RequestMapping()
	public ModelAndView researchUpdate() {
		ModelAndView model = new ModelAndView("");
		
		return model;
	}
}
