package mil.af.asti.journal;

import javax.servlet.http.HttpServletRequest;

import mil.af.asti.model.AstiUserDTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("journal")
public class JournalController {
	
	
	@RequestMapping("journal.do")
	public ModelAndView journalView(@RequestParam String code,
			@RequestParam(defaultValue="init",required=false) String board_id,
			@RequestParam(defaultValue="init",required=false) String board_form,
			ModelAndView model,
			HttpServletRequest request){
		request.getSession().setAttribute("nowUrl", "journal");
		/*ModelAndView model = new ModelAndView("menu/journal");*/
		model.setViewName("menu/journal");
		
		model.addObject("board_id",board_id);
		model.addObject("board_form",board_form);
		return model;
	}

}
