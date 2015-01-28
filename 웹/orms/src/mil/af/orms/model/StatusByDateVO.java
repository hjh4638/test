package mil.af.orms.model;

import java.util.List;

/**
 * 날짜별 진단현황
 */
public class StatusByDateVO {
	String pilot_rankname;
	String pilot_sn;
	List<String> resultByDateAndPeriodList;
	
	
	public String getPilot_rankname() {
		return pilot_rankname;
	}
	public void setPilot_rankname(String pilot_rankname) {
		this.pilot_rankname = pilot_rankname;
	}
	public String getPilot_sn() {
		return pilot_sn;
	}
	public void setPilot_sn(String pilot_sn) {
		this.pilot_sn = pilot_sn;
	}
	public List<String> getResultByDateAndPeriodList() {
		return resultByDateAndPeriodList;
	}
	public void setResultByDateAndPeriodList(List<String> resultByDateAndPeriodList) {
		this.resultByDateAndPeriodList = resultByDateAndPeriodList;
	}
	
	
}
