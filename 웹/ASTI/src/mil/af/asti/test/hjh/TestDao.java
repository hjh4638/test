package mil.af.asti.test.hjh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiBoardPaginationDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiResearchWorkerDTO;

import com.ibatis.sqlmap.client.SqlMapClient;

public class TestDao{
	private SqlMapClient sqlMap;
	
	public TestDao(){
		TotalTest t= new TotalTest();
		try {
			sqlMap = t.getSqlMapClient();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void insertBoard(AstiBoardDTO astiBoardDTO) throws SQLException{
		sqlMap.insert("hjhtest.insertBoard", astiBoardDTO);
	}
	public Integer getMaxBoardId() throws SQLException{
		Integer maxBoardId = (Integer) sqlMap.queryForObject("hjhtest.getMaxBoardId");
		if(maxBoardId==null)
			return 0;
		else return maxBoardId; 
	}
	public Integer getMaxWorkerId() throws SQLException{
		Integer maxWorkerId = (Integer) sqlMap.queryForObject("hjhtest.getMaxWorkerId");
		if(maxWorkerId==null)
			return 0;
		else return maxWorkerId; 
	}
	@SuppressWarnings("unchecked")
	public List<AstiBoardDTO> getBoardList(AstiBoardSearchDTO astiBoardSearchDTO) throws SQLException{
		return sqlMap.queryForList("hjhtest.getBoardList", astiBoardSearchDTO);
	}
	public Integer getBoardCount() throws SQLException{
		return (Integer) sqlMap.queryForObject("hjhtest.getBoardCount");
	}
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getColumnLength() throws SQLException{
		return sqlMap.queryForList("hjhtest.getColumnLength");
	}
	public void insertBoardFile(AstiBoardFileDTO astiBoardFileDTO) throws SQLException{
		sqlMap.insert("hjhtest.insertBoardFile",astiBoardFileDTO);
	}
	public Integer getBoardFileSeq() throws SQLException{
		return (Integer) sqlMap.queryForObject("hjhtest.getBoardFileSeq");
	}
	public void mergeIntoBoard(AstiBoardDTO astiBoardDTO) throws SQLException{
		sqlMap.insert("hjhtest.mergeIntoBoard", astiBoardDTO);
	}
	public void deleteBoardFile(AstiBoardFileDTO astiBoardFileDTO) throws SQLException{
		sqlMap.delete("hjhtest.deleteBoardFile",astiBoardFileDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getAstiCodeByType(String code_type) throws SQLException{
		return sqlMap.queryForList("hjhtest.getAstiCodeByType", code_type);
	}
	public void insertResearchWorker(AstiResearchWorkerDTO astiResearchWorkerDTO) throws SQLException{
		sqlMap.insert("hjhtest.insertREsearchWorker", astiResearchWorkerDTO);
	}
	public void deleteBoard() throws SQLException{
		sqlMap.delete("hjhtest.deleteBoard");
	}
	public void deleteFile() throws SQLException{
		sqlMap.delete("hjhtest.deleteFile");
	}
	public void deleteAdd() throws SQLException{
		sqlMap.delete("hjhtest.deleteAdd");
	}
}
