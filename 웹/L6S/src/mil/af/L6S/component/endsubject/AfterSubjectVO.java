package mil.af.L6S.component.endsubject;

public class AfterSubjectVO {
	Integer subject_code;
	Integer price;
	String content;
	Integer title;
	Integer seq;
	String price_com;
	
	public String getPrice_com() {
		return price_com;
	}
	public void setPrice_com(String price_com) {
		this.price_com = price_com;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Integer getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(Integer subject_code) {
		this.subject_code = subject_code;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getTitle() {
		return title;
	}
	public void setTitle(Integer title) {
		this.title = title;
	}
	
}
