package mil.af.orms.sso;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import com.ksign.ssoapi.SSORspData;
import com.ksign.ssoapi.SSOService;

import mil.af.orms.model.UserVO;
public class SSOWrapper {

	private SSOService kaSSO;


	// 생성자
	SSOWrapper(SSOService ksso) {
		this.kaSSO = ksso;
	}


	/**
	 * SSO 토큰에서 값을 가져올 때 인코딩 변환을 위한 메소드
	 * @param s
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	private static String fromUStoKR(String s) throws UnsupportedEncodingException {
		if( s == null || s.trim().equals("") ) {
			return s;
		}
		return new String(s.getBytes("ISO-8859-1"), "EUC-KR");
	}

	/**
	 * SSO 를 생성하고 SSOWrapper 객체에 설정하여 리턴한다.
	 * @param request
	 * @return
	 */
	public static SSOWrapper InitSSO(HttpServletRequest request) {

		String initVal = "368B184727E89AB69FAF";
		String domain = "af.mil";
		String clientIP = request.getRemoteAddr();
		SSORspData rspData = null;
		SSOService sso = new SSOService(domain, initVal);	// Create EAMService Object
		rspData = sso.ka_checkSSO(request, clientIP);
		int nResultSso = rspData.getResultCode();

		if (nResultSso >= 0) {
			return new SSOWrapper(sso);
		}
		else {
			
			return null;
		}
	}

	/**
	 * SSO 토큰에서 값을 가져온다.
	 * @param key
	 * @return
	 */
	public String getValue(String key) {
		if( kaSSO == null ) {
			return null;
		}
		try {
			return fromUStoKR( kaSSO.getValue(key) );
		}
		catch (UnsupportedEncodingException e) {
			
			return null;
		}
	}

	/**
	 * SSO 토큰의 사용자 정보를 가져와 UserVO 객체로 리턴한다.
	 * @return
	 */
	public UserVO getUserInfo() {

		UserVO userinfo = new UserVO();
		//LogManager.getLogger().info("사용자 정보 생성");

		String userid = getValue("USERID");
		userinfo.setUserid(userid);

		// TODO tems_EAMWrapper 클래스의 메소드 구현 후 EAMWrapper 를 활용하여 권한 및 역할등을 얻어오고, userinfo 에 설정해주도록 구현
		/*
		//장교 시스템 권한
		int userRole = EAMWrapper.getUserRole(sn, 1);
		userinfo.setRole(Integer.toString(userRole));
		*/
		//LogManager.getLogger().info("장교용 권한 : " + userRole);

		// TODO 권한 이외에도 EAM 에서 추가적으로 가져올 사항 (예를들면 AD200에서의 관리부대 처럼) 이 있으면 tems_EAMWrapper 통해 가져온후 userinfo 설정
		/*
		userinfo.setManageGroup(EAMWrapper.getManageSquadron(sn, 1));
		*/

		// 토큰에 저장된 사용자 정보를 가져와서 userinfo 에 넣어줌
		userinfo.setIntrasosokname(getValue("INTRASOSOKNAME"));
		userinfo.setSosokname(getValue("SOSOKNAME"));
		userinfo.setName(getValue("NAME"));
		userinfo.setRankcode(getValue("RANKCODE"));
		userinfo.setRankname(getValue("RANKNAME"));
		userinfo.setSosokcode(getValue("SOSOKCODE"));
		userinfo.setSinbuncode(getValue("SINBUNCODE"));
		userinfo.setKisu(getValue("KISU"));
		userinfo.setInsasosokname(getValue("INSASOSOKNAME"));
		userinfo.setOrigin(getValue("ORIGIN"));
		userinfo.setGunbun(getValue("GUNBUN"));
		userinfo.setInsabojik(getValue("INSABOJIK"));
		userinfo.setInsasosokcode(getValue("INSASOSOKCODE"));
		userinfo.setAss(getValue("ASS"));
		userinfo.setFullass(getValue("FULLASS"));
		userinfo.setTelin(getValue("TELIN"));
		userinfo.setUsergubun(getValue("USERGUBUN"));
		userinfo.setMspccode(getValue("MSPCCODE"));
		userinfo.setMspcname(getValue("MSPCNAME"));

		// EAM 에서 역할을 가져옴
		//userinfo.setRole( EAMWrapper.getRole(userinfo.getUserid()) );

		return userinfo;
	}


	public void setSSO(SSOService ksso) {
		kaSSO = ksso;
	}

	public SSOService getSSO() {
		return kaSSO;
	}
}
