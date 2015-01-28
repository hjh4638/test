package mil.af.asti.test.hjh;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class TotalTest {
	private String resource = "mil/af/asti/config/junitTest-sqlMapConfig.xml";
	
	public SqlMapClient getSqlMapClient() throws IOException{
		Reader reader = Resources.getResourceAsReader(resource);
		SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		return sqlMap;
	}
}
