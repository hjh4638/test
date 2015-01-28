package mil.af.L6S.component.subject;

import java.util.List;
import java.util.Map;

import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.endsubject.AfterSubjectVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SubjectDao {
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	public void insertSubject(SubjectVO subjectVO) {
		sqlMapClientTemplate.insert("SubjectSql.insertSubject",subjectVO);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> getAllSubject() {
		return (List<SubjectVO>) sqlMapClientTemplate.queryForList("SubjectSql.getAllSubject");
	}
	/**
	 * ALERT: 이 메소드는 맨 처음 과제등록시에만 사용가능
	 * @param userVO
	 */
	public void insertUserWithSubject(UserVO userVO) {
		sqlMapClientTemplate.insert("SubjectSql.insertUser",userVO);
	}
	public Integer getSeq() {
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getSeq");
	}
	@SuppressWarnings("unchecked")
	public List<AdministratorVO> getAdminByName(String name) {
		return (List<AdministratorVO>) sqlMapClientTemplate.queryForList("administratorSql.getAdminByName", name);
	}
	@SuppressWarnings("unchecked")
	public List<UserVO> searchUserByAvs(String name) {
		return (List<UserVO>) sqlMapClientTemplate.queryForList("SubjectSql.searchUserByAvs",name);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getFormByType(String str) {
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getFormByType",str);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getFormById(String str){
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getFormById",str);
	}
	public Integer getStepSeq() {
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getStepSeq");
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> getMySubjectCode(String sn){
		return sqlMapClientTemplate.queryForList("SubjectSql.getMySubjectCode",sn);
	}
	public void insertStep(Map<String, Object> map) {
		sqlMapClientTemplate.insert("SubjectSql.insertStep",map);
	}
	public void insertDataWithStep(SubjectFormAndDataVO subjectFormAndDataVO) {
		sqlMapClientTemplate.insert("SubjectSql.insertDataWithStep",subjectFormAndDataVO);
	}
	public SubjectVO getSubjectBySn(String sn) {
		return (SubjectVO) sqlMapClientTemplate.queryForObject("SubjectSql.getSubjectBySn",sn);
	}
	@SuppressWarnings("unchecked")
	public List<BaseVO> getBaseByBaseCode(){
		return (List<BaseVO>) sqlMapClientTemplate.queryForList("SubjectSql.getBaseByBaseCode");
	}
	@SuppressWarnings("unchecked")
	public List<BaseVO> getBaseByCode(String basecode){
		return (List<BaseVO>) sqlMapClientTemplate.queryForList("BaseSql.getBaseByCode",basecode);
	}
	@SuppressWarnings("unchecked")
	public List<BaseVO> getHeadBase(){
		return (List<BaseVO>) sqlMapClientTemplate.queryForList("BaseSql.getHeadBase");
	}
	public Integer hasChild(String basecode) {
		return (Integer) sqlMapClientTemplate.queryForObject("BaseSql.hasChild",basecode);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> searchSubject(SubjectVO sub){
		if(sub.getName() ==null)
			sub.setName("-9999");
		return (List<SubjectVO>) sqlMapClientTemplate.queryForList("SubjectSql.searchSubject", sub);
	}
	public SubjectVO getSubjectBySeq(Integer seq) {
		return (SubjectVO) sqlMapClientTemplate.queryForObject("SubjectSql.getSubjectBySeq", seq);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getData(Map<String, Object> map){
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getData", map);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getStepList(Integer seq){
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getStepList", seq);
	}
	public void updateStep(SubjectFormAndDataVO data) {
		sqlMapClientTemplate.update("SubjectSql.updateStep", data);
	}
	@SuppressWarnings("unchecked")
	public List<BaseVO> getBaseAll() {
		return sqlMapClientTemplate.queryForList("SubjectSql.getBaseAll");
	}
	public void expireSubject(Integer seq) {
		sqlMapClientTemplate.update("SubjectSql.expireSubject", seq);
	}
	public String getBaseNameBySn(String sn) {
		return (String) sqlMapClientTemplate.queryForObject("SubjectSql.getBaseNameBySn",sn);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectFormAndDataVO> getEachStepCount(Integer seq) {
		return (List<SubjectFormAndDataVO>) sqlMapClientTemplate.queryForList("SubjectSql.getEachStepCount",seq);
	}
	public void deleteAllDataInaStep(Integer step_code){
		sqlMapClientTemplate.delete("SubjectSql.deleteAllDataInaStep", step_code);
	}
	public Integer getStepSeqBySubjectSeq(Map map) {
		// TODO Auto-generated method stub
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getStepSeqBySubjectSeq", map);
	}
	public void updateSubject(SubjectVO subjectVO) {
		// TODO Auto-generated method stub
		sqlMapClientTemplate.update("SubjectSql.updateSubject", subjectVO);
	}
	public void deleteAllUserInaUser(Integer seq) {
		// TODO Auto-generated method stub
		sqlMapClientTemplate.delete("SubjectSql.deleteAllUserInaUser", seq);
	}
	@SuppressWarnings("unchecked")
	public List<UserVO> getUsersInfo(Integer subject_code){
		return (List<UserVO>) sqlMapClientTemplate.queryForList("SubjectSql.getUsersInfo", subject_code);
		
	}
	public int getListCount(SubjectVO subject) {
		// TODO Auto-generated method stub
		if(subject.getName() ==null)
			subject.setName("-9999");
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.getListCount",subject);
	}
	public int myListCount(SubjectVO subject) {
		// TODO Auto-generated method stub
		return (Integer) sqlMapClientTemplate.queryForObject("SubjectSql.myListCount",subject);
	}
	public void updateSubjectChampion(SubjectVO champion){
		sqlMapClientTemplate.update("SubjectSql.updateSubjectChampion", champion);
	}
	public void updateSubjectDepartment_chair(SubjectVO chair){
		sqlMapClientTemplate.update("SubjectSql.updateSubjectDepartment_chair", chair);
	}
	public void updateSubjectGuide_committee(SubjectVO committee){
		sqlMapClientTemplate.update("SubjectSql.updateSubjectGuide_committee", committee);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectExcelVO> getExcelDatum() {
		return sqlMapClientTemplate.queryForList("SubjectSql.getExcelDatum");
	}
	public String getOneDataByCode(Map<String,String> map){
		return (String ) sqlMapClientTemplate.queryForObject("SubjectSql.getOneDataByCode",map);
	}
	public void inserAfter(AfterSubjectVO param){
		sqlMapClientTemplate.insert("SubjectSql.inserAfter", param);
	}
	public void updateAfter(AfterSubjectVO param){
		sqlMapClientTemplate.insert("SubjectSql.updateAfter", param);
	}
	public List<AfterSubjectVO> getAfter(String param){
		return (List<AfterSubjectVO>) sqlMapClientTemplate.queryForList("SubjectSql.getAfter", param);
	}
	public void deleteAfter(String param){
		sqlMapClientTemplate.delete("SubjectSql.deleteAfter", param);
	}
}
