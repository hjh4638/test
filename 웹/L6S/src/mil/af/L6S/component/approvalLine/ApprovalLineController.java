package mil.af.L6S.component.approvalLine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import mil.af.L6S.component.belt.BeltService;
import mil.af.L6S.component.belt.BeltVO;
import mil.af.L6S.component.common.User;
import mil.af.L6S.component.subject.SubjectService;
import mil.af.common.util.ApprovalUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

/**
 * @author 공군 상병 함준혁
 *
 */
@Controller
@RequestMapping("/approval_line")
public class ApprovalLineController {

	private ApprovalService approvalService;
	@SuppressWarnings("unused")
	private SubjectService subjectService;
	private BeltService beltService;
	
	@Autowired
	void ApprovalLineController(ApprovalService approvalService, SubjectService subjectService, BeltService beltService){
		this.approvalService = approvalService;
		this.subjectService = subjectService;
		this.beltService = beltService;
	}
	
	@RequestMapping(value = "/app/flash.do")
	public ModelAndView View(HttpServletRequest req,User user) {
		ModelAndView mav = new ModelAndView();
				
		String sosokcode = user.getPositionCode();
		mav.addObject("sosokcode", sosokcode.substring(0, sosokcode.length()-2));
		mav.setViewName("/approval_line/mainFrame");
		return mav;
	}

	// [공통] 조직도 페이지
	@RequestMapping(value = "/app/treeView.do")
	public ModelAndView treeView(
			@RequestParam(required = false) String startcode) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/approval_line/treeView");
		mav.addObject("startcode", startcode);
		return mav;
	}

	// [공통] 조직도 페이지 플래쉬XML
	@RequestMapping(value = "/app/flashXmlTree.do")
	public ModelAndView flashTree(ModelAndView mav, HttpServletRequest req,
			@RequestParam(required = false) String startCode,
			@RequestParam(required = false) String treeType,
			@RequestParam(required = false) String dbUser) {
		mav.setViewName("/approval_line/flashXmlTree");
		mav.addObject("startcode", startCode);
		mav.addObject("treetype", treeType);
		mav.addObject("dbuser", dbUser);
		return mav;
	}

	// [공통] 부서별 페이지
	@RequestMapping(value = "/app/deptMemberList.do", method = RequestMethod.GET)
	public ModelAndView deptMemberList(ModelAndView mav,
			HttpServletRequest req, String sosokcode) {
		mav.setViewName("/approval_line/deptMemberList");
		List<ApprovalMemberVO> line_list = approvalService.getLineList(sosokcode);
		mav.addObject("processLineList", line_list);
		return mav;
	}

	// 결재자 지정페이지
	@RequestMapping(value = "/app/selectApprovalMembers.do")
	public ModelAndView addApproval(ModelAndView mav, String sosokcode) {
		mav.setViewName("/approval_line/selectApprovalMembers");
		
		return mav;
	}
	
	/*메인 결재수신현황 메뉴*/
	@RequestMapping("/approvalMain.do")
	public void appMain(User user,Model model,
			@ModelAttribute(value="approvalVO") ApprovalVO approvalVO){
		if(user !=null){
			approvalVO.setApp_sn(user.getSn());
			List<ApprovalBeltVO> beltappList=approvalService.getBelt_app(user.getSn());
			model.addAttribute("beltappList", beltappList);
			approvalVO.setApp_state(ApprovalUtil.doing_state);
			/*app_state가 0으로되어있는(어떠한 행위를 대기중인) 상태의 자기 결재를 가져옴*/
			List<ApprovalVO> myapp=approvalService.getApprovalListAndPage(approvalVO);
			if(myapp != null){
				/*권한 넣어줌*/
			approvalService.addAppRight(myapp);
			}
			model.addAttribute("appList", myapp);
			model.addAttribute("user",user);
		}
	}
	
	
	/**어려운 로직 알고리즘은 없다. 조금 코드가 많아서 복잡하고 어려워 보이지만
	 * 대부분은 가져온 리스트에서 인자 추출하는 코드이므로 어렵지 않다.
	 * 1.접수대기인 과제결재가 있으면 접수하고 해당결재 접수완료시키고
	 * 2.결재가 된 단계 결재가 있을때 다음 결재자 지정한다.(BB를 불러와서 insert함)
	 *  #과제 결재가 완료되고 단계 시작할때는 approval 테이블에 데이터가 없으므로  else if(isRegistered.equals("N")
	 *  이하 문장 실행. 
	 *  !!!이 상태에서 app_state가 0(결재대기) 이므로 my_step_app가 가져오지 못해 한번더 approval 테이블에  insert 할수도 있다!!! 
	 *  그러나 결재가 완료되어야 접수 가능하도록 만들었으므로 걱정하지 않아도된다. 
	 * 3.접수 대기인 결재도 없고 결재가 된 단계도 없을시에는 아예 입력이 안된(approval테이블에 insert 안된)
	 * 상태이므로 approval 테이블에 insert하고 결재자 접수한다.
	 * @param approvalVO
	 * @param seq
	 * @param user
	 * @param app_type
	 * @return
	 */
	@RequestMapping(value="/registerNext.do",method=RequestMethod.POST)
	@Transactional
	public String registerNext(@ModelAttribute ApprovalVO approvalVO,@RequestParam(required=true) Integer seq,
			User user,@RequestParam(required=true) String app_type){
		
		/*단계용*/
		ApprovalVO my_step_app = approvalService.doingStepApproval(seq, ApprovalUtil.step_type);
		String isRegistered = approvalService.isRegistered(seq,app_type);
//		
		/*단계가 진행중이고 결재가 끝난 것이 있을때 실행(Approval 테이블에는 insert 안함)*/
		if(my_step_app != null){
			Integer my_app_order = my_step_app.getApp_order();
			Integer app_id = my_step_app.getApp_id();
			ApprovalVO bb = approvalService.getBBbyAdmin(seq);
			approvalService.deleteApproval_line(ApprovalUtil.gigak_stae, seq);
			approvalService.registerApp(bb, seq, my_app_order+1, ApprovalUtil.doing_state, app_id);
		}
		/*단계든 과제든 lsms_approval 테이블에 입력이 되지않은(아예 시작도 안된)
		것들 lsms_approval과 lsms_approvalLine 테이블에 입력*/
		else if(isRegistered.equals("N") ){
			/*결재선 등록*/
			/*결재가 등록되어 있지 않을시 실행*/
			Integer app_id = approvalService.getApprovalSeq();
			approvalVO.setSubject_code(seq);
			approvalVO.setApp_id(app_id);
			approvalVO.setIs_complete(ApprovalUtil.doing_state);
			approvalVO.setApp_type(app_type);
			approvalService.insertApproval(approvalVO);
			if(app_type.equals(ApprovalUtil.report_type) || app_type.equals(ApprovalUtil.end_report_type)){
				approvalService.registerApp(approvalVO,seq,ApprovalUtil.subject_one,ApprovalUtil.doing_state,app_id);
				/*기각된 과제 찾아서 항목 모두 기각상태로 바꾸고 전부 delete 하는 */
				approvalService.deleteApproval(ApprovalUtil.gigak_stae, seq);
			}
			else if(app_type.equals(ApprovalUtil.step_type)){
				ApprovalVO bb = approvalService.getBBbyAdmin(seq);
				approvalService.registerApp(bb,seq,ApprovalUtil.step_d,ApprovalUtil.doing_state,app_id);
				approvalService.deleteApproval_line(ApprovalUtil.gigak_stae, seq);
			}
		}
		return "redirect:/subject/detailSubjectList.do?seq=" + seq;
	}
	
	/**결재 요청이 들어가면
	 * 1.doingApproval메소드로 현재 진행중인 결재(is_complete가 0 app_state도 0)인 결재를 가져온다.
	 * %!!!doingApproval메소드에서 list로 가져와서 맨 앞에 데이터를 리턴한다. 만일 현재 진행중인 결재가  여럿일 경우 잘못된 데이터를 가져올수도 있다. !!! 
	 * 그러나 이 체계에 결재는 개별 결재 유닛들과 결재자가 1:1로 매칭되어 있으며, 결재가 끝나야 다음 결재대기 상태의
	 * 결재를 insert 하기 때문에 doingApproval메소드는 한개의 데이터만 가져온다.
	 * 2.doingApproval메소드로 가져온 myapp가 널인경우 해당자에게 결재할 결재가 없으므로 결재는 진행되지 않는다.
	 * 3.app_type로 결재 종류를 구별한다.
	 * 4.과제등록서 혹은 완료보고서일시 결재 가능한 order 1,3,5,6,7일 때만 결재이고 order 6(공본담당자)일 때는
	 * 접수까지 같이 해버린다.
	 * 4-1. 결재타입을 가져와서 결재 타입별로 다른 결재선을 탄다.
	 * 5.단계를 결재시키고 step_c가 결재되었을때 step결재를 완전히 완료시킨다(approval의 is_complete를 1로).
	 * @param request
	 * @param comment
	 * @param seq
	 * @param app_type
	 * @param approvalVO
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/approvalSubject.do", method = RequestMethod.POST)
	@Transactional
	public String appSubject(HttpServletRequest request,
			@RequestParam(required=false) String comment,
			@RequestParam(required=true) Integer seq,
			@RequestParam(required=true) String app_type,
			@ModelAttribute ApprovalVO approvalVO,
			User user){
				 
		System.out.println("test");
		/*내 결제정보(진행중인 정보)*/
		ApprovalVO myapp = approvalService.doingApproval(user.getSn(),seq,app_type);
		
		if(myapp !=null){
			Integer my_app_order = myapp.getApp_order();
			Integer app_id = myapp.getApp_id();
			/*과제 혹은 완료보고서 일때 결재*/
			if(app_type.equals("S") || app_type.equals("E")){
				String my_app_type=approvalService.approvalType(myapp,user.getPositionCode());
				/*부대 담당자를 sosokcode로 가져옴(계급,이름,군번,직책)*/
				List<ApprovalVO> approvalList= approvalService.getBaseAdmin(user.getPositionCode());
				
				/*결재*/
				approvalService.updateState(ApprovalUtil.done_state,myapp.getApp_seq(),comment);
				
				/*공본담당자일때 접수까지 함*/
				/*수정 관리자 권한일 경우 접수까지함*/
				if(my_app_order.equals(ApprovalUtil.subject_six) || my_app_order.equals(ApprovalUtil.subject_two)
						|| my_app_order.equals(ApprovalUtil.subject_four)){
					approvalService.registerApp(approvalVO, seq, my_app_order+1, ApprovalUtil.doing_state, app_id);
				}
				/*유형별로 다르게 결재라인을 탄다*/
				if(my_app_type.equals("a"))
					approvalService.approvalLineA(my_app_order,approvalList,seq,app_id);
				else if(my_app_type.equals("b"))
					approvalService.approvalLineB(my_app_order,approvalList,seq,app_id);
				else
					approvalService.approvalLineC(my_app_order,approvalList,seq,app_id);
			}
			/*단계일때 결재*/
			else if(app_type.equals("step")){
				approvalService.updateState(ApprovalUtil.done_state,myapp.getApp_seq(),comment);
				if(myapp.getApp_order().equals(ApprovalUtil.step_c)){
					approvalService.updateApproval(ApprovalUtil.done_state,myapp.getApp_id(),null);
				}
			}
		}
		return "redirect:/subject/detailSubjectList.do?seq=" + seq;
	}
	
	/** 기각기능
	 * 별로 복잡할 것 없다. 여기서도 현재 진행중인 결재를 doingApproval메소드롤 통해 가져온다.
	 * 결재에서 결재,기각,회수 등에 타겟은 아무 행위도 일어나 있지 않은 결재를 대상으로한다.(app_state가 0인)
	 * 타겟 이전의 결재들은 이미 모두 결재나 접수 등 행위가 일어난 상태이기 때문에 신경쓰지 않아도 된다.
	 * 1.과제등록서 혹은 완료보고서 기각시에는 해당 결재 기각 뿐만 아니라 해당 결재선 전체를 기각한다(is_complete를 2로)
	 * 2.단게 기각시에는 해당 결재만 기각처리한다.
	 * @param request
	 * @param comment
	 * @param user
	 * @param app_type
	 * @param seq
	 * @return
	 */
	@RequestMapping(value ="/disapprovalSubject.do", method = RequestMethod.POST)
	@Transactional
	public String disappSubject(HttpServletRequest request,
			@RequestParam(required=false) String comment,User user,
			@RequestParam(required=true) String app_type,
			@RequestParam(required=true) Integer seq){
		/*내 결제정보(진행중인 정보)*/
		ApprovalVO myapp = approvalService.doingApproval(user.getSn(),seq,app_type);
			
		if(myapp !=null){
			Integer my_app_order = myapp.getApp_order();
			Integer app_id = myapp.getApp_id();
					
			if(app_type.equals("S") || app_type.equals("E")){
				/*is_complete 2은 approval 테이블에서 기각 의미*/
				approvalService.updateApproval(ApprovalUtil.gigak_stae,app_id,null);
				/*app_state 2는 기각 의미*/
				approvalService.updateState(ApprovalUtil.gigak_stae,myapp.getApp_seq(),comment);
			}
			else if(app_type.equals(ApprovalUtil.step_type)){
				/*app_state 2는 기각 의미*/
				approvalService.updateState(ApprovalUtil.gigak_stae,myapp.getApp_seq(),comment);
			}
		}
		return "redirect:/subject/detailSubjectList.do?seq=" + seq;
	}
	/**회수기능
	 * @param request
	 * @param user
	 * @param seq
	 * @return
	 */
	@RequestMapping(value ="/returnSubject.do", method = RequestMethod.POST)
	@Transactional
	public String returnSubject(HttpServletRequest request,
			User user,	@RequestParam(required=true) Integer seq
			){
				
		/*내 결제정보(진행중인 정보)*/
		List<ApprovalVO> myappList=approvalService.getApprovalList(null,seq,null,ApprovalUtil.doing_state,null);
		
		/*과제코드*/
		List<Integer> sub_codes = user.getSubject_code();
		boolean is_mysubject = sub_codes.contains(seq);
		
		/*내 과제일때만 회수가능*/ 
		if(myappList.size() >0 && is_mysubject){
			String app_type = myappList.get(0).getApp_type();
			/*과제 완료보고서 회수일때 현재 결재중인 모든 것을 회수상태로 바꾼다.
			approval 테이블의 is_complete의 상태도 회수로 바꿔줌*/
			if((app_type.equals(ApprovalUtil.report_type) ||app_type.equals(ApprovalUtil.end_report_type))
					/*자기 부대내에서만 회수 가능하도록*/
					&& approvalService.withdrawalValidate(seq).equals("Y")){
				for(int i=0; i<myappList.size();i++){
				ApprovalVO myapp=myappList.get(i);
					approvalService.updateState(ApprovalUtil.withdrawal_state,myapp.getApp_seq(),null);
				}
				Integer app_id = myappList.get(0).getApp_id();
				approvalService.updateApproval(ApprovalUtil.withdrawal_state,app_id,null);
			}
			/*단계회수일시 단계 결재선중 현재 결재대기중인것을 찾아서 회수상태로 바꿈*/
			else if(app_type.equals(ApprovalUtil.step_type)){
				for(int i=0; i<myappList.size();i++){
					ApprovalVO myapp=myappList.get(i);
						if(myapp.getApp_state().equals(ApprovalUtil.doing_state))
							approvalService.updateState(ApprovalUtil.withdrawal_state,myapp.getApp_seq(),null);
				}
			}
		}

		/*회수로 되어있는 결재선들 삭제*/
		approvalService.deleteApproval_line(ApprovalUtil.withdrawal_state,null);
		approvalService.deleteApproval(ApprovalUtil.withdrawal_state,null);
		return "redirect:/subject/detailSubjectList.do?seq=" + seq;
	}
	
	/*결재현황 보여주는 페이지*/
	@RequestMapping("/popup/approvalProcessing.do")
	public void processing(User user,Model model,@RequestParam Integer seq){
		List<ApprovalVO> subject_app =approvalService.getMyApproval(ApprovalUtil.report_type, seq);
		List<ApprovalVO> step_app = approvalService.getMyApproval(ApprovalUtil.step_type, seq);
		List<ApprovalVO> end_app = approvalService.getMyApproval(ApprovalUtil.end_report_type, seq);
		if(subject_app !=null){
			approvalService.addAppRight(subject_app);
			
			model.addAttribute("s_app_id", approvalService.getAppidToProcessPage(seq,ApprovalUtil.report_type));
			model.addAttribute("subject_app", subject_app);
			model.addAttribute("subject_app_size", subject_app.size());
		}
		if(step_app !=null){
			approvalService.addAppRight(step_app);
			
			model.addAttribute("app_seq_map", approvalService.getAppseqToProcessPage(seq));
			model.addAttribute("step_app", step_app);
			model.addAttribute("step_app_size", step_app.size());
		}
		if (end_app != null) {
			approvalService.addAppRight(end_app);
			 
			model.addAttribute("end_app_id", approvalService.getAppidToProcessPage(seq,ApprovalUtil.end_report_type));
			model.addAttribute("end_app", end_app); 
			model.addAttribute("end_app_size", end_app.size());
		}
	}
	/*벨트결재*/
	@RequestMapping(value="/approvalBelt.do",method = RequestMethod.GET)
	public ModelAndView approvalBelt(
			@RequestParam(value="code", required=true) String str){
		ModelAndView model = new ModelAndView();
		model.setViewName("/approval_line/approvalBelt");
		beltService.updateBeltState(str);
		approvalService.updateBeltApproval(str);
		return new ModelAndView(new RedirectView("approvalMain.do"));
	}
	/*벨트회수*/
	@RequestMapping(value="/withdrawalBelt.do",method = RequestMethod.GET)
	public ModelAndView withdrawalBelt(User user,
			@RequestParam(value="code", required=true) String str,
			@RequestParam(value="ppl", required=true) String ppl,
			@ModelAttribute(value = "beltVO") BeltVO beltVO){
	//	ModelAndView model = new ModelAndView();
	//	model.setViewName("/approval_line/approvalBelt");
		ModelAndView model = new ModelAndView("belt/detail");
		approvalService.deleteBeltApproval(str);
		//approvalService.updateBeltdisApproval(str);	
		model.addObject("user",user);
		
		return new ModelAndView(new RedirectView("/L6S/belt/detail.do?num="+ppl));
	}
	/*벨트기각*/
	@RequestMapping(value="/rejectionBelt.do",method = RequestMethod.POST)
	public ModelAndView disapprovalBelt(/*@RequestParam(required=false, value="comment") String comment,
										@RequestParam(required=true, value="code") Integer code,*/
										@ModelAttribute(value = "appVO") ApprovalBeltVO approvalBeltVO){
		ModelAndView model = new ModelAndView();
		model.setViewName("/approval_line/approvalBelt");
		
//		System.out.println("***** DEBUG ***** comment: " + comment);
		//System.out.println("***** DEBUG ***** seq: " + seq);
//		System.out.println("***** DEBUG ***** approvalService is null: " + approvalService == null);
		
		//approvalService.deleteBeltApproval(str);
//		approvalService.updateBeltdisApproval(code);
		//System.out.println("☆★☆★☆ comment : "+approvalBeltVO);
		approvalService.updateBeltdisApproval(approvalBeltVO);
		return new ModelAndView(new RedirectView("approvalMain.do"));
	}
}
