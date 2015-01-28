package mil.af.iers.config;

import java.io.IOException;
import java.io.Reader;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class LocalIbatis {
	private String resource = "mil/af/iers/config/junitTest-sqlMapConfig.xml";
	
	public SqlMapClientTemplate getSqlMapClientTemplate() throws IOException{
		Reader reader = Resources.getResourceAsReader(resource);
		SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		return new SqlMapClientTemplate(sqlMap);
	}
	
	public SqlMapClient getSqlMapClient() throws IOException{
		Reader reader = Resources.getResourceAsReader(resource);
		SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		return sqlMap;
	}
}
