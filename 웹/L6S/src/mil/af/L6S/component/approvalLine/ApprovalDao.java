package mil.af.L6S.component.approvalLine;

import java.util.List;

import mil.af.L6S.component.belt.ContentsVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ApprovalDao {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	@SuppressWarnings("unchecked")
	public List<ApprovalMemberVO> getLineList(String sosokcode) {
		// TODO Auto-generated method stub
		return (List<ApprovalMemberVO>) sqlMapClientTemplate.queryForList("commonSql.getLineList", sosokcode);
	}
	public void insertApproval(ApprovalVO approvalVO){
		sqlMapClientTemplate.insert("ApprovalSql.insertApproval", approvalVO);
	}
	public void insertApprovalLine(ApprovalVO approvalVO){
		sqlMapClientTemplate.insert("ApprovalSql.insertApprovalLine", approvalVO);
	}
	public Integer getApprovalSeq(){
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getApprovalSeq");
	}
	public Integer getApprovalLineSeq(){
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getApprovalLineSeq");
	}
	/*군번으로 결재올린 사람 과제 뽑아줌*/
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getApprovalList(ApprovalVO app){
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getApprovalList", app);
	}
	public void updateState(ApprovalVO app){
		sqlMapClientTemplate.update("ApprovalSql.updateState", app);
	}
	@SuppressWarnings("unchecked")
	/*소속코드로 계급 군번 이름 직책을 admin 테이블에서 가져옴*/
	public List<ApprovalVO> getBaseAdmin(ApprovalVO app){
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getBaseAdmin", app);
	}
	public void updateApproval(ApprovalVO app){
		sqlMapClientTemplate.update("ApprovalSql.updateApproval", app);
	}
	public int getListCount(ApprovalVO approvalVO) {
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getListCount", approvalVO);
	}
	public void deleteApproval_line(ApprovalVO state){
		sqlMapClientTemplate.delete("ApprovalSql.deleteApproval_line",state);
	}
	public void deleteApproval(ApprovalVO state){
		sqlMapClientTemplate.delete("ApprovalSql.deleteApproval",state);
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getBBbyAdmin(ApprovalVO app){
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getBBbyAdmin",app);
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getApprovalTableList(ApprovalVO app){
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getApprovalTableList",app);
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getGuide_Committee(ApprovalVO app){
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getGuide_Committee", app);
	}
	/**
	 *  벨트 결재 등록
	 *  
	 */
	public void Belt_RegisterAPP(ContentsVO contentsVO) {
		sqlMapClientTemplate.insert("ApprovalSql.Belt_RegisterAPP",	contentsVO);
	}
	public String getApp_state(int state) {
		return (String) sqlMapClientTemplate.queryForObject("ApprovalSql.getApp_state", state);
	}
	@SuppressWarnings("unchecked")
	public List<String> getBeltSeq(String sn) {
		return sqlMapClientTemplate.queryForList("ApprovalSql.getBeltSeq", sn);
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalBeltVO> getBelt_app(String sn) {
		return sqlMapClientTemplate.queryForList("ApprovalSql.getBelt_app", sn);
	}
	public void updateBeltApproval(String str) {
		sqlMapClientTemplate.update("ApprovalSql.updateBeltApproval", str);
	}
	public void updateBeltdisApproval(ApprovalBeltVO approvalBeltVO) {
		sqlMapClientTemplate.update("ApprovalSql.updateBeltdisApproval", approvalBeltVO);
		
	}
	@Transactional
	public void insertBeltApproval(int fileseq){
		sqlMapClientTemplate.insert("ApprovalSql.insertBeltApproval",fileseq);
		//sqlMapClientTemplate.insert("ApprovalSql.insertApprovalLine",fileseq);
	}
	public void deleteBeltApproval(String str) {
		sqlMapClientTemplate.delete("ApprovalSql.deletebeltApp_line", str);
		sqlMapClientTemplate.delete("ApprovalSql.deletebeltApp", str);
		
	}
	public String checkisexist(int fileseq) {
		return (String) sqlMapClientTemplate.queryForObject("ApprovalSql.checkisexist", fileseq);
		
	}
	public void updaterejectedBelt(int fileseq) {
		sqlMapClientTemplate.update("ApprovalSql.updaterejectedBelt", fileseq);
		
	}
	public int getFileSeq() {
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getFileSeq");
	}
	public String getComment(int fileseq) {
		return (String) sqlMapClientTemplate.queryForObject("ApprovalSql.getComment",fileseq);
	}
	@SuppressWarnings("unchecked")
	public List<Integer> getAppidToProcessPage(ApprovalVO app){
		return (List<Integer>) sqlMapClientTemplate.queryForList("ApprovalSql.getAppidToProcessPage", app);
	}
	@SuppressWarnings("unchecked")
	public Integer getAppseqToProcessPage(ApprovalVO app){
		List<Integer> app_seq_list = sqlMapClientTemplate.queryForList("ApprovalSql.getAppseqToProcessPage", app);
		if(app_seq_list.size()>0)
			return app_seq_list.get(0);
		else return null;
	}
}

