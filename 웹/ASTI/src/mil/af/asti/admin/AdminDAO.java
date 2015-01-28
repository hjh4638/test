package mil.af.asti.admin;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.asti.model.AstiAdminSearchDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiPageDTO;
import mil.af.asti.model.AstiUserDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {

	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate;

	@SuppressWarnings("unchecked")
	public List<AstiUserDTO> getMemberList(AstiAdminSearchDTO astiAdminSearchDTO) {
		return sqlMapClientTemplate.queryForList("AdminSql.getMemberList",astiAdminSearchDTO);
	}

	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getAuthorityCodeList() {
		return sqlMapClientTemplate.queryForList("AdminSql.getAuthorityCodeList");
	}

	public void changeAuthority(AstiUserDTO astiUserDTO) {
		sqlMapClientTemplate.update("AdminSql.changeAuthority",astiUserDTO);
		
	}

	public List<AstiUserDTO> removedMemberManage() {
		return (List<AstiUserDTO>) sqlMapClientTemplate.queryForList("AdminSql.getRemovedMember");
	}

	public List<AstiUserDTO> getNewMemberList() {
		return (List<AstiUserDTO>) sqlMapClientTemplate.queryForList("AdminSql.getNewMemberList");
	}

	public int getMemberCount(AstiAdminSearchDTO astiAdminSearchDTO) {
		return (Integer) sqlMapClientTemplate.queryForObject("AdminSql.getMemberCount",astiAdminSearchDTO);
	}

	public String validateAuthority(String authority) {
		return (String) sqlMapClientTemplate.queryForObject("AdminSql.getValidatedAuthority",authority);
	}

	public void deleteMember(String id) {
		sqlMapClientTemplate.delete("AdminSql.deleteMember",id);
	}
	
	public List<AstiPageDTO> getPageInfo(String page_id){
		return (List<AstiPageDTO>) sqlMapClientTemplate.queryForList("AdminSql.getPageInfo", page_id);
	}
	public void updatePageInfo(AstiPageDTO pageDTO){
		sqlMapClientTemplate.update("AdminSql.updatePageInfo", pageDTO);		
	}
	public void insertPageInfo(AstiPageDTO pageDTO){
		sqlMapClientTemplate.insert("AdminSql.insertPageInfo",pageDTO);
	}
	public void deletePage(String page_id){
		sqlMapClientTemplate.delete("AdminSql.deletePage", page_id);
	}
	public void mergeIntoCodeUserDept(AstiCodeDTO codeDTO){
		sqlMapClientTemplate.insert("AdminSql.mergeIntoCodeUserDept", codeDTO);
	}
	public void deleteCodeUserDept(AstiCodeDTO codeDTO){
		sqlMapClientTemplate.delete("AdminSql.deleteCodeUserDept", codeDTO);
	}
	
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getCodeUserDetp(){
		return (List<AstiCodeDTO>) sqlMapClientTemplate.queryForList("AdminSql.getCodeUserDetp");
	}
	public void userPasswordChange(AstiUserDTO user){
		sqlMapClientTemplate.update("AdminSql.userPasswordChange", user);
	}
}
