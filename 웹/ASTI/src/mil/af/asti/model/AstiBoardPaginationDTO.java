package mil.af.asti.model;

/**
 * @author 한다현
 * pagination을 위한 DTO
 * mil.af.asti.model.AstiBoardPaginationDTO가 상속하고 있다.
 */
/**
 * @author Administrator
 *
 */
public class AstiBoardPaginationDTO {
	
	/**
	 * 기본 생성자
	 */
	public AstiBoardPaginationDTO(){}
	
	/**
	 * 현재 페이지를 초기화 시키는 생성자
	 * 거의 사용하지 않음.. 아니 사용할 일이 없음
	 */
	public AstiBoardPaginationDTO(int currentPage){
		setCurrentPage(currentPage);
	}
	/**
	 * 현재 페이지와 총 글 수를 초기화시키는 생성자
	 * 주로 사용됨
	 */
	public AstiBoardPaginationDTO(int currentPage,int numberOfContents){
		setCurrentPage(currentPage);
		setNumberOfContents(numberOfContents);
	}
	/**
	 * 현재 페이지 , 총 글 수 , 화면에 표시할 총 페이지 수 ,
	 * 화면에 표시할 글 수를 초기화시키는 생성자 
	 * 만약 UI적 변화가 필요할 시 이 부분을 건드리면 된다.
	 */
	public AstiBoardPaginationDTO(int currentPage,int numberOfContents,
			int numberOfPage , int contentsPerPage){
		setCurrentPage(currentPage);
		setNumberOfContents(numberOfContents);
		setNumberOfPage(numberOfPage);
		setContentsPerPage(contentsPerPage);
	}
	
	private int numberOfContents=0;
	/**
	 * 페이지 당 게시글 수
	 */
	private int contentsPerPage=15;
	/**
	 * 페이지 내에 표시할 총 페이지 수
	 */
	private int numberOfPage=10;
	/**
	 * 현재 페이지 
	 */
	private int currentPage=1;
		
	public int getContentsPerPage() {
		return contentsPerPage;
	}
	public void setContentsPerPage(int contentsPerPage) {
		this.contentsPerPage = contentsPerPage;
	}
	public int getNumberOfPage() {
		return numberOfPage;
	}
	public void setNumberOfPage(int numberOfPage) {
		this.numberOfPage = numberOfPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public int getNumberOfContents() {
		return numberOfContents;
	}
	public void setNumberOfContents(int numberOfContents) {
		this.numberOfContents = numberOfContents;
	}
	
	
	/**
	 * 페이지 시작점 (1을 의미하는 것이 아님)
	 * 만약 화면에 표시할 페이지 수가 10이고 자신이 16페이지를 조회하고 있다면
	 * 11페이지가 시작점이 된다.
	 * 계산식 - (((현재 페이지 - 1) ÷ 화면에 표시할 페이지 수 )+ 1) x 화면에 표시할 페이지 수 -(화면에 표시할 페이지 수 - 1)
	 * 현재 페이지가 14고 화면에 표시할 페이지 수가 6이라면	 *
	 * ex) (((14 - 1) / 6) + 1) x 6 - (6 - 1)
	 * = (2 + 1) x 6 - 5
	 * = 18 - 5
	 * = 13
	 */
	public int getBeginPage(){
		int beginPage = (((getCurrentPage()-1)/getNumberOfPage())+1)*getNumberOfPage()-(getNumberOfPage()-1);
		return beginPage;
	}
	/**
	 * 페이지 끝점 (마지막을 의미하는 것이 아님)
	 * 만약 화면에 표시할 페이지 수가 10이고 자신이 16페이지를 조회하고 있다면
	 * 20페이지가 끝점이 된다.
	 * 계산식 - (페이지 시작점 + 화면에 표시할 페이지 수) - 1
	 * 현재 페이지가 14고 화면에 표시할 페이지 수가 6이라면
	 * ex) (13 + 6) - 1
	 * = 18
	 */
	public int getEndPage(){
		int endPage = (getBeginPage()+getNumberOfPage())-1;
		return endPage;
	}
	/**
	 * 마지막 페이지
	 * 계산식 - (총 글 수 - 1 ÷ 화면에 표시할 글 수) + 1
	 * 총 글 수가 160이고 , 화면에 표시하는 글 수가 10이면 
	 * ex) ((160 - 1) ÷ 10) + 1 = 16페이지 
	 */
	public int getLastPage() {
		int lastPage = ((getNumberOfContents() - 1) / getContentsPerPage())+1;
		return lastPage;
	}	
	
	/**
	 * 가져올 글의 시작점
	 * 이 소스는 DB 쿼리 내에 적용되며 무차별 적으로 SELECT하여 거기서만 RNUM으로 뽑아내어
	 * DB에 과부화를 주는 것을 방지하기 위해 제작한 공식이다.
	 * 계산식 - (현재 페이지 * 화면에 표시하는 글 수) - (화면에 표시하는 글 수 - 1)
	 * 현재 페이지가 26이고 화면에 표시하는 글 수가 10일 경우
	 * ex) (26 * 10) - (10 - 1)
	 * = 260 - 9
	 * = 251
	 */
	public int getBeginContentsPerPage(){
		int beginContents = (getCurrentPage() * getContentsPerPage())
				- (getContentsPerPage() - 1);
		return beginContents;
	}
	/**
	 * 가져올 글의 끝점
	 * 계산식 - (현재 페이지 * 화면에 표시하는 글 수);
	 * 현재 페이지가 26이고 화면에 표시하는 글 수가 10일 경우
	 * ex) 26 * 10
	 * = 260
	 */
	public int getLastContentsPerPage(){
		int lastContents = (getCurrentPage() * getContentsPerPage());
		return lastContents;
	}
	
	@Override
	public String toString() {
		return "AstiBoardPaginationDTO [numberOfContents=" + numberOfContents
				+ ", contentsPerPage=" + contentsPerPage + ", numberOfPage="
				+ numberOfPage + ", currentPage=" + currentPage + "]";
	}
}
