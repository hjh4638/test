package mil.af.L6S.component.belt;
	
public class BeltTableVO {
	/**
	 * 벨트(MBB,BB,GB,FEA)
	 */
	String belt;
	
	/**
	 * 신분 (장교,준사관,부사관,군무원)
	 */
	String code;
	
	/**
	 * 수료/자격 여부 
	 */
	String state;
	
	/**
	 * 해당 인원 수 
	 */
	String count;
	
	public String getBelt() {
		return belt;
	}
	public String getCode() {
		return code;
	}
	public String getCount() {
		return count;
	}
	public String getState() {
		return state;
	}
	public void setBelt(String belt) {
		this.belt = belt;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "BeltTableVO [belt=" + belt + ", code=" + code + ", state="
				+ state + ", count=" + count + "]";
	}
}
