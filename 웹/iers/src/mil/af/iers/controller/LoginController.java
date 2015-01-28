package mil.af.iers.controller;

import java.net.MalformedURLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.iers.component.util.SMSSender;
import mil.af.iers.model.UserDTO;
import mil.af.iers.service.MemberService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class LoginController {

	@Resource
	private HttpServletRequest request;
	@Resource
	private MemberService memberService;
	
	@RequestMapping(value="login.do",method=RequestMethod.GET)
	public ModelAndView loginPage(){
		return new ModelAndView("/view/login/login");
	}
	@RequestMapping(value="login.do",method=RequestMethod.POST)
	public ModelAndView login(Model model,UserDTO user){
		UserDTO login = memberService.getLoginData(user);
		if(login !=null){
			ModelAndView mav = new ModelAndView(new RedirectView("/main.do",true));
			request.getSession().setAttribute("login",login);
			return mav;
		}
		else{
			ModelAndView mav = new ModelAndView(new RedirectView("/fail.do",true));
			return mav;
		}
	}
	@RequestMapping(value="logout.do",method=RequestMethod.GET)
	public ModelAndView logout(){
		ModelAndView mav = new ModelAndView(new RedirectView("/main.do",true));
		request.getSession().removeAttribute("login");
				
		return mav;
	}
	@RequestMapping(value="loginFail.do")
	public ModelAndView loginFail(){
		return new ModelAndView("/view/login/loginFail");
	}
	@RequestMapping(value="findPassword.do")
	public ModelAndView findPassword(){
		return new ModelAndView("/view/login/findPassword");
	}
	@RequestMapping(value="getApproveNumber.do",method=RequestMethod.POST)
	@ResponseBody
	public String findPasswordPost(String user_id,String user_sosok,String phone) throws MalformedURLException{
		UserDTO user = memberService.getOneOfUser(user_id, user_sosok);
		if(user !=null){
			if(phone!=null){
				if(phone.equals(user.getUser_cellular_phone())){
//					비밀번호 임의 난수로 초기화
//					초기화한 임의 비밀번호 휴대폰 전송
					String key = (int) (Math.random()*1000000000)+"";
					memberService.initApproveKey(user_id,user_sosok,key);
					SMSSender sender = new SMSSender();
					sender.SendSMS("010-7777-7777", user.getUser_cellular_phone(), "[철매휴양소] 인증번호는 "+key+"입니다.");
					return "success";
				}
			}
		}
		return "false";
	}
	@RequestMapping(value="changePassword.do",method=RequestMethod.POST)
	@ResponseBody
	public String changePassword(String id,String sosok,String approve_key) throws MalformedURLException{
		UserDTO user=memberService.oneUserToChangePassword(id,sosok,approve_key);
		if(user !=null){
			String password = (int) (Math.random()*1000000000)+"";
			memberService.initPassword(id, sosok, password);
			memberService.initApproveKey(id,sosok,"");
			SMSSender sender = new SMSSender();
			sender.SendSMS("010-7777-7777", user.getUser_cellular_phone(), "[철매휴양소] 임시 비밀번호는 "+password+"입니다.");
			return "success";
		}
		return "false";
	}
	@RequestMapping(value="initPassword.do",method=RequestMethod.POST)
	@ResponseBody
	public String initPassword(String id,String sosok){
		String password = (int) (Math.random()*1000000000)+"";
		memberService.initPassword(id, sosok, password);
		return password;
	}
}
