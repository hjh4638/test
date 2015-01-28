package mil.af.orms.model;

import java.util.List;

import mil.af.orms.util.DateUtil;

public class ScheduleVO {
	
	//ORMS_SCHEDULE 변수
	Integer seq;
	String cs;
	String position;
	String position_codename;
	String period;
	String period_codename;
	String sn;
	String rankname;
	String flight_date;
	String unit_code;
	String unit_codename;
	String result;
	String result_codename;
	String section;
	String section_codename;
	String weather;
	String id;
	String cancelReason;
	String cancelOrnot;
	
	//ORMS_CONFIRM 변수
	String confirm_sn;
	String confirm_rankname;
	String confirm_sosokcode;
	String confirm_time;
	String confirm_opinion;
	String confirm_result_fix;
	
	List<ScoreVO> scoreList;
	
	Integer count;
	
	
	
	public String getCancelOrnot() {
		return cancelOrnot;
	}
	public void setCancelOrnot(String cancelOrnot) {
		this.cancelOrnot = cancelOrnot;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public int getTotalScore(){
		int score=0;
		int size=scoreList.size();
		for(int i=0;i<size;i++){
			score+=Integer.parseInt(scoreList.get(i).score);
		}
		return score;
	}
	public String getResultColor(){
		if("01".equals(result)){
			return ScoreVO.GREEN;
		}else if("02".equals(result)){
			return ScoreVO.YELLOW;
		}else if("03".equals(result)){
			return ScoreVO.ORANGE;
		}
		return "";
	}
	public String getInitial_color(){
		StringBuffer str=new StringBuffer(getResultColor());
		String intial = str.substring(0,1);
		return intial.toUpperCase();
	}
	public String getResultName(){
		if("01".equals(result)){
			return "정상";
		}else if("02".equals(result)){
			return "주의";
		}else if("03".equals(result)){
			return "위험";
		}
		return "";
	}
	
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getCs() {
		return cs;
	}
	public void setCs(String cs) {
		this.cs = cs;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPosition_codename() {
		return position_codename;
	}
	public void setPosition_codename(String position_codename) {
		this.position_codename = position_codename;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getPeriod_codename() {
		return period_codename;
	}
	public void setPeriod_codename(String period_codename) {
		this.period_codename = period_codename;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getRankname() {
		return rankname;
	}
	public void setRankname(String rankname) {
		this.rankname = rankname;
	}
	public String getFlight_date() {
		return flight_date;
	}
	public void setFlight_date(String flight_date) {
		this.flight_date = flight_date;
	}
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
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getResult_codename() {
		return result_codename;
	}
	public void setResult_codename(String result_codename) {
		this.result_codename = result_codename;
	}
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public String getSection_codename() {
		return section_codename;
	}
	public void setSection_codename(String section_codename) {
		this.section_codename = section_codename;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<ScoreVO> getScoreList() {
		return scoreList;
	}
	public void setScoreList(List<ScoreVO> scoreList) {
		this.scoreList = scoreList;
	}
	public String getConfirm_sn() {
		return confirm_sn;
	}
	public void setConfirm_sn(String confirm_sn) {
		this.confirm_sn = confirm_sn;
	}
	public String getConfirm_rankname() {
		return confirm_rankname;
	}
	public void setConfirm_rankname(String confirm_rankname) {
		this.confirm_rankname = confirm_rankname;
	}
	public String getConfirm_sosokcode() {
		return confirm_sosokcode;
	}
	public void setConfirm_sosokcode(String confirm_sosokcode) {
		this.confirm_sosokcode = confirm_sosokcode;
	}
	public String getConfirm_time() {
		return confirm_time;
	}
	public void setConfirm_time(String confirm_time) {
		this.confirm_time = confirm_time;
	}
	public String getConfirm_opinion() {
		return confirm_opinion;
	}
	public void setConfirm_opinion(String confirm_opinion) {
		this.confirm_opinion = confirm_opinion;
	}
	public String getConfirm_result_fix() {
		return confirm_result_fix;
	}
	public void setConfirm_result_fix(String confirm_result_fix) {
		this.confirm_result_fix = confirm_result_fix;
	}
	public String getFormedFlightDate(){
		return DateUtil.getDayString(flight_date, "YYYY년 MM월 DD일");
	}
	
}
