package mil.af.orms.model;

import java.util.List;

public class SquadronStatusVO {
	String unit_code;
	String unit_codename;
	
	//진단현황 카운트
	Integer notCreateDiagnosisCount;
	Integer createDiagnosisCount;
	
	//처리 현황 카운트
	Integer normalFlightCount;
	Integer cancelFlightCount;
	
	List<ConfirmVO> confirmList;

	public String getUnit_code() {
		return unit_code;
	}

	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}

	public String getUnit_codename() {
		return unit_codename;
	}

	public void setUnit_codename(String unit_codename) {
		this.unit_codename = unit_codename;
	}

	public Integer getNotCreateDiagnosisCount() {
		return notCreateDiagnosisCount;
	}

	public void setNotCreateDiagnosisCount(Integer notCreateDiagnosisCount) {
		this.notCreateDiagnosisCount = notCreateDiagnosisCount;
	}

	public Integer getCreateDiagnosisCount() {
		return createDiagnosisCount;
	}

	public void setCreateDiagnosisCount(Integer createDiagnosisCount) {
		this.createDiagnosisCount = createDiagnosisCount;
	}

	public Integer getNormalFlightCount() {
		return normalFlightCount;
	}

	public void setNormalFlightCount(Integer normalFlightCount) {
		this.normalFlightCount = normalFlightCount;
	}

	public Integer getCancelFlightCount() {
		return cancelFlightCount;
	}

	public void setCancelFlightCount(Integer cancelFlightCount) {
		this.cancelFlightCount = cancelFlightCount;
	}

	public List<ConfirmVO> getConfirmList() {
		return confirmList;
	}

	public void setConfirmList(List<ConfirmVO> confirmList) {
		this.confirmList = confirmList;
	}
	
	
}
