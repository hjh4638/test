package mil.af.asti.model;

import java.util.List;

/*메인게시판테이블 모델*/
public class AstiBoardDTO {
	Integer row_number;
	
	Integer row_count;
	
	public Integer getRow_number() {
		return row_number;
	}
	public void setRow_number(Integer row_number) {
		this.row_number = row_number;
	}
	public Integer getRow_count() {
		return row_count;
	}
	public void setRow_count(Integer row_count) {
		this.row_count = row_count;
	}
	/*ASTI_BOARD테이블의 pk.*/
	Integer board_id;
	
	/*ASTI_BOARD 테이블의 fk. ASTI_USER의 user_id 참조*/
	String user_id;
	
	/*게시판 제목. not null*/
	String board_title;
	
	/*게시판 내용. not null*/
	String board_content;
	
	/*게시판 작성자. not null*/
	String board_writer;
	
	/*게시판 작성일. not null*/
	String board_register_date;
	
	String board_password;
	
	/*ASTI_BOARD 테이블의 fk. ASTI_CODE의 code_id 참조*/
	String board_authority;
	
	/*ASTI_BOARD 테이블의 fk. ASTI_CODE의 code_id 참조*/
	String board_type;
	
	/*ASTI_BOARD 테이블의 board_authority 코드에 해당하는 ASTI_CODE의 code_name*/
	String board_authority_name;
	
	/*ASTI_BOARD 테이블의 board_type 코드에 해당하는 ASTI_CODE의 code_name*/
	String board_type_name;
	String board_reference;
	
	List<AstiBoardFileDTO> astiBoardFileDTO;
	
	public List<AstiBoardFileDTO> getAstiBoardFileDTO() {
		return astiBoardFileDTO;
	}
	public void setAstiBoardFileDTO(List<AstiBoardFileDTO> astiBoardFileDTO) {
		this.astiBoardFileDTO = astiBoardFileDTO;
	}
	
	public String getBoard_authority_name() {
		return board_authority_name;
	}
	public void setBoard_authority_name(String board_authority_name) {
		this.board_authority_name = board_authority_name;
	}
	public String getBoard_type_name() {
		return board_type_name;
	}
	public void setBoard_type_name(String board_type_name) {
		this.board_type_name = board_type_name;
	}
	
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_register_date() {
		return board_register_date;
	}
	public void setBoard_register_date(String board_register_date) {
		this.board_register_date = board_register_date;
	}
	public String getBoard_authority() {
		return board_authority;
	}
	public void setBoard_authority(String board_authority) {
		this.board_authority = board_authority;
	}
	public String getBoard_password() {
		return board_password;
	}
	public void setBoard_password(String board_password) {
		this.board_password = board_password;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getBoard_reference() {
		return board_reference;
	}
	public void setBoard_reference(String board_reference) {
		this.board_reference = board_reference;
	}
	@Override
	public String toString() {
		return "board_id= "+board_id+", "+
				"user_id= "+user_id+", "+
				"board_title= "+board_title+", "+
				"board_content= "+board_content+", "+
				"board_writer= "+board_writer+", "+
				"board_register_date= "+board_register_date+", "+
				"board_authority= "+board_authority+", "+
				"board_authority_name= "+board_authority_name+", "+
				"board_password= "+board_password+", "+
				"board_type= "+board_type+", "+
				"board_type_name= "+board_type_name+", "+
				"board_reference= "+board_reference;
	}
}
