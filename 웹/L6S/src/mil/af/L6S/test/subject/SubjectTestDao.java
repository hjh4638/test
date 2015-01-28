package mil.af.L6S.test.subject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.approvalLine.ApprovalVO;
import mil.af.L6S.component.subject.BaseVO;
import mil.af.L6S.component.subject.SubjectExcelVO;
import mil.af.L6S.component.subject.SubjectFormAndDataVO;
import mil.af.L6S.component.subject.SubjectVO;
import mil.af.L6S.component.subject.UserVO;
import mil.af.L6S.test.TotalTest;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

public class SubjectTestDao {

	private SqlMapClient sqlMapClientTemplate;
	
	SubjectTestDao(){
		TotalTest t = new TotalTest();
		try {
			this.sqlMapClientTemplate=t.getSqlMapClient();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public UserVO getUserInfo(String sn) throws SQLException{
		return (UserVO) sqlMapClientTemplate.queryForObject("testUser.getUser", sn);
	}
	@SuppressWarnings("unchecked")
	public List<UserVO> getUserInProject(String sn) throws SQLException{
		return sqlMapClientTemplate.queryForList("testUser.getUserInProject", sn);
		
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> getSubjectInfo(Integer subject_code) throws SQLException{
		return sqlMapClientTemplate.queryForList("testUser.getSubjectInfo", subject_code);
		
	}
	@SuppressWarnings("unchecked")
	public List<SubjectStep> getSubjectDataInfo(Integer subject_code) throws SQLException{
		return sqlMapClientTemplate.queryForList("testUser.getSubjectDataInfo", subject_code);
		
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getSubjectAppInfo(Integer subject_code) throws SQLException{
		return sqlMapClientTemplate.queryForList("testUser.getSubjectAppInfo", subject_code);
		
	}
//	************************************************************************************
	public void insertSubject(SubjectVO subjectVO) throws SQLException {
		sqlMapClientTemplate.insert("SubjectSql.insertSubject",subjectVO);
	}
	public void insertUserWithSubject(UserVO userVO) throws SQLException {
		sqlMapClientTemplate.insert("SubjectSql.insertUser",userVO);
	}
	public void insertStep(Map<String, Object> map) throws SQLException {
		sqlMapClientTemplate.insert("SubjectSql.insertStep",map);
	}
	public void insertDataWithStep(SubjectFormAndDataVO subjectFormAndDataVO) throws SQLException {
		sqlMapClientTemplate.insert("SubjectSql.insertDataWithStep",subjectFormAndDataVO);
	}
	public void insertApproval(ApprovalVO approvalVO) throws SQLException{
		sqlMapClientTemplate.insert("ApprovalSql.insertApproval", approvalVO);
	}
	public void insertApprovalLine(ApprovalVO approvalVO) throws SQLException{
		sqlMapClientTemplate.insert("ApprovalSql.insertApprovalLine", approvalVO);
	}
	
	
//	************************************************************************************
	public void deleteAllDataInaStep(Integer step_code) throws SQLException{
		sqlMapClientTemplate.delete("SubjectSql.deleteAllDataInaStep", step_code);
	}
	public void deleteAllUserInaUser(Integer seq) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClientTemplate.delete("SubjectSql.deleteAllUserInaUser", seq);
	}
	public void deleteApproval_line(ApprovalVO state) throws SQLException{
		sqlMapClientTemplate.delete("ApprovalSql.deleteApproval_line",state);
	}
	public void deleteApproval(ApprovalVO state) throws SQLException{
		sqlMapClientTemplate.delete("ApprovalSql.deleteApproval",state);
	}
	
//	************************************************************************************
	public Integer getSeq() throws SQLException {
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getSeq");
	}
	public Integer getStepSeq() throws SQLException {
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getStepSeq");
	}
	public Integer getApprovalSeq() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getApprovalSeq");
	}
	public Integer getApprovalLineSeq() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ApprovalSql.getApprovalLineSeq");
	}
	
	
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getData(Map<String, Object> map) throws SQLException{
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getData", map);
	}
	@SuppressWarnings("unchecked")
	public List<ApprovalVO> getBaseAdmin(ApprovalVO app) throws SQLException{
		return (List<ApprovalVO>) sqlMapClientTemplate.queryForList("ApprovalSql.getBaseAdmin", app);
	}
	
	public void updateApproval(ApprovalVO app) throws SQLException{
		sqlMapClientTemplate.update("ApprovalSql.updateApproval", app);
	}
}
