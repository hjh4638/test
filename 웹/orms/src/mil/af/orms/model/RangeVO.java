package mil.af.orms.model;

public class RangeVO {
	public RangeVO(String name,Integer startDate,Integer endDate){
		this.name=name;
		this.startDate=startDate;
		this.endDate=endDate;
	}
	
	public String toString(){
		String result="--------RangeVO------------";
		result+="name = "+name+"\n";
		result+="startDate = "+startDate+"\n";
		result+="endDate = "+endDate+"\n";
		return result;
	}
	
	String name;
	Integer startDate;
	Integer endDate;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getStartDate() {
		return startDate;
	}
	public void setStartDate(Integer startDate) {
		this.startDate = startDate;
	}
	public Integer getEndDate() {
		return endDate;
	}
	public void setEndDate(Integer endDate) {
		this.endDate = endDate;
	}
	
}
