package mil.af.L6S.component.approvalLine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mil.af.L6S.component.belt.ContentsVO;
import mil.af.L6S.util.Pagination;
import mil.af.common.util.ApprovalUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 공군 상병 함준혁
 *
 */
@Service
public class ApprovalService {

	@Autowired
	ApprovalDao approvalDao;
	public List<ApprovalMemberVO> getLineList(String sosokcode) {
		return approvalDao.getLineList(sosokcode);
	}
	public void insertApproval(ApprovalVO approvalVO){
		approvalDao.insertApproval(approvalVO);
	}
	public void insertApproval(Integer app_id, Integer seq, Integer is_complete,String app_type){
		ApprovalVO app = new ApprovalVO();
		app.setApp_id(app_id);
		app.setSubject_code(seq);
		app.setIs_complete(is_complete);
		app.setApp_type(app_type);
		approvalDao.insertApproval(app);
	}
	public void insertApprovalLine(ApprovalVO approvalVO){
		approvalDao.insertApprovalLine(approvalVO);
	}
	public Integer getApprovalSeq(){
		return approvalDao.getApprovalSeq();
	}
	public Integer getApprovalLineSeq(){
		return approvalDao.getApprovalLineSeq();
	}
	/**
	 * 상세 결재정보 넣을때 app_id 가져오기 위해 사용
	 * @param app_id
	 * @param subject_code
	 * @param is_complete
	 * @param app_type
	 * @return
	 */
	public List<ApprovalVO> getApprovalTableList(Integer app_id,Integer subject_code, Integer is_complete,String app_type){
		ApprovalVO app = new ApprovalVO();
		app.setApp_id(app_id);
		app.setSubject_code(subject_code);
		app.setIs_complete(is_complete);
		app.setApp_type(app_type);
		return approvalDao.getApprovalTableList(app);
	}
	/*페이지네이션 가져오기*/
	public List<ApprovalVO> getApprovalListAndPage(ApprovalVO approvalVO){
		Pagination pagination = approvalVO.getPagination();
		int cnt = approvalDao.getListCount(approvalVO); 
		pagination.setNumItems(cnt);
		List<ApprovalVO> app = approvalDao.getApprovalList(approvalVO);
		if(app.size()>0)
			return app;
		else return null;
	}
	/*파라미터만 다르고 기능은 동일*/
	public List<ApprovalVO> getApprovalList(String sn){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		return approvalDao.getApprovalList(app);
	}
	/*파라미터만 다르고 기능은 동일*/
	public List<ApprovalVO> getApprovalList(ApprovalVO app){
		return approvalDao.getApprovalList(app);
	}
	public List<ApprovalVO> getApprovalList(Integer subject_code){
		ApprovalVO app = new ApprovalVO();
		app.setSubject_code(subject_code);
		return approvalDao.getApprovalList(app);
	}
	public List<ApprovalVO> getApprovalList(String sn, Integer subject_code){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		app.setSubject_code(subject_code);
		return approvalDao.getApprovalList(app);
	}
	public List<ApprovalVO> getApprovalList(String sn, Integer subject_code,Integer app_state){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		app.setSubject_code(subject_code);
		app.setApp_state(app_state);
		return approvalDao.getApprovalList(app);
	}
	/**결재나 접수권한 판별할때 사용
	 * @param sn
	 * @param subject_code
	 * @param app_state
	 * @param is_complete
	 * @return
	 */
	public List<ApprovalVO> getApprovalList(String sn, Integer subject_code,Integer app_state,Integer is_complete){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		app.setSubject_code(subject_code);
		app.setApp_state(app_state);
		app.setIs_complete(is_complete);
		return approvalDao.getApprovalList(app);
	}
	
	public List<ApprovalVO> getApprovalList(String sn, Integer subject_code,Integer app_state,Integer is_complete,Integer app_id){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		app.setSubject_code(subject_code);
		app.setApp_state(app_state);
		app.setIs_complete(is_complete);
		app.setApp_id(app_id);
		return approvalDao.getApprovalList(app);
	}
	/**
	 * @param sn
	 * @param subject_code
	 * @param app_state
	 * @param is_complete
	 * @param app_id
	 * @param app_type
	 * @return
	 */
	public List<ApprovalVO> getApprovalList(String sn, Integer subject_code,Integer app_state,Integer is_complete,Integer app_id,String app_type){
		ApprovalVO app = new ApprovalVO();
		app.setApp_sn(sn);
		app.setSubject_code(subject_code);
		app.setApp_state(app_state);
		app.setIs_complete(is_complete);
		app.setApp_id(app_id);
		app.setApp_type(app_type);
		return approvalDao.getApprovalList(app);
	}
	/**app_state와 app_seq 필요
	 * @param app
	 */
	public void updateState(Integer app_state,Integer app_seq,String comment){
		ApprovalVO app = new ApprovalVO();
		app.setApp_state(app_state);
		app.setApp_seq(app_seq);
		app.setApp_comment(comment);
		approvalDao.updateState(app);
	}
	
	/**4단계만 거치는지 전부 거치는지 군수사 단계 뛰어넘는지 리턴
	 * myapp에 소속코드와 과제구분 들어있어야함
	 * @return
	 */
	public String approvalType(ApprovalVO myapp,String sosok){
		String s_section=myapp.getSubject_section();
		String sosokcode = sosok.substring(0, 4);
		if(s_section.equals("GB") || s_section.equals("SSS")){
			/*1.부서장 2.군수담당3.군수과장/처장*/
			return "a";
		}
		else if(sosokcode.equals("A500")||
				sosokcode.equals("D300")||
				sosokcode.equals("D910")||
				sosokcode.equals("D800")||
				sosokcode.equals("D200")||
				sosokcode.equals("D400")||
				sosokcode.equals("DA00")){
			/*1.부서장 2.군수담당3.군수과장/처장4.군수사 군수담당
			  5.군수사 군수과장/처장6.공본 담당자7.공본 과장/처장*/
			return "b";
		}
		else{
			/*1.부서장 2.군수담당3.군수과장/처장
			  6.공본 담당자7.공본 과장/처장*/
			return "c";
		}	
	}
	/**소속코드로 부대관리자 가져옴
	 * 주로 본인 부대관리자 찾을때 사용
	 * @param sosokcode
	 * @return
	 */
	public List<ApprovalVO> getBaseAdmin(String sosokcode){
		int length = sosokcode.length();
		ApprovalVO app=new ApprovalVO();
		if(length>=6){
			String sosok =sosokcode.substring(0, 6);
			if(sosok.equals("A500J0") || sosok.equals("A500I0") ||
					sosok.equals("A500G0") || sosok.equals("A500H0")){
				app.setSosokcode(sosok);
			}
			else
				app.setSosokcode(sosokcode.substring(0, 4));
		}
		else
			app.setSosokcode(sosokcode.substring(0, 4));
		return approvalDao.getBaseAdmin(app);
	}
	/**소속코드와 baseAuth로 부대관리자 가져옴
	 * 군수사 군수담당,공본담당자 가져올시 사용
	 * @param sosokcode
	 * @param baseAuth
	 * @return
	 */
	public List<ApprovalVO> getBaseAdmin(String sosokcode,String baseAuth){
		ApprovalVO app=new ApprovalVO();
		app.setSosokcode(sosokcode.substring(0, 4));
		/*이거 하나에 변수 하나 더 만들기 싫어서 app_comment에 넣어서 파라미터 전송*/
		app.setApp_comment(baseAuth);
		return approvalDao.getBaseAdmin(app);
	}
	
	/**order은 결제 순서, state는 결재진행상황 0:대기 1:결재 2:기각
	 * approvalVO는 계급 이름 군번 직책만 들어있으면 됨
	 * @param approvalVO
	 * @param seq
	 * @param order
	 * @param state
	 */
	public void registerApp(ApprovalVO approvalVO,Integer seq,Integer order,Integer state,Integer app_id){
		Integer app_seq = getApprovalLineSeq();
		
		approvalVO.setApp_id(app_id);
		approvalVO.setApp_seq(app_seq);
		approvalVO.setApp_order(order);
		approvalVO.setApp_state(state);
						
		insertApprovalLine(approvalVO);
	}
	/**결재라인이 모두 결재가 완료되었을시 사용
	 * is_complete 바꿀때 사용
	 * 기각되었을때도 사용
	 * @param is_complete
	 * @param app_id
	 */
	public void updateApproval(Integer is_complete, Integer app_id,String app_type){
		ApprovalVO app = new ApprovalVO();
		app.setIs_complete(is_complete);
		app.setApp_id(app_id);
		app.setApp_type(app_type);
		approvalDao.updateApproval(app);
	}
	/**1.부서장 2.군수담당3.군수과장/처장순으로 결재
	 * 일단 결재자 한명씩 지정학끔 추후 수정예정
	 * @param my_app_order
	 * @param approvalList 부대관리자
	 * @param seq 
	 * @param app_id 
	 * @param subjectApp 
	 */
	public void approvalLineA(Integer my_app_order, List<ApprovalVO> approvalList, Integer seq, Integer app_id){
		/*부대담당자 없음 실행안됨*/
		if(approvalList.size()>0){	
			if(my_app_order.equals(1)){
				/*app_order 2이고 state 1인 결재선 추가*/
				registerApp(approvalList.get(0),seq,ApprovalUtil.subject_two,ApprovalUtil.doing_state,app_id);
			}
			if(my_app_order.equals(3)){
				updateApproval(ApprovalUtil.done_state,app_id,null);
				/*단계 결재 approval 입력*/
			
			}
		}
	}
	/**1.부서장 2.군수담당3.군수과장/처장4.군수사 군수담당
			  5.군수사 군수과장/처장6.공본 담당자7.공본 과장/처장 순으로 결재
	  %전제: 부대관리자는 각 부대별 하나이다.%
	 * @param my_app_order
	 * @param approvalList
	 * @param seq 
	 * @param app_id 
	 * @param subjectApp 
	 */
	public void approvalLineB(Integer my_app_order, List<ApprovalVO> approvalList, Integer seq, Integer app_id){
		/*공본 담당자를 가져온다*/
		List<ApprovalVO> aAdmin=getBaseAdmin("A100","A");
		/*군수사 담당자를 가져온다*/
		List<ApprovalVO> bAdmin=getBaseAdmin("A500","B");
		if(approvalList.size()>0){	
			if(my_app_order.equals(1)){
				/*app_order 4이고 state 1인 결재선 추가 
				 * 군수사 소속일때 군수담당자 등록*/
				if(bAdmin.size()>0){
					if(approvalList.get(0).getApp_sn().equals(bAdmin.get(0).getApp_sn())){
						registerApp(bAdmin.get(0),seq,ApprovalUtil.subject_four,ApprovalUtil.doing_state,app_id);
					}
					/*군수사 예하일때
					 * approvalList가 예하 부대담당자 가져옴*/
					else 
						registerApp(approvalList.get(0),seq,ApprovalUtil.subject_two,ApprovalUtil.doing_state,app_id);
				}
				/*군수사 예하일때
				 * approvalList가 예하 부대담당자 가져옴*/
				else 
					registerApp(approvalList.get(0),seq,ApprovalUtil.subject_two,ApprovalUtil.doing_state,app_id);
			}
			/*app_order 4이고 state 1인 결재선 추가
			 * 군수 담당자 등록*/
			else if(my_app_order.equals(3) && bAdmin.size()>0){
				ApprovalVO b=bAdmin.get(0);
				registerApp(b,seq,ApprovalUtil.subject_four,ApprovalUtil.doing_state,app_id);
			}
			/*app_order 6이고 state 0인 결재선 추가(6단계에선 결재기능도 있기에 state 0 넣어야함)
			 * state가 0이어야 결재 할수 있는 권한 생김
			 * 공본 담당자 등록*/
			else if(my_app_order.equals(5) && aAdmin.size()>0){
				ApprovalVO a=aAdmin.get(0);
				registerApp(a,seq,ApprovalUtil.subject_six,ApprovalUtil.doing_state,app_id);
			}
			else if(my_app_order.equals(7)){
				/*과제보고서 결재가 완료되었으면 2입력(2는 완료보고서 완료 의미)*/
				updateApproval(ApprovalUtil.done_state,app_id,null);
				
			
			}
		}
		
	}
	/**1.부서장 2.군수담당3.군수과장/처장
			  6.공본 담당자7.공본 과장/처장 순으로 결재
			  각 단계별로 쉽게 알기위해 코드 간소화 하지 않음
	 * @param my_app_order
	 * @param approvalList
	 * @param seq 
	 * @param app_id 
	 * @param subjectApp 
	 */
	public void approvalLineC(Integer my_app_order, List<ApprovalVO> approvalList, Integer seq, Integer app_id){
		/*공본 담당자를 가져온다*/
		List<ApprovalVO> aAdmin=getBaseAdmin("A100","A");
		if(approvalList.size()>0){	
			if(my_app_order.equals(1)){
				/*app_order 2이고 state 1인 결재선 추가*/
				if(aAdmin.size()>0){
					/*공본 소속일때*/
					if(approvalList.get(0).getApp_sn().equals(aAdmin.get(0).getApp_sn())){
						registerApp(approvalList.get(0),seq,ApprovalUtil.subject_six,ApprovalUtil.doing_state,app_id);
					}
					/*공본 예하일때*/
					else
						registerApp(approvalList.get(0),seq,ApprovalUtil.subject_two,ApprovalUtil.doing_state,app_id);
				}
				/*공본 예하일때*/
				else
					registerApp(approvalList.get(0),seq,ApprovalUtil.subject_two,ApprovalUtil.doing_state,app_id);
			}
			else if(my_app_order.equals(3)){
				/*app_order 6이고 state 0인 결재선 추가(6단계에선 결재기능도 있기에 state 0 넣어야함)
				 * state가 0이어야 결재 할수 있는 권한 생김
				 * 공본 담당자 등록*/
				if(aAdmin.size()>0){
					registerApp(aAdmin.get(0),seq,ApprovalUtil.subject_six,ApprovalUtil.doing_state,app_id);
				}
			}
			else if(my_app_order.equals(7)){
				updateApproval(ApprovalUtil.done_state,app_id,null);
				
			}
		}
	}
	/**다음단계 접수 되었는지 여부 가져옴
	 * 단, 결재가 완료되지 않은 과제만 
	 * %전제 : 완료가 된 결제는 모든 state가 1이며 과제등록서 결재가 끝난 후에야 완료보고서 결제가 이루어질수 있다.%
	 * @param seq
	 * @return
	 */
	public boolean haveRegistered(Integer seq){
		/*접수 했나 안했나여부(미완결 결재에서 결재대기인 것이 있으고 app_order이 1,2,4,6이 아니면 접수 한것임*/
		List<ApprovalVO> prepareHandin=getApprovalList(null,seq,0,0);
		
		if(prepareHandin.size()>0){
			for(int i=0;i<prepareHandin.size();i++){
				ApprovalVO ap = prepareHandin.get(i);
				if(!(ap.getApp_order().equals(1)||ap.getApp_order().equals(2)||ap.getApp_order().equals(4)||ap.getApp_order().equals(6))){
					return true;
				}
			}
		}
		return false;
	}
	public boolean haveFirstOneRegistered(Integer seq,Integer is_complete){
		/*접수 했나 안했나여부(미완결 결재에서 결재대기인 것이 있으고 app_order이 1,2,4,6이 아니면 접수 한것임*/
		/*전제: seq는 같고 app_id가 다르면 두 결재선은 is_complete가 0이 될 수 없다*/
		List<ApprovalVO> prepareHandin=getApprovalList(null,seq,null,0);
		
		if(prepareHandin.size()>0)
			return true;
		return false;
	}
	
	public void deleteApproval_line(Integer state, Integer seq){
		ApprovalVO app = new ApprovalVO();
		if(state == ApprovalUtil.gigak_stae){
			app.setApp_state(ApprovalUtil.gigak_stae);
			app.setSubject_code(seq);
			approvalDao.deleteApproval_line(app);
		}
		else if(state == ApprovalUtil.withdrawal_state){
			app.setApp_state(ApprovalUtil.withdrawal_state);
			approvalDao.deleteApproval_line(app);
		}
	}
	public void deleteApproval(Integer state, Integer seq){
		ApprovalVO app = new ApprovalVO();
		if(state == ApprovalUtil.gigak_stae){
			app.setIs_complete(ApprovalUtil.gigak_stae);
			app.setSubject_code(seq);
			List<ApprovalVO> gigakapp = getApprovalList(app);
			for(int i=0;i<gigakapp.size();i++){
				ApprovalVO myapp = gigakapp.get(i);
				updateState(ApprovalUtil.gigak_stae,myapp.getApp_seq(),null);
			}
			deleteApproval_line(state, seq);
			approvalDao.deleteApproval(app);
		}
		else if(state == ApprovalUtil.withdrawal_state){
			app.setApp_state(ApprovalUtil.withdrawal_state);
			approvalDao.deleteApproval(app);
		}
	}
	public ApprovalVO getBBbyAdmin(Integer seq){
		ApprovalVO app = new ApprovalVO();
		app.setSubject_code(seq);
		/*한 과제당 BB는 하나이므로*/
		return approvalDao.getBBbyAdmin(app).get(0);
	}
	/**
	 * 소속코드로 지도위원(BB)를 가져옴
	 * @param sosokcode
	 * @return
	 */
	public List<ApprovalVO> getGuide_Committee(String sosokcode){
		ApprovalVO app = new ApprovalVO();
		app.setSosokcode(sosokcode);
		return approvalDao.getGuide_Committee(app);
	}
	/*기각 회수 승인 시 사용*/
	/**과제용
	 * 현재 진행중인 단계 정보
	 * @param app_sn
	 * @param seq
	 * @param app_type
	 * @return
	 */
	public ApprovalVO doingApproval(String app_sn,Integer seq,String app_type){
		Integer app_state = ApprovalUtil.doing_state;
		Integer is_complete = ApprovalUtil.doing_state;
		List<ApprovalVO> app = getApprovalList(app_sn, seq, app_state, is_complete, null, app_type);
		if(app.size()>0)
			return app.get(0);
		else{
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/**진행중인 단계 결재중 결재끝난 것들 가져옴
	 * @param seq
	 * @param app_type step으로만 들어갈듯
	 * @return
	 */
	public ApprovalVO doingStepApproval(Integer seq,String app_type){
		Integer app_state = ApprovalUtil.done_state;
		Integer is_complete = ApprovalUtil.doing_state;
		List<ApprovalVO> app = getApprovalList(null, seq, app_state, is_complete, null, app_type);
		if(app.size()>0)
			return app.get(app.size()-1);
		else{
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/**결재가 아직 진행중이고 접수대기상태인 리스트 가져옴
	 * @param app_sn
	 * @param seq
	 * @param app_type
	 * @return
	 */
	public ApprovalVO doingRegisteInSubject(String app_sn,Integer seq,String app_type){
		Integer app_state = ApprovalUtil.registering_state;
		Integer is_complete = ApprovalUtil.doing_state;
		List<ApprovalVO> app = getApprovalList(app_sn, seq, app_state, is_complete, null, app_type);
		if(app.size()>0)
			return app.get(0);
		else{
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	public Integer getDoingAppId(Integer seq,String app_type){
		Integer is_complete = ApprovalUtil.doing_state;
		List<ApprovalVO> app =getApprovalTableList(null, seq, is_complete, app_type);
		if(app.size()>0)
			return app.get(0).getApp_id();
		else{
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	
	/*자기 결재목록 가져옴*/
	/**
	 * @param app_sn
	 * @param app_type
	 * @return
	 */
	public List<ApprovalVO> getMyApproval(String app_sn,String app_type){
		List<ApprovalVO> app = getApprovalList(app_sn, null, null, null, null, app_type);
		if(app.size()>0)
			return app;
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/*해당 과제의 자기 결재 가져옴*/
	/**
	 * @param app_sn
	 * @param app_type
	 * @param seq
	 * @return
	 */
	public List<ApprovalVO> getMyApproval(String app_sn,String app_type,Integer seq){
		List<ApprovalVO> app = getApprovalList(app_sn, seq, null, null, null, app_type);
		if(app.size()>0)
			return app;
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/*결재자 권한 부여*/
	public ApprovalVO getMyApprovalInGrant(String app_sn,String app_type,Integer seq){
		List<ApprovalVO> app = getApprovalList(app_sn, seq, ApprovalUtil.doing_state, ApprovalUtil.doing_state, null, app_type);
		List<ApprovalVO> app_regi = getApprovalList(app_sn, seq, ApprovalUtil.registering_state, ApprovalUtil.doing_state, null, app_type);
		if(app.size()>0)
			return app.get(0);
		else if(app_regi.size()>0)
			return app_regi.get(0);
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	
	/**
	 * 결재자 권한 넣어주기
	 * @param app_sn
	 * @param app_type
	 * @param seq
	 * @return
	 */
	public ApprovalVO grantRight(String app_sn,String app_type,Integer seq){
		List<ApprovalVO> alist = new ArrayList<ApprovalVO>();
		ApprovalVO app =getMyApprovalInGrant(app_sn, app_type, seq);
		if(app!=null){
			alist.add(app);
			addAppRight(alist);
		}
		return app;
	}
	/**결재수신현황에서 사용
	 * @param app_type
	 * @param seq
	 * @return
	 */
	public List<ApprovalVO> getMyApproval(String app_type,Integer seq){
		List<ApprovalVO> app = getApprovalList(null, seq, null, null, null, app_type);
		if(app.size()>0)
			return app;
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/**단계 결재 끝났나 알려줄때 사용
	 * @param app_type
	 * @param seq
	 * @return
	 */
	public List<ApprovalVO> getMyApprovalFinishStep(String app_type,Integer seq){
		List<ApprovalVO> app = getApprovalList(null, seq, null, ApprovalUtil.done_state, null, app_type);
		if(app.size()>0)
			return app;
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/** 단계 유효성에 사용
	 * @param app_type
	 * @param seq
	 * @return
	 */
	public List<ApprovalVO> getMyApprovalInValidate(String app_type,Integer seq){
		List<ApprovalVO> app = getApprovalList(null, seq, ApprovalUtil.done_state, null, null, app_type);
		if(app.size()>0)
			return app;
		else {
			System.out.println("데이터가 없습니다.");
			return null;
		}
	}
	/*자기 결재목록에 권한 결재상태등 등록*/
	/**app_right에 권한을 넣어서 set시킨다.
	 * is_complete 결재가 모두 종료되고 완료되었는지 여부
	 * is_approval 결재 대기상태인지로 결재 권한 있는지 여부
	 * is_handin 접수대기상태일때 접수 가능하다는 권한
	 * haveHanded 접수가 완료되고 접수가 끝났다는것을 의미
	 * approvalState 결재상태를 나타내준다.
	 * @param myApp
	 */
	public void addAppRight(List<ApprovalVO> myApp){
		Integer doing_state = ApprovalUtil.doing_state;
		Integer done_state = ApprovalUtil.done_state;
		Integer gigak_stae = ApprovalUtil.gigak_stae;
		Integer withdrawal_state= ApprovalUtil.withdrawal_state;
/*
		Integer registering_state= ApprovalUtil.registering_state;
		Integer registered_state= ApprovalUtil.registered_state;
		*/
		for(int i=0; i<myApp.size();i++){
			Map<String,String> right = new HashMap<String,String>();
			ApprovalVO app= myApp.get(i);
			if(app.getIs_complete().equals(done_state)){
				right.put("is_complete", "Y");
			}
			if(app.getApp_state().equals(done_state)){
				right.put("approvalState", ApprovalUtil.done);
			}
			if(app.getApp_state().equals(doing_state)){
				right.put("is_approval", "Y");
				right.put("approvalState", ApprovalUtil.doing);
			}
			/*if(app.getApp_state().equals(registering_state)){
				right.put("is_handin", "Y");
				right.put("approvalState", ApprovalUtil.registering);
				
			}
			if(app.getApp_state().equals(registered_state)){
				right.put("haveHanded", "Y");
				right.put("approvalState", ApprovalUtil.registered);
			}*/
			if(app.getApp_state().equals(gigak_stae)){
				right.put("approvalState", ApprovalUtil.gigak);
			}
			if(app.getApp_state().equals(withdrawal_state)){
				right.put("approvalState", ApprovalUtil.withdrawal);
			}
		app.setApp_right(right);
		}
	}
	/**과제보고서에서 과제가 결재타고 있는지 여부 가려서 버튼 나올지 안나올지 정해줌
	 * 단계에서 접수버튼 뜰지 말지 결정
	 * @param seq
	 * @param app_type
	 * @return
	 */
	public String isRegistered(Integer seq, String app_type){
		List<ApprovalVO> app=getApprovalTableList(null, seq, ApprovalUtil.doing_state, app_type);
		List<ApprovalVO> app_done=getApprovalTableList(null, seq, ApprovalUtil.done_state, app_type);
		List<ApprovalVO> app_step_doing=getApprovalList(null, seq, ApprovalUtil.doing_state, ApprovalUtil.doing_state, null,ApprovalUtil.step_type);
		int end_report =getApprovalList(null, seq, null, ApprovalUtil.done_state, null,ApprovalUtil.report_type).size();
		/*과제일때*/
		if(app.size()>0 && (app_type.equals(ApprovalUtil.report_type) || app_type.equals(ApprovalUtil.end_report_type)))
			return "Y";
		else if(app_done.size()>0 && (app_type.equals(ApprovalUtil.report_type) || app_type.equals(ApprovalUtil.end_report_type)))
			return "Y";
		/*단계일때*/
		else if(app_done.size()>0 && app_type.equals(ApprovalUtil.step_type)){
			return "Y";
		}
		else if(app_step_doing.size()>0 && app_type.equals(ApprovalUtil.step_type)){
			return "Y";
		}
		else if(app_type.equals(ApprovalUtil.step_type) && end_report == 0)
			return "Y";
		else return "N";
	}
	/**
	 * 과제등록서 결재 끝났나 여부
	 * @param seq
	 * @return
	 */
	public String isFinishedReport_typeApp(Integer seq){
		List<ApprovalVO> app_done=getApprovalTableList(null, seq, ApprovalUtil.done_state, ApprovalUtil.report_type);
		int size = app_done.size();
		if(size >0){
			return "Y";
		}
		else
			return "N";
	}
	public String stepApprovalCount(Integer seq){
		List<ApprovalVO> app_doing = getApprovalList(null, seq, ApprovalUtil.done_state, ApprovalUtil.doing_state, null, ApprovalUtil.step_type);
		List<ApprovalVO> app_done = getApprovalList(null, seq, ApprovalUtil.done_state, ApprovalUtil.done_state, null, ApprovalUtil.step_type);
		int done_size = app_doing.size();
		if(app_done.size()>0)
			return "Y";
		else if(app_doing.size()>0){
			return done_size+"";
		}
		else return "N";
	}
	
	/**과제회수 부대내에서만 하도록 결과값 리턴
	 * @param seq
	 * @return
	 */
	public String withdrawalValidate(Integer seq){
		List<ApprovalVO> app_subject_done=getApprovalList(null, seq, ApprovalUtil.done_state, ApprovalUtil.doing_state, null,ApprovalUtil.report_type);
		List<ApprovalVO> app_end_done=getApprovalList(null, seq, ApprovalUtil.done_state, ApprovalUtil.doing_state, null,ApprovalUtil.end_report_type);
		int sub_size=app_subject_done.size();
		int end_size=app_end_done.size();
		if(end_size >= 3)
			return "N";
		else if(sub_size >= 3)
			return "N";
		else
			return "Y";
	}
	/**
	 *  벨트 결재 등록
	 *  
	 * @param code(file_seq)
	 */
	public void Belt_RegisterAPP(ContentsVO contentsVO) {
		approvalDao.Belt_RegisterAPP(contentsVO);
	}
	public String getApp_state(int state) {
		return approvalDao.getApp_state(state);
	}
	public List<String> getBeltSeq(String sn) {
		return approvalDao.getBeltSeq(sn);
	}
	public List<ApprovalBeltVO> getBelt_app(String sn) {
		List<ApprovalBeltVO> appBelt = approvalDao.getBelt_app(sn);
		for(ApprovalBeltVO VO : appBelt){
			VO.setApp_str(VO.getApp_state());
			VO.setBeltstr(VO.getBeltstate());
		}
		return appBelt;
	}
	/**
	 * 벨트 결재상태 업데이트
	 * @param str
	 */
	public void deleteBeltApproval(String str) {
	approvalDao.deleteBeltApproval(str);
	}
	public void updateBeltApproval(String str) {
		approvalDao.updateBeltApproval(str);
		
	}
	public void insertBeltApproval(int fileseq){
		approvalDao.insertBeltApproval(fileseq);
	}
	public void updateBeltdisApproval(ApprovalBeltVO approvalBeltVO) {
		approvalDao.updateBeltdisApproval(approvalBeltVO);
		
	}
	public String checkisexist(int fileseq) {
		return approvalDao.checkisexist(fileseq);
		
	}
	public void updaterejectedBelt(int fileseq) {
		approvalDao.updaterejectedBelt(fileseq);
		
	}
	public int getFileSeq() {
		// TODO Auto-generated method stub
		return approvalDao.getFileSeq();
	}
	public String getComment(int fileseq){
		return approvalDao.getComment(fileseq);
	}
	/**seq,type으로 가장 최근 app_id 가져옴
	 * @param app
	 * @return
	 */
	public Integer getAppidToProcessPage(Integer seq, String app_type){
		ApprovalVO app = new ApprovalVO();
		app.setSubject_code(seq);
		app.setApp_type(app_type);
		List<Integer> app_id=approvalDao.getAppidToProcessPage(app);
		if(app_id.size()>0)
			return app_id.get(0);
		else return null;
	}
	/**단계 최신 것만 출력하기 위해 사용
	 * @param seq
	 * @return
	 */
	public Map<String,Integer> getAppseqToProcessPage(Integer seq){
		Map<String,Integer> app_seq_map = new HashMap<String,Integer>();
		
		List<String> key = new ArrayList<String>();
		key.add("one");key.add("two");key.add("three");key.add("four");key.add("five");
		
		ApprovalVO app = new ApprovalVO();
		app.setSubject_code(seq);
		for(int i=ApprovalUtil.step_d;i<16;i++){
			app.setApp_order(i);
			app_seq_map.put(key.get(i-11), approvalDao.getAppseqToProcessPage(app));
		}
		return app_seq_map;
	}
	/**세션에 넣어놓을 나의 결재관련 정보
	 * @param sn
	 * @return
	 */
	public Map<String, String> getMyAppInfo(String sn){
		Map<String, String> myAppInfo = new HashMap<String, String>();
		List<ApprovalVO> waitingApp = getApprovalList(sn, null, ApprovalUtil.doing_state);
		
		ApprovalVO app = new ApprovalVO();
		app.setLeader(sn);app.setApp_state(ApprovalUtil.gigak_stae);
		List<ApprovalVO> gigakApp = getApprovalList(app);
		
		myAppInfo.put("waitingCount", ""+0);
		myAppInfo.put("gigakCount", ""+0);
		if(waitingApp.size()>0)
			myAppInfo.put("waitingCount", ""+waitingApp.size());
		if(gigakApp.size()>0)
			myAppInfo.put("gigakCount", ""+gigakApp.size());
		return myAppInfo;
	}
}
