package mil.af.orms.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/MeasureStandardTable")
public class MeasureStandardTableController {

	@RequestMapping("/measureStandardTable.do")
	public void measureStandardTable(HttpServletRequest request,Model model){
				System.out.println("success");
	}
}
