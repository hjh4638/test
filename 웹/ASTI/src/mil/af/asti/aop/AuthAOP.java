package mil.af.asti.aop;

import java.lang.reflect.Method;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.asti.board.BoardService;
import mil.af.asti.exception.AuthDeniedException;
import mil.af.asti.exception.NeedBrowserUpgradeException;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiUserDTO;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@Aspect
public class AuthAOP{

	@Autowired
	HttpServletRequest request;
	
	@Resource
	private BoardService boardService;

	/*컨트롤러 포인트컷 */
	
	@Pointcut("execution(public * mil.af.*.*.*Controller.*(..))")
	private void controller(){}
	
	/*게시판 입력 창, 게시판 입력 포인트컷*/
	@Pointcut("execution(* mil.af.asti.board.BoardController.insertBoard*(..))")
	private void boardInsert(){}
	
	/*관리자 포인트컷*/
	@Pointcut("execution(public * mil.af.asti.admin.AdminController.*(..))")
	private void admin(){}
	
	/*연구원 삭제 포인트컷*/
	@Pointcut("execution(* mil.af.asti.ajax.AjaxController.workerDelete(..))")
	private void workerDelete(){}
	
	/*게시판 삭제 포인트컷*/
	@Pointcut("execution(* mil.af.asti.ajax.AjaxController.boardDelete(..))")
	private void boardDelete(){}
	
	/*다운로드 권한 제한 포인트컷*/
	@Pointcut("execution(* mil.af.asti.common.CommonController.download(..))")
	private void download(){}
	
/*	
 * AOP 쓰면 view resolve할때 곤란할듯;;;
 * @Before("download()")
	public Object downloadCheck(ProceedingJoinPoint pjp) throws Throwable{
		String user_authority="";
		String board_id="";
		파라미터 정보 가져오기
		Object param[] = pjp.getArgs();
		
		parm[0].getClass().getName()
		
		for(int i=0; i<param.length;i++){
			String param_name = param[i].getClass().getName();
			if(param_name.equals("user_authority"))
				user_authority=(String) param[i];
			else if(param_name.equals("board_id"))
				board_id = (String) param[i];
		}
		board_id와 user_authority는 필수 파라미터이므로 널체크 필요없음
		AstiBoardSearchDTO searchDTO = new AstiBoardSearchDTO();
		searchDTO.setBoard_id(board_id);
		if(boardService.getBoardContent(searchDTO)!=null){
			String board_authority = boardService.getBoardContent(searchDTO).getBoard_authority();
			
		}
		
		Object ret = pjp.proceed();
		return ret;
	}*/
		
/*	@Before("controller()")
	public void checkBrowserVersion() throws Throwable{
		if(request.getSession().getAttribute("browserCheck") == null){
			browserCheck();
		}
	}*/
	@Before("admin() || workerDelete()")
	public void adminAuthCheck() throws Throwable{
		authCheck();
				
	}
	
	/**
	 * boardDelete는 비번체크도 해야되서 골치아파서 걍 그 메소드에 때려넣음 흐미
	 * @param pjp
	 * @return
	 * @throws Throwable
	 */
	@Around("boardInsert() || boardDelete()")
	public Object boardDeleteCheck(ProceedingJoinPoint pjp) throws Throwable{
		AstiUserDTO userInfo = (AstiUserDTO)request.getSession().getAttribute("USERINFO");
		
		AstiBoardDTO boardDTO = new AstiBoardDTO();
		AstiBoardSearchDTO searchDTO = new AstiBoardSearchDTO();
		
		/*파라미터 정보 가져오기*/
		Object parm[] = pjp.getArgs();
		for(int i=0;i<parm.length;i++){
			if(parm[i].getClass() == AstiBoardDTO.class){
				boardDTO = (AstiBoardDTO) parm[i];
			}
			else if(parm[i].getClass() == AstiBoardSearchDTO.class){
				searchDTO = (AstiBoardSearchDTO) parm[i];
			}
		}
		/*기고문이 아니고 사용자 정보 없음 에러로 던져*/
		if(userInfo == null){
			if(!("B07".equals(boardDTO.getBoard_type()) || 
					 "B07".equals(searchDTO.getBoard_type()))){
//				여기서 에러타면 왜 exceptionResolver를 안탈까;;;
//				java.lang.reflect.UndeclaredThrowableException이 생기네;;
				throw new AuthDeniedException();
			}
		}
		else {
			String userAuth = userInfo.getUser_authority();
			/*웹마스터도 아닌것이 기고문도 아니라면 에러로 던져!*/
			if(!"Z00".equals(userAuth)){
				if(!("B07".equals(boardDTO.getBoard_type()) || 
					 "B07".equals(searchDTO.getBoard_type()))){
					System.out.println(!("B07".equals(boardDTO.getBoard_type()) || 
					 "B07".equals(searchDTO.getBoard_type())));
					throw new AuthDeniedException();
				}
			}
		}
		
		Object ret = pjp.proceed();
		return ret;
	}
	
	public void authCheck() throws AuthDeniedException{
		AstiUserDTO userInfo = (AstiUserDTO)request.getSession().getAttribute("USERINFO");
		if(userInfo == null){
			throw new AuthDeniedException();
		}
		else if(!"Z00".equals(userInfo.getUser_authority())){
			throw new AuthDeniedException();
		}
	}
	
	public void browserCheck() throws NeedBrowserUpgradeException{
		String browserVersion = request.getHeader("User-Agent");
		if(!(browserVersion.indexOf("MSIE 8.0") > -1) && !(browserVersion.indexOf("Chrome") > -1)){
			throw new NeedBrowserUpgradeException();
		}else{
			request.getSession().setAttribute("browserCheck", "access");
		}
	}
	
}
