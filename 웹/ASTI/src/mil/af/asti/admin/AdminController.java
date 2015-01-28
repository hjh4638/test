package mil.af.asti.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.asti.board.BoardService;
import mil.af.asti.common.CommonService;
import mil.af.asti.dept.DeptService;
import mil.af.asti.exception.AuthDeniedException;
import mil.af.asti.model.AstiAdminSearchDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiNewMemberDTO;
import mil.af.asti.model.AstiPageDTO;
import mil.af.asti.model.AstiResearchWorkerDTO;
import mil.af.asti.model.AstiUserDTO;
import mil.af.asti.model.AstiValidator;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import util.PaginationUtil;
import util.UploadAndDownloadUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Resource
	private AdminService adminService;
	@Resource
	private DeptService deptService;
	@Resource
	private CommonService commonService;
	@Resource
	private AstiValidator astiValidator;
	@Resource
	private BoardService boardService;
	
	@RequestMapping("/auth.do")
	public ModelAndView authPage(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute AstiAdminSearchDTO astiAdminSearchDTO,
			@RequestParam(defaultValue="1",required=false)int currentPage
			) throws Exception{
		ModelAndView mav = new ModelAndView("admin/auth");
//		astiAdminSearchDTO.setAstiBoardPaginationDTO(PaginationUtil.pageSetter(
//				currentPage , adminService.getMemberCount(astiAdminSearchDTO)));
//		List<AstiUserDTO> astiUserDTO = adminService.getMemberList(astiAdminSearchDTO);
//		List<AstiCodeDTO> astiCodeDTO = adminService.getAuthorityCodeList();
//		
//		mav.addObject("astiUserDTO",astiUserDTO);
//		mav.addObject("astiCodeDTO",astiCodeDTO);
		
		return mav;
	}
	/*회원사 관리 페이지*/
	@RequestMapping("/userDept.do")
	public ModelAndView userDept(){
		ModelAndView model= new ModelAndView("auth/userDept");
		List<AstiCodeDTO> userDetp = adminService.getCodeUserDetp();
		model.addObject("userDept", userDetp);
		return model;
	}
	@RequestMapping("/membermanage.do")
	public ModelAndView memmanage(HttpServletRequest request, 
			HttpServletResponse response,
			@ModelAttribute AstiAdminSearchDTO astiAdminSearchDTO,
			@RequestParam(defaultValue="1",required=false)int currentPage
			)throws Exception{
		String saveAuthorityName = astiAdminSearchDTO.getSearchDetail();
		ModelAndView model= new ModelAndView("auth/membermanage");
		astiAdminSearchDTO.setAstiBoardPaginationDTO(PaginationUtil.pageSetter(
				currentPage , adminService.getMemberCount(astiAdminSearchDTO)));
		if("user_authority".equals(astiAdminSearchDTO.getSearchType()) && 
				astiAdminSearchDTO.getSearchDetail() instanceof String){
			
			astiAdminSearchDTO.setSearchDetail(adminService.validateAuthority
					(astiAdminSearchDTO.getSearchDetail()));
		}
		List<AstiUserDTO> astiUserDTO = adminService.getMemberList(astiAdminSearchDTO);
		List<AstiCodeDTO> astiCodeDTO = adminService.getAuthorityCodeList();
		
		model.addObject("astiUserDTO",astiUserDTO);
		model.addObject("astiCodeDTO",astiCodeDTO);
		if(saveAuthorityName instanceof String){
			if(!saveAuthorityName.equals(astiAdminSearchDTO.getSearchDetail())){
				astiAdminSearchDTO.setSearchDetail(saveAuthorityName);
			}
		}
		
		return model; 
	}
	
	@RequestMapping("/deleteMember.do")
	public ModelAndView deleteMember(@RequestParam String id){
		ModelAndView model = new ModelAndView("redirect:auth.do");
		adminService.deleteMember(id);
		return model;
	}
	
	
	
	@ExceptionHandler(AuthDeniedException.class)
	public ModelAndView authDeniedHandler(){
		return new ModelAndView("redirect:/main/index.do"); 
	}
	@Transactional
	@RequestMapping(value="/authChange.do",method=RequestMethod.POST)
	public String authChange(@ModelAttribute AstiUserDTO astiUserDTO){
		String[] user_authority = astiUserDTO.getUser_authority().split(",");
		String[] user_id = astiUserDTO.getUser_id().split(",");
		
		List<AstiUserDTO> changeAuthorityDTO = new ArrayList<AstiUserDTO>();
		
		if(user_authority.length == user_id.length){
			for(int i=0;i<user_id.length;i++){
				
				changeAuthorityDTO.add(new AstiUserDTO(user_id[i],user_authority[i]));
			}
		}
		
		adminService.changeAuthority(changeAuthorityDTO);
		return "redirect:auth.do";
	}
	
	@RequestMapping("removedMemberManage.do") 
	public ModelAndView memberManage() throws Exception{
		ModelAndView model = new ModelAndView("admin/removedMemberManage");
		List<AstiUserDTO> removedUser = adminService.removedMemberManage();
		model.addObject("removedUser",removedUser);
		return model;
		
	}
	
	@RequestMapping("deptworkerAdmin.do")
	public ModelAndView workerAdmin(@RequestParam(defaultValue="") String code,
			@ModelAttribute AstiBoardSearchDTO searchDTO,
			@RequestParam(defaultValue="1",required=false) int currentPage) throws Exception{
		ModelAndView model = new ModelAndView ("auth/deptworkerAdmin");
		
		searchDTO.setWorker_department(code);
		Integer numOfContents =deptService.getWorkerCount(searchDTO);
		searchDTO.setAstiBoardPaginationDTO(PaginationUtil.pageSetter(
				currentPage , numOfContents));
		
		List<AstiResearchWorkerDTO> workerList = deptService.getWorkerList(searchDTO);
		
		model.addObject("workerList", workerList);
		model.addObject("astiBoardSearchDTO", searchDTO);

		List<AstiCodeDTO> department = commonService.getAstiCodeByType("research");
		model.addObject("department", department);
						
		return model;
	}
	@RequestMapping("workerRegister.do")
	public ModelAndView workerRegisterView(
			@RequestParam(required=false) String worker_id,
			@ModelAttribute AstiBoardSearchDTO searchDTO
			)throws Exception{
		List<AstiCodeDTO> department = commonService.getAstiCodeByType("research");
		AstiResearchWorkerDTO workerDTO;
		/*INSERT할때*/
		if(worker_id == null || "".equals(worker_id)){
			ModelAndView model = new ModelAndView("admin/pop/workerRegister");
			workerDTO = new AstiResearchWorkerDTO();
			model.addObject("astiResearchWorkerDTO", workerDTO);
			
			model.addObject("department", department);
			
			return model;
		}
		/*UPDATE할때*/
		else{
			ModelAndView model = new ModelAndView("admin/pop/workerRegister");
			workerDTO = deptService.getWorker(searchDTO);
			model.addObject("astiResearchWorkerDTO", workerDTO);
			
			model.addObject("department", department);
			
			return model;
		}
	}

	
	
	@Transactional
	@RequestMapping(value="/workerRegister.do", method=RequestMethod.POST)
	public ModelAndView workerRegister(
			@ModelAttribute AstiResearchWorkerDTO workerDTO,
			BindingResult result,
			HttpServletRequest request,
			HttpServletResponse response)throws Exception{
		this.astiValidator.researchWorkerValidate(workerDTO, result);
		if(result.hasErrors()){
			System.out.println("에러당");
			/*workerDTO가 널이 아니면 worker_id를 파라미터로 넘김*/
			/*업데이트 실패했을때 다시 띄워줄라고*/
			/*if(workerDTO !=null){
				worker_id = workerDTO.getWorker_id()+""; 비교대상으로 쓸거에 +"" 들어있어서 그런듯;;
				if(worker_id == null)
					worker_id =""; 이게 왜 데드코드야 ㅡ.ㅡ
			return new ModelAndView(new RedirectView("auth.do?tab=3&&worker_id="+worker_id));
			}*/
			if(workerDTO !=null){
				String worker_id= workerDTO.getWorker_id()+"";
				if(workerDTO.getWorker_id() ==null)
					worker_id ="";
			return new ModelAndView(new RedirectView("auth.do?tab=3&&worker_id="+worker_id));
			}
		}
		/*insert할때*/
		if(workerDTO.getWorker_id() == null || "".equals(workerDTO.getWorker_id()))
			workerDTO.setWorker_id(deptService.getMaxWorkerId()+1);
			
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = mhsr.getFiles("worker_picture");
		
		if(files.size()>0){
			UploadAndDownloadUtil upload = new UploadAndDownloadUtil("Temp", "worker_picture");
			String filename = files.get(0).getOriginalFilename();
			
			/*업로드했을때*/
			if(!("".equals(filename)) && filename != null){
				workerDTO.setWorker_picture_name(upload.upload(request, response, workerDTO.getWorker_id()+""));
				workerDTO.setWorker_picture_id(workerDTO.getWorker_id()+"");
			}
		}
				
		deptService.mergeIntoWorker(workerDTO);
		return new ModelAndView(new RedirectView("auth.do?tab=2"));
	}
	@RequestMapping("pageManage.do")
	public ModelAndView pageManage(@RequestParam(required=false , defaultValue="D01") String page_id){
		ModelAndView model = new ModelAndView("auth/pageManage");
		
		List<AstiCodeDTO> pageList = commonService.getAstiCodeByType("page");
		model.addObject("pageList", pageList);
		
		List<AstiPageDTO> page = adminService.getPageInfo(page_id);
		model.addObject("pageInfo", page);
		
		model.addObject("pageId",page_id);
		return model;
	}
	@Transactional
	@RequestMapping(value="/pageImageChange.do", method=RequestMethod.POST)
	public ModelAndView pageImageChange(HttpServletRequest request,
			@RequestParam(required=true) String page_id) throws Exception{
		ModelAndView model = new ModelAndView(new RedirectView("auth.do?page_id="+page_id));
		
		UploadAndDownloadUtil upload = new UploadAndDownloadUtil("pageImage", "pageImage");
		upload.setAccept_type("jpg,gif,bmp,png");

		List<String> file_ids = new ArrayList<String>();
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = mhsr.getFiles("pageImage");
		for(int i=0;i<files.size();i++)
			file_ids.add(boardService.createFileId());
		Map<String,String> filenames= upload.severalThingUpload(request, files, file_ids);
		
		adminService.insertPageList(page_id,filenames);
			
		return model;
	}
}
