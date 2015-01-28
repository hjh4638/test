package mil.af.asti.model;
/*댓글테이블 모델*/
public class AstiBoardAddtextDTO {
	
	/*ASTI_BOARD_ADDTEXT테이블의 fk. ASTI_BOARD의 board_id 참조.not null임*/
	Integer board_id;
	
	/*ASTI_BOARD_ADDTEXT테이블의 pk*/
	Integer add_id;
	
	/*ASTI_BOARD_ADDTEXT테이블의 fk. ASTI_BOARD_ADDTEXT의 add_id 참조*/
	Integer add_upper_id;
	
	/*댓글 작성자. not null*/
	String add_writer;
	
	/*댓글 내용. not null*/
	String add_content;
	
	/*댓글 등록일. not null*/
	String add_register_date;
	
	String lev;
	
	public String getLev() {
		return lev;
	}
	public void setLev(String lev) {
		this.lev = lev;
	}
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public Integer getAdd_id() {
		return add_id;
	}
	public void setAdd_id(Integer add_id) {
		this.add_id = add_id;
	}
	public Integer getAdd_upper_id() {
		return add_upper_id;
	}
	public void setAdd_upper_id(Integer add_upper_id) {
		this.add_upper_id = add_upper_id;
	}
	public String getAdd_writer() {
		return add_writer;
	}
	public void setAdd_writer(String add_writer) {
		this.add_writer = add_writer;
	}
	public String getAdd_content() {
		return add_content;
	}
	public void setAdd_content(String add_content) {
		this.add_content = add_content;
	}
	public String getAdd_register_date() {
		return add_register_date;
	}
	public void setAdd_register_date(String add_register_date) {
		this.add_register_date = add_register_date;
	}

	
}
