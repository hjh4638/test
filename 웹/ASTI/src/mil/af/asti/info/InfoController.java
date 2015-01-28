package mil.af.asti.info;

import javax.servlet.http.HttpServletRequest;

import mil.af.asti.model.AstiUserDTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/**
 * UI 적용 base 틀
 * 716th. 이승호
 * @author Administrator
 *
 */

@Controller
@RequestMapping("info")
public class InfoController {
	
	@RequestMapping("info.do")
	public ModelAndView infoView(@RequestParam String code,
			ModelAndView model,
			HttpServletRequest request){
		/*ModelAndView model = new ModelAndView("menu/info");*/
		model.setViewName("menu/info");
		return model;
	}
	

}
