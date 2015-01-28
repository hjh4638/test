package mil.af.L6S.test.subject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import mil.af.L6S.component.approvalLine.ApprovalVO;
import mil.af.L6S.component.subject.*;

public class SubjectTest {
	private SubjectTestDao subjectDao=new SubjectTestDao();

//	사용자 계급,군번,소속
//	본인 과제들 과제코드와 각 역할들 보여줌
	
	public void getUserInfo() throws IOException, SQLException{
		System.out.println("군번을 입력하시오:");
		
		BufferedReader a = new BufferedReader(new InputStreamReader(System.in));
		String sn = a.readLine();
		
		UserVO user=subjectDao.getUserInfo(sn);
		List<UserVO> sub=subjectDao.getUserInProject(sn);
		System.out.println("이 사용자의 이름은 "+user.getName()+"\n"+
				" 계급은 "+user.getRankname()+"\n"+
				" 군번은 "+user.getUserid()+"\n"+" 소속은 "+user.getIntrasosokname()
				);
		for(int i=0;i<sub.size();i++){
			UserVO s=sub.get(i);
			System.out.println((i+1)+". 과제코드는 "+s.getSubject_code()+
					" 역할은 "+s.getRole_name());
		}
	}
//	해당 과제에 해당하는 진행단계,결재정보 등등 출력
	
	public void getSubjectInfo() throws IOException, SQLException{
		System.out.println("과제코드를 입력하시오:");
		
		BufferedReader a = new BufferedReader(new InputStreamReader(System.in));
		Integer subject_code = Integer.parseInt(a.readLine());
		
		List<SubjectVO> s1=subjectDao.getSubjectInfo(subject_code);
		List<SubjectStep> s2=subjectDao.getSubjectDataInfo(subject_code);
		List<ApprovalVO> s3=subjectDao.getSubjectAppInfo(subject_code);
		
		System.out.println("현재까지 작성된 지점 " + s2.get(s2.size()-1).getStep());
		System.out.println("현재까지 결재현황 "+s3.get(s3.size()-1).getApp_order()+
				"단계에서" +s3.get(s3.size()-1).getApp_state());
		
	}
//	@Test
//	public void aa(){
//		String a =new String("ttt");
//		String d = a;
//		d=d.substring(0, 1);
//		System.out.println(a);
//		System.out.println(d);
//		
//		System.out.println(this.su);
//		
//	}
//	@Test
	public void tt() throws SQLException{
		UserVO u = new UserVO();
		u.setSubject_code(4258);
		u.setName("김지은");
		u.setDepartment("중전소");
		u.setSn("11-10357");
		subjectDao.insertUserWithSubject(u);
//		SUBJECT_CODE
//
//		NAME
//		DEPARTMENT
//		SN
	}
//	해당 단계까지 입력!!!
	@Test
	public void gogoProcess() throws NumberFormatException, IOException, SQLException{
		SubjectVO s1=subjectDao.getSubjectInfo(4101).get(0);
		
		System.out.println("원하는 지점 선택 ");
		System.out.println("1:D단계 입력 \n2:M단계 입력 \n3:A단계 입력 \n4:I단계 입력\n5:C단계 입력\n6:E단계입력\n7:E단계 결재완료");
		
		BufferedReader a = new BufferedReader(new InputStreamReader(System.in));
		Integer pro = Integer.parseInt(a.readLine());
		System.out.println(pro+"단계까지 입력 결재 하겠습니다.");
		
		RelativeData ac = new RelativeData(4022);
		Integer asize;
		if(ac.getAppLineType().equals("A"))
			asize=3;
		else if(ac.getAppLineType().equals("B"))
			asize=7;
		else
			asize=5;
		System.out.println("팀원으로 쓸 군번 입력");
		BufferedReader cc = new BufferedReader(new InputStreamReader(System.in));
		String sn = a.readLine();
		
		subjectDao.insertSubject(ac.getSubject());
		UserVO u = new UserVO();
		u.setSubject_code(ac.getSubject_code());
		u.setName("test이름");
		u.setDepartment("test부서");
		u.setSn(sn);
		subjectDao.insertUserWithSubject(u);
		
		subjectDao.insertApproval(ac.getApp().get(0));
		for(int q=0;q<asize;q++)
		subjectDao.insertApprovalLine(ac.getAppLine().get(q));
		
		if(pro>=2){
			subjectDao.insertStep(ac.getStep().get(0));
			for(int q=0;q<ac.getData().get(0).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(0).get(q));
			ApprovalVO ap=new ApprovalVO();
			ap=ac.getApp().get(1);ap.setIs_complete(0);
			subjectDao.insertApproval(ap);
			subjectDao.insertApprovalLine(ac.getAppLine().get(asize));
		}
		if(pro>=3){
			subjectDao.insertStep(ac.getStep().get(1));
			for(int q=0;q<ac.getData().get(1).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(1).get(q));
						
			subjectDao.insertApprovalLine(ac.getAppLine().get(asize+1));
		}
		if(pro>=4){
			subjectDao.insertStep(ac.getStep().get(2));
			for(int q=0;q<ac.getData().get(2).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(2).get(q));
						
			subjectDao.insertApprovalLine(ac.getAppLine().get(asize+2));
		}
		if(pro>=5){
			subjectDao.insertStep(ac.getStep().get(3));
			for(int q=0;q<ac.getData().get(3).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(3).get(q));
						
			subjectDao.insertApprovalLine(ac.getAppLine().get(asize+3));
		}
		if(pro>=6){
			subjectDao.insertStep(ac.getStep().get(4));
			for(int q=0;q<ac.getData().get(4).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(4).get(q));
						
			subjectDao.insertApprovalLine(ac.getAppLine().get(asize+4));
			subjectDao.updateApproval(ac.getApp().get(1));
		}
		if(pro>=7){
			subjectDao.insertStep(ac.getStep().get(5));
			for(int q=0;q<ac.getData().get(5).size();q++)
				subjectDao.insertDataWithStep(ac.getData().get(5).get(q));
											
			subjectDao.insertApproval(ac.getApp().get(2));
			for(int q=asize+5;q<asize*2+5;q++)
			subjectDao.insertApprovalLine(ac.getAppLine().get(q));
		}
	}
	
	
}
class RelativeData{
	private SubjectTestDao subjectDao=new SubjectTestDao();
	private Integer subject_code;
	private SubjectVO subject;
	
//	private Integer step_code; 
	private List<Map<String,Object>> step=new ArrayList<Map<String,Object>>();
	
	private List<List<SubjectFormAndDataVO>> data=new ArrayList<List<SubjectFormAndDataVO>>();
	
//	private Integer app_id;
	private List<ApprovalVO> app=new ArrayList<ApprovalVO>();
	
//	private Integer app_seq;
	private List<ApprovalVO> appLine=new ArrayList<ApprovalVO>();
	
	private String app_sn;
	private String appLineType;
	
	public SubjectTestDao getSubjectDao() {
		return subjectDao;
	}
	public void setSubjectDao(SubjectTestDao subjectDao) {
		this.subjectDao = subjectDao;
	}
	public Integer getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(Integer subject_code) {
		this.subject_code = subject_code;
	}
	public SubjectVO getSubject() {
		return subject;
	}
	public void setSubject(SubjectVO subject) {
		this.subject = subject;
	}
	public List<Map<String, Object>> getStep() {
		return step;
	}
	public void setStep(List<Map<String, Object>> step) {
		this.step = step;
	}
	public List<List<SubjectFormAndDataVO>> getData() {
		return data;
	}
	public void setData(List<List<SubjectFormAndDataVO>> data) {
		this.data = data;
	}
	public List<ApprovalVO> getApp() {
		return app;
	}
	public void setApp(List<ApprovalVO> app) {
		this.app = app;
	}
	public List<ApprovalVO> getAppLine() {
		return appLine;
	}
	public void setAppLine(List<ApprovalVO> appLine) {
		this.appLine = appLine;
	}
	public String getApp_sn() {
		return app_sn;
	}
	public void setApp_sn(String app_sn) {
		this.app_sn = app_sn;
	}
	public String getAppLineType() {
		return appLineType;
	}
	public void setAppLineType(String appLineType) {
		this.appLineType = appLineType;
	}
	RelativeData(Integer subject_code) throws SQLException{
				
		this.subject_code=subjectDao.getSeq();
		this.subject=subjectDao.getSubjectInfo(subject_code).get(0);
		this.subject.setSubject_code(this.subject_code);
		
		setStep();
		setData(subject_code);
		setApp();
		
		ApprovalVO pa=new ApprovalVO();
		pa.setSosokcode(this.subject.getSosokcode().substring(0,4));
		this.app_sn=subjectDao.getBaseAdmin(pa).get(0).getApp_sn();
		
		if(this.subject.getSubject_section().equals("SSS")||this.subject.getSubject_section().equals("GB")){
			setAppLine(3);
			this.appLineType="A";
		}
//		이부분 A500H0같은거 들어오면 인식 못함 ㅋㅋㅋ
		else if(this.subject.getSosokcode().substring(0, 4).equals("A500")){
			setAppLine(7);
			this.appLineType="B";
		}
		else{
			setAppLine(5);
			this.appLineType="C";
		}
	}
	public void setStep() throws SQLException{
		String step="D";
		for(int i=0;i<6;i++){
			switch(i){
			case 1:
				step="M";
				break;
			case 2:
				step="A";
				break;
			case 3:
				step="I";
				break;
			case 4:
				step="C";
				break;
			case 5:
				step="E";
				break;
			}
						
			Map<String,Object> m = new HashMap<String,Object>();
			m.put("step_code", subjectDao.getStepSeq());
			m.put("subject_code", this.subject_code);
			m.put("step", step);
			this.step.add(m);
		}
	}
	public void setData(Integer subject_code) throws SQLException{
		for(int i=0;i<6;i++){
			Map<String,Object> m =new HashMap<String,Object>(); 
			m.put("subject_code", subject_code);
			m.put("step", this.step.get(i).get("step"));
			
			List<SubjectFormAndDataVO> li=subjectDao.getData(m);
			for(int a=0;a<li.size();a++)
				li.get(a).setStep_code((Integer) this.step.get(i).get("step_code"));
			
			this.data.add(li);
		}
	}
	//is_complete는 바꿔서 넣어야함
	public void setApp() throws SQLException{
		String app_type="S";
		for(int i=0;i<3;i++){
			switch(i){
			case 0:
				app_type="S";
				break;
			case 1:
				app_type="step";
				break;
			case 2:
				app_type="E";
				break;
			}
			
			ApprovalVO a = new ApprovalVO();
			a.setApp_id(subjectDao.getApprovalSeq());
			a.setSubject_code(this.subject_code);
			a.setIs_complete(1);
			a.setApp_type(app_type);
			
			this.app.add(a);
		}
	}
	public void setAppLine(int size) throws SQLException{
		for(int i=0;i<size;i++){
			ApprovalVO a =new ApprovalVO();
			a.setApp_seq(subjectDao.getApprovalLineSeq());
			a.setApp_id(this.app.get(0).getApp_id());
			if(size==5 && (i==3||i==4))
				a.setApp_order(i+1+2);
			else
				a.setApp_order(i+1);
			
			a.setApp_sn(this.app_sn);
			a.setApp_state(1);
			this.appLine.add(a);
		}
		for(int i=0;i<5;i++){
			ApprovalVO a =new ApprovalVO();
			a.setApp_seq(subjectDao.getApprovalLineSeq());
			a.setApp_id(this.app.get(1).getApp_id());
			a.setApp_order(i+11);
			a.setApp_sn(this.app_sn);
			a.setApp_state(1);
			this.appLine.add(a);
		}
		for(int i=0;i<size;i++){
			ApprovalVO a =new ApprovalVO();
			a.setApp_seq(subjectDao.getApprovalLineSeq());
			a.setApp_id(this.app.get(2).getApp_id());
			if(size==5 && (i==3||i==4))
				a.setApp_order(i+1+2);
			else
				a.setApp_order(i+1);
			
			a.setApp_sn(this.app_sn);
			a.setApp_state(1);
			this.appLine.add(a);
		}
	}
}
