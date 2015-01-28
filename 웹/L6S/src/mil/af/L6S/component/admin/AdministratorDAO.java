package mil.af.L6S.component.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.common.User;
import mil.af.L6S.util.Pagination;

/**
 *  AdministratorDAO Part
 * @author 정성모
 */
@Repository
public class AdministratorDAO {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	/**
	 * INSERT
	 * 		관리자 등록
	 * @param administratorVO
	 *            sn = '군번', classification = '체계분류', authoirty = '권한
	 */
	public void insertAdministrator(AdministratorVO administratorVO) {
		sqlMapClientTemplate.insert("administratorSql.insertAdministrator",
				administratorVO);
	}
	
	/**
	 * SELECT
	 * 		관리자 List 조회
	 * @param searchVO
	 * @return AdministratorVO
	 */
	@SuppressWarnings("unchecked")
	public List<AdministratorVO> selectAdministratorList(
			AdministratorVO searchVO) {
		return (List<AdministratorVO>) sqlMapClientTemplate.queryForList(
				"administratorSql.selectAdministratorList", searchVO);
	}
	
	public int checkUserSn(String sn){
		return (Integer) sqlMapClientTemplate.queryForObject("administratorSql.checkUserSn",sn);
	}

	/**
	 * COUNT
	 * 		등록된 관리자 수 조회
	 * @param searchVO        
	 * @return 관리자 수
	 */
	public int getAdministratorCount() {
		return (Integer) sqlMapClientTemplate.queryForObject(
				"administratorSql.getAdministratorCount");
	}

	/**
	 * DELETE
	 * 		관리자 삭제
	 * @param sn
	 */
	public void deleteAdministrator(String sn) {
		sqlMapClientTemplate.delete("administratorSql.deleteAdministrator", sn);
		
	}

	@SuppressWarnings("unchecked")
	public List<String> getConfirmedData() {
		return sqlMapClientTemplate.queryForList("administratorSql.getConfirmedData");
	}
	
	public List<String> getConfirmedData2() {
		return sqlMapClientTemplate.queryForList("administratorSql.getConfirmedData2");
	}

	public void upDateData(String snList) {
		sqlMapClientTemplate.update("administratorSql.upDateData", snList);
	}
	public void upDateData2(String snList) {
		sqlMapClientTemplate.update("administratorSql.upDateData2", snList);
	}

	public void insertAdmin(AdministratorVO administratorVO) {
		sqlMapClientTemplate.update("administratorSql.insertAdmin",administratorVO);		
	}

	/**
	 *  부대에 따른 사용자 호출
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectAvs11u0tToQuarter(AdministratorVO searchVO) {
		return sqlMapClientTemplate.queryForList("administratorSql.selectAvs11u0tToQuarter", searchVO);
	}

	/**
	 *  Count(개정)
	 *  	등록된 관리자 수 조회 
	 * @param string 
	 * @return
	 */
	public int getAdminCount(String quarter) {
		return (Integer) sqlMapClientTemplate.queryForObject(
				"administratorSql.getAdminCount",quarter);
	}

	/**
	 *  자신 base_code 호출
	 * @param sn
	 * @return
	 */
	public String getMyQuarter(String sn) {
		return (String) sqlMapClientTemplate.queryForObject("administratorSql.getMyQuarter", sn);
	}

	public String getMyAuth(String sn) {
		return (String) sqlMapClientTemplate.queryForObject("administratorSql.getMyAuth",sn);
	}
}


/**
 * 부서에 해당하는 사람 호출
 * @param searchVO
 * @return
 */
//@SuppressWarnings("unchecked")
//public List<User> selectAvs11u0tToQuarter(AdministratorVO searchVO) {
//	Pagination pagination = searchVO.getPagination();
//	int count = administratorDAO.getAdministratorCount();
//	pagination.setNumItems(count);
//	
//	pagination.setNumItems(getAvs11u0tToName(searchVO.getSearchName()));
//	return sqlMapClientTemplate.queryForList("commonSql.selectAvs11u0tToQuarter", searchVO);
//}
