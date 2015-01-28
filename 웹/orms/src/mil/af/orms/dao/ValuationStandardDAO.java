package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;



import mil.af.orms.model.QuestionVO;
import mil.af.orms.model.QuestionWithAllScoreVO;
import mil.af.orms.model.ScoreVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("ValuationStandardDao")

public class ValuationStandardDAO {

	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;
	
	@SuppressWarnings("unchecked")
	
	/*기종별로 DB에서 가져옴*/
	public List<QuestionWithAllScoreVO> getQuestionListWithAllScoreByLevel(String code)  throws Exception {
		if(("06").equals(code) || ("07").equals(code)){	return sqlMapClient.queryForList("Question.getTRANSPORT_PLANE_QS",code);}
		if(("08").equals(code)){return sqlMapClient.queryForList("Question.getHELICOPTER_QS",code);}
		if(("09").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_09",code);}
		if(("10").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_10",code);}
		if(("11").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_11",code);}
		if(("12").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_12",code);}
		if(("13").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_13",code);}
		if(("14").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_14",code);}
		if(("15").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_15",code);}
		if(("16").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_16",code);}
		if(("17").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_17",code);}
		if(("18").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_18",code);}
		if(("19").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_19",code);}
		if(("20").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_20",code);}
		if(("21").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_21",code);}
		if(("22").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_22",code);}
		if(("23").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_23",code);}
		if(("24").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_24",code);}
		if(("25").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_25",code);}
		if(("26").equals(code)){return sqlMapClient.queryForList("Question.getPLANECODE_26",code);}
				
		return sqlMapClient.queryForList("Question.getFIGHTER_PLANE_QS",code);
		
	}

	public int updateScore(ScoreVO scoreVO) throws SQLException {
		// TODO Auto-generated method stub
		return sqlMapClient.update("Question.updateScore",scoreVO);
	}

	public int updateQuestion(QuestionWithAllScoreVO questionWithAllScoreVO) throws SQLException {
		// TODO Auto-generated method stub
		return sqlMapClient.update("Question.updateQuestion", questionWithAllScoreVO);
		
	}

	public void insertQuestion(QuestionWithAllScoreVO questionWithAllScoreVO) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("Question.insertQuestion", questionWithAllScoreVO);
	}

	public void insertScore(ScoreVO ScoreVO) throws SQLException {
		
		sqlMapClient.insert("Question.insertScore", ScoreVO);
	}

	public void changeUseYn(int id) throws SQLException {
		sqlMapClient.update("Question.changeUseYn",id);
	}

	
}
