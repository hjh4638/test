package mil.af.asti.model;

public class AstiPageDTO {
	String page_id;
	String page_picture_id;
	String page_picture_name;
	String page_name;
	Integer page_order;
	
	public Integer getPage_order() {
		return page_order;
	}
	public void setPage_order(Integer page_order) {
		this.page_order = page_order;
	}
	public String getPage_id() {
		return page_id;
	}
	public void setPage_id(String page_id) {
		this.page_id = page_id;
	}
	public String getPage_picture_id() {
		return page_picture_id;
	}
	public void setPage_picture_id(String page_picture_id) {
		this.page_picture_id = page_picture_id;
	}
	public String getPage_picture_name() {
		return page_picture_name;
	}
	public void setPage_picture_name(String page_picture_name) {
		this.page_picture_name = page_picture_name;
	}
	public String getPage_name() {
		return page_name;
	}
	public void setPage_name(String page_name) {
		this.page_name = page_name;
	}
}
