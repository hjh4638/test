package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.orms.model.QuestionVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("QuestionDAO")
public class QuestionDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	
	// 교육훈련기, 특수임무기 확대적용 12.10.11
	@SuppressWarnings("unchecked")
	public List<QuestionVO> getQuestionListByLevel(Map<String,Object> parameterMap) throws SQLException {
		if("06".equals(parameterMap.get("airplane")) || "07".equals(parameterMap.get("airplane")) 
				|| "08".equals(parameterMap.get("airplane")) || "09".equals(parameterMap.get("airplane"))
				|| "10".equals(parameterMap.get("airplane")) || "11".equals(parameterMap.get("airplane"))
				|| "12".equals(parameterMap.get("airplane")) || "13".equals(parameterMap.get("airplane"))
				|| "14".equals(parameterMap.get("airplane")) || "15".equals(parameterMap.get("airplane"))
				|| "16".equals(parameterMap.get("airplane")) || "17".equals(parameterMap.get("airplane"))
				|| "18".equals(parameterMap.get("airplane")) || "19".equals(parameterMap.get("airplane"))
				|| "20".equals(parameterMap.get("airplane")) || "21".equals(parameterMap.get("airplane"))
				|| "22".equals(parameterMap.get("airplane")) || "23".equals(parameterMap.get("airplane"))
				|| "24".equals(parameterMap.get("airplane")) || "25".equals(parameterMap.get("airplane"))
				|| "26".equals(parameterMap.get("airplane")))
			return sqlMapClient.queryForList("Question.getNormalQuestionListByLevel",parameterMap);	
			
		return sqlMapClient.queryForList("Question.getFighterListByLevel",parameterMap);
	}

	@SuppressWarnings("unchecked")
	public List<QuestionVO> getQuestionListByOneLevel(Map<String,Object> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Question.getQuestionListByOneLevel",parameterMap);
	}

	
	// 교육훈련기, 특수임무기 확대적용 12.10.11
	@SuppressWarnings("unchecked")
	public List<QuestionVO> getQuestionListWithScoreByLevel(HashMap<String, String> parameterMap) throws SQLException {
		if("06".equals(parameterMap.get("airplane")) || 
			"07".equals(parameterMap.get("airplane")) ||
			"08".equals(parameterMap.get("airplane")) ||
			"09".equals(parameterMap.get("airplane")) ||
			"10".equals(parameterMap.get("airplane")) ||
			"11".equals(parameterMap.get("airplane")) ||
			"12".equals(parameterMap.get("airplane")) ||
			"13".equals(parameterMap.get("airplane")) ||
			"14".equals(parameterMap.get("airplane")) ||
			"15".equals(parameterMap.get("airplane")) ||
			"16".equals(parameterMap.get("airplane")) ||
			"17".equals(parameterMap.get("airplane")) ||
			"18".equals(parameterMap.get("airplane")) ||
			"19".equals(parameterMap.get("airplane")) ||
			"20".equals(parameterMap.get("airplane")) ||
			"21".equals(parameterMap.get("airplane")) ||
			"22".equals(parameterMap.get("airplane")) ||				
			"23".equals(parameterMap.get("airplane")) ||
			"24".equals(parameterMap.get("airplane")) ||
			"25".equals(parameterMap.get("airplane")) ||
			"26".equals(parameterMap.get("airplane")))
			return sqlMapClient.queryForList("Question.getNormalListWithScoreByLevel",parameterMap);
		
		return sqlMapClient.queryForList("Question.getFighterListWithScoreByLevel",parameterMap);
	}

	
	// 교육훈련기, 특수임무기 확대적용 12.10.11
	public Integer getHeadQuestionCount(String airplane) throws SQLException {
		if("06".equals(airplane) ||
				"07".equals(airplane) ||
				"08".equals(airplane) ||
				"09".equals(airplane) ||
				"10".equals(airplane) ||
				"11".equals(airplane) ||
				"12".equals(airplane) ||
				"13".equals(airplane) ||
				"14".equals(airplane) ||
				"15".equals(airplane) ||
				"16".equals(airplane) ||
				"17".equals(airplane) ||
				"18".equals(airplane) ||
				"19".equals(airplane) ||
				"20".equals(airplane) ||
				"21".equals(airplane) ||
				"22".equals(airplane) ||
				"23".equals(airplane) ||
				"24".equals(airplane) ||
				"25".equals(airplane) ||			
				"26".equals(airplane))
			return (Integer) sqlMapClient.queryForObject("Question.getNormalHeadQuestionCount",airplane);

		return (Integer) sqlMapClient.queryForObject("Question.getFighterHeadQuestionCount",airplane);
	}

	public String getQuestion_name(int idForSubject) throws SQLException {
		// TODO Auto-generated method stub
		return (String)sqlMapClient.queryForObject("Question.getQuestion_name", idForSubject);
	}


	public String getlastChecked_Date(HashMap<String, String> map) throws SQLException {
		// TODO Auto-generated method stub
		return (String)sqlMapClient.queryForObject("Question.getlastChecked_Date", map);
	}

	public int getnumberOfChecked(HashMap<String, String> map) throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) sqlMapClient.queryForObject("Question.getnumberOfChecked", map);
	}

	
}
