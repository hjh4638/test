package mil.af.L6S.component.subject;

import java.util.HashMap;
import java.util.Map;

import mil.af.L6S.util.AbstractListFilter;

public class SubjectVO extends AbstractListFilter{
	int rnum;
	String sn;
	Integer subject_code;
	String project_name;
	String team_name;
	String register_day;
	String leader;
	String leader_qualification;
	String champion;
	String department_chairman;
	String guide_committee;
	String field_type;
	String subject_section;
	String result_section;
	String subject_type;
	String plan_d;
	String plan_a;
	String plan_m;
	String plan_i;
	String plan_c;
	Integer is_expire;
	String problem;
	String advance;
	String sosokcode;
	String sosokname;
	String filename;
	String guide_sn; 
	/*그래프 만들때 주입하는 데이터*/
	String sosok_gragh;
	Integer subject_count;
	String name;
	String fullbasename;
	String dummy;
	//검색조건
	String nametype;
	String username;
	String person;
	
	//사후관리 여부
	String endsubject;
	
	public String getEndsubject() {
		return endsubject;
	}
	public void setEndsubject(String endsubject) {
		this.endsubject = endsubject;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getAdvance() {
		return advance;
	}
	public String getChampion() {
		return champion;
	}
	public String getDepartment_chairman() {
		return department_chairman;
	}
	public String getDummy() {
		return dummy;
	}
	
	
	public String getField_type() {
		return field_type;
	}
	public String getFilename() {
		return filename;
	}
	public String getFullbasename() {
		return fullbasename;
	}
	public String getGuide_committee() {
		return guide_committee;
	}
	public String getGuide_sn() {
		return guide_sn;
	}
	public Integer getIs_expire() {
		return is_expire;
	}
	public String getLeader() {
		return leader;
	}
	public String getLeader_qualification() {
		return leader_qualification;
	}
	public String getName() {
		return name;
	}
	
	public String getNametype() {
		return nametype;
	}
	public String getPlan_a() {
		return plan_a;
	}
	
	public String getPlan_c() {
		return plan_c;
	}
	public String getPlan_d() {
		return plan_d;
	}
	public String getPlan_i() {
		return plan_i;
	}
	public String getPlan_m() {
		return plan_m;
	}
	
	public Map<String,String> getPlan_map() {
		String[] p1=plan_d.split(",");
		String[] p2=plan_m.split(",");
		String[] p3=plan_a.split(",");
		String[] p4=plan_i.split(",");
		String[] p5=plan_c.split(",");
		
		Map<String,String> plan = new HashMap<String,String>();
		plan.put("begin_d", p1[0]);
		plan.put("begin_m", p2[0]);
		plan.put("begin_a", p3[0]);
		plan.put("begin_i", p4[0]);
		plan.put("begin_c", p5[0]);
		plan.put("end_d", p1[1]);
		plan.put("end_m", p2[1]);
		plan.put("end_a", p3[1]);
		plan.put("end_i", p4[1]);
		plan.put("end_c", p5[1]);
		
		return plan;
	}
	public String getProblem() {
		return problem;
	}
	public String getProject_name() {
		return project_name;
	}
	public String getRegister_day() {
		return register_day;
	}

	public String getResult_section() {
		return result_section;
	}
	public int getRnum() {
		return rnum;
	}
	public String getSn() {
		return sn;
	}
	public String getSosok_gragh() {
		return sosok_gragh;
	}
	
	public String getSosokcode() {
		return sosokcode;
	}
	public String getSosokname() {
		return sosokname;
	}
	public Integer getSubject_code() {
		return subject_code;
	}
	public Integer getSubject_count() {
		return subject_count;
	}
	public String getSubject_section() {
		return subject_section;
	}
	public String getSubject_type() {
		return subject_type;
	}
	public String getTeam_name() {
		return team_name;
	}
	public String getUsername() {
		return username;
	}
	public void setAdvance(String advance) {
		this.advance = advance;
	}
	public void setChampion(String champion) {
		this.champion = champion;
	}
	public void setDepartment_chairman(String department_chairman) {
		this.department_chairman = department_chairman;
	}
	public void setDummy(String dummy) {
		this.dummy = dummy;
	}
	public void setField_type(String field_type) {
		this.field_type = field_type;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public void setFullbasename(String fullbasename) {
		this.fullbasename = fullbasename;
	}
	public void setGuide_committee(String guide_committee) {
		this.guide_committee = guide_committee;
	}
	public void setGuide_sn(String guide_sn) {
		this.guide_sn = guide_sn;
	}
	public void setIs_expire(Integer is_expire) {
		this.is_expire = is_expire;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public void setLeader_qualification(String leader_qualification) {
		this.leader_qualification = leader_qualification;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setNametype(String nametype) {
		this.nametype = nametype;
	}
	public void setPlan_a(String plan_a) {
		this.plan_a = plan_a;
	}
	public void setPlan_c(String plan_c) {
		this.plan_c = plan_c;
	}
	public void setPlan_d(String plan_d) {
		this.plan_d = plan_d;
	}
	public void setPlan_i(String plan_i) {
		this.plan_i = plan_i;
	}
	public void setPlan_m(String plan_m) {
		this.plan_m = plan_m;
	}
	public void setProblem(String problem) {
		this.problem = problem;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public void setRegister_day(String register_day) {
		this.register_day = register_day;
	}
	public void setResult_section(String result_section) {
		this.result_section = result_section;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public void setSosok_gragh(String sosok_gragh) {
		this.sosok_gragh = sosok_gragh;
	}
	public void setSosokcode(String sosokcode) {
		this.sosokcode = sosokcode;
	}
	public void setSosokname(String sosokname) {
		this.sosokname = sosokname;
	}
	public void setSubject_code(Integer subject_code) {
		this.subject_code = subject_code;
	}
	public void setSubject_count(Integer subject_count) {
		this.subject_count = subject_count;
	}
	public void setSubject_section(String subject_section) {
		this.subject_section = subject_section;
	}
	public void setSubject_type(String subject_type) {
		this.subject_type = subject_type;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@Override
	public String toString() {
		return "SubjectVO [rnum=" + rnum + ", sn=" + sn + ", subject_code="
				+ subject_code + ", project_name=" + project_name
				+ ", team_name=" + team_name + ", register_day=" + register_day
				+ ", leader=" + leader + ", leader_qualification="
				+ leader_qualification + ", champion=" + champion
				+ ", department_chairman=" + department_chairman
				+ ", guide_committee=" + guide_committee + ", field_type="
				+ field_type + ", subject_section=" + subject_section
				+ ", result_section=" + result_section + ", subject_type="
				+ subject_type + ", plan_d=" + plan_d + ", plan_a=" + plan_a
				+ ", plan_m=" + plan_m + ", plan_i=" + plan_i + ", plan_c="
				+ plan_c + ", is_expire=" + is_expire + ", problem=" + problem
				+ ", advance=" + advance + ", sosokcode=" + sosokcode
				+ ", sosokname=" + sosokname + ", filename=" + filename
				+ ", guide_sn=" + guide_sn + ", sosok_gragh=" + sosok_gragh
				+ ", subject_count=" + subject_count + ", name=" + name
				+ ", fullbasename=" + fullbasename + ", dummy=" + dummy
				+ ", nametype=" + nametype + ", username=" + username + "]";
	}
}
