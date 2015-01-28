package mil.af.hq.orms.test.hjh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

public class TestDao {
	private SqlMapClient sqlMapClientTemplate;
	
	public TestDao() {
		LocalIbatis setting = new LocalIbatis();
		try {
			this.sqlMapClientTemplate=setting.getSqlMapClient();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public List<DataOfHistoryDTO> getScoreTypeCount() throws SQLException{
		return (List<DataOfHistoryDTO>) sqlMapClientTemplate.queryForList("TestSql.getScoreTypeCount");
	}
	public List<DataOfHistoryDTO> getScoreDetailData() throws SQLException{
		return (List<DataOfHistoryDTO>) sqlMapClientTemplate.queryForList("TestSql.getScoreDetailData");
	}
}
