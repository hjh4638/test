package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.SysCodeVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("CodeDAO")
public class CodeDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	@SuppressWarnings("unchecked")
	public List<SysCodeVO> getTimePeriodList() throws SQLException {
		return sqlMapClient.queryForList("Code.getCodeList","ORM006");
	}
	
	@SuppressWarnings("unchecked")
	public List<SysCodeVO> getPositionList() throws SQLException{
		return sqlMapClient.queryForList("Code.getCodeList","ORM002");
	}
	
	@SuppressWarnings("unchecked")
	public List<SysCodeVO> getSectionList(String code, String squadron, String airplane) throws SQLException{
		SysCodeVO sys = new SysCodeVO();
		sys.setCode(squadron);
		sys.setM_code(code);
		sys.setOrder_cd(airplane);
		return sqlMapClient.queryForList("Code.getSectionList",sys);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<SysCodeVO> getResultList() throws SQLException{
		return sqlMapClient.queryForList("Code.getCodeList","ORM001");
	}
}
