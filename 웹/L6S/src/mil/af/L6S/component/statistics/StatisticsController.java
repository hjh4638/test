package mil.af.L6S.component.statistics;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.belt.BeltGraphVO;
import mil.af.L6S.component.subject.SubjectFormAndDataVO;
import mil.af.L6S.component.subject.SubjectService;
import mil.af.L6S.component.subject.SubjectVO;
import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {
	
	private BeltStatisticsService beltStatisticsService;
	private SubjectStatisticsService statisticsService;
	@SuppressWarnings("unused")
	private SubjectService subjectService;
	
	@Autowired
	void subjectcontroller(SubjectService subjectService,
						   SubjectStatisticsService statisticsService,
						   BeltStatisticsService beltStatisticsService){
		this.subjectService=subjectService;
		this.statisticsService=statisticsService;
		this.beltStatisticsService=beltStatisticsService;
	}
	
	@RequestMapping("/subjectStatistics.do")
	public void mainStatistics(Model model,
			@ModelAttribute SearchFilter searchFilter){
		
		Calendar calendar = new GregorianCalendar();
		if(searchFilter.getYear() == null){
			searchFilter.setYear(calendar.get(Calendar.YEAR)+"");
		}
		
		Map<String,SubjectFormAndDataVO> step_count = statisticsService.getStepCount(searchFilter.getYear());
		model.addAttribute("step_count",step_count);
	
		Map<String,SubjectVO> section_count =statisticsService.getSubjectSectionCount(searchFilter.getYear());
		model.addAttribute("section_count",section_count);
		
		model.addAttribute("finishCount", statisticsService.getFinishSubjectCount(searchFilter.getYear()));
			
	}
	@RequestMapping("/chartTest.do")
	public void test(){
		
	}
	@RequestMapping("/singleData.do")
	public void ttt(){
		
	}
	
	/**
	 *  벨트 현황 그래프 
	 * @param searchFilter(연도)
	 * @return model
	 */
	@RequestMapping("/beltStatistics.do")
	public ModelAndView beltStatistics(
			@ModelAttribute SearchFilter searchFilter){
		ModelAndView model = new ModelAndView(/*"/statistics/beltStatistics"*/);
		
		Calendar calendar = new GregorianCalendar();
//		벨트 현황 조희시 디폴트 전체로~~
		if(searchFilter.getYear() == null){
			searchFilter.setYear(9999+"");
		}
		
		List<BeltGraphVO> x1Data = beltStatisticsService.belt1Count(searchFilter);
		List<Object> tableData = beltStatisticsService.getTableDatum(searchFilter);
		model.addObject("tableData",tableData);
		model.addObject("tableDataSize",tableData.size());
		model.addObject("tableSUM",x1Data);
		model.addObject("dataJSON", JSONArray.fromObject(x1Data).toString());
		model.addObject("dummy",calendar.get(Calendar.YEAR) );
//		if( searchFilter.getYear().equals("9999"))
//			searchFilter.setYear(calendar.get(Calendar.YEAR)+"");
			
		return model;
	}
}
