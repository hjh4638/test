package mil.af.asti.notif;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.asti.board.BoardService;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiUserDTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("notif")
public class NotifController {
	@Resource
	private BoardService boardService;
	
	@RequestMapping("notif.do")
	public ModelAndView notif(@RequestParam String code
			,HttpServletRequest request
			,@RequestParam(defaultValue="init",required=false) String board_id
			,@RequestParam(defaultValue="init",required=false) String board_form){
		request.getSession().setAttribute("nowUrl","notif");
		ModelAndView model = new ModelAndView("menu/notif");
		
		/*뷰 페이지에서 삭제하면 남아있는 board_id 파라미터 때문에 창 안떠서 ㅜ.ㅡ
		 * 강제로 init 넣어줌*/
		AstiBoardSearchDTO astiBoardSearchDTO = new AstiBoardSearchDTO();
		astiBoardSearchDTO.setBoard_id(board_id);
		/*if(boardService.getBoardContent(astiBoardSearchDTO) == null) 이건 왜 안돼냐 ㅡ.ㅡ 이 문제가 아니엇군 */
		/*해당 board_id 있는지 검사*/
		AstiBoardDTO boardContent=boardService.getBoardContent(astiBoardSearchDTO);
			if(boardContent==null)
				board_id = "init";
	
		model.addObject("board_id",board_id);
		model.addObject("board_form",board_form);
		return model;
	}

}
