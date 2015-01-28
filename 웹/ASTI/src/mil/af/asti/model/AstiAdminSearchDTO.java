package mil.af.asti.model;

/**
 * @author 한다현
 * 자유게시판 검색을 위해 필요한 Type과 그에 따른 내용을 지정할 수 있는 클래스
 */
public class AstiAdminSearchDTO {
	/**
	 * 검색 타입 - ID , 권한으로 검색이 가능하게
	 */
	private String searchType;
	/**
	 * 검색 내용 - 검색 타입에 따른 검색 내용
	 */
	private String searchDetail;

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

	
	
	
}
