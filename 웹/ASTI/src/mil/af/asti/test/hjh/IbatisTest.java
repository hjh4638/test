package mil.af.asti.test.hjh;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mil.af.asti.model.*;

import org.junit.Test;

/**
 * @author Administrator
 *
 */
public class IbatisTest{
	private TestDao testDao=new TestDao();

	public void aa(){
		
	}

	
	public void dd(){
		int i=0;
		while(i<10){
			i++;
			System.out.println("tes");
			if(i==5)
				break;
		}
	}
	
	public void testttt(){
		String worker_id = null;
		System.out.println(worker_id);
		System.out.println(worker_id+"");
		worker_id ="";
		System.out.println(worker_id);
	}
	
	 
	public void resetTable() throws SQLException{
		testDao.deleteAdd();
		testDao.deleteFile();
		testDao.deleteBoard();
	}
	
	/* */
	public void researchWorkerInsert() throws SQLException{
		Integer worker_id = testDao.getMaxWorkerId()+1;
		
		AstiResearchWorkerDTO input = new AstiResearchWorkerDTO();
		
		for(int i=0;i<40;i++){
		input.setWorker_id(worker_id+i);
		input.setWorker_name("이승호");
		input.setWorker_department("C01");
		
		input.setWorker_detail_info("담배는 맛있어~~");
		
		testDao.insertResearchWorker(input);
		}
	}
/*	 */
	public void boardInsertTest() throws Exception{
	
		Integer board_id = testDao.getMaxBoardId()+1;
		String title = "test";
		String content = "스트링테스트"
								;
		String writer = "abc";
		List<String> asd = new ArrayList<String>();
		asd.add("B00");asd.add("B01");asd.add("B02");asd.add("B03");asd.add("B04");asd.add("B05");asd.add("B06");asd.add("B07");asd.add("B08");
		
		/*입력원하는 행수*/
		int count = 1;
				
		for(int i=0;i<count;i++){
			AstiBoardDTO astiBoardDTO = new AstiBoardDTO();
			/*not null*/
			astiBoardDTO.setBoard_id(board_id+i);
			astiBoardDTO.setBoard_title(i+i+i+title+i);
			astiBoardDTO.setBoard_content(content);
			astiBoardDTO.setBoard_writer(writer);
			
			astiBoardDTO.setUser_id(null);
			astiBoardDTO.setBoard_authority(null);
			astiBoardDTO.setBoard_password(null);
			astiBoardDTO.setBoard_type(asd.get(i%9));
			astiBoardDTO.setBoard_reference(null);
			astiBoardDTO.setBoard_register_date("2013/03/04");
			if(checkDataLength(AstiBoardDTO.class, astiBoardDTO))
				testDao.insertBoard(astiBoardDTO);
			else
				System.out.println("글자수가 초과되었습니다.");
			
			System.out.println(checkDataLength(AstiBoardDTO.class, astiBoardDTO));
		}
		
	}
	
/*	 */
	public void getBoardList() throws SQLException{
		Integer board_count = testDao.getBoardCount();
		AstiBoardSearchDTO search = new AstiBoardSearchDTO();
		AstiBoardPaginationDTO pagination = new AstiBoardPaginationDTO(3,board_count);
		search.setAstiBoardPaginationDTO(pagination);
		
		List<AstiBoardDTO> board_list = testDao.getBoardList(search);
		
		for(int i=0; i<board_list.size(); i++){
			AstiBoardDTO board = board_list.get(i);
		}
	}
	
	/**
	 * 해당 DTO와 DTO.class를 보내주면 DTO field와 DB 테이블 컬럼 데이터 length와 비교하여 값 반환
	 * 프로퍼티 타입이 Sring인것만 해당
	 * @param tagetClass
	 * @param dto
	 * @return
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
		List<AstiCodeDTO> code = testDao.getColumnLength();
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
	@Test
	public void bodInsert() throws Exception{
		Integer board_id = testDao.getMaxBoardId()+1;
		String title = "merge";
		String content = "merge"
						;
		String writer = "asdfasdfs";
		List<String> asd = new ArrayList<String>();
		asd.add("B00");asd.add("B01");asd.add("B02");asd.add("B03");asd.add("B04");asd.add("B05");asd.add("B06");asd.add("B07");asd.add("B08");
		/*입력원하는 행수*/
		int i = 1;
		AstiBoardDTO astiBoardDTO = new AstiBoardDTO();
		/*not null*/
		astiBoardDTO.setBoard_id(board_id);
		astiBoardDTO.setBoard_title(i+i+i+title+i);
		astiBoardDTO.setBoard_content(content);
		astiBoardDTO.setBoard_writer(writer);
		
		astiBoardDTO.setUser_id(null);
		astiBoardDTO.setBoard_authority(null);
		astiBoardDTO.setBoard_password(null);
		astiBoardDTO.setBoard_type(asd.get(i%9));
		astiBoardDTO.setBoard_reference(null);
		
		if(checkDataLength(AstiBoardDTO.class, astiBoardDTO))
			testDao.mergeIntoBoard(astiBoardDTO);
		else
			System.out.println("글자수가 초과되었습니다.");
		
		Integer randomNumber1 = (int) (Math.random()*1000000000);
		Integer randomNumber2 = (int) (Math.random()*1000000000);
		Integer fileSeq = testDao.getBoardFileSeq();
		
		String file_id = randomNumber1+""+fileSeq+""+randomNumber2;
		String filename = "qqnsldkdjdldkdj";
		
		AstiBoardFileDTO astiBoardFileDTO = new AstiBoardFileDTO();
		astiBoardFileDTO.setBoard_id(board_id);
		astiBoardFileDTO.setFile_id(file_id);
		astiBoardFileDTO.setFilename(filename);
				
		if(checkDataLength(AstiBoardFileDTO.class, astiBoardFileDTO))
			testDao.insertBoardFile(astiBoardFileDTO);
		else
			System.out.println("글자수가 초과되었습니다.");
		
			
	}
	/**
	 * board_id 있으면 update 없으면 insert
	 * @param astiBoardDTO
	 * @throws SQLException
	 * @throws Exception
	 */
	public void boardMerge(AstiBoardDTO astiBoardDTO) throws SQLException, Exception{
		if(checkDataLength(AstiBoardDTO.class, astiBoardDTO))
			testDao.mergeIntoBoard(astiBoardDTO);
		else
			System.out.println("글자수가 초과되었습니다.");
	}
	/**
	 * file_id만 난수로 만들어서 입력
	 * @param astiBoardFileDTO
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 */
	public void boardFileInsert(AstiBoardFileDTO astiBoardFileDTO) throws SQLException, Exception{
		Integer randomNumber1 = (int) (Math.random()*1000000000);
		Integer randomNumber2 = (int) (Math.random()*1000000000);
		Integer fileSeq = testDao.getBoardFileSeq();
		
		String file_id = randomNumber1+""+fileSeq+""+randomNumber2;
		astiBoardFileDTO.setFile_id(file_id);
		
		if(checkDataLength(AstiBoardFileDTO.class, astiBoardFileDTO)){
			testDao.insertBoardFile(astiBoardFileDTO);
		}
		else
			System.out.println("글자수가 초과되었습니다.");
	}
	/**
	 * boardFile delete
	 * @param astiBoardFileDTO
	 * @throws SQLException
	 */
	public void deleteBoardFile(AstiBoardFileDTO astiBoardFileDTO) throws SQLException{
		if(astiBoardFileDTO.getBoard_id() !=null)
			if(!(astiBoardFileDTO.getBoard_id().equals("")))
				testDao.deleteBoardFile(astiBoardFileDTO);
			else
				System.out.println("board_id가  \"\"입니다.");
		else 
			System.out.println("board_id가 널입니다.");
	}
}
