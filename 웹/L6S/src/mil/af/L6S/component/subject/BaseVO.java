package mil.af.L6S.component.subject;

import java.util.List;

public class BaseVO {

	String basecode;
	String basename;
	
	List<BaseVO> child;
	
	public List<BaseVO> getChild() {
		return child;
	}
	public void setChild(List<BaseVO> child) {
		this.child = child;
	}
	public String getBasecode() {
		return basecode;
	}
	public void setBasecode(String basecode) {
		this.basecode = basecode;
	}
	public String getBasename() {
		return basename;
	}
	public void setBasename(String basename) {
		this.basename = basename;
	}
}
