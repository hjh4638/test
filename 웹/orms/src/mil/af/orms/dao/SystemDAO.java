package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.SystemVO;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("SystemDAO")
public class SystemDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	@SuppressWarnings("unchecked")
	public List<SystemVO> getAuthSelectList() throws SQLException {
		return sqlMapClient.queryForList("System.getAuthSelectList");
	}
	
	@SuppressWarnings("unchecked")
	public List<SystemVO> getAuthViewList() throws SQLException {
		return sqlMapClient.queryForList("System.getAuthViewList");
	}
	
	public void insertAuthList(HashMap<String, String> parameterMap) throws SQLException {
		sqlMapClient.insert("System.insertAuthList", parameterMap);
	}
	
	public void deleteAuthList(HashMap<String, String> parameterMap) throws SQLException {
		sqlMapClient.delete("System.deleteAuthList", parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<SystemVO> searchAuthViewList(String sosokcode) throws SQLException {
		return (List<SystemVO>)sqlMapClient.queryForList("System.searchAuthViewList",sosokcode);
	}
}
