package mil.af.asti.test.hjh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import mil.af.asti.model.*;

import com.ibatis.sqlmap.client.SqlMapClient;

public class DeptDao {

	private SqlMapClient sqlMapClientTemplate;
	
	DeptDao(){
		TotalTest test = new TotalTest();
		try {
			sqlMapClientTemplate = test.getSqlMapClient();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Integer getMaxWorkerId() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("DeptSql.getMaxWorkerId");
	}
	public void mergeIntoWorker(AstiResearchWorkerDTO workerDTO) throws SQLException{
		sqlMapClientTemplate.insert("DeptSql.mergeIntoWorker", workerDTO);
	}
	public void deleteWorker(AstiBoardSearchDTO searchDTO) throws SQLException{
		sqlMapClientTemplate.delete("DeptSql.deleteWorker", searchDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiResearchWorkerDTO> getWorkerList(AstiBoardSearchDTO searchDTO) throws SQLException{
		return sqlMapClientTemplate.queryForList("DeptSql.getWorkerList", searchDTO);
	}
	
}
