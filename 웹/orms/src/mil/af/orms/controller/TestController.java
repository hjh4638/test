package mil.af.orms.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.orms.model.UserVO;
import mil.af.orms.service.CommonService;
import mil.af.orms.service.TestService;
import mil.af.orms.sso.TokenUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ksign.ssoapi.SSOService;

@Controller
@RequestMapping("/Test")
public class TestController {
	
	@Resource(name="TestService")
	TestService testService;
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@RequestMapping("/ssoTest.do")
	public void ssoTest(HttpServletRequest request,HttpServletResponse response,
			@RequestParam String userid,Model model) throws Exception{
		TokenUtil.resetCookie(response);
		
		String clientIP = null;

		
		clientIP = request.getRemoteAddr();	//사용자 IP
		if( clientIP == null ) {
			throw new Exception("클라이언트 IP 를 가져올 수 없음");
		}
			
		

		try {

			// 파라미터가 없는 경우, 테스트용 인덱스 페이지를 보여줌
			if( userid == null || userid.length() <= 0 ) {
				//return "Admin/popup/TestLogin";
			}

			// 쿠키 삭제
			TokenUtil.resetCookie(response);

			// 인증 설정값
			String initVal = "368B184727E89AB69FAF";
			String domain = "af.mil";

			// SSO Service 객체 생성
			SSOService sso = new SSOService(domain, initVal);

			// 사용자 정보를 DB에서 가져옴
			UserVO user = commonService.getIntraUser(userid);

			// 사용자 정보 DB 조회 결과가 NULL이면 잘못된 군번이거나 정보가 없는 사람이므로 에러처리
			if( user == null ) {
				throw new Exception("테스트 로그인 사용자 정보를 가져올 수 없음. IP = " + clientIP);
			}

			
			//user.setRole( EAMWrapper.getRole(user.getUserid()) );
		

			// DB에서 가져온 정보를 기반으로 sso에 putValue를 통해 정보를 넣는다.
			// 일부 필요한 정보를 제외하면 더미값이 들어간다.
			sso.putValue("GUNBUN", encode(user.getGunbun()));	//군번
			sso.putValue("SINBUNCODE", encode(user.getSinbuncode()));
			sso.putValue("RANKCODE", encode(user.getRankcode()));
			sso.putValue("RANKNAME", encode(user.getRankname()));
			sso.putValue("INSABOJIK", encode(user.getInsabojik()));
			sso.putValue("INSASOSOKCODE", encode(user.getInsasosokcode()));
			sso.putValue("INSASOSOKNAME", encode(user.getInsasosokname()));
			sso.putValue("UNITNO", "");
			sso.putValue("SOSOKNAME", encode(user.getSosokname()));
			sso.putValue("SOSOKCODE", encode(user.getSosokcode()));
			sso.putValue("INTRASOSOKNAME", encode(user.getIntrasosokname()));
			sso.putValue("ASS", encode(user.getAss()));
			sso.putValue("FULLASS", encode(user.getFullass()));
			sso.putValue("TELIN", encode(user.getTelin()));
			sso.putValue("TELOUT", "");
			sso.putValue("MOBILEPHONE", "");
			sso.putValue("AUTHGUBUN", "10");
			sso.putValue("LOGINTYPE", "ID");
			sso.putValue("HOMEURL", "");
			sso.putValue("LOCATEGUBUN", "");
			sso.putValue("USERGUBUN", encode(user.getUsergubun()));
			sso.putValue("USERAUTHCODE", "");
			sso.putValue("ORIGIN", encode(user.getOrigin()));
			sso.putValue("KISU", encode(user.getKisu()));
			sso.putValue("MSPCCODE", encode(user.getMspccode()));
			sso.putValue("MSPCNAME", encode(user.getMspcname()));
			sso.putValue("MODIFYDATE", "");
			sso.putValue("SEX", "");
			sso.putValue("SIGNFILE1", "");
			sso.putValue("SIGNFILE2", "");
			sso.putValue("OLD_ID", "");
			sso.putValue("DOCSHIN", "");
			sso.putValue("NICKNAME", "");
			sso.putValue("USERID", encode(userid));
			sso.putValue("MAIL", "sss@ksign.com");
			sso.putValue("NAME", encode(user.getName()));
			sso.putValue("TS", getTokenToday());
			sso.putValue("AM", "form-based");
			sso.putValue("CP", clientIP);

			//sso.putValue("ROLE", user.getRole().name());

			sso.ka_generateSSOToken(response); //토큰 생성
			
		}
		catch(Exception ex) {
			
			throw new Exception("테스트용 토큰 생성 중 에러가 발생하였습니다. " + ((ex.getMessage()!=null)?(ex.getMessage()):("")));
		}
		
		response.sendRedirect(request.getContextPath()+"/main.do");

		//
	}
	
	
	@RequestMapping("/chartTest.do")
	public void charTest(){
		
	}
	
	
	/**
	 * SSO 토큰에 값을 넣을 때 인코딩 변환을 위한 메소드
	 * @param v
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private static String encode(String v) throws UnsupportedEncodingException {
		if( v == null ) {
			return "";
		}
		return (new String(v.getBytes("EUC-KR"),"ISO-8859-1"));
	}
	private static String getTokenToday() {
		Calendar cal = Calendar.getInstance();
		StringBuilder sb = new StringBuilder();
		sb.append(cal.get(Calendar.YEAR)).append("-")
			.append(getTwoDigit(cal.get(Calendar.MONTH)+1)).append("-")
			.append(getTwoDigit(cal.get(Calendar.DAY_OF_MONTH))).append(" ")
			.append(getTwoDigit(cal.get(Calendar.HOUR_OF_DAY))).append(":")
			.append(getTwoDigit(cal.get(Calendar.MINUTE))).append(":")
			.append(getTwoDigit(cal.get(Calendar.SECOND)));
		return sb.toString();
	}
	private static String getTwoDigit(int i) {
		if(i > 9) return String.valueOf(i);
		else return "0"+String.valueOf(i);
	}

}
