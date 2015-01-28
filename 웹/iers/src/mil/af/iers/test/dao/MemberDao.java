package mil.af.iers.test.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.UserDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;


public class MemberDao {
	private SqlMapClient sqlMapClientTemplate;
	
	public MemberDao() {
		LocalIbatis setting = new LocalIbatis();
		try {
			this.sqlMapClientTemplate=setting.getSqlMapClient();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void mergeIntoUser(UserDTO user) throws SQLException{
		sqlMapClientTemplate.insert("UserSql.mergeIntoUser", user);
	}
	public UserDTO getOneOfUser(UserDTO user) throws SQLException{
		return (UserDTO) sqlMapClientTemplate.queryForObject("UserSql.getOneOfUser",user);
	}
	@SuppressWarnings("unchecked")
	public List<UserDTO> getListOfUser(UserDTO user) throws SQLException{
		return (List<UserDTO>) sqlMapClientTemplate.queryForList("UserSql.getListOfUser",user);
	}
	public UserDTO getLoginData(UserDTO user) throws SQLException{
		return (UserDTO)sqlMapClientTemplate.queryForObject("UserSql.getLoginData", user);
	}
	public void resetUser() throws SQLException{
		sqlMapClientTemplate.delete("UserSql.resetUser");
	}
}
