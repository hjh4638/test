package mil.af.asti.model;

/**
 * @author 한다현
 * 자유게시판 검색을 위해 필요한 Type과 그에 따른 내용을 지정할 수 있는 클래스
 */
public class AstiBoardSearchDTO {
	/**
	 * 검색 타입 - 작성자 , 제목 , 내용으로 검색이 가능하게
	 */
	private String searchType;
	/**
	 * 검색 내용 - 검색 타입에 따른 검색 내용
	 */
	private String searchDetail;
	/**
	 * 검색 게시판 - 게시판에 따른 검색 내용
	 */
	private String board_type;
	
	/**
	 * 글을 보다가 목록을 눌러 나왔을때 검색 내용을 유지시키기 위한 용도의 글 번호 
	 */
	private String board_id;
	
	/**
	 * research_worker 검색할때 쓸 seq 
	 */
	private String worker_id;
	
	/**
	 * 검색 연구원 - 연구센터 종류에 따른 검색 내용
	 */
	private String worker_department;
	
	public String getWorker_department() {
		return worker_department;
	}

	public void setWorker_department(String worker_department) {
		this.worker_department = worker_department;
	}

	public String getWorker_id() {
		return worker_id;
	}

	public void setWorker_id(String worker_id) {
		this.worker_id = worker_id;
	}

	private AstiBoardPaginationDTO astiBoardPaginationDTO;
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	public String getSearchDetail() {
		return searchDetail;
	}
	
	public void setSearchDetail(String searchDetail) {
		this.searchDetail = searchDetail;
	}
	
	public AstiBoardPaginationDTO getAstiBoardPaginationDTO() {
		return astiBoardPaginationDTO;
	}

	public void setAstiBoardPaginationDTO(AstiBoardPaginationDTO astiBoardPaginationDTO) {
		this.astiBoardPaginationDTO = astiBoardPaginationDTO;
	}

	
	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	
	public String getBoard_id() {
		return board_id;
	}

	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}

	@Override
	public String toString() {
		return "AstiBoardSearchDTO [searchType=" + searchType
				+ ", searchDetail=" + searchDetail + ", board_type="
				+ board_type + ", astiBoardPaginationDTO="
				+ astiBoardPaginationDTO + "]";
	}

	
	
	
}
