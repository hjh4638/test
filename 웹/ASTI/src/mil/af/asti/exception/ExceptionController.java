package mil.af.asti.exception;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.stereotype.Controller;

@Controller
@RequestMapping("error")
public class ExceptionController {

	@RequestMapping("uriCheatException.do")
	public ModelAndView uriCheatException(){
		return new ModelAndView("error/uriCheatException");
	}
	
	@RequestMapping("authDeniedException.do")
	public ModelAndView authDeniedException(){
		return new ModelAndView("redirect:/main/index.do");
	}
}
