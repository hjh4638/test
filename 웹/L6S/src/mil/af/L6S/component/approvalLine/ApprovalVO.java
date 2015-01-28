package mil.af.L6S.component.approvalLine;

import java.util.Map;

import mil.af.L6S.component.subject.SubjectVO;
import mil.af.common.util.ApprovalUtil;

/**
 * @author 공군 상병 함준혁
 * lsms_approval의 is_complete 컬럼
 * 0이면 완료대기,1이면 과제등록서결재완료,2이면 완료보고서 결재완료,3이면 기각,4이면 회수
 * 10단계진행,11단계완료,12단계기각
 *
 *lsms_approval_line
 *app_state 칼럼 : 0:대기 1:결재 2:기각 3:회수
 *				D단계10:대기	11결재,12기각
 *				M단계20:대기	21결재,22기각
 *				A단계30:대기	31결재,32기각
 *				I단계40:대기	41결재,42기각
 *				C단계50:대기	51결재,52기각
 *
 *APP_ORDER 칼럼:1~8 과제 결재선, 
 *				10:D 11:M 12:A 13:I 14:C
 */
public class ApprovalVO extends SubjectVO{

	Integer app_id;
	String create_time;
	Integer is_complete;
		
	Integer app_seq;
	Integer app_order;
	String app_rank;
	String app_sn;
	String app_name;
	String app_ass;
	Integer app_state;
	String app_comment;
	
	/*DB에는 없는 항목 접수 되었는지 알아보기 위함*/
	boolean haveRegistered;
	public boolean getHaveRegistered() {
		return haveRegistered;
	}
	public void setHaveRegistered(boolean haveRegistered) {
		this.haveRegistered = haveRegistered;
	}
	
	
	public String getOrderName(){
		if(this.app_order.equals(ApprovalUtil.subject_one))
			return ApprovalUtil.one_step;
		else if(this.app_order.equals(ApprovalUtil.subject_two))
			return ApprovalUtil.two_step;
		else if(this.app_order.equals(ApprovalUtil.subject_three))
			return ApprovalUtil.three_step;
		else if(this.app_order.equals(ApprovalUtil.subject_four))
			return ApprovalUtil.four_step;
		else if(this.app_order.equals(ApprovalUtil.subject_five))
			return ApprovalUtil.five_step;
		else if(this.app_order.equals(ApprovalUtil.subject_six))
			return ApprovalUtil.six_step;
		else if(this.app_order.equals(ApprovalUtil.subject_seven))
			return ApprovalUtil.seven_step;
		else if(this.app_order.equals(ApprovalUtil.step_d))
			return ApprovalUtil.d;
		else if(this.app_order.equals(ApprovalUtil.step_m))
			return ApprovalUtil.m;
		else if(this.app_order.equals(ApprovalUtil.step_a))
			return ApprovalUtil.a;
		else if(this.app_order.equals(ApprovalUtil.step_i))
			return ApprovalUtil.i;
		else if(this.app_order.equals(ApprovalUtil.step_c))
			return ApprovalUtil.c;
		
		else {
			return "false";
		}
	}
	public String app_type;
	public String getApp_type() {
		return app_type;
	}
	public void setApp_type(String app_type) {
		this.app_type = app_type;
	}
	public Integer getApp_id() {
		return app_id;
	}
	public void setApp_id(Integer app_id) {
		this.app_id = app_id;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public Integer getApp_seq() {
		return app_seq;
	}
	public void setApp_seq(Integer app_seq) {
		this.app_seq = app_seq;
	}
	public Integer getApp_order() {
		return app_order;
	}
	public void setApp_order(Integer app_order) {
		this.app_order = app_order;
	}
	public String getApp_rank() {
		return app_rank;
	}
	public void setApp_rank(String app_rank) {
		this.app_rank = app_rank;
	}
	public String getApp_sn() {
		return app_sn;
	}
	public void setApp_sn(String app_sn) {
		this.app_sn = app_sn;
	}
	public String getApp_name() {
		return app_name;
	}
	public void setApp_name(String app_name) {
		this.app_name = app_name;
	}
	public String getApp_ass() {
		return app_ass;
	}
	public void setApp_ass(String app_ass) {
		this.app_ass = app_ass;
	}
	public Integer getApp_state() {
		return app_state;
	}
	public void setApp_state(Integer app_state) {
		this.app_state = app_state;
	}
	public String getApp_comment() {
		return app_comment;
	}
	public void setApp_comment(String app_comment) {
		this.app_comment = app_comment;
	}
	public Integer getIs_complete() {
		return is_complete;
	}
	public void setIs_complete(Integer is_complete) {
		this.is_complete = is_complete;
	}
	/*결재완료여부, 결재가능여부, 접수가능여부, 접수여부, 결재상태 저장됨*/
	/*is_complete is_approval is_handin haveHanded approvalState*/
	Map<String,String> app_right;
	public Map<String, String> getApp_right() {
		return app_right;
	}
	public void setApp_right(Map<String, String> app_right) {
		this.app_right = app_right;
	}
	
	
}
