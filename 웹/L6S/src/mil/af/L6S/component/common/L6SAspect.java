package mil.af.L6S.component.common;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.admin.AdministratorService;
import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.exception.NeedSSOLoginException;
import mil.af.L6S.component.subject.SubjectService;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;

import com.ksign.ssoapi.SSORspData;
import com.ksign.ssoapi.SSOService;
import com.ksign.ssoapi.SSOToken;

/**
 * 
 * AOP Auto proxy 사용 클래스
 * 
 * @author 김성근
 * 
 */
@Aspect
@Component
public class L6SAspect {

	final Logger logger = LoggerFactory.getLogger(L6SAspect.class);

	private HttpServletRequest request;
	private CommonService commonService;
	private SSOService ssoService;
	private SubjectService subjectService;
	private AdministratorService administratorService;
	private ApprovalService approvalService;

	@Autowired
	public void config(HttpServletRequest request, CommonService commonService,
			SSOService ssoService,SubjectService subjectService,
			AdministratorService administratorService,ApprovalService approvalService) {
		this.request = request;
		this.commonService = commonService;
		this.ssoService = ssoService;
		this.subjectService = subjectService;
		this.administratorService = administratorService;
		this.approvalService = approvalService;
	}
	@Before("bean(*Controller)")
	public void checkSession(JoinPoint joinPoint) throws Throwable {
		String className = joinPoint.getSignature().getDeclaringTypeName();
		String methodName = joinPoint.getSignature().getName();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("login");
		if((className.contains("CommonController") && (methodName.equals("loginPost")||methodName.equals("loginGet"))) 
				|| className.contains("Object")){
			System.out.println("백도어는 세션체크를 하지 않음");
			
		}
		else{
			if(user == null){
				
				
				throw new NeedSSOLoginException();
						
				
			}
			else if("".equals(user.getSn()) || user.getSn() == null){
				
				
				
				throw new NeedSSOLoginException();
				
				
			}
		}
		
		
	}
	/**
	 * Controller 로 끝나는 모든 빈에 적용되는 AOP
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around("bean(*Controller)")
	public Object trace(ProceedingJoinPoint joinPoint) throws Throwable {
		String signatureString = joinPoint.getSignature().toShortString();
		String className = joinPoint.getSignature().getDeclaringTypeName();
		String methodName = joinPoint.getSignature().getName();
		System.out.println("className="+className + "methodName="+ methodName);
		logger.debug(signatureString + " 시작");

		long start = System.currentTimeMillis();

		HttpSession session = request.getSession();
		try {
			/**
			 * Spring security에서 로그인 정보를 처리
			 */
			User user = (User) session.getAttribute("login");
			
			if (user == null) {
				user = new User();
				SSORspData rsp = ssoService.ka_checkSSO(request,
						request.getRemoteAddr());
				SSOToken token = rsp.getSSOToken();
				String sn = token.getAttribute("USERID");
				user.setRank(token.getAttribute("RANKNAME"));
				user.setName(token.getAttribute("NAME"));
				user.setInsasosok(token.getAttribute("INSASOSOKNAME"));
				user.setIntrasosok(token.getAttribute("INTRASOSOKNAME"));
				user.setPositionCode(token.getAttribute("SOSOKCODE"));
				user.setSn(sn);
				
				/**
				 * 군번을 통해 체계분류를 가져옴 - 현재 체계가 하나임으로 classification 을 항상 A 로고정
				 * 
				 * user.setClassification(administratorVO.getClassification());
				 */
				AdministratorVO administratorVO = commonService
						.getAuthority(sn);
				user.setAuthority(administratorVO.getAuthority());
				user.setQuarter(administratorService.getMyQuarter(sn));
				user.setSubject_code(subjectService.getMySubjectCode(sn));
				user.setMyAppInfo(approvalService.getMyAppInfo(sn));

				/**
				 * 로그인을 안하고 접근이 필요한 경우
				 * 
				 * user.setClassification("A"); user.setSn("11-10781");
				 * user.setRank("중위(진)"); user.setName("심정훈");
				 * user.setAuthority("A"); user.setPersonPositionName("중전소");
				 */
					
				session.setAttribute("login", user); 
			}

//			Map<String, Integer> myWorkCountMap = commonService
//					.getMyWorkCount(user);

//			session.setAttribute("myWorkCountMap", myWorkCountMap);
			user.setAuthority(administratorService.getMyAuth(user.getSn()));
			user.setSubject_code(subjectService.getMySubjectCode(user.getSn()));
			user.setMyAppInfo(approvalService.getMyAppInfo(user.getSn()));
			
			return parseProcessArguments(joinPoint, user);

		} finally {
			long fininsh = System.currentTimeMillis();
			logger.debug(signatureString + " 종료");
			logger.debug(signatureString + " 실행시간 : " + (fininsh - start)
					+ "ms");
		}
	}

	/**
	 * AOP를 통해 유저 객체를 넘기는 Method
	 * 
	 * SearchFilter 조회조건에대한것도 넘김
	 * 
	 * @param joinPoint
	 * @param user
	 * @return
	 * @throws Throwable
	 */
	private Object parseProcessArguments(ProceedingJoinPoint joinPoint,
			User user) throws Throwable {

		Object parm[] = joinPoint.getArgs();
		boolean newParmSkip[] = new boolean[parm.length];

		Class<?> targetController = joinPoint.getSignature().getDeclaringType();
		Method targetMethod = findMethodByName(targetController, joinPoint
				.getSignature().getName());

		Annotation[][] annotationss = targetMethod.getParameterAnnotations();

		logger.debug("ASize="+ annotationss.length);
		for (int i = 0; i < parm.length; i++) {
			Annotation annotations[] = annotationss[i];
			if (annotations.length > 0) {
				if (annotations[0].annotationType() == ModelAttribute.class
						|| annotations[0].annotationType() == RequestBody.class) {
					newParmSkip[i] = true;
				}
			} else {
				newParmSkip[i] = false;
			}
		}

		for (int i = 0; i < parm.length; i++) {
			if (parm[i] != null && newParmSkip[i] == false) {
				if (parm[i].getClass() == User.class) {
					parm[i] = user;
				} else if (parm[i].getClass() == HttpSession.class) {
					parm[i] = request.getSession();
				} else if (parm[i].getClass() == Model.class) {
					Model model = (Model) parm[i];
					model.addAttribute("user", user);
				}
				else if (parm[i].getClass() == SearchFilter.class) {
					parm[i] = setSearchData(user);
				}
			}
			if (parm[i] != null && newParmSkip[i] == true
					&& (parm[i].getClass() == SearchFilter.class)) {
				request.setAttribute("searchData", setSearchData(user));
			}
		}

		return joinPoint.proceed(parm);
	}

	private Method findMethodByName(Class<?> target, String name) {
		Method m[] = target.getMethods();
		for (Method method : m) {
			if (method.getName().equals(name))
				return method;
		}
		return null;
	}

	/**
	 * SearchFilter에 데이터 저장
	 * 
	 * @return year = 연도
	 * 
	 */
	private SearchFilter setSearchData(User user) {

		SearchFilter searchFilter = new SearchFilter();

		if (request.getParameter("year") != null)
			searchFilter.setYear(request.getParameter("year"));

//		searchFilter.setUpperUnits(commonService.selectUpperUnitCode());
//		searchFilter.createUpperUnitMap();
//
//		searchFilter.setAuditSubjects(commonService.selectAuidtSubjectCode());
//		searchFilter.createAuditSubjectMap();
//
//		searchFilter.setWorkFields(commonService.selectWorkFields(user
//				.getClassification()));
//		searchFilter.setPenalties(commonService.selectPenalties(user
//				.getClassification()));

		return searchFilter;
	}
}
