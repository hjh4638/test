package mil.af.asti.aop;

import java.util.List;

import javax.annotation.Resource;

import mil.af.asti.admin.AdminService;
import mil.af.asti.model.AstiPageDTO;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;


@Aspect
public class PageAOP {

	@Resource
	private AdminService adminService;
	
	@Pointcut("execution(* mil.af.asti.common.CommonController.mainView(..))")
	private void mainView(){}
	@Pointcut("execution(* mil.af.asti.common.CommonController.slideindex(..))")
	private void slideindex(){}
	@Pointcut("execution(* mil.af.asti.dept.DeptController.researchView(..))")
	private void deptView(){}
	@Pointcut("execution(* mil.af.asti.edu.EduController.eduView(..))")
	private void eduView(){}
	@Pointcut("execution(* mil.af.asti.info.InfoController.infoView(..))")
	private void infoView(){}
	@Pointcut("execution(* mil.af.asti.journal.JournalController.journalView(..))")
	private void journalView(){}
	
	@Around("mainView() || deptView() || eduView() || infoView() || journalView() || slideindex()")
	public Object pageImageInjection(ProceedingJoinPoint pjp) throws Throwable{
		Class<?> targetController = pjp.getSignature().getDeclaringType();
		String controllerName = targetController.getName();
	
		Object param[] = pjp.getArgs();
		for(int i =0;i<param.length;i++){
			if(param[i].getClass()==ModelAndView.class){
				/*메인페이지*/
				if(controllerName.contains("CommonController")){
					ModelAndView model = (ModelAndView) param[i];
					List<AstiPageDTO> d01 = adminService.getPageInfo("D01");
					model.addObject("length",d01.size());
					model.addObject("d01", d01);
				}
				/*연구원소개*/
				else if(controllerName.contains("InfoController")){
					ModelAndView model = (ModelAndView) param[i];
					/*인사말*/
					List<AstiPageDTO> d02 = adminService.getPageInfo("D02");
					/*비전과미션*/
					List<AstiPageDTO> d03 = adminService.getPageInfo("D03");
					/*연혁*/
					List<AstiPageDTO> d04 = adminService.getPageInfo("D04");
					/*조직도*/
					List<AstiPageDTO> d05 = adminService.getPageInfo("D05");
					/*브로셔*/
					List<AstiPageDTO> d06 = adminService.getPageInfo("D06");
					/*찾아오는길*/
					List<AstiPageDTO> d07 = adminService.getPageInfo("D07");
					model.addObject("d02", d02);
					model.addObject("d03", d03);
					model.addObject("d04", d04);
					model.addObject("d05", d05);
					model.addObject("d06", d06);
					model.addObject("d07", d07);
				}
				/*연구센터*/
				else if(controllerName.contains("DeptController")){
					ModelAndView model = (ModelAndView) param[i];
					/*안보전략센터(연구분야)*/
					List<AstiPageDTO> d08 = adminService.getPageInfo("D08");
					/*안보전략센터(사업계획)*/
					List<AstiPageDTO> d09 = adminService.getPageInfo("D09");
					/*경제산업센터(연구분야)*/
					List<AstiPageDTO> d10 = adminService.getPageInfo("D10");
					/*경제산업센터(사업계획)*/
					List<AstiPageDTO> d11 = adminService.getPageInfo("D11");
					/*과학기술센터(연구분야)*/
					List<AstiPageDTO> d12 = adminService.getPageInfo("D12");
					/*과학기술센터(사업계획)*/
					List<AstiPageDTO> d13 = adminService.getPageInfo("D13");
					model.addObject("d08", d08);
					model.addObject("d09", d09);
					model.addObject("d10", d10);
					model.addObject("d11", d11);
					model.addObject("d12", d12);
					model.addObject("d13", d13);
				}
				/*발간물*/
				else if(controllerName.contains("JournalController")){
					ModelAndView model = (ModelAndView) param[i];
					/*발간물 안내*/
					List<AstiPageDTO> d14 = adminService.getPageInfo("D14");
					model.addObject("d14", d14);
				}
				/*교육/연수*/
				else if(controllerName.contains("EduController")){
					ModelAndView model = (ModelAndView) param[i];
					/*단기연수*/
					List<AstiPageDTO> d15 = adminService.getPageInfo("D15");
					/*mini MBA*/
					List<AstiPageDTO> d16 = adminService.getPageInfo("D16");
					/*학위과정*/
					List<AstiPageDTO> d17 = adminService.getPageInfo("D17");
					/*최고위과정*/
					List<AstiPageDTO> d18 = adminService.getPageInfo("D18");
							
					model.addObject("d15", d15);
					model.addObject("d16", d16);
					model.addObject("d17", d17);
					model.addObject("d18", d18);
				}
			}
		}
		
		Object ret =pjp.proceed(param);
		return ret;
	}
	@Test
	public void sfdf(){
		
	}
}