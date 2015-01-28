package mil.af.L6S.component.belt;

public class BeltGraphVO {
	/**
	 * 벨트 종류
	 */
	String belt;
	
	/**
	 * 수료자 수 
	 */
	int count1;
		
	/**
	 * 자격자 수 
	 */
	int count2;
	
	
	public String getBelt() {
		return belt;
	}

	public int getCount1() {
		return count1;
	}

	public int getCount2() {
		return count2;
	}

	public void setBelt(String belt) {
		this.belt = belt;
	}

	public void setCount1(int count1) {
		this.count1 = count1;
	}

	public void setCount2(int count2) {
		this.count2 = count2;
	}
	
	@Override
	public String toString() {
		return "BeltGraphVO [belt=" + belt + ", count1=" + count1 + ", count2="
				+ count2 + "]";
	}
}
