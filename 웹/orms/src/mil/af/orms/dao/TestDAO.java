package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("TestDAO")
public class TestDAO {
	
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;
	

	public List getTestList() throws SQLException {
		return sqlMapClient.queryForList("Common.testSql");
	}

}
