package mil.af.iers.test.pm714;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping()

public class TController {

		
		@RequestMapping(value="/test.do",method=RequestMethod.GET)
		public ModelAndView test(){
			System.out.println("test");
			
			return new ModelAndView("layout/layout");
		}


}
