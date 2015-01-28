package mil.af.orms.model;

public class DiagnosisStatusParamVO {
	public static final int GUBUN_TODAY=0;
	public static final int GUBUN_MONTH=1;
	public static final int GUBUN_QUARTER=2;
	public static final int GUBUN_YEAR=3;
	public static final int GUBUN_CUSTOM=4;
	
	public static final int RESULT_GRAPH=0;
	public static final int RESULT_BYPERSON=1;
	
	String flightGroup;
	String squadron;
	Integer dateRangeGubun;
	String year;
	String month;
	String quarter;
	String startDate;
	String endDate;
	String resultType;
	boolean isAll;
	public String toString(){
		String result="";
		result+="flightGroup:"+flightGroup;
		result+=", squadron:"+squadron;
		result+=", dateRangeGubun:"+dateRangeGubun;
		result+=", year:"+year;
		result+=", month:"+month;
		result+=", quarter:"+quarter;
		result+=", startDate:"+startDate;
		result+=", endDate:"+endDate;
		result+=", resultType:"+resultType;
		
		return result;
	}
	public String getFlightGroup() {
		return flightGroup;
	}
	public void setFlightGroup(String flightGroup) {
		this.flightGroup = flightGroup;
	}
	public String getSquadron() {
		return squadron;
	}
	public void setSquadron(String squadron) {
		this.squadron = squadron;
	}
	
	public Integer getDateRangeGubun() {
		return dateRangeGubun;
	}
	public void setDateRangeGubun(Integer dateRangeGubun) {
		this.dateRangeGubun = dateRangeGubun;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getQuarter() {
		return quarter;
	}
	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getResultType() {
		return resultType;
	}
	public void setResultType(String resultType) {
		this.resultType = resultType;
	}
	public boolean isAll() {
		return isAll;
	}
	public void setAll(boolean isAll) {
		this.isAll = isAll;
	}
	
}
