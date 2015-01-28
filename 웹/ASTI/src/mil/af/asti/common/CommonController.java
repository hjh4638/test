package mil.af.asti.common;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.asti.admin.AdminService;
import mil.af.asti.board.BoardDAO;
import mil.af.asti.board.BoardService;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiBoardPaginationDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiUserDTO;
import mil.af.asti.model.AstiValidator;

import org.directwebremoting.guice.spring.WebApplicationContextLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.portlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import util.HDIdeaCipher;
import util.PaginationUtil;
import util.UploadAndDownloadUtil;

 /**
 * 
 * @author 중위이승국
 * 메인페이지
 * 세션 관리
 * 회원관리(회원가입, 가입승인, 비밀번호찾기?, Capcha?등등)
 */
@Controller
@RequestMapping("main")
public class CommonController {
		@Autowired
		private CommonService commonService;
		 
		@Resource
		private CommonDAO commonDAO;
		
		@Resource
		private BoardService boardService;
		
		@Resource
		private HttpServletRequest request;
		
		@Resource
		private AdminService adminService;
		
		@Resource
		private AstiValidator astiValidator;
		

		/******************************메인페이지*****************************/
		/**
		 * 메인페이지
		 * @return
		 */
		@RequestMapping(value="index.do", method=RequestMethod.GET)
		public ModelAndView mainView(AstiUserDTO userInfo,
				ModelAndView model)throws Exception {
			/*ModelAndView model = new ModelAndView("common/test");*/
			model.setViewName("common/main");
		
			return model;
		}
		@RequestMapping(value="slideindex",method=RequestMethod.GET)
		public ModelAndView slideindex(@RequestParam Integer index,
				ModelAndView model){
			/*ModelAndView model = new ModelAndView("slideindex");*/
			model.setViewName("slideindex");
			
			return model;
		}
		@RequestMapping(value="menu2.do",method=RequestMethod.GET)
		public ModelAndView menu2()throws Exception{
						
			ModelAndView model = new ModelAndView("submenu/menu2");
			AstiBoardSearchDTO searchDTO = new AstiBoardSearchDTO();
			AstiBoardPaginationDTO pagination = new AstiBoardPaginationDTO();
			/*6개씩 나타낼거라서*/
			pagination.setContentsPerPage(6);
			searchDTO.setAstiBoardPaginationDTO(pagination);
						
			/*공지사항*/
			searchDTO.setBoard_type("B04");
			List<AstiBoardDTO> alamTable = boardService.getBoardContentsList(searchDTO);
			model.addObject("alamTable", alamTable);
			/*보도자료*/
			searchDTO.setBoard_type("B06");
			List<AstiBoardDTO> broadTable = boardService.getBoardContentsList(searchDTO);
			model.addObject("broadTable", broadTable);
			/*언론보도*/
			searchDTO.setBoard_type("B08");
			List<AstiBoardDTO> reportTable = boardService.getBoardContentsList(searchDTO);
			model.addObject("reportTable", reportTable);
			
			return model;
		}
		
		@RequestMapping(value="menu3.do",method=RequestMethod.GET)
		public ModelAndView menu3()throws Exception{
			ModelAndView model = new ModelAndView("submenu/menu3");
			
			AstiBoardSearchDTO searchDTO = new AstiBoardSearchDTO();
			AstiBoardPaginationDTO pagination = new AstiBoardPaginationDTO();
			/*6개씩 나타낼거라서*/
			pagination.setContentsPerPage(6);
			searchDTO.setAstiBoardPaginationDTO(pagination);
						
			/*최신발간물*/
			searchDTO.setBoard_type("B00");
			List<AstiBoardDTO> issue1 = boardService.getBoardContentsList(searchDTO);
			model.addObject("issue1", issue1);
			/*연구보고서*/
			searchDTO.setBoard_type("B01");
			List<AstiBoardDTO> issue2 = boardService.getBoardContentsList(searchDTO);
			model.addObject("issue2", issue2);
			/*정기간행물*/
			searchDTO.setBoard_type("B02");
			List<AstiBoardDTO> issue3 = boardService.getBoardContentsList(searchDTO);
			model.addObject("issue3", issue3);
			
			return model;
		}
		@RequestMapping(value="scrollimg.do",method=RequestMethod.GET)
		public ModelAndView scrollimg()throws Exception{
			ModelAndView model = new ModelAndView("submenu/scrollimg");
			
			/*연구원 동정 사진 가져오기 */
//			AstiBoardSearchDTO search = new AstiBoardSearchDTO();
//			search.setBoard_type("B05");
//			List<AstiBoardFileDTO> departmentImageList = boardService.getBoardFile(search);
//			model.addObject("departmentImageList", departmentImageList);
			model.addObject("departmentImageList", boardService.getMainDeptImage());
			
			return model;
		}
		
		
		/******************************세션관리*******************************/
		
		
		/******************************회원관리*******************************/
		/**
		 * 탑메뉴
		 * @return
		 */
		@RequestMapping(value="top.do", method=RequestMethod.GET)
		public ModelAndView topMenu(AstiUserDTO userInfo)throws Exception {
			ModelAndView model = new ModelAndView("common/top");
								
			return model;
		}
		
		/**
		 * 회원가입 양식 전송 처리 
		 * @param request
		 * @param userDTO
		 * @return
		 */
		@RequestMapping(value="sign_up.do", method=RequestMethod.POST)
		public ModelAndView signUpProcess(@ModelAttribute AstiUserDTO userDTO)throws Exception {
			ModelAndView model = new ModelAndView("common/sign_up_complete");
			try{
				commonDAO.insertUserInfo(userDTO);	
			}
			catch(Exception e){
				model = errorPage(model, e);
			}
			
			return model;
		}
		
		/**
		 * 이메일(아이디) 중복 확인
		 * @param req
		 * @return
		 */
		@ResponseBody
		@RequestMapping(value="/isUserIdDup.do", method= RequestMethod.GET)
		public String idChecker(HttpServletRequest req)throws Exception{
			String user_id = req.getParameter("user_id");
			String result = "false";
			if(user_id != null){
				if(commonService.isUserIdDup(user_id)){
					result = "true";
				}
			}
			return result;
		}
		/**
		 * 로그인체크 후 세션 생성
		 * @param req
		 * @param userInfo
		 * @return
		 */
		@ResponseBody
		@RequestMapping(value="/isValidSignIn.do", method= RequestMethod.POST)
		public String isValidSignIn(AstiUserDTO userInfo)throws Exception{
			String user_id = request.getParameter("user_id");
			
			HDIdeaCipher cipher = new HDIdeaCipher();
			String user_password = cipher.encrypt(request.getParameter("user_password"));
			
			String result = "false";
			if(user_id != null && user_password != null){
				userInfo.setUser_id(user_id);
				userInfo.setUser_password(user_password);
				
				/*아이디 비번체크*/
				if(commonService.isValidSignIn(userInfo)){
					userInfo = commonService.getUserInfo(user_id);
					result="notApproval";
					/*권한 부여 받아야 로그인 가능함*/
					if(userInfo.getUser_authority()!=null){
						result = "true";
						request.getSession().setAttribute("USERINFO", userInfo);
					}
				}
			}
			return result;
		}
		
		@RequestMapping(value="/sign_out.do", method= RequestMethod.GET)
		public ModelAndView SignOut(AstiUserDTO userInfo)throws Exception{
			ModelAndView model = new ModelAndView();
			request.getSession().removeAttribute("USERINFO");
			model.setViewName("redirect:index.do");
			return model;
		}
		
		/**
		 * 에러 페이지
		 * @param model
		 * @param e
		 * @return
		 */
		public ModelAndView errorPage(ModelAndView model, Exception e)throws Exception{
			model = new ModelAndView("common/error");
			model.addObject("error", e.getMessage());
			return model;
		}
		
		/**
		 * 회원승인페이지
		 * @return
		 */
		@RequestMapping(value="waiting_users.do", method=RequestMethod.GET)
		public ModelAndView WaitngUsers() throws Exception{
			ModelAndView model = new ModelAndView("common/waiting_users");
			List<AstiUserDTO> userList = commonService.getWaitingUserList();
			model.addObject("userList", userList);
			return model;
		}
		@RequestMapping(value = "download.do", method=RequestMethod.POST)
		public void download(
				HttpServletResponse response,
				@RequestParam(required =true) String filename
				) throws Exception{
			AstiBoardSearchDTO boardSearch = new AstiBoardSearchDTO();
			boardSearch.setSearchDetail(filename);
			List<AstiBoardFileDTO> boardFile = boardService.getBoardFile(boardSearch);
			/*
			AstiUserDTO userInfo = (AstiUserDTO) request.getSession().getAttribute("USERINFO");
			String user_authority= new String();
			if(userInfo != null)
				user_authority =userInfo.getUser_authority();*/
			
			AstiBoardSearchDTO search = new AstiBoardSearchDTO();
			
			/*if("true".equals(commonService.isDownAuth(filename, user_authority))){*/
				if(boardFile.size()==1){
					search.setBoard_id(boardFile.get(0).getBoard_id()+"");
					String board_type=boardService.getBoardContent(search).getBoard_type();
					
					String origin_filename = boardFile.get(0).getFilename();
					UploadAndDownloadUtil depart_down = new UploadAndDownloadUtil("departmentImage","file");
					UploadAndDownloadUtil down = new UploadAndDownloadUtil("WEB-INF/upload","file");
					
					if(board_type.equals("B05"))
						depart_down.download(request, response, filename,origin_filename);
					else 
						down.download(request, response, filename,origin_filename);
				}
			/*}
			System.out.println(request.getHeader("referer"));*/
		}
		/*회원가입페이지*/
		@RequestMapping(value="signUp.do",method=RequestMethod.GET)
		public ModelAndView signUp(/*@RequestParam(required = false) String user_id*/){
			ModelAndView model = new ModelAndView("sign/signUp");
			/*insert할때는 user_id 없응께 userInfo에 null이 들어갈것이고 
			update할때는 user_id가 있으니깐 그거 뿌리지*/
			AstiUserDTO user = (AstiUserDTO)request.getSession().getAttribute("USERINFO");
			
//			파라미터 안넘기고 세션으로 수정인지 입력인지 판단
			AstiUserDTO userInfo;
			if(user==null){
				userInfo=new AstiUserDTO();
				model.addObject("userDeptList",adminService.getCodeUserDetp());
				model.addObject("astiUserDTO", userInfo);
				return model;
			}
			else{
				AstiUserDTO param = new AstiUserDTO();
				param.setUser_id(user.getUser_id());
				userInfo= commonService.getUser(param);
				model.addObject("userDeptList",adminService.getCodeUserDetp());
				model.addObject("astiUserDTO", userInfo);
				return model;
			}
			
		}
		@RequestMapping(value="signUp.do", method=RequestMethod.POST)
		public ModelAndView signUpInsert(@ModelAttribute AstiUserDTO astiUserDTO,
				BindingResult result) throws Exception{
			this.astiValidator.userValidate(astiUserDTO, result);
			if(result.hasErrors()){
				ModelAndView model = new ModelAndView("sign/signUp");
				model.addObject("userDeptList",adminService.getCodeUserDetp());
				return model;
			}
			else{
				HDIdeaCipher cipher = new HDIdeaCipher();
				astiUserDTO.setUser_password(cipher.encrypt(astiUserDTO.getUser_password()));
				commonService.mergeIntoUser(astiUserDTO);
				return new ModelAndView("redirect:/main/index.do");
			}
		}
		
		/**********************브라우저 체크******************************/
}
