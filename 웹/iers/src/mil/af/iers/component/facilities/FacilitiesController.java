package mil.af.iers.component.facilities;

import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.model.VacationFacilitiesDTO;
import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FacilitiesController {
	
	@Resource
	private FacilitiesService facilitiesService;
	
	@RequestMapping(value="/changeFacilites.do",method=RequestMethod.GET)
	public ModelAndView change(){
		List<VacationFacilitiesDTO> flist=facilitiesService.getFacilitiesList();
		System.out.println("****"+flist);
		ModelAndView mav = new ModelAndView("view/admin/changeFacilites");
		mav.addObject("facilitiesList", JSONArray.fromObject(flist));
	
		return mav;
	}
}
