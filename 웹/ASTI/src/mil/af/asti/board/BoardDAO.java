package mil.af.asti.board;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;


import mil.af.asti.model.AstiBoardAddtextDTO;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;


@Repository
public class BoardDAO {

	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate; 
	/**************************Board**********************/
	@SuppressWarnings("unchecked")
	public List<AstiBoardDTO> getBoardContentsList(
			AstiBoardSearchDTO astiBoardSearchDTO) {
		return (List<AstiBoardDTO>) sqlMapClientTemplate.queryForList(
				"BoardSql.getBoardContentsList",astiBoardSearchDTO);
	}

	
	public int getBoardContentsCount(
			AstiBoardSearchDTO astiBoardSearchDTO) {
		return (Integer) sqlMapClientTemplate.queryForObject(
				"BoardSql.getBoardContentsCount",astiBoardSearchDTO);
	}
	
	public String getBoardSign(AstiBoardSearchDTO astiBoardSearchDTO) {
		return (String) sqlMapClientTemplate.queryForObject(
				"CodeSql.getBoardSign",astiBoardSearchDTO);
	}
	/*****************************************************/
	
	/**************************Board View*****************/
	public AstiBoardDTO getBoardContent(AstiBoardSearchDTO astiBoardSearchDTO) {
		
		return (AstiBoardDTO) sqlMapClientTemplate.queryForObject(
				"BoardSql.getBoardContent",astiBoardSearchDTO);
	}
	/*****************************************************/
	
	/**************************Validate*******************/
	@SuppressWarnings("unchecked")
	public List<String> getBoardCodeList(String board){
		return (List<String>) sqlMapClientTemplate.queryForList(
				"CodeSql.getBoardCodeList");
	}
	/*****************************************************/
	
	/*게시판 입력 수정*/
	public void mergeIntoBoard(AstiBoardDTO astiBoardDTO){
		sqlMapClientTemplate.insert("BoardSql.mergeIntoBoard", astiBoardDTO);
	}
	/*nextval로 file_seq 구해옴*/
	public Integer getBoardFileSeq(){
		return (Integer) sqlMapClientTemplate.queryForObject("BoardSql.getBoardFileSeq");
	}
	/*첨부파일 입력*/
	public void insertBoardFile(AstiBoardFileDTO astiBoardFileDTO){
		sqlMapClientTemplate.insert("BoardSql.insertBoardFile",astiBoardFileDTO);
	}
	/*첨부파일 삭제*/
	public void deleteBoardFile(AstiBoardSearchDTO search){
		sqlMapClientTemplate.delete("BoardSql.deleteBoardFile",search);
	}
	/*컬럼 정보 조회*/
	@SuppressWarnings("unchecked")
	public List<AstiCodeDTO> getColumnLength(){
		return sqlMapClientTemplate.queryForList("BoardSql.getColumnLength");
	}
	/*board_id 최대값*/
	public Integer getMaxBoardId(){
		Integer maxBoardId = (Integer) sqlMapClientTemplate.queryForObject("BoardSql.getMaxBoardId");
		if(maxBoardId==null)
			return 0;
		else return maxBoardId; 
	}
	@SuppressWarnings("unchecked")
	public List<AstiBoardFileDTO> getBoardFile(AstiBoardSearchDTO astiBoardSearchDTO){
		return sqlMapClientTemplate.queryForList("BoardSql.getBoardFile", astiBoardSearchDTO);
	}

	/*******************************Comment**********************************/
	public void insertBoardComment(AstiBoardAddtextDTO astiBoardAddtextDTO) {
		sqlMapClientTemplate.insert("BoardSql.insertComment", astiBoardAddtextDTO);
	}

	@SuppressWarnings("unchecked")
	public List<AstiBoardAddtextDTO> getBoardComments(AstiBoardDTO astiBoardDTO) {
		return sqlMapClientTemplate.queryForList("BoardSql.getBoardComments",astiBoardDTO);
	}
	/*************************************************************************/


	public void insertReplyComment(AstiBoardAddtextDTO astiBoardAddtextDTO) {
		sqlMapClientTemplate.insert("BoardSql.insertReplyComment",astiBoardAddtextDTO);
	}
	
	public void deleteBoard(AstiBoardSearchDTO search){
		sqlMapClientTemplate.delete("BoardSql.deleteBoard",search);
	}
	public void deleteAdd(AstiBoardSearchDTO search){
		sqlMapClientTemplate.delete("BoardSql.deleteAdd",search);
	}


	public int getBoardRnumByDTO(AstiBoardDTO boardContent) {
		return (Integer)sqlMapClientTemplate.queryForObject("BoardSql.getBoardRnumByDTO",boardContent);
	}


	public int getBoardIdByRnum(AstiBoardDTO boardContent) {
		return (Integer)sqlMapClientTemplate.queryForObject("BoardSql.getBoardIdByRnum",boardContent);
	}


	public AstiBoardDTO getDTOByBoardId(int board_id) {
		return (AstiBoardDTO)sqlMapClientTemplate.queryForObject("BoardSql.getTitleByBoardId",board_id);
	}


	public int getCountByBoardType(AstiBoardDTO boardContent) {
		return (Integer)sqlMapClientTemplate.queryForObject("BoardSql.getCountByBoardType",boardContent);
	}
	
	@SuppressWarnings("unchecked")
	public List<AstiBoardFileDTO> getMainDeptImage(){
		return (List<AstiBoardFileDTO>) sqlMapClientTemplate.queryForList("BoardSql.getMainDeptImage");
	}
	
}
