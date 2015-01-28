package mil.af.iers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ImageViewController {

	@RequestMapping("usingInfo.do")
	public ModelAndView usingInfo(){
		return new ModelAndView("/view/imageView/usingInfo");
	}
	@RequestMapping("roomInfo.do")
	public ModelAndView roomInfo(){
		return new ModelAndView("/view/imageView/roomInfo");
	}
	@RequestMapping("mapInfo.do")
	public ModelAndView mapInfo(){
		return new ModelAndView("/view/imageView/mapInfo");
	}
	@RequestMapping("declareBoard.do")
	public ModelAndView declareBoard(){
		return new ModelAndView("/view/imageView/declareBoard");
	}
	@RequestMapping("qnaBoard.do")
	public ModelAndView qnaBoard(){
		return new ModelAndView("/view/imageView/qnaBoard");
	}
}
