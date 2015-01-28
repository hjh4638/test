package mil.af.L6S.component.subject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.approvalLine.ApprovalVO;
import mil.af.L6S.component.common.User;
import mil.af.common.util.ApprovalUtil;
import mil.af.common.util.ListVOUtil;
import mil.af.common.util.UploadAndDownloadUtil;

/*import org.junit.Test;*/
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author 공군 상병 함준혁
 * 
 */
@Controller
@RequestMapping("/subject")
public class SubjectController {
	private UploadAndDownloadUtil upAndDown;
	private SubjectService subjectService;
	private ApprovalService approvalService;
	private SubjectExcelView subjectExcelView;

	@Autowired
	void subjectcontroller(UploadAndDownloadUtil upAndDown,
			SubjectService subjectService,
			ApprovalService approvalService,
			SubjectExcelView subjectExcelView) {
		this.upAndDown = upAndDown;
		this.subjectService = subjectService;
		this.approvalService = approvalService;
		this.subjectExcelView = subjectExcelView;
	}
	@RequestMapping("getBigo.do")
	@ResponseBody
	public SubjectFormAndDataVO getBigo(String form_id){
		List<SubjectFormAndDataVO> subjectTypeItem = subjectService.getFormByType("SUBJECT_TYPE");
		for(int i=0;i<subjectTypeItem.size();i++){
			SubjectFormAndDataVO a= subjectTypeItem.get(i);
			if(a.getForm_id().equals(form_id)){
				return a;
			}
		}
		return null;
	}
	/**
	 * 과제등록페이지
	 */
	@RequestMapping("/subjectRegister.do")
	public void subjectRegister(Model model, User user,
			HttpServletRequest request,
			@ModelAttribute(value = "subjectVO") SubjectVO subjectVO) throws Exception {
			try{
				/* 셀렉트박스 항목 구해오는 code */
				/*과제유형*/
				List<SubjectFormAndDataVO> subjectTypeItem = subjectService
						.getFormByType("SUBJECT_TYPE");
				model.addAttribute("subjectTypeItem", subjectTypeItem);
				/*과제 구분*/
				List<SubjectFormAndDataVO> subjectSectionItem = subjectService
						.getFormByType("SUBJECT_SECTION");
				model.addAttribute("subjectSectionItem", subjectSectionItem);
				/*성과구분*/
				List<SubjectFormAndDataVO> subjectResultSection = subjectService
						.getFormByType("RESULT_SECTION");
				model.addAttribute("subjectResultSection", subjectResultSection);
				/*분야별 유형*/
				List<SubjectFormAndDataVO> subjectFieldType = subjectService
						.getFormByType("FIELD_TYPE");
				model.addAttribute("subjectFieldType", subjectFieldType);
				
				/*부대담장자 있을시 result는 true*/
				if(user.getPositionCode() !=null)
					model.addAttribute("guide_committee", approvalService.getGuide_Committee(user.getPositionCode()).get(0));
					model.addAttribute("result", "true");
				/*부대담당자 없을시(IndexOutOfBoundsException이 일어남) result는 false*/
			}catch (IndexOutOfBoundsException e) {
				System.out.println("The problem happened in Array Index [0]!");
				model.addAttribute("result", "false");
			}
		}
		
	/**
	 * 관리자 조회 팝업
	 */
	@RequestMapping(value = "/popup/popupSearchAdmin.do")
	public void searchAdmin(Model model,
			@RequestParam(required = false) String name) {
		/*avs11u0t 테이블에서 이름으로 조회*/
		List<UserVO> admin = subjectService.searchUserByAvs(name);
		model.addAttribute("admin", admin);
	}
	/**
	 * 인쇄화면
	 */
	@RequestMapping(value = "/popup/popupPrint.do")
	public void print(Model model) {
	}

	/**
	 * 사용자 조회 팝업
	 */
	@RequestMapping(value = "/popup/popupSearchUser.do")
	public void searchUser(Model model,
			@RequestParam(required = false) String name) {
		/*avs11u0t 테이블에서 이름으로 조회*/
		List<UserVO> user = subjectService.searchUserByAvs(name);
		model.addAttribute("user", user);
	}
	/**
	 * 목록조회/단계별현황관리 페이지
	 * 
	 * @param model
	 */
	@RequestMapping(value = "/subjectList.do")
	public void subjectList(Model model,
			@ModelAttribute(value = "subjectVO") SubjectVO subjectVO,
//			@RequestParam(required=false) String year,
			User user) {
		/* 셀렉트박스 항목 구해오는 code */
		/*과제유형*/
		List<SubjectFormAndDataVO> subjectTypeItem = subjectService
				.getFormByType("SUBJECT_TYPE");
		model.addAttribute("subjectTypeItem", subjectTypeItem);
		/*과제 구분*/
		List<SubjectFormAndDataVO> subjectSectionItem = subjectService
				.getFormByType("SUBJECT_SECTION");
		model.addAttribute("subjectSectionItem", subjectSectionItem);
		/*성과구분*/
		List<SubjectFormAndDataVO> subjectResultSection = subjectService
				.getFormByType("RESULT_SECTION");
		model.addAttribute("subjectResultSection", subjectResultSection);
		/*분야별 유형*/
		List<SubjectFormAndDataVO> subjectFieldType = subjectService
				.getFormByType("FIELD_TYPE");
		model.addAttribute("subjectFieldType", subjectFieldType);
		/*소속*/
		List<BaseVO> allBase = subjectService.getBaseAll();
		model.addAttribute("allBase", allBase);

		/* 검색해서 나온 결과물 구해오는 code */
		/*사람검색(팀원,리더,챔피언,부서장,지도위원) 코드로 구분*/
		subjectService.setSelection(subjectVO);
		
//		subjectVO.setRegister_day(year);
		/*구분된 코드로 과제 조회*/
		List<SubjectVO> sub = subjectService.searchSubject(subjectVO);
		model.addAttribute("allSubject", sub);
	}

	/**
	 * 과제등록 기능
	 * 
	 * @param subjectVO
	 * @param request
	 */
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	@Transactional
	public String insert(@ModelAttribute SubjectVO subjectVO, 
			@ModelAttribute ApprovalVO approvalVO,User user,
			HttpServletRequest request, HttpServletResponse response) {
		
		List<SubjectFormAndDataVO> subjectTypeItem = subjectService.getFormByType("SUBJECT_TYPE");
		for(int i=0;i<subjectTypeItem.size();i++){
			SubjectFormAndDataVO a= subjectTypeItem.get(i);
			if(a.getForm_id().equals(subjectVO.getSubject_type())){
				subjectVO.setSubject_type(a.getTitle());
			}
		}
		
		/*과제코드 가져오기(과제시퀀스에서 nextval함수로 가져옴)*/
		Integer seq = subjectService.getSeq();
		
		/*과제등록*/
		subjectVO.setSubject_code(seq);
		subjectVO.setFilename(upAndDown.upload(request, response));
		subjectService.insertSubject(subjectVO);

		/*팀원등록*/
		@SuppressWarnings("unchecked")
		/*request parameter중 UserVO 항목의 것들만 리스트로 뽑아줌*/
		List<UserVO> users = (List<UserVO>) ListVOUtil.getVOList(request,
				UserVO.class);
		subjectService.insertUser(subjectVO, users);
	
		return "redirect:detailSubjectList.do?seq=" + seq;
	}
	/**
	 * 과제수정 기능
	 * @param subjectVO
	 * @param user
	 * @param seq
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/subjectUpdate.do",method = RequestMethod.POST)
	@Transactional
	public String subjectupdate(@ModelAttribute SubjectVO subjectVO, User user,
			@RequestParam Integer seq,
			HttpServletRequest request, HttpServletResponse response){
		subjectVO.setSubject_code(seq);
		subjectVO.setFilename(upAndDown.upload(request, response));
		
		/*과제 수정*/
		subjectService.updateSubject(subjectVO);
		
		return "redirect:detailSubjectList.do?seq=" + seq;
	}

	/**
	 * 단계입력 기능
	 * D,M,A,I,C,완료 보고서의 입력을 모두 이 메소드에서 담당
	 * 
	 * @param request
	 * @param String
	 *            step
	 * @param Integer
	 *            seq
	 * @param User
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "stepInsert.do", method = RequestMethod.POST)
	@Transactional
	public String stepInsert(HttpServletRequest request,
			HttpServletResponse response, @RequestParam String step,
			@RequestParam Integer seq,
			@RequestParam(required = false) String tool_form, User user)
			throws IOException {
		//referer 헤더를 이용해 원래 위치로 redirect
		String send = request.getHeader("referer");
		String redi = send.substring(send.indexOf("stage"), send.length());
		
		/*입력 불가능한 상황 걸러냄*/
		if (!(subjectService.checkSubjectCode(user, seq,
				"본인 과제가 아니라 입력 불가능합니다.")))
			return "redirect:"+redi;
		else if(!(subjectService.validateInsertStep(step, seq))){
			System.out.println(step+"단계가 등록되어 있거나 이전 단계가 등록되어 있지 않습니다. 또는 결재가" +
					"이루어지지 않았습니다.");
			return "redirect:"+redi;
		}
	
		/*step_code를 생성하는 코드(DB 시퀀스.nextval로 가져옴)*/
		Integer stepSeq = subjectService.getStepSeq();
		
		/*업로드 후 파일명 반환*/
		/*단계별 완료보고서 업로드*/
		String filename = upAndDown.upload(request, response);
		
		/*첨부파일 업로드*/
		List<String> a_filename_list = upAndDown.severalThingUpload(request,response);
		@SuppressWarnings("unchecked")
		
		/*보낸 데이터를 순서대로 짝을 맞춰서 리스트로 반환(멀티파트용)*/
		List<SubjectFormAndDataVO> subject_data = (List<SubjectFormAndDataVO>) ListVOUtil
				.getVOListWhenMultipart(request, SubjectFormAndDataVO.class);
		
		/*step테이블에 데이터 입력*/
		//stepSeq : 과제입력 위한 과제 코드
		//seq : PK인 과제코드
		//step : D,M,A,I,C,E중 하나
		//filename : LSMS_STEP 테이블에 저장되는 파일명
		subjectService.insertStep(stepSeq, seq, step, filename);
		
		/*과제 데이터 저장*/
		//subject_data : LSMS_DATA 테이블에 저장되기 위한 순서쌍이 리스트로 저장됨
		//a_filename_list : 첨부파일 혹은 이미지 저장시 data에 들어갈 파일명 집단
		//stepSeq : 과제입력 위한 과제 코드
		subjectService.insertData(subject_data, a_filename_list, stepSeq);
	
		/*적용툴 저장*/
		//tool_form : tool-data의 form_id
		///request : tool_data를 뽑아내기위함
		//stepSeq : 과제입력 위한 과제 코드
		subjectService.adjustTool(request, tool_form, stepSeq);
		
			System.out.println(subjectService.validateInsertStep(step, seq));
		return "redirect:"+redi;
	}
	
	/**단계 수정 기능
	 * @param request
	 * @param response
	 * @param user
	 * @param seq
	 * @param step
	 * @param tool_form
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/stepUpdate.do", method = RequestMethod.POST)
	@Transactional
	public String update(HttpServletRequest request,
			HttpServletResponse response, User user,
			@RequestParam(required = false) Integer seq,
			@RequestParam String step,
			@RequestParam(required = false) String tool_form) {
		//referer 헤더를 이용해 원래 위치로 redirect
		String send = request.getHeader("referer");
		String redi = send.substring(send.indexOf("stage"), send.length());
		
		/*수정 불가능한 상황 걸러냄*/
		if (!(subjectService.checkSubjectCode(user, seq,"본인 과제가 아니라 수정 불가능합니다.")))
			return "redirect:"+redi;
		
		/*업로드 후 파일명 반환*/
		/*단계별 완료보고서 업로드*/
		String filename = upAndDown.upload(request, response);
		
		/*첨부파일 업로드*/
		List<String> a_filename_list = upAndDown.severalThingUpload(request,response);
				
		/*보낸 데이터를 순서대로 짝을 맞춰서 리스트로 반환(멀티파트용)*/
		List<SubjectFormAndDataVO> subject_data = (List<SubjectFormAndDataVO>) ListVOUtil
				.getVOListWhenMultipart(request, SubjectFormAndDataVO.class);
		/*현재 입력되어 있는 해당 단계의 단계 코드*/
		Integer stepSeq=subjectService.getStepSeqBySubjectSeq(seq, step);
			
		/*과제 테이블 파일네임 update 한후 데이터 테이블 delete하고 insert함*/
		SubjectFormAndDataVO step_update=new SubjectFormAndDataVO();
		step_update.setFilename(filename);
		step_update.setStep_code(stepSeq);
		
		/*단계 테이블 파일네임 update*/
		subjectService.updateStep(step_update);
		/*해당 단계 기존 데이터 모두 삭제*/
		subjectService.deleteAllDataInaStep(stepSeq);
		/*해당 단계에 들어갈 신규 데이터 입력*/
		subjectService.insertData(subject_data, a_filename_list, stepSeq);
		/*적용툴 저장*/
		subjectService.adjustTool(request, tool_form, stepSeq);
				
		return "redirect:"+redi;
	}

	/**
	 * 내 과제관리 페이지
	 * sub 메뉴 1.내 과제 목록 2.과제별 팀원관리
	 * @param model
	 * @param user
	 */
	@RequestMapping(value = "/mySubject.do")
	public void sub(Model model, User user,
			@ModelAttribute(value="subjectData") SubjectVO subjectData,
			@RequestParam(required = false) Integer seq) {
		/* 내과제 목록 구해오는 code */
		subjectData.setDummy(user.getSn());
		List<SubjectVO> mySubjects = subjectService.searchSubject(subjectData);
		
		/*과제코드*/
		List<Integer> sub_codes = user.getSubject_code();
		boolean is_mysubject = sub_codes.contains(seq);
		if(is_mysubject){
			/*과제별 팀원관리*/
			model.addAttribute("subject_user", subjectService.getUsersInfo(seq));
		}
		/*내 과제 목록*/
		model.addAttribute("mySubject", mySubjects);
	}
	
	/**
	 * 팀원 수정 기능
	 * @param request
	 * @param response
	 * @param seq
	 */
	@RequestMapping(value= "/updateUser.do")
	@Transactional
	public void updateUser(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = false) Integer seq){
		/*request parameter중 UserVO 항목의 것들만 리스트로 뽑아줌*/
		@SuppressWarnings("unchecked")
		List<UserVO> users = (List<UserVO>) ListVOUtil.getVOList(request,
				UserVO.class);
		SubjectVO subjectVO = new SubjectVO();
		subjectVO.setSubject_code(seq);
		
		/*사용자 초기화후 입력함*/
		subjectService.insertUser(subjectVO, users);
		
		//referer 헤더를 이용해 원래 위치로 redirect
		String send = request.getHeader("referer");
		
		try {
			response.sendRedirect(send);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**선택한 과제를 보여줌
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping(value = "/detailSubjectList.do")
	public void mySubject(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		
		/*해당 과제코드 과제*/
		SubjectVO mainSubject = subjectService.getSubjectBySeq(seq);
		model.addAttribute("mainSubject", mainSubject);

		/*내 과제인지 판단*/
		List<Integer> sub_codes = user.getSubject_code();
		boolean is_mysubject = sub_codes.contains(seq);
		model.addAttribute("is_mysubject", is_mysubject);
				
		/* 셀렉트박스 항목 구해오는 code */
		/*과제유형*/
		List<SubjectFormAndDataVO> subjectTypeItem = subjectService
				.getFormByType("SUBJECT_TYPE");
		model.addAttribute("subjectTypeItem", subjectTypeItem);
		/*과제구분*/
		List<SubjectFormAndDataVO> subjectSectionItem = subjectService
				.getFormByType("SUBJECT_SECTION");
		model.addAttribute("subjectSectionItem", subjectSectionItem);
		/*성과구분*/
		List<SubjectFormAndDataVO> subjectResultSection = subjectService
				.getFormByType("RESULT_SECTION");
		model.addAttribute("subjectResultSection", subjectResultSection);
		/*분야별유형*/
		List<SubjectFormAndDataVO> subjectFieldType = subjectService
				.getFormByType("FIELD_TYPE");
		model.addAttribute("subjectFieldType", subjectFieldType);
		
		/*몇단계까지 입력되었는지 출력(1이면 D단계,2이면 D,M단계,3이면 D,M,A단계, 4이면 D,M,A,I, 5이면 D,M,A,I,C단계)*/
		model.addAttribute("stepping", subjectService.getStepingCount(seq));
		
		/*현재 결재진행중인 단계 정보*/
		ApprovalVO stepAppInfo =approvalService.doingApproval(user.getSn(),seq,ApprovalUtil.step_type);
		model.addAttribute("stepAppInfo", stepAppInfo);
		
		/*단계 결재 횟수 가져옴. 이 숫자로 위에 d,m,a,i,c 버튼 보이게함*/
		List<ApprovalVO> approvedStep=approvalService.getApprovalList(null, seq, ApprovalUtil.done_state, null, null,ApprovalUtil.step_type);
		if(approvedStep.size() >0)
			model.addAttribute("isApproved", approvedStep.size());
		else
			model.addAttribute("isApproved", 0);
		
		/*작성자 입장*/
		if(is_mysubject){
			model.addAttribute("isRegistered",approvalService.isRegistered(seq, ApprovalUtil.report_type));
		}
		/*결재자 입장*/
		ApprovalVO right = approvalService.grantRight(user.getSn(), ApprovalUtil.report_type, seq);
		if(right != null)
			model.addAttribute("right", right);
		
		/* 과제등록서 결재 끝났나 여부*/
		model.addAttribute("finishApp", approvalService.isFinishedReport_typeApp(seq));
	}

	/**
	 * D단계 페이지
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping("/stage/stage_d.do")
	public void stageDInsert(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		subjectService.getParam(seq, "D", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"D");
		model.addAttribute("data", data);
	}

	/**
	 * M단계 페이지
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping("/stage/stage_m.do")
	public void stageMInsert(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		subjectService.getParam(seq, "M", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"M");
		model.addAttribute("data", data);
	}

	/**
	 * A단계 페이지
	 * model)databind: form_id A02,A03,A04 묶어서 리스트로 가져옴
	 * model)databindsize
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping("/stage/stage_a.do")
	public void stageAInsert(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		subjectService.getParam(seq, "A", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"A");
		model.addAttribute("data", data);
				
		List<String> form_code =new ArrayList<String>();
		/*한 행으로 묶고싶은 form_id (A02,A03,A04)*/
		form_code.add("A02");
		form_code.add("A03");
		form_code.add("A04");
		
		/*X's Data 수집*/
		List<List<SubjectFormAndDataVO>> databind =subjectService.changeDataToView(data, form_code);
		model.addAttribute("databind",databind);
	
		/*rowspan 값 넣어주기 위한 개체*/
		model.addAttribute("databindsize", databind.size());
	}

	/**
	 * I단계 페이지
	 * model)data
	 * model)solutionbind
	 * model)solutionbindsize
	 * model)briefbind
	 * model)briefbindsize
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping("/stage/stage_i.do")
	public void stageIInsert(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		subjectService.getParam(seq, "I", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"I");
		model.addAttribute("data", data);
				
		List<String> n1form =new ArrayList<String>();
		/*한 행으로 묶고싶은 form_id (I01,I02)*/
		n1form.add("I01");
		n1form.add("I02");
				
		List<String> n2form =new ArrayList<String>();
		/*한 행으로 묶고싶은 form_id (I04,I05,I06,I07)*/
		n2form.add("I04");
		n2form.add("I05");
		n2form.add("I06");
		n2form.add("I07");
		
		/*주요원인 개선대책*/
		List<List<SubjectFormAndDataVO>> solutionbind =subjectService.changeDataToView(data, n1form);
		model.addAttribute("solutionbind",solutionbind);
		model.addAttribute("solutionbindsize", solutionbind.size());
		
		/*단계요약*/
		List<List<SubjectFormAndDataVO>> briefbind =subjectService.changeDataToView(data, n2form);
		model.addAttribute("briefbind",briefbind);
		model.addAttribute("briefbindsize", briefbind.size());
	}

	/**model)data: C단계 데이터
	 * model)m_data: M단계 데이터
	 * model)databind: form_id C05,C06,C07,C08,C09인거 묶어서 리스트로 가져옴
	 * model)databindsize
	 * @param model
	 * @param user
	 * @param seq
	 */
	@RequestMapping("/stage/stage_c.do")
	public void stageCInsert(Model model, User user,
			@RequestParam(required = false) Integer seq) {
		subjectService.getParam(seq, "C", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"C");
		model.addAttribute("data", data);
		
		List<SubjectFormAndDataVO> m_data = subjectService.getData(seq,"M");
		model.addAttribute("m_data", m_data);
		
		List<String> form_code =new ArrayList<String>();
		/*한 행으로 묶고싶은 form_id (C05,C06,C07,C08,C09)*/
		form_code.add("C05");
		form_code.add("C06");
		form_code.add("C07");
		form_code.add("C08");
		form_code.add("C09");
		
		/*목표기술서*/
		List<List<SubjectFormAndDataVO>> databind =subjectService.changeDataToView(data, form_code);
		model.addAttribute("databind",databind);
		model.addAttribute("databindsize", databind.size());
	}

	/**model)data: E단계 데이터 리스트로 가져옴
	 * model)i_databind: I단계 I04,I05,I06,I07을 묶어서 리스트로 가져옴
	 * model)i_databindsize
	 * model)c_data
	 * @param model
	 * @param user
	 * @param request
	 * @param seq
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/stage/stage_e.do")
	public void stageEInsert(Model model, User user, HttpServletRequest request,
			@RequestParam(required = false) Integer seq) throws UnsupportedEncodingException {
		subjectService.getParam(seq, "E", model, user);
		List<SubjectFormAndDataVO> data = subjectService.getData(seq,"E");
		model.addAttribute("data", data);
		
		/*완료보고서 가능한지 판단*/
		List<ApprovalVO> step_app = approvalService.getMyApprovalFinishStep(ApprovalUtil.step_type,seq);
		if(step_app !=null)
			model.addAttribute("canStart", "Y");
		
		/*C단계 데이터*/
		List<SubjectFormAndDataVO> c_data = subjectService.getData(seq,"C");
		model.addAttribute("c_data", c_data);
		
		List<SubjectFormAndDataVO> i_data = subjectService.getData(seq,"I");
		List<String> form_code =new ArrayList<String>();
		/*한 행으로 묶고싶은 form_id (I04,I05,I06,I07)*/
		form_code.add("I04");
		form_code.add("I05");
		form_code.add("I06");
		form_code.add("I07");
		List<List<SubjectFormAndDataVO>> i_databind =subjectService.changeDataToView(i_data, form_code);
		
		List<String> filenames = new ArrayList<String>();
		
		/*i_databind에서 form_id가 I05,I06(image)인 것들을 분류해 filenames에 저장*/
		for(int i=0; i<i_databind.size();i++){
			List<SubjectFormAndDataVO> sd=i_databind.get(i);
			for(int k=0;k<sd.size();k++){
				SubjectFormAndDataVO d=sd.get(k);
				if(d.getForm_id().equals("I05") || d.getForm_id().equals("I06")){
					
					String filename = java.net.URLEncoder.encode(d.getData(),"euc-kr");
					filename = filename.replace("+", "%20");
					filenames.add(d.getData());
					d.setData(filename);
				}
			}
		}
		/*위에서 뽑아낸 form_id가 I05,I06(Image)인 data(파일명) filenames를 
		transferFile메소드에 파라미터 전달하여 filenames와 파일명이 같은 파일들은
		Temp 폴더에 복사 전송한다.*/
		boolean nullcheck =true;
			for(String fname :filenames){
				if(fname == null)
					nullcheck = false;
			}
		if(nullcheck)
			upAndDown.transferFile(request,"Temp", filenames);
		
		model.addAttribute("i_databind", i_databind);
		model.addAttribute("i_databindsize", i_databind.size());
		
	}

	/**subject-upload 폴더에서 파일명이 같은 파일 다운로드 시켜주게 해주는 메소드
	 * @param request
	 * @param response
	 * @param filename
	 * @throws IOException
	 */
	@RequestMapping(value = "download.do")
	public void downlodad(HttpServletRequest request,
			HttpServletResponse response, String filename) throws IOException {
		upAndDown.download(request, response, filename);
	}

	/**과제 삭제시 사용
	 * @param request
	 * @param response
	 * @param user
	 * @param seq
	 * @return
	 */
	@RequestMapping(value = "expireSubject.do")
	public String expireSubject(HttpServletRequest request,
			HttpServletResponse response, User user,
			@RequestParam(required = false) Integer seq) {
		if (!(subjectService
				.checkSubjectCode(user, seq, "본인과제가 아니라 삭제 불가능합니다.")))
			return "redirect:detailSubjectList.do?seq=" + seq;
		subjectService.expireSubject(seq);
		return "redirect:subjectList.do";
	}
	
	/**
	 * 과제 엑셀목록 다운
	 * @return
	 */
	@RequestMapping("excel/SubjectExcel.do")
	public ModelAndView SubjectExcel( ){
		ModelAndView model = new ModelAndView(subjectExcelView);
		List<SubjectExcelVO> excelDatum = subjectService.getExcelDatum();
		model.addObject("ExcelDatum",excelDatum);
		return model;
	}
}
