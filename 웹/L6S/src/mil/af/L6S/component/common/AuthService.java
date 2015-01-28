package mil.af.L6S.component.common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import mil.af.L6S.component.common.AuthService;
import mil.af.L6S.component.common.CommonService;
import mil.af.L6S.component.admin.AdministratorVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.util.Assert;

import com.ksign.ssoapi.SSORspData;
import com.ksign.ssoapi.SSOService;
import com.ksign.ssoapi.SSOToken;


/**
 *  통합 인증 권한 설정 Service Part
 * @author Administrator
 */
public class AuthService extends AbstractPreAuthenticatedProcessingFilter
		implements AuthenticationProvider {

	final Logger logger = LoggerFactory.getLogger(AuthService.class);

	private SSOService ssoService;
	private CommonService commonService;

	@Autowired
	public void config(SSOService ssoService, CommonService commonService) {
		this.ssoService = ssoService;
		this.commonService = commonService;
	}

	@Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		Assert.isInstanceOf(PreAuthenticatedAuthenticationToken.class,
				authentication);
		String sn = (String) authentication.getPrincipal();

		AdministratorVO administratorVO = commonService.getAuthority(sn);
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		switch (administratorVO.getLevel()) {
		case 1:
			authorities.add(new GrantedAuthorityImpl("ROLE_ADMIN"));
			break;
		case 2:
			authorities.add(new GrantedAuthorityImpl("ROLE_MANAGER"));
			break;
		case 3:
			authorities.add(new GrantedAuthorityImpl("ROLE_ANONYMOUS"));
			break;
		case 5:
			authorities.add(new GrantedAuthorityImpl("ROLE_ANONYMOUS"));
			break;
		}

		return new PreAuthenticatedAuthenticationToken(sn, null, authorities);
	}

	@Override
	protected Object getPreAuthenticatedCredentials(HttpServletRequest request) {
		return "";
	}

	@Override
	protected Object getPreAuthenticatedPrincipal(HttpServletRequest request) {
		return getSnByRequest(request);
	}

	/**
	 * ssoService Id Check
	 * 
	 * @param request
	 * @return
	 */
	private String getSnByRequest(HttpServletRequest request) {	
		SSORspData rsp = ssoService.ka_checkSSO(request,
				request.getRemoteAddr());
		logger.debug("SSO Check: {} {}", rsp.getResultCode(),
				rsp.getResultMessage());
		if (rsp.getResultCode() != 0) {
			return "";
		}
		SSOToken token = rsp.getSSOToken();
		String sn = token.getAttribute("USERID");
		logger.debug("USERID = {}", sn);
		if (sn == null) {
			return "";
		} else {
			return sn;
		}
	}

	@Override
	public boolean supports(Class<? extends Object> authentication) {
		return authentication
				.isAssignableFrom(PreAuthenticatedAuthenticationToken.class);
	}
}
