package mil.af.orms.aop;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.exception.NeedSSOLoginException;
import mil.af.orms.exception.NoServiceSquadronException;
import mil.af.orms.model.AccessUrlConfigMapVO;
import mil.af.orms.model.AccessUrlConfigVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.service.CommonService;
import mil.af.orms.sso.SSOWrapper;
import mil.af.orms.util.ArgsUtil;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class UserAuthAOP {
		
	public void printParamater(ProceedingJoinPoint joinPoint) {
		//여기다 파라메터 출력
		System.out.println("---------@Parameters---------");
				
		HttpServletRequest request=ArgsUtil.getRequestByArgs(joinPoint.getArgs());
		
		if (request != null) {
			Enumeration<String> keys = request.getParameterNames();
			while (keys.hasMoreElements()) {
				String key = keys.nextElement();
				String value = request.getParameter(key);
				System.out.println(key + " : " + value);
			}
		}

		System.out.println("-----------------------------");
				
	}
	
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="AccessUrlConfigMap")
	AccessUrlConfigMapVO accessUrlConfigMap;
	
	@Around("execution(* mil.af.orms.controller.*.*(..))")
	public Object setAroundUserAuth(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("---------@Around--------");
		String declaringType=joinPoint.getSignature().getDeclaringType().toString();
		System.out.println(declaringType);
		System.out.println(joinPoint.getSignature().getName());
		System.out.println(joinPoint.toString());
		if(declaringType.contains("TestController")){
			System.out.println("TestController는 SSO 검증을 거치지 않음.");
			return joinPoint.proceed();
		}else{
			HttpServletRequest request=ArgsUtil.getRequestByArgs(joinPoint.getArgs());
			if(request!=null){
				System.out.println("requestURI:"+request.getRequestURI());
				
				SSOWrapper ssoWrapper=SSOWrapper.InitSSO(request);
				System.out.println("ssoWrapper"+ssoWrapper);
				if(ssoWrapper!=null){
					UserVO userVO=ssoWrapper.getUserInfo();
					/*본인 기종정보 가져옴*/
					userVO.setAirplane(commonService.getUserPlane(userVO.getSosokcode()));
					if(userVO!=null){
						//서비스 대대(ORMS_UNIT에서 STATE가 Y)인지 확인후 아닐 시 Exception발생
						
						UserAuthVO userAuthVO=commonService.getUserAuth(userVO);
						userVO.setRole(commonService.getUserRole(userAuthVO,userVO));
						
						//조종관련("0002, 0003, 14")특기를 제외한 나머지는 접속 제한 2012.02.09 
						if(userAuthVO!=null){
							userVO.setUnit_code(userAuthVO.getUnit_code());// 관리 부대 코드
							
						}else{ // 비 권한자중에 조종특기,장군,조종교육가 아닌 사람은 Excepton 발생
							if(!commonService.isPilot(userVO)){								
								throw new NoServiceSquadronException();
							}else{
								userVO.setUnit_code(commonService.getUserSquadron(userVO.getSosokcode()));
							}
						}
						//***********************
						Map<UserRole,AccessUrlConfigVO> accessMap=accessUrlConfigMap.getAccessConfigMap();
						List<String> accessUrlList=accessMap.get(userVO.getRole()).getAccessUrlList();
						
						String nowUrl=request.getRequestURI();
						int size=accessUrlList.size();
						boolean isAccessUrl=false;
						for(int i=0;i<size;i++){
							String url=accessUrlList.get(i);
							if(nowUrl.equals(url)){
								isAccessUrl=true;
							}
						}
						if(!isAccessUrl){ //해당 권한 접근 불가 URL
							System.out.println(userVO.getRole()+"권한은 "+nowUrl+"에 접근 불가합니다.");
							throw new Exception(userVO.getRole()+"권한은 "+nowUrl+"에 접근 불가합니다.");
							
						}else{
							System.out.println(userVO.getRole()+"권한은 "+nowUrl+"에 접근 가능");
						}
						request.setAttribute("UserVO", userVO);
					}
				
				}else{
					throw new NeedSSOLoginException();
				}
			}
			return joinPoint.proceed();
		}
	}
}
