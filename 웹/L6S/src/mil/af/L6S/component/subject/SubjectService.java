package mil.af.L6S.component.subject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.approvalLine.ApprovalService;
import mil.af.L6S.component.approvalLine.ApprovalVO;
import mil.af.L6S.component.common.User;
import mil.af.L6S.component.endsubject.AfterSubjectVO;
import mil.af.L6S.util.Pagination;
import mil.af.common.util.ApprovalUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

/**
 * @author 공군 상병 함준혁
 *
 */
@Service
public class SubjectService {
	private SubjectDao subjectDao;
	private ApprovalService approvalService;
	
	@Autowired
	void SubjectService(SubjectDao subjectDao,ApprovalService approvalService){
		this.subjectDao = subjectDao;
		this.approvalService = approvalService;
	}
	
	/**
	 * 팀원 등록 로직
	 * @param subjectVO
	 * @param users
	 */
	@Transactional
	public boolean insertUser(SubjectVO subjectVO,List<UserVO> users) {
		/*군번 같은 사용자 걸러줌*/
		int size=users.size();
		for(int i = 0 ; i< size; i++){
			UserVO u = users.get(i);
			for(int k=i+1 ; k< size; k++){
				UserVO us = users.get(k);
				if(u.getSn().equals(us.getSn())){
					System.out.println("군번이 같은 사용자가 입력됬습니다.");
					return false;
				}
			}
		}
		Integer subjectCode=subjectVO.getSubject_code();
		
		/*유저 테이블 초기화*/
		deleteAllUserInaUser(subjectCode);
		
		for(int i = 0 ; i< size; i++){
			users.get(i).setSubject_code(subjectCode);
			if(users.get(i).getSn() != null && !("".equals(users.get(i).getSn()))){
			subjectDao.insertUserWithSubject(users.get(i));
			}
		}
		return true;
	}
	/**과제등록
	 * @param subjectVO
	 */
	@Transactional
	public void insertSubject(SubjectVO subjectVO){
		subjectDao.insertSubject(subjectVO);
	}
	/**
	 * 과제수정 로직
	 * @param subjectVO
	 */
	@Transactional
	public void updateSubject(SubjectVO subjectVO){
		/*챔피언, 부서장, 지도위원 제외하고 수정*/
		subjectDao.updateSubject(subjectVO);
		SubjectVO sub =new SubjectVO();
		String champion = subjectVO.getChampion();
		String chair = subjectVO.getDepartment_chairman(); 
		String committee = subjectVO.getGuide_committee();
		
		sub.setSubject_code(subjectVO.getSubject_code());
		/*챔피언이 있을시 챔피언 수정*/
		if(champion != null && !("empty".equals(champion))){
			sub.setChampion(champion);
			subjectDao.updateSubjectChampion(sub);
		}
		/*부서장 있을시 부서장 수정*/
		if(chair != null && !("empty".equals(chair))){
			sub.setDepartment_chairman(chair);
			subjectDao.updateSubjectDepartment_chair(sub);
		}
		/*지도위원 있을시 지도위원 수정*/
		if(committee != null && !("empty".equals(committee))){
			sub.setGuide_committee(committee);
			subjectDao.updateSubjectGuide_committee(sub);
		}
	}
	/**
	 * Step 등록
	 * @param stepseq: 과제입력 위한 과제 코드
	 * @param seq: PK인 과제코드
	 * @param step: D,M,A,I,C,E중 하나
	 * @param filename : LSMS_STEP 테이블에 저장되는 파일명
	 */
	@Transactional
	public void insertStep(Integer stepseq,Integer seq, String step,String filename) {
		HashMap<String, Object> map =new HashMap<String, Object>();
		map.put("step_code", stepseq);
		map.put("subject_code", seq);
		map.put("step", step);
		map.put("filename", filename);
		subjectDao.insertStep(map);
	}
	/**과제데이터 입력
	 * @param subject_data : LSMS_DATA 테이블에 저장되기 위한 순서쌍이 리스트로 저장됨
	 * @param a_filename_list : 첨부파일 혹은 이미지 저장시 data에 들어갈 파일명 집단
	 * @param stepseq: 과제입력 위한 과제 코드
	 */
	@Transactional
	public void insertData(List<SubjectFormAndDataVO> subject_data,List<String> a_filename_list, Integer stepseq){
		int size=subject_data.size();
		Iterator<String> file_name_iterator=a_filename_list.iterator();
		for(int i=0; i<size; i++){
			SubjectFormAndDataVO s_data = subject_data.get(i);
			s_data.setStep_code(stepseq);
			
			SubjectFormAndDataVO real_data=checkFilename(s_data,file_name_iterator);
			subjectDao.insertDataWithStep(real_data);
		}
	}
	/** 적용툴 저장
	 * @param tool_form : tool-data의 form_id
	 * @param request : tool_data를 뽑아내기위함
	 * @param stepseq: 과제입력 위한 과제 코드
	 */
	@Transactional
	public void adjustTool(HttpServletRequest request, String tool_form ,Integer stepseq){
		/*적용툴 저장*/
		String tool_data=new String();
		String[] t_data = request.getParameterValues("tool_data");
		System.out.println("★☆★☆"+t_data);
//		실 데이터 수 = realCount
		int realCount=0;
		if(t_data != null){
			realCount = t_data.length;
			for(String data : t_data){
				if(data.equals("")){
					realCount -= 1;
				}
			}
				
			if(t_data !=null){
				for(int i=0;i<realCount;i++){
					if(i!=realCount-1)
						tool_data+=t_data[i]+", ";
					else if(i==realCount-1)
						tool_data+=t_data[i];
				}
				if(tool_data !=null && tool_form !=null && !("".equals(tool_form))){
					SubjectFormAndDataVO s = new SubjectFormAndDataVO();
					s.setData(tool_data);
					s.setForm_id(tool_form);
					s.setSubkey("0");
					s.setStep_code(stepseq);
					subjectDao.insertDataWithStep(s);
				}
			}
		}
	}
	/**
	 * form type이 FILE(첨부파일)인 것에 실제 파일명 저장
	 * FILE 타입이 D,M,A,I,C에 있는데 각 단계를 구별해주기 위해 전체 FILE타입을 가져와서 비교함
	 * @param s_data
	 * @param file_name
	 * @return
	 */
	public SubjectFormAndDataVO checkFilename(SubjectFormAndDataVO s_data,
			Iterator<String> file_name){
		
		/*d,m,a,i,c,e에서 타입에 해당하는 데이터 가져옴*/
		List<SubjectFormAndDataVO> b_image = getFormByType("BEFOREIMAGE");
		List<SubjectFormAndDataVO> a_image = getFormByType("AFTERIMAGE");
		List<SubjectFormAndDataVO> c_type = getFormByType("FILE");
		
		int b_size = b_image.size();
		int a_size = a_image.size();
		int t_size = c_type.size();
		/*개선전 개선후 이미지 입력시 DB에 저장될 내용 변환*/
		if(file_name.hasNext()){
			if(s_data.getForm_id().substring(0,1).equals("I")){
				for(int q=0;q<b_size;q++){
					if(s_data.getForm_id().equals(b_image.get(q).getForm_id())){
						s_data.setData(file_name.next());
						return s_data;
					}
				}
				for(int w=0;w<a_size;w++){
					if(s_data.getForm_id().equals(a_image.get(w).getForm_id())){
						s_data.setData(file_name.next());
						return s_data;
					}
				}
			}
			/*FILE 타입(d,m,a,i,c 총 5개임)수만큼 반복*/
			for(int k=0;k<t_size;k++){
				if(s_data.getForm_id().equals(c_type.get(k).getForm_id())){
					s_data.setData(file_name.next());
					return s_data;
				}
			}
		}
		return s_data;
					
	}
	/**view에서 행이 여럿인것(subkey가 1이상인 것들) 뿌려주기 편하게 묶어주는 함수
	 * 사용법 : 한 행으로 묶고싶은 form_id를 List<String> 객체에 넣어 파라미터로 전송만 하면됨
	 * 그럼 자동으로 List<List<SubjectFormAndDataVO>>객체로 리턴해줌
	 * @param data:getData함수로 가져온 객체
	 * @param form_code:한 행으로 묶고싶은 form_id들
	 * @return
	 */
	public List<List<SubjectFormAndDataVO>> changeDataToView(List<SubjectFormAndDataVO> data,List<String> form_code){
		/*행의 수만큼의 리스트가 저장될 객체*/
		List<List<SubjectFormAndDataVO>> li = new ArrayList<List<SubjectFormAndDataVO>>();
		
		/*1.행의 수만큼 List객체 생성하여 li에 넣어줌*/
		for(int k=0;k<data.size();k++){
			if(data.get(k).getForm_id().equals(form_code.get(0))){
				List<SubjectFormAndDataVO> dalist =new ArrayList<SubjectFormAndDataVO>();
				li.add(dalist);
			}
		}
		/*최종 output인 databind 객체 생성*/
		List<List<SubjectFormAndDataVO>> databind = new ArrayList<List<SubjectFormAndDataVO>>();
		
		/*subkey 0인 것들,1인것들,2인 것들,...n인 것들 구분해주기 위한 변수*/
		int subkey = 0;
		for(int i=0;i<data.size();i++){
			SubjectFormAndDataVO d = data.get(i);
			for(int q=0;q<form_code.size();q++){
		/*지정된 form_id를 가지고 있고 subkey가 0인것들만  li에 저장(0인 것들 저장 다되면 subkey+1인 것들 저장)*/
				/*2012.12.17 상병 함준혁 데이터 확실성 위해 넣은 서브키 확인하는 코드 없앰
				레코드 추가할시 삭제버튼 맨 밑에만 뜨는거 개선하기 위함*/
				if(d.getForm_id().equals(form_code.get(q)) /*&& d.getSubkey().equals(""+subkey+"")*/){
					li.get(subkey).add(d);
					/*form_code의 사이즈만큼 저장되면(다른말로 한 행이 저장되면) databind에 저장*/
					if(li.get(subkey).size()==form_code.size()){
						databind.add(li.get(subkey));
						subkey++;
					}
				}
			}
		}
		System.out.println(databind);
		return databind;
	}
	
	/**
	 * 넣어준 basecode가 하위부대를 가지고 있는지 판단하는 함수
	 * 하위 부대 있으면 Return false;
	 * 하위 부대 없으면 Return true;
	 * @param basecode
	 * @return
	 */
	public boolean hasChild(String basecode){
		Integer bol = subjectDao.hasChild(basecode);
		if(bol == 0)
			return false;
		else 
			return true;
	}
	/**
	 * 가장 밑에 있는 부대를 리턴해주는 함수
	 * @param lev1
	 * @param lev2
	 * @param lev3
	 * @param lev4
	 * @return
	 */
	public String getLowestBase(String lev1, String lev2, String lev3, String lev4) {
		if(!("".equals(lev1)) && !("".equals(lev2)) && !("".equals(lev3)) && !("".equals(lev4)))
			return lev4;
		else if(!("".equals(lev1)) && !("".equals(lev2)) && !("".equals(lev3)))
			return lev3;
		else if(!("".equals(lev1)) && !("".equals(lev2)))
			return lev2;
		else if(!("".equals(lev1)))
			return lev1;
		else
			return null;
	}
	/**
	 * 네임타입으로 검색에 사용될 이름을 
	 * 리더,팀원,챔피언,부서장,지도위원으로 나눠서 자바빈에 넣음 
	 * @param subject
	 * @param field_type
	 * @param result_section
	 * @param subject_section
	 * @param subject_type
	 * @param nametype
	 * @param username
	 * @param sosokcode 
	 * @param sosokname 
	 */
	public void setSelection(SubjectVO subjectVO) {
		if("1".equals(subjectVO.getNametype()) && subjectVO.getUsername().length() == 0 )
			subjectVO.setLeader(subjectVO.getUsername());
		else if("1".equals(subjectVO.getNametype()) )
		subjectVO.setName(subjectVO.getUsername());
		if("2".equals(subjectVO.getNametype()) )
		subjectVO.setLeader(subjectVO.getUsername());
		if("3".equals(subjectVO.getNametype()) )
		subjectVO.setChampion(subjectVO.getUsername());
		if("4".equals(subjectVO.getNametype()))
		subjectVO.setDepartment_chairman(subjectVO.getUsername());
		if("5".equals(subjectVO.getNametype()))
		subjectVO.setGuide_committee(subjectVO.getUsername());
	}
	/**
	 * step_code, step_view, data, form_id로 구성된 List를 리턴
	 * @param seq
	 * @param step
	 * @return
	 */
	public List<SubjectFormAndDataVO> getData(Integer seq, String step){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("subject_code", seq);
		map.put("step", step);
		
		return subjectDao.getData(map);
	}
		
	/**입력시 자기 과제인지 과제가 있는지 없는지 판별해주는 함수
	 * @param user
	 * @param seq
	 * @param message
	 * @return
	 */
	public boolean checkSubjectCode(User user,Integer seq,String message){
		List<Integer> a =user.getSubject_code();
		if(a.size()==0){
			System.out.println(message);
			return false;
		}
		else if(!(a.contains(seq))){
			System.out.println(message);
			return false;
		}
		return true;
	}
	/**
	 * Template/Callback 패턴사용, 코드 간소화 시키기 위한 메소드
	 * stage_d,m,a,i,c,e에 중복되는 코드가 너무 많아 분리함
	 * @param seq
	 * @param str
	 * @param model 
	 * @param user 
	 * @param param
	 * @return
	 */
	public void getParam(Integer seq, String str, Model model, User user) {
		List<SubjectFormAndDataVO> form = getFormById(str);
		SubjectVO subject =getSubjectBySeq(seq);
		List<SubjectFormAndDataVO> step = getStepList(seq);
		List<Integer> sub_codes=user.getSubject_code();
		boolean is_mystep = sub_codes.contains(seq);
				
		model.addAttribute("data_form", form);
		model.addAttribute("subject", subject);
		model.addAttribute("step",step);
		model.addAttribute("is_mystep",is_mystep);
		model.addAttribute("stepping", getStepingCount(seq));
		model.addAttribute("mystepname", str);
		model.addAttribute("validateInsert",validateInsertStep(str, seq));
		
		/*단계 결재 횟수 가져옴. 이 숫자로 위에 d,m,a,i,c 버튼 보이게함*/
		List<ApprovalVO> approvedStep=approvalService.getApprovalList(null, seq, ApprovalUtil.done_state, null, null,ApprovalUtil.step_type);
		if(approvedStep.size() >0)
			model.addAttribute("isApproved", approvedStep.size());
		else
			model.addAttribute("isApproved", 0);
		
		if(!(str.equals("E"))){
			/*작성자 입장*/
			if(is_mystep){
				model.addAttribute("isRegistered",approvalService.isRegistered(seq, ApprovalUtil.step_type));
			}
			/*결재자 입장*/
			ApprovalVO right = approvalService.grantRight(user.getSn(), ApprovalUtil.step_type, seq);
			if(right !=null)	
				model.addAttribute("right", right);
		}
		else if(str.equals("E")){
			/*작성자 입장*/
			if(is_mystep){
				model.addAttribute("isRegistered",approvalService.isRegistered(seq, ApprovalUtil.end_report_type));
			}
			/*결재자 입장*/
			ApprovalVO right = approvalService.grantRight(user.getSn(), ApprovalUtil.end_report_type, seq);
			if(right != null)
				model.addAttribute("right", right);
		}
		/*공통 과제등록서 결재 끝났나 여부*/
		model.addAttribute("finishApp", approvalService.isFinishedReport_typeApp(seq));
	}
	
	/**
	 * SEQ구하는 함수 
	 * List<SubjectVO>에 인자 수에 따라 List<Integer>로 반환한다.
	 * @param sn
	 * @return
	 */
	public List<Integer> getMySubjectCode(String sn){
		List<SubjectVO> s = subjectDao.getMySubjectCode(sn);
		List<Integer> codes= new ArrayList<Integer>();
		
		if(s.size() == 0 ){
			return codes;
		}
		else if(s.size()==1){
			codes.add(s.get(0).getSubject_code());
			return codes;
		}
		else{
			for(int i=0;i<s.size();i++){
				codes.add(s.get(i).getSubject_code());
			}
			System.out.println(codes);
			return codes;
		}
	}
	/**
	 * D,M,A,I,C,완료보고서 진행된 상황 숫자로 반환
	 * 0:단계입력없음  1:D  2:D,M  3:D,M,A  4:D,M,A,I  5:D,M,A,I,C 6:D,M,A,I,C,E
	 * @param seq
	 * @return
	 */
	public int getStepingCount(Integer seq){
		List<SubjectFormAndDataVO> c_step=subjectDao.getEachStepCount(seq);
		return c_step.size();
	}
	/**입력되는 단계의 유효성 판단
	 * 핵심 알고리즘: 자기 단계의 수가 0이고 이전 단계의 수가 1일때 TRUE 반환
	 * 추가로 결재 되어야 입력 가능하도록 수정
	 * @param step
	 * @param seq
	 * @return
	 */
	public boolean validateInsertStep(String step,Integer seq){
		List<ApprovalVO> step_app = approvalService.getMyApprovalInValidate(ApprovalUtil.step_type, seq);
		int app_size=0;
		if(step_app !=null){
			app_size = step_app.size();
		}
		List<SubjectFormAndDataVO> c_step=subjectDao.getEachStepCount(seq);
		Integer s=1,d=0,m=0,a=0,i=0,c=0,e=0;
		List<Integer> steplist= new ArrayList<Integer>();
		int count = -1;

		for(int k=0;k<c_step.size();k++){
			SubjectFormAndDataVO sfad =c_step.get(k);
			if(c_step.get(k).getStep_view().equals("D"))d+=sfad.getFnd_count();
			else if(c_step.get(k).getStep_view().equals("M"))m+=sfad.getFnd_count();
			else if(c_step.get(k).getStep_view().equals("A"))a+=sfad.getFnd_count();
			else if(c_step.get(k).getStep_view().equals("I"))i+=sfad.getFnd_count();
			else if(c_step.get(k).getStep_view().equals("C"))c+=sfad.getFnd_count();
			else if(c_step.get(k).getStep_view().equals("E"))e+=sfad.getFnd_count();
		}
		steplist.add(s);steplist.add(d);steplist.add(m);steplist.add(a);steplist.add(i);steplist.add(c);steplist.add(e);
		
		if(step.equals("S"))count=0;
		else if(step.equals("D"))count=1;
		else if(step.equals("M"))count=2;
		else if(step.equals("A"))count=3;
		else if(step.equals("I"))count=4;
		else if(step.equals("C"))count=5;
		else if(step.equals("E"))count=6;
		
		if(count!=-1 && !(step.equals("S"))){
		if(steplist.get(count-1).equals(1) && steplist.get(count).equals(0) && app_size == count-1)
			return true;
		else return false;
		}
		else return false;
	}
	
	/**적용툴 배열로 바꿔서 리턴하는 함수
	 * @return
	 */
	public List<String> changeToolToArray(List<SubjectFormAndDataVO> data){
		List<String> tool_data= new ArrayList<String>();
		String tem=new String();
		List<SubjectFormAndDataVO> tool = getFormByType("TOOL");
		int size=data.size();
		for(int i=0;i<size;i++){
			SubjectFormAndDataVO d = data.get(i);
			for(int k=0;k<tool.size();k++){
				SubjectFormAndDataVO t = tool.get(k);
				if(d.getForm_id().equals(t.getForm_id()))
					tem=d.getData();
			}
		}
		if(tem != null && !("".equals(tem))){
			String[] a = tem.split(",");
			for(int q=0;q<a.length;q++){
				tool_data.add(a[q]);
			}
			return tool_data;
		}
		else
			return null;
	}
	/**
	 * stepList 출력해주는 함수
	 * @param seq
	 * @return
	 */
	public List<SubjectFormAndDataVO> getStepList(Integer seq){
		return subjectDao.getStepList(seq);
	}
	/**
	 * lsms_step 테이블 업데이트
	 * @param pa
	 */
	public void updateStep(SubjectFormAndDataVO pa){
		subjectDao.updateStep(pa);
	}
	
	/**
	 * FORM 테이블에서 타입으로 조회
	 * @param str
	 * @return
	 */
	public List<SubjectFormAndDataVO> getFormByType(String str) {	return subjectDao.getFormByType(str);}
	/**
	 * FORM 테이블에서 form_id로 조회
	 * @param str
	 * @return
	 */
	public List<SubjectFormAndDataVO> getFormById(String str){	return subjectDao.getFormById(str);}
	
	/*부대 관련 함수*/
	public List<BaseVO> getBaseByCode(String basecode){	return subjectDao.getBaseByCode(basecode);}
	public List<BaseVO> getHeadBase(){	return subjectDao.getHeadBase();}
	
	/*과제를 리스트로 뽑아오는 함수 
	 * @Return List<SubejctVO>
	 */
	/**
	 * 조건에 해당하는 과제목록 출력
	 * 과제조회 페이지, 내과제목록 페이지에 사용
	 * @param subject
	 * @return
	 */
	public List<SubjectVO> searchSubject(SubjectVO subject){
		if(subject.getDummy()==null){
			Pagination pagination = subject.getPagination();
			int cnt = subjectDao.getListCount(subject); 
			pagination.setNumItems(cnt);
		}else{
			Pagination pagination = subject.getPagination();
			int cnt = subjectDao.myListCount(subject); 
			pagination.setNumItems(cnt);			
		}
		return subjectDao.searchSubject(subject);
	}
	public List<SubjectVO> getAllSubject() {return subjectDao.getAllSubject();}

	/*과제 구하는 함수 
	 * @Return SubejctVO
	 * @Param sn or seq
	 * */
	public SubjectVO getSubjectBySn(String sn){	return subjectDao.getSubjectBySn(sn);}
	/**
	 * 과제코드로 과제조회
	 * 과제 한개 뽑아낼시
	 * @param seq
	 * @return
	 */
	public SubjectVO getSubjectBySeq(Integer seq) {	return subjectDao.getSubjectBySeq(seq);}
	
	/*내과제 목록 구해오는 code*/
	public List<SubjectVO> getMySubjects(User user){
		List<Integer> a = user.getSubject_code();
		List<SubjectVO> mySubjects= new ArrayList<SubjectVO>();
		for(int i=0; i<a.size();i++){
			SubjectVO mySubject = getSubjectBySeq(a.get(i));
			mySubjects.add(mySubject);
		}
		return mySubjects;
	}
	/**
	 * PK로 쓰일 과제코드 가져옴(시퀀스.nextval로)
	 * @return
	 */
	public Integer getSeq() {return subjectDao.getSeq();}
	/**
	 * PK로 쓰일 단계코드 가져옴(시퀀스.enxtval로)
	 * @return
	 */
	public Integer getStepSeq(){return subjectDao.getStepSeq();}

	/*조회 팝업에 사용하는 함수*/
	public List<AdministratorVO> getAdminByName(String name) {return subjectDao.getAdminByName(name);}
	/**
	 * AVS11U0T 테이블에서 사람 이름으로 조회
	 * @param name
	 * @return
	 */
	public List<UserVO> searchUserByAvs(String name) {return subjectDao.searchUserByAvs(name);}
	/**
	 * BASE2 테이블에서 모든항목 조회
	 * @return
	 */
	public List<BaseVO> getBaseAll() {	return subjectDao.getBaseAll();}
	public void expireSubject(Integer seq) {
		subjectDao.expireSubject(seq);
		
	}
	/**
	 * 해당 단계의 데이터를 모두 삭제
	 * @param step_code
	 */
	public void deleteAllDataInaStep(Integer step_code){
		subjectDao.deleteAllDataInaStep(step_code);
	}
	public String getBaseNameBySn(String sn){
		return subjectDao.getBaseNameBySn(sn);
	}
	/**
	 * 해당 과제의 해당 단계의 단계코드 가져옴
	 * @param seq
	 * @param step
	 * @return
	 */
	public Integer getStepSeqBySubjectSeq(Integer seq, String step) {
		// TODO Auto-generated method stub
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("seq", seq);
		map.put("step", step);
		return subjectDao.getStepSeqBySubjectSeq(map);
	}
	public void deleteAllUserInaUser(Integer seq) {
		// TODO Auto-generated method stub
		subjectDao.deleteAllUserInaUser(seq);
	}
	/**
	 * 해당 과제의 팀원조회
	 * @param subject_code
	 * @return
	 */
	public List<UserVO> getUsersInfo(Integer subject_code){
		return subjectDao.getUsersInfo(subject_code);
	}

	/**
	 * 엑셀에 넣을 데이터 가져옴
	 * @return
	 */
	public List<SubjectExcelVO> getExcelDatum() {
		return subjectDao.getExcelDatum();
	}
	public List<BaseVO> getBaseByBaseCode(){
		return subjectDao.getBaseByBaseCode();
	}
	public String getOneDataByCode(String form_id,String subject_code){
		Map<String,String> map = new HashMap<String, String>();
		map.put("form_id", form_id);
		map.put("subject_code",subject_code);
		return subjectDao.getOneDataByCode(map);
	}
	public void inserAfter(AfterSubjectVO param){
		subjectDao.inserAfter(param);
	}
	public void updateAfter(AfterSubjectVO param){
		subjectDao.updateAfter(param);
	}
	public List<AfterSubjectVO> getAfter(String param){
		return subjectDao.getAfter(param);
	}
	public void deleteAfter(String param){
		subjectDao.deleteAfter(param);
	}
}
