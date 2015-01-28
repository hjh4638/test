package mil.af.asti.model;
/*첨부파일테이블 모델*/
public class AstiBoardFileDTO {
	
	/*ASTI_BOARD_FILE테이블의 fk. ASTI_BOARD의 board_id 참조.not null*/
	Integer board_id;
	
	/*ASTI_BOARD_FILE 테이블의 pk. 난수+seq 데이터가 들어갈것*/
	String file_id;
	
	/*실제 파일명. not null*/
	String filename;
	
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
}
