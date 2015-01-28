package mil.af.asti.edu;

import javax.servlet.http.HttpServletRequest;

import mil.af.asti.model.AstiUserDTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("edu")
public class EduController {
	
	@RequestMapping("edu.do")
	public ModelAndView eduView(@RequestParam String code,
			ModelAndView model
			,HttpServletRequest request){
		model.setViewName("menu/edu");
		
		return model;
	}

}
