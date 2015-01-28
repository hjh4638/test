package mil.af.asti.common;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiUserDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class CommonDAO {
	
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void insertUserInfo(AstiUserDTO userInfo){
		sqlMapClientTemplate.insert("CommonSql.insertAstiUser", userInfo);
	}
	
	//로그인 중복체크를 위한 메소드
	public AstiUserDTO getUserInfo(String user_id){
		return (AstiUserDTO)sqlMapClientTemplate.queryForObject("CommonSql.getUserInfo", user_id);
	}
	public AstiUserDTO getUserInfo(AstiUserDTO userInfo){
		return (AstiUserDTO) sqlMapClientTemplate.queryForObject("CommonSql.getMatchedUserInfo", userInfo);
	}
	
	
	public void mergeIntoUser(AstiUserDTO userDTO){
		sqlMapClientTemplate.insert("CommonSql.mergeIntoUser", userDTO);
	}
	public AstiUserDTO getUser(AstiUserDTO userDTO){
		return (AstiUserDTO) sqlMapClientTemplate.queryForObject("CommonSql.getUser", userDTO);
	}
	public void deleteUser(AstiUserDTO userDTO){
		sqlMapClientTemplate.delete("CommonSql.deleteUser", userDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiUserDTO> getUserList(AstiUserDTO userDTO){
		return sqlMapClientTemplate.queryForList("CommonSql.getUserList", userDTO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<AstiUserDTO> getWaitingUserList(){
		return (List<AstiUserDTO>)sqlMapClientTemplate.queryForList("CommonSql.getWaitingUserList");
	}
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getAstiCodeByType(String code_type){
		return sqlMapClientTemplate.queryForList("CodeSql.getAstiCodeByType", code_type);
	}
	@SuppressWarnings("unchecked")
	public AstiCodeDTO getAstiCodeById(String code_id){
		return (AstiCodeDTO) sqlMapClientTemplate.queryForObject("CodeSql.getAstiCodeById", code_id);
	}
	
	public void removeMember(AstiUserDTO userInfo) {
		AstiUserDTO userData = (AstiUserDTO) sqlMapClientTemplate.queryForObject("CommonSql.getUsersAllInfo",userInfo);
		sqlMapClientTemplate.insert("CommonSql.insertRemoveMember",userData);
		sqlMapClientTemplate.delete("CommonSql.deleteUser",userData);
	}
	public String isDownAuth(Map map){
		return (String) sqlMapClientTemplate.queryForObject("CommonSql.isDownAuth", map);
	}
}
