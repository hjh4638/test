package mil.af.iers.component.aop;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mil.af.iers.model.UserDTO;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Aspect
@Component
public class AuthAOP {
	
	@Autowired
	HttpServletRequest request;
	
	@Pointcut("execution(* mil.af.iers.controller.AdminController.*(..))")
	private void admin(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.appListshow(..))")
	private void appListshow(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.changeFacilitesR(..))")
	private void changeFacilitesR(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.changeFacilitesD(..))")
	private void changeFacilitesD(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.changeFacilitesCode(..))")
	private void changeFacilitesCode(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.changeFacilitesCodeDelete(..))")
	private void changeFacilitesCodeDelete(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.memberManagePost(..))")
	private void memberManagePost(){}
	@Pointcut("execution(* mil.af.iers.controller.AdminController.settlementPost(..))")
	private void settlementPost(){}
	
	@Pointcut("execution(* mil.af.iers.controller.NormalController.myReserve(..))")
	private void myReserve(){}
	@Pointcut("execution(* mil.af.iers.controller.NormalController.reserveView(..))")
	private void reserveView(){}
	
	@Around("myReserve() || reserveView()")
	public Object loginCheck(ProceedingJoinPoint pjp) throws Throwable{
		UserDTO user = (UserDTO)request.getSession().getAttribute("login");
		if(user==null){
			ModelAndView mav=new ModelAndView(new RedirectView("/login.do",true));
			return mav;
		}
		else{
			Object ret=pjp.proceed();
			return ret;
		}
	}
	
	@Around("admin()")
	public Object adminAuthCheck(ProceedingJoinPoint pjp) throws Throwable{
			
		if(authCheck() == true){
			Object ret = pjp.proceed();
			return ret;
		}
		else{
			ModelAndView mav=new ModelAndView(new RedirectView("/main.do",true));
			return mav;
		}
	}
	@Around("appListshow()||changeFacilitesR()||changeFacilitesD()||" +
			"changeFacilitesCode()||changeFacilitesCodeDelete()||memberManagePost()||" +
			"settlementPost()")
	public Object d04Check(ProceedingJoinPoint pjp) throws Throwable{
		if(d04AuthCheck() == true){
			Object ret = pjp.proceed();
			return ret;
		}
		else{
			ModelAndView mav=new ModelAndView(new RedirectView("/admin.do",true));
//			ModelAndView mav = new ModelAndView("/layout/layout");
//			String url="index.do";
//			mav.addObject("url", url);
			return mav;
		}
	}
	public boolean authCheck() throws IOException {
		UserDTO userInfo = (UserDTO)request.getSession().getAttribute("login");
		
		if(userInfo == null ){
			return false;
		}
		else if(!("D03".equals(userInfo.getUser_auth())
				||"D04".equals(userInfo.getUser_auth()))){
			return false;
		}
		return true;
	}
	public boolean d04AuthCheck(){
		UserDTO userInfo = (UserDTO)request.getSession().getAttribute("login");
		
		if(userInfo == null ){
			return false;
		}
		else if(!("D04".equals(userInfo.getUser_auth()))){
			return false;
		}
		return true;
	}
	private Method findMethodByName(Class<?> target, String name) {
		Method m[] = target.getMethods();
		for (Method method : m) {
			if (method.getName().equals(name))
				return method;
		}
		return null;
	}
}
