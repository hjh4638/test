package mil.af.asti.test.hjh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import mil.af.asti.model.*;

import com.ibatis.sqlmap.client.SqlMapClient;

public class PageDao {

	private SqlMapClient sqlMapClientTemplate;
	
	PageDao(){
		TotalTest test = new TotalTest();
		try {
			sqlMapClientTemplate = test.getSqlMapClient();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public AstiPageDTO getPageInfo(String page_id) throws SQLException{
		return (AstiPageDTO) sqlMapClientTemplate.queryForObject("AdminSql.getPageInfo", page_id);
	}
	public void updatePageInfo(AstiPageDTO pageDTO) throws SQLException{
		sqlMapClientTemplate.update("AdminSql.updatePageInfo", pageDTO);		
	}
}
