package mil.af.asti.board;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.asti.common.CommonService;
import mil.af.asti.model.AstiBoardAddtextDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiBoardPaginationDTO;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiUserDTO;
import mil.af.asti.model.AstiValidator;


import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import util.PaginationUtil;
import util.UploadAndDownloadUtil;

/**
 * @author 한다현
 * 게시판 Controller
 * 모든 게시판 종류는 이 곳을 거쳐서 접근'한다'.
 */
@Controller
@RequestMapping("board")
public class BoardController {
	
	@Resource
	private BoardService boardService;
	
	@Resource
	private AstiValidator astiValidator;

	@Resource
	private CommonService commonService;
	/********************************Board List********************************/
	/** 
	 * @param astiFreeBoardSearchDTO - 게시판 글 검색 DTO
	 * 		  currentPage - 현재 페이지
	 * 
	 */
	@RequestMapping(value="/board.do",method=RequestMethod.GET)
	public ModelAndView board(
			HttpServletRequest request, AstiUserDTO userInfo,
			@ModelAttribute AstiBoardSearchDTO astiBoardSearchDTO,
			@RequestParam(defaultValue="1",required=false) int currentPage){
		ModelAndView mav = null;
		String board_type = astiBoardSearchDTO.getBoard_type();
		
		if(board_type.equals("B00")||board_type.equals("B01")||board_type.equals("B02")||board_type.equals("B03"))
			mav = new ModelAndView("board/issueBoard");
		else if(board_type.equals("B05"))
			mav = new ModelAndView("board/researchStateBoard");
		else if(board_type.equals("B07"))
			mav = new ModelAndView("board/contributionBoard");
		else if(board_type.equals("B08"))
			mav = new ModelAndView("board/reportBoard");
		else 
			mav = new ModelAndView("board/normalBoard");
			
		astiBoardSearchDTO.setBoard_type( 
				boardService.validateBoardUri(astiBoardSearchDTO.getBoard_type()));
		if(board_type.equals("B05")){
			AstiBoardPaginationDTO pagination = new AstiBoardPaginationDTO(currentPage , boardService.getBoardContentsCount(astiBoardSearchDTO));
			pagination.setContentsPerPage(10);
			astiBoardSearchDTO.setAstiBoardPaginationDTO(pagination);
		}
		else{
			astiBoardSearchDTO.setAstiBoardPaginationDTO(PaginationUtil.pageSetter(
					currentPage , boardService.getBoardContentsCount(astiBoardSearchDTO)));
		}
		
		List<AstiBoardDTO> boardContentsList= 
				boardService.getBoardContentsList(astiBoardSearchDTO); 
		
		AstiBoardSearchDTO search = new AstiBoardSearchDTO();
		search.setBoard_type(astiBoardSearchDTO.getBoard_type());
		List<AstiBoardFileDTO> boardFile=boardService.getBoardFile(search);
		
		boardService.appendFileToBoard(boardContentsList,boardFile);
		
		mav.addObject("freeBoardContentsList",boardContentsList);
		mav.addObject("astiBoardSearchDTO",astiBoardSearchDTO);
		/*보드사인 없앰*/
		/*mav.addObject("boardSign",boardService.getboardSign(astiBoardSearchDTO));*/
		return mav;
	}
	
	/***************************************************************************/
	/*view.do에서 뒤로가기 누르면 메인페이지로감;;
	 * 새로고침 눌러도 메인페이지로감;;
	 * */
	/*******************************Board View**********************************/
	@RequestMapping(value="view.do",method=RequestMethod.GET)
	public ModelAndView view(
			@ModelAttribute AstiBoardSearchDTO astiBoardSearchDTO){
		ModelAndView mav = new ModelAndView("board/view");
		
		AstiBoardDTO boardContent=
				boardService.getBoardContent(astiBoardSearchDTO);
		mav.addObject("boardContent",boardContent);
		
		AstiBoardDTO previous = boardService.getBoardPreviousDTO(boardContent);
		AstiBoardDTO next = boardService.getBoardNextDTO(boardContent);
		
		mav.addObject("previous",previous);
		mav.addObject("next",next);
		/*삭제하거나 하면 board_id 없어져서 null포인터에러남 그래서 조건 추가*/
		if(boardContent != null){
			List<AstiBoardFileDTO> boardFile=
					boardService.getBoardFile(astiBoardSearchDTO);
			mav.addObject("boardFile",boardFile);
			
			List<AstiBoardAddtextDTO> boardComment=
					boardService.getBoardComments(boardContent);
			mav.addObject("boardComment",boardComment);
		}
		return mav;
	}
	/*******************************Board View**********************************/
	/*AOP로 묶을라고 메소드 이름 바꿈 ㅋㅋ*/
	@RequestMapping(value="insert.do",method=RequestMethod.GET)
	public ModelAndView insertBoardView(
			@ModelAttribute AstiBoardSearchDTO astiBoardSearchDTO
			){
		ModelAndView mav = new ModelAndView("board/insert");
		ModelAndView errorView = new ModelAndView("common/main");
		mav.addObject("boardSign",boardService.getboardSign(astiBoardSearchDTO));
		mav.addObject("authorityList", commonService.getAstiCodeByType("authority"));
		
		AstiBoardDTO boardContent;
		/*입력할때*/
		if(astiBoardSearchDTO.getBoard_id() ==null || "".equals(astiBoardSearchDTO.getBoard_id())){
			boardContent=new AstiBoardDTO();
		}
		/*수정할때*/
		else{
			boardContent=boardService.getBoardContent(astiBoardSearchDTO);
			List<AstiBoardFileDTO> boardFile=boardService.getBoardFile(astiBoardSearchDTO);
			mav.addObject("boardFile",boardFile);
		}
		mav.addObject("astiBoardDTO", boardContent);
				
		/*파라미터에 board_type가 넘어오면 입력창, 아니면 메인페이지로*/
		if(boardService.containBoardType(astiBoardSearchDTO.getBoard_type())){
			return mav;
		}
		else 
			return errorView;
					
	}
	@Transactional
	@RequestMapping(value="insert.do",method=RequestMethod.POST)
	public ModelAndView insertBoard(@ModelAttribute AstiBoardDTO astiBoardDTO,
			BindingResult result,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam String insertUrl,
			Model model) throws Exception{
		this.astiValidator.boardValidate(astiBoardDTO, result);
		if(result.hasErrors()){
			System.out.println("에러당");
			
//			String send = request.getHeader("referer");
			AstiBoardSearchDTO dto = new AstiBoardSearchDTO();
			dto.setBoard_type(astiBoardDTO.getBoard_type());
			
			if(astiBoardDTO.getBoard_id()==null || "".equals(astiBoardDTO.getBoard_id()))
				model.addAttribute("board_form", "insert");
			else{
				model.addAttribute("board_form", "update");
				model.addAttribute("board_id", astiBoardDTO.getBoard_id());
			}
			return new ModelAndView("redirect:/"+insertUrl+"/"+insertUrl+".do?code="+astiBoardDTO.getBoard_type());
		}
				
		/*asti_board테이블에 처음 입력할때만 board_id 생성*/
		if(astiBoardDTO.getBoard_id()==null || "".equals(astiBoardDTO.getBoard_id())){
			Integer board_id = boardService.getMaxBoardId()+1;
			astiBoardDTO.setBoard_id(board_id);
		}
		boardService.boardMerge(astiBoardDTO);
		
		List<String> file_ids = new ArrayList<String>();
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = mhsr.getFiles("file");
		for(int i=0;i<files.size();i++)
			file_ids.add(boardService.createFileId());
		
		UploadAndDownloadUtil depart_upload = new UploadAndDownloadUtil("departmentImage","file");
		UploadAndDownloadUtil upload = new UploadAndDownloadUtil("WEB-INF/upload","file");
		
		Map<String,String> filenames;
		/*연구원 동정일때는 departmentImage에 저장*/
		if(astiBoardDTO.getBoard_type().equals("B05")){
			depart_upload.setAccept_type("jpg,gif,bmp,png");
			filenames= depart_upload.severalThingUpload(request, files, file_ids);
		}
		else
			filenames= upload.severalThingUpload(request, files, file_ids);
		
		/*파일 업로드 안했을시에는 기존 파일 남아있음*/
		if(filenames.size()>0)
			boardService.insertBoardFile(astiBoardDTO.getBoard_id(), filenames);
		
		model.addAttribute("board_id", astiBoardDTO.getBoard_id());
//		return new ModelAndView(new RedirectView("/journal/journal.do"));
		return new ModelAndView("redirect:/"+insertUrl+"/"+insertUrl+".do?code="+astiBoardDTO.getBoard_type());
	}
	/*******************************Comment Input************************************/
	@Transactional
	@RequestMapping(value="insertComment.do",method=RequestMethod.POST)
	public String insertComment(@ModelAttribute AstiBoardAddtextDTO astiBoardAddtextDTO,String board_type
			,HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam String insertUrl){
		boardService.insertBoardComment(astiBoardAddtextDTO);
		return "redirect:/"+insertUrl+"/"+insertUrl+".do?code="+board_type+"&board_id="+astiBoardAddtextDTO.getBoard_id();  
	}
	
	@Transactional
	@RequestMapping(value="addReplyComment.do",method=RequestMethod.POST)
	public String insertReplyComment(@ModelAttribute AstiBoardAddtextDTO astiBoardAddtextDTO,String board_type
			,HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam String insertUrl){
		boardService.insertReplyComment(astiBoardAddtextDTO);
		return "redirect:/"+insertUrl+"/"+insertUrl+".do?code="+board_type+"&board_id="+astiBoardAddtextDTO.getBoard_id();
	}
	  
	/********************************************************************************/
	
}
