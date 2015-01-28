package mil.af.asti.ajax;

import java.lang.reflect.InvocationTargetException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.asti.admin.AdminService;
import mil.af.asti.board.BoardService;
import mil.af.asti.common.CommonService;
import mil.af.asti.dept.DeptService;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiResearchWorkerDTO;
import mil.af.asti.model.AstiUserDTO;
import mil.af.asti.model.AstiValidator;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import util.HDIdeaCipher;
import util.StringUtil;

@Controller
@RequestMapping("ajax")
public class AjaxController {
	@Resource
	private HttpServletRequest request;
	
	@Resource
	private CommonService commonService;
	
	@Resource
	private DeptService deptService;
	
	@Resource
	private BoardService boardService;
	
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private AstiValidator astiValidator;
	
	@RequestMapping("removeMember.do")
	@Transactional
	public ModelAndView memberRemoved(){
		AstiUserDTO userInfo = (AstiUserDTO)request.getSession().getAttribute("USERINFO");
		commonService.removeMember(userInfo);
		request.getSession().invalidate();
		return new ModelAndView("common/main");
	}
	@ResponseBody
	@Transactional
	@RequestMapping(value="/workerDelete.do", method=RequestMethod.POST)
	public String workerDelete(@ModelAttribute AstiBoardSearchDTO searchDTO ){
		String worker_id = searchDTO.getWorker_id();
		if(worker_id == null || "".equals(worker_id)){
			System.out.println("삭제실패");
			return "fail";
		}
		else{
			deptService.deleteWorker(searchDTO);
			return "success";
		}
	}
	@ResponseBody
	@Transactional
	@RequestMapping(value="/boardDelete.do", method=RequestMethod.POST)
	public String boardDelete(@ModelAttribute AstiBoardSearchDTO searchDTO,
			@RequestParam(defaultValue="",required=false) String board_password){

		/*aop로 권한체크 만들라다 delete는 좀 중요해서 직접 넣음*/
		String board_id = searchDTO.getBoard_id();
		
		if(board_id == null || "".equals(board_id)){
			System.out.println("삭제실패");
			return "fail";
		}
		else{
			AstiBoardDTO board = boardService.getBoardContent(searchDTO);
			String boardPasswordInBoard =board.getBoard_password(); 
			System.out.println(boardPasswordInBoard);
			/*게시판 패스워드 있고 패스워드 맞을때*/
			/*if(boardPasswordInBoard != null || !("".equals(boardPasswordInBoard))){ 이코드 안되네 ㅡ.ㅡ*/
			if(boardPasswordInBoard != null){	
				if(boardPasswordInBoard.equals(board_password)){
					boardService.deleteBoardFile(searchDTO);
					boardService.deleteAdd(searchDTO);
					boardService.deleteBoard(searchDTO);
					return "success";
				}
				else return "false";
			}
			/*게시판 패스워드 없음 걍 삭제*/
			else{
				boardService.deleteBoardFile(searchDTO);
				boardService.deleteAdd(searchDTO);
				boardService.deleteBoard(searchDTO);
				return "success";
			}
		}
	}
	@ResponseBody
	@RequestMapping(value="/downloadCheck.do", method=RequestMethod.POST)
	public String downloadCheck(@RequestParam(required=true) String file_id){
		AstiUserDTO userInfo = (AstiUserDTO) request.getSession().getAttribute("USERINFO");
		String user_authority= new String();
		if(userInfo != null)
			user_authority =userInfo.getUser_authority();
		
		if("true".equals(commonService.isDownAuth(file_id, user_authority))){
			return "success";
		}
		else
			return "false";
	}
	@ResponseBody
	@RequestMapping(value="/back.do", method=RequestMethod.GET)
	public String back(){
		AstiUserDTO userInfo = new AstiUserDTO();
		userInfo.setUser_id("qqqqqqq");
		userInfo.setUser_authority("Z00");
		request.getSession().setAttribute("USERINFO", userInfo);
		return "success";
	}
	@ResponseBody
	@RequestMapping(value="/mergeUserDept.do", method=RequestMethod.POST)
	public String mergeUserDetp(AstiCodeDTO codeDTO,BindingResult result) throws Exception{
		this.astiValidator.userDeptValidate(codeDTO,result);
		if(result.hasErrors()){
			return "false";
		}
		else{
			adminService.mergeIntoCodeUserDept(codeDTO);
			return "success";
		}
	}
	@ResponseBody
	@RequestMapping(value="/deleteUserDept.do", method=RequestMethod.POST)
	public String deleteUserDetp(AstiCodeDTO codeDTO){
		adminService.deleteCodeUserDept(codeDTO);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping("workerInfomation.do")
	public AstiResearchWorkerDTO workerInfomation(String worker_id) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException
	{
		AstiResearchWorkerDTO dto = deptService.getWorkerById(worker_id);
		StringUtil.entityValidateAll(dto);
		return dto;
	}
	@ResponseBody
	@RequestMapping(value="/userPasswordChange.do", method=RequestMethod.POST)
	public String userPasswordChange(@RequestParam(required=true) String user_id,
			@RequestParam(required=true) String user_password){
		HDIdeaCipher cipher = new HDIdeaCipher();
		AstiUserDTO user = new AstiUserDTO();
		user.setUser_id(user_id);
		user.setUser_password(cipher.encrypt(user_password));
		
		adminService.userPasswordChange(user);
		return "success";
	}
	
}
