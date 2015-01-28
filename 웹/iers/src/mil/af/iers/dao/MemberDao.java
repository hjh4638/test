package mil.af.iers.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.iers.component.util.HDIdeaCipher;
import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.UserDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class MemberDao {
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate; 

//	private SqlMapClient sqlMapClientTemplate;
//	
//	public MemberDao() {
//		LocalIbatis setting = new LocalIbatis();
//		try {
//			this.sqlMapClientTemplate=setting.getSqlMapClient();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	public void mergeIntoUser(UserDTO user){
		HDIdeaCipher cipher = new HDIdeaCipher();
		user.setUser_password(cipher.encrypt(user.getUser_password()));
		sqlMapClientTemplate.insert("UserSql.mergeIntoUser", user);
	}
	public UserDTO getOneOfUser(UserDTO user){
		return (UserDTO) sqlMapClientTemplate.queryForObject("UserSql.getOneOfUser",user);
	}
	@SuppressWarnings("unchecked")
	public List<UserDTO> getListOfUser(UserDTO user) throws SQLException{
		return (List<UserDTO>) sqlMapClientTemplate.queryForList("UserSql.getListOfUser",user);
	}
	public void updateAuthByAdmin(UserDTO user){
		sqlMapClientTemplate.update("UserSql.updateAuthByAdmin", user);
	}
	public UserDTO getLoginData(UserDTO user){
		HDIdeaCipher cipher = new HDIdeaCipher();
		user.setUser_password(cipher.encrypt(user.getUser_password()));
		return (UserDTO)sqlMapClientTemplate.queryForObject("UserSql.getLoginData", user);
	}
	public String getFileName(String file_id){
		return (String) sqlMapClientTemplate.queryForObject("UserSql.getFileName", file_id);
	}
	public void initPassword(Map<String,String> map){
		HDIdeaCipher cipher = new HDIdeaCipher();
		map.put("user_password", cipher.encrypt(map.get("user_password")));
		sqlMapClientTemplate.update("UserSql.initPassword", map);
	}
	public void initApproveKey(Map<String,String> map){
		sqlMapClientTemplate.update("UserSql.initApproveKey",map);
	}
	public UserDTO oneUserToChangePassword(Map<String,String> map){
		return (UserDTO)sqlMapClientTemplate.queryForObject("UserSql.oneUserToChangePassword", map);
	}
	public String getCellPhone(Map<String,String> param){
		return (String) sqlMapClientTemplate.queryForObject("UserSql.getCellPhone", param);
	}
}
