package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.CalVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("CalDAO")
public class CalDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	@SuppressWarnings("unchecked")
	public List<CalVO> getCalList(String airplane) throws SQLException { 
		if("06".equals(airplane)
		   || "07".equals(airplane)
		   || "08".equals(airplane)
		   || "09".equals(airplane)
		   || "10".equals(airplane)
		   || "11".equals(airplane)
		   || "12".equals(airplane)
		   || "13".equals(airplane)
		   || "14".equals(airplane)
		   || "15".equals(airplane)
		   || "16".equals(airplane)
		   || "17".equals(airplane)
		   || "18".equals(airplane)
		   || "19".equals(airplane)
		   || "20".equals(airplane)
		   || "21".equals(airplane)
		   || "22".equals(airplane)   
		   || "23".equals(airplane)
		   || "24".equals(airplane)
		   || "25".equals(airplane)		   
		   || "26".equals(airplane))
			return sqlMapClient.queryForList("Cal.getNormalCalList",airplane);
		
		return sqlMapClient.queryForList("Cal.getFihgterCalList",airplane);
	}
}
