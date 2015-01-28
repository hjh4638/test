package mil.af.asti.board;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import mil.af.asti.common.CommonDAO;
import mil.af.asti.model.AstiBoardAddtextDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiBoardPaginationDTO;
import mil.af.asti.model.AstiBoardDTO;
import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiCodeDTO;

import org.springframework.stereotype.Service;

import util.PaginationUtil;

@Service
public class BoardService {

	@Resource
	private BoardDAO boardDAO;
	
	@Resource 
	private CommonDAO commonDAO;
	/*******************************Board*******************************/
	
	/**
	 * 해당 검색 조건에 대한 글 목록
	 */
	public List<AstiBoardDTO> getBoardContentsList(
			AstiBoardSearchDTO astiBoardSearchDTO){
		return boardDAO.getBoardContentsList(astiBoardSearchDTO);
	}
	
	/**
	 * 해당 검색 조건에 대한 총 글 수
	 */ 
	public int getBoardContentsCount(AstiBoardSearchDTO astiBoardSearchDTO){
		return boardDAO.getBoardContentsCount(astiBoardSearchDTO);
	}
	/**
	 * 해당 게시판에 대한 간판
	 */
	public String getboardSign(AstiBoardSearchDTO astiBoardSearchDTO) {
		return boardDAO.getBoardSign(astiBoardSearchDTO);
	}
	/*******************************************************************/
	/******************************Board View***************************/
	/**
	 * 게시판 , 게시글 번호를 이용해 글을 불러온다.
	 */
	public AstiBoardDTO getBoardContent(AstiBoardSearchDTO astiBoardSearchDTO) {
		return boardDAO.getBoardContent(astiBoardSearchDTO);
	}
	/*******************************************************************/
	/****************************Auth Check*****************************/
//	public String authCheck(String boardCode,String myAuth){
//		String writerCode = boardDAO.getWriterCode(boardCode);
//		String writerUpperGrade = boardDAO.getWriterUpperGrade();
//		
//		if(writerCode.equals(writerUpperGrade)){
//			if(myAuth.equals(writerCode)){
//				return "writerAuth";
//			}
//		}
//		else{
//			int wc = Integer.parseInt(writerCode.substring(1,3));
//			int wug = Integer.parseInt(writerUpperGrade.substring(1,3));
//			for(int i = wc;i>wug;i--){
//				String code_id = "";
//				if(wc<10){
//					code_id = "A0"+Integer.toString(wc);
//				}
//				else{
//					code_id = "A"+Integer.toString(wc);
//				}
//				
//				if(code_id.equals(myAuth)){
//					return "writerAuth";
//				}
//			}
//		}
//		
//		return "nonAuth";
//	}
	/*******************************************************************/
	
	/******************************Validate*****************************/
	/**
	 * Uri 중 board_type에 대한 유효성 검사
	 * 만약 board_type에 해당하지 않는 uri값을 입력할 경우
	 * 가장 최상위의 게시판 코드에 해당하는 게시판으로 향한다.
	 */
	public String validateBoardUri(String board){
		List<String> boardList = boardDAO.getBoardCodeList(board);
		boolean isNotCheat = false;
		for(String board_code : boardList)
		{
			if(board_code.equals(board)){
				isNotCheat = true;
			}
		}
		if(!isNotCheat){
			board = boardList.get(0);
		}
		return board;
	}
	/******************************************************************/
	public List<AstiBoardFileDTO> getBoardFile(AstiBoardSearchDTO astiBoardSearchDTO){
		return boardDAO.getBoardFile(astiBoardSearchDTO);
	}
	
	/**
	 * board_id 있으면 update 없으면 insert
	 * @param astiBoardDTO
	 */
	public void boardMerge(AstiBoardDTO astiBoardDTO) throws Exception{
		if(checkDataLength(AstiBoardDTO.class, astiBoardDTO))
			boardDAO.mergeIntoBoard(astiBoardDTO);
		else
			System.out.println("글자수가 초과되었습니다.");
	}
	/**
	 * @param astiBoardFileDTO
	 * @return
	 */
	public void insertBoardFile(Integer board_id, Map<String,String> filenames) throws Exception{
		Iterator<String> keys = filenames.keySet().iterator();
		
		AstiBoardSearchDTO searchDTO = new AstiBoardSearchDTO();
		searchDTO.setBoard_id(board_id+"");
		deleteBoardFile(searchDTO);
		
		AstiBoardFileDTO astiBoardFileDTO = new AstiBoardFileDTO();
		astiBoardFileDTO.setBoard_id(board_id);
		while(keys.hasNext()){
			String key = keys.next();
			
			astiBoardFileDTO.setFilename(key);
			astiBoardFileDTO.setFile_id(filenames.get(key));
			
			if(checkDataLength(AstiBoardFileDTO.class, astiBoardFileDTO)){
				boardDAO.insertBoardFile(astiBoardFileDTO);
			}
			else
				System.out.println("글자수가 초과되었습니다.");
		}
	}
	public String createFileId(){
		Integer randomNumber1 = (int) (Math.random()*1000000000);
		Integer randomNumber2 = (int) (Math.random()*1000000000);
		Integer fileSeq = boardDAO.getBoardFileSeq();
		String file_id = randomNumber1+""+fileSeq+""+randomNumber2;
		return file_id;
	}
	/**
	 * boardFile delete
	 * @param astiBoardFileDTO
	 * @throws SQLException
	 */
	public void deleteBoardFile(AstiBoardSearchDTO search){
		if(search.getBoard_id() !=null || !("".equals(search.getBoard_id())))
			boardDAO.deleteBoardFile(search);
		else 
			System.out.println("board_id가 널입니다.");
	}
	/**
	 * 해당 DTO와 DTO.class를 보내주면 DTO field와 DB 테이블 컬럼 데이터 length와 비교하여 값 반환
	 * 프로퍼티 타입이 Sring인것만 해당
	 * @param tagetClass
	 * @param dto
	 * @return
	 * 
	 */
	public boolean checkDataLength(Class<?> tagetClass, Object dto) throws Exception{
		/*reflect를 이용하여 DTO를 fieldname를 키로 그 값을 value로 하는 map객체 생성*/
		Map<String,String> dtoMap = new HashMap<String,String>();
		
		Field[] field =tagetClass.getDeclaredFields();
		
		for(int i=0;i<field.length;i++){
			if(field[i].getType().getName().equals("java.lang.String")){
				String property = field[i].getName().substring(0, 1).toUpperCase()+field[i].getName().substring(1);
				Method me = tagetClass.getDeclaredMethod("get"+property);
				String pro = (String) me.invoke(dto);
				dtoMap.put(field[i].getName(),pro);
			}
		}
		/*dba_tab_columns에서 가져온 제약데이터길이로 길이체크*/
		List<AstiCodeDTO> code = boardDAO.getColumnLength();
		for(int i=0;i<code.size();i++){
			AstiCodeDTO coco = code.get(i);
			String zxc =coco.getCode_id().toLowerCase(); 
			if(dtoMap.get(zxc) !=null){
				if(dtoMap.get(zxc).getBytes("euc-kr").length >Integer.parseInt(coco.getCode_name())){
					return false;
				}
			}
		}
		return true;
	}
	
	
	public Integer getMaxBoardId(){
		return boardDAO.getMaxBoardId();
	}
	
	/**
	 * input된 데이터가 board_type에 속하는지 판단
	 * @param type
	 * @return
	 * @throws SQLException
	 */
	public boolean containBoardType(String type){
		List<AstiCodeDTO> sdd = commonDAO.getAstiCodeByType("board");
			
		for(int i=0;i<sdd.size();i++){
			if(sdd.get(i).getCode_id().equals(type))
				return true;
		}
		return false;
	}

	/*******************************Comment*******************************/
	public void insertBoardComment(AstiBoardAddtextDTO astiBoardAddtextDTO) {
		boardDAO.insertBoardComment(astiBoardAddtextDTO);
		
	}
	
	public List<AstiBoardAddtextDTO> getBoardComments(AstiBoardDTO astiBoardDTO){
		return boardDAO.getBoardComments(astiBoardDTO);
	}
	/*********************************************************************/

	public void insertReplyComment(AstiBoardAddtextDTO astiBoardAddtextDTO) {
		boardDAO.insertReplyComment(astiBoardAddtextDTO);
	}

	public void appendFileToBoard(List<AstiBoardDTO> boardContentsList,
			List<AstiBoardFileDTO> boardFile) {
		int contentSize = boardContentsList.size();
		int fileSize = boardFile.size();
		for(int i=0;i<contentSize;i++){
			AstiBoardDTO board = boardContentsList.get(i);
			List<AstiBoardFileDTO> fileList = new ArrayList<AstiBoardFileDTO>();
			for(int k=0;k<fileSize;k++){
				AstiBoardFileDTO file = boardFile.get(k);
				if(board.getBoard_id().equals(file.getBoard_id()))
					fileList.add(file);
			}
			board.setAstiBoardFileDTO(fileList);
		}
	}
	public void deleteBoard(AstiBoardSearchDTO search){
		boardDAO.deleteBoard(search);
	}
	public void deleteAdd(AstiBoardSearchDTO search){
		boardDAO.deleteAdd(search);
	}

	public AstiBoardDTO getBoardNextDTO(AstiBoardDTO boardContent) {
		if(!isCanCheckNextPrevious(boardContent)){
			return null;
		}
		int rnum = boardDAO.getBoardRnumByDTO(boardContent);
		int saveBoardId = boardContent.getBoard_id();
		if(rnum <= 1){
			return null;
		}else{
			boardContent.setBoard_id(rnum-1);
			int board_id = 	boardDAO.getBoardIdByRnum(boardContent);
			boardContent.setBoard_id(saveBoardId);
			return boardDAO.getDTOByBoardId(board_id);
		}
	}

	public AstiBoardDTO getBoardPreviousDTO(AstiBoardDTO boardContent) {
		if(!isCanCheckNextPrevious(boardContent)){
			return null; 
		}
		if(boardDAO.getCountByBoardType(boardContent)==boardDAO.getBoardRnumByDTO(boardContent)){
			return null;
		}
		int rnum = boardDAO.getBoardRnumByDTO(boardContent);
		int saveBoardId = boardContent.getBoard_id();
		boardContent.setBoard_id(rnum+1);
		int board_id = 	boardDAO.getBoardIdByRnum(boardContent);
		boardContent.setBoard_id(saveBoardId);
			return boardDAO.getDTOByBoardId(board_id);
	}
	
	public boolean isCanCheckNextPrevious(AstiBoardDTO boardContent){
		int countByBoardType = boardDAO.getCountByBoardType(boardContent);
		if(countByBoardType<=1){
			return false;
		}
		return true;
	}
	public List<AstiBoardFileDTO> getMainDeptImage(){
		return boardDAO.getMainDeptImage();
	}
}
