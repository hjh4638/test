package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("DiagnosisStatusDAO")
public class DiagnosisStatusDAO {

	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	
	
	
}
