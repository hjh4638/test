package mil.af.L6S.component.board;

import mil.af.L6S.component.board.BoardService;
import mil.af.L6S.component.common.User;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ksign.ssoapi.SSOService;

/**
 *  Main Controller
 * @author 이의준
 */
@Controller
@RequestMapping("/board")
public class BoardController {
	final Logger logger = LoggerFactory.getLogger(BoardController.class);

	private BoardService boardService;

	@Autowired
	private void config(BoardService boardService) {
		this.boardService = boardService;
	}


	/**
	 * Notice
	 * @return model(boardNotice) 
	 */
	@RequestMapping("boardNotice.do")
	public ModelAndView boardNotice() {
		ModelAndView mav = new ModelAndView("board/boardNotice");
		return mav;
	}
	
	 /**
	 * QnA
	 * @return model(boardQnA) 
	 */
	// @RequestMapping("boardQnA.do")
	//    public ModelAndView boardQnA(User user) {
	//	ModelAndView mav = new ModelAndView("board/boardQnA");
	//	return mav;
	//  }
	
	/**
	 *  Data
	 * @return model(boardData) 
	 */
	@RequestMapping("boardData.do")
	public ModelAndView boardData(User user) {
		ModelAndView mav = new ModelAndView("board/boardData");
		return mav;
	}
}