package mil.af.asti.test.hjh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import mil.af.asti.model.*;

import com.ibatis.sqlmap.client.SqlMapClient;

public class UserDao {

	private SqlMapClient sqlMapClientTemplate;
	
	UserDao(){
		TotalTest test = new TotalTest();
		try {
			sqlMapClientTemplate = test.getSqlMapClient();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	public void mergeIntoUser(AstiUserDTO userDTO) throws SQLException{
		sqlMapClientTemplate.insert("CommonSql.mergeIntoUser", userDTO);
	}
	public AstiUserDTO getUserInfo(AstiUserDTO userDTO) throws SQLException{
		return (AstiUserDTO) sqlMapClientTemplate.queryForObject("CommonSql.getUserInfo", userDTO);
	}
	public void deleteUser(AstiUserDTO userDTO) throws SQLException{
		sqlMapClientTemplate.delete("CommonSql.deleteUser", userDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiUserDTO> getUserList(AstiUserDTO userDTO) throws SQLException{
		return sqlMapClientTemplate.queryForList("CommonSql.getUserList", userDTO);
	}
	public String isDownAuth(Map map) throws SQLException{
		return (String) sqlMapClientTemplate.queryForObject("CommonSql.isDownAuth", map);
		
	}
	public void mergeIntoCodeUserDept(AstiCodeDTO codeDTO) throws SQLException{
		sqlMapClientTemplate.insert("CommonSql.mergeIntoCodeUserDept", codeDTO);
	}
	public void deleteCodeUserDept(AstiCodeDTO codeDTO) throws SQLException{
		sqlMapClientTemplate.delete("CommonSql.deleteCodeUserDept", codeDTO);
	}
	
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getCodeUserDetp() throws SQLException{
		return (List<AstiCodeDTO>) sqlMapClientTemplate.queryForList("CommonSql.getCodeUserDetp");
	}
	
}
