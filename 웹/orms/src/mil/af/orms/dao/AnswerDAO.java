package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.AnswerWithHeadQuestionVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("AnswerDAO")
public class AnswerDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;
	
	
	@SuppressWarnings("unchecked")
	public List<AnswerWithHeadQuestionVO> getAnswerWithHeadQuestionList(
			HashMap<String, Object> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Answer.getAnswerWithHeadQuestionList",parameterMap);
	}
	
	public void deleteDiagnosisTable(HashMap<String,Object> parameterMap) throws SQLException{
		sqlMapClient.delete("Answer.deleteDiagnosisTable",parameterMap);
	}

	public void insertDiagnosisTable(HashMap<String, Object> parameterMap) throws SQLException {
		sqlMapClient.insert("Answer.insertDiagnosisTable",parameterMap);
	}

	
}
