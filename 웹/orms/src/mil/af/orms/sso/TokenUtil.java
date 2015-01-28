package mil.af.orms.sso;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

public class TokenUtil {
	public static void resetCookie(HttpServletResponse response) {

		Cookie ssoCookie = new Cookie( "ka_sso_token", "" );
		ssoCookie.setMaxAge(0);
		ssoCookie.setPath("/");
		ssoCookie.setDomain("af.mil");
		response.addCookie(ssoCookie);
	}
}
