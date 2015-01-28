package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.dao.ScheduleDAO;
import mil.af.orms.model.ConfirmVO;
import mil.af.orms.model.DiagnosisStatusParamVO;
import mil.af.orms.model.ScheduleForModifyVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.SquadronStatusVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Service;


@Service("ScheduleService")
public class ScheduleService {
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="ScheduleDAO")
	ScheduleDAO scheduleDAO;

	public List<ScheduleForModifyVO> getScheduleForViewList(String squadron, String timePeriod, String flight_date) throws SQLException {
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("unit_code", squadron);
		parameterMap.put("period", timePeriod);
		parameterMap.put("flight_date", flight_date);
		return scheduleDAO.getScheduleForViewList(parameterMap);
	}

	public List<ScheduleForModifyVO> getScheduleForModifyList(String squadron, String timePeriod, String flight_date) throws SQLException {
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("unit_code", squadron);
		parameterMap.put("period", timePeriod);
		parameterMap.put("flight_date", flight_date);
		return scheduleDAO.getScheduleForModifyList(parameterMap);
	}

	public List<ScheduleVO> getMyUnitScheduleList(String flight_date,
			String sosokcode, String period,String sn) throws SQLException {
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("flight_date", flight_date);
		parameterMap.put("sosokcode", sosokcode);
		parameterMap.put("period", period);
		parameterMap.put("sn", sn); 
		return scheduleDAO.getMyUnitScheduleList(parameterMap);
	}

	public List<ScheduleVO> getMainScheduleList(String flight_date,
			String sosokcode, String sn) throws SQLException {
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("flight_date", flight_date);
		parameterMap.put("sosokcode", sosokcode);
		parameterMap.put("sn", sn); 
		return scheduleDAO.getMainScheduleList(parameterMap);
	}
	
	public ScheduleVO getSchedule(String scheduleId) throws SQLException {
		return scheduleDAO.getSchedule(scheduleId);
	}

	public int setResultToSchedule(ScheduleVO schedule, String result) throws SQLException {
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("seq", schedule.getSeq());
		parameterMap.put("result",result);
		return scheduleDAO.setResultToSchedule(parameterMap);
	}
	public ScheduleVO getRecentScheduleWithResult(UserVO userVO) throws SQLException{
		return scheduleDAO.getRecentScheduleWithResult(userVO.getUserid());
	}
	public List<ScheduleVO> getScheduleWithResultList(UserVO userVO,
			String flight_date,String unit, String period) throws SQLException {
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		if(!("").equals(flight_date))
		parameterMap.put("flight_date", flight_date);
		if(!("").equals(unit))
		parameterMap.put("unit", unit);
		if(!("".equals(period)))
		parameterMap.put("period", period);
		
		if(userVO.getRole()==UserRole.NORMAL||userVO.getRole()==UserRole.CQ||userVO.getRole()==UserRole.SCHEDULEOFFICER){ // 일반 조종사 일시는 군번을 넘겨줌
			parameterMap.put("sn",userVO.getUserid());
		}else if(userVO.getRole()==UserRole.FORMATIONMANAGER||userVO.getRole()==UserRole.SQUADRONMANAGER||userVO.getRole()==UserRole.GROUPMANAGER){
			//안전편대장급 이상에선 관리 부대를 넘겨서 전체 부대를 다 조회함
			String unit_code;
			if(unit==null||unit.equals("")){
				//편대 리스트 가져오기 (해당편대만 가져오기 수정 2012.02.09 중사 황예찬)
				UserAuthVO userAuthVO=commonService.getUserAuth(userVO);
				unit_code=userAuthVO.getUnit_code();
			}else{
				unit_code=unit;
			}
			parameterMap.put("unit_code", unit_code);
		} 
		return scheduleDAO.getScheduleWithResultList(parameterMap);
	}

	public ScheduleVO getScheduleBySeq(String scheduleSeq) throws SQLException {
		return scheduleDAO.getScheduleBySeq(scheduleSeq);
	}
	
	public List<ScheduleVO> getScheduleWithResultByDate(String unit_code,String start_date,String end_date) throws SQLException{
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("unit_code", unit_code);
		parameterMap.put("start_date", start_date);
		parameterMap.put("end_date", end_date);
		return scheduleDAO.getScheduleWithResultByDate(parameterMap);
	}
	
	public List<ScheduleVO> getScheduleWithResultByMonth(DiagnosisStatusParamVO param) throws SQLException {
		// TODO Auto-generated method stub
		return scheduleDAO.getScheduleWithResultByMonth(param);
	}
	
	
	public void insertResultToSchedule(HashMap<String,String> p) throws SQLException {
		scheduleDAO.insertResultToSchedule(p);
	}
	
	public void deleteSchedule(HashMap<String,String> p) throws SQLException {
		
		scheduleDAO.deleteSchedule(p);
	}
	
	/*저장기능*/
	public void setResultToSchedule(List<ScheduleForModifyVO> scheduleList,String flight_date) throws SQLException {
		int listSize=scheduleList.size();
		for(int i=0;i<listSize;i++){
			insertOrUpdateSchedule(scheduleList.get(i),flight_date);
		}
	}

	private void insertOrUpdateSchedule(ScheduleForModifyVO scheduleForModifyVO,String flight_date) throws SQLException {

		ScheduleVO schedule1=new ScheduleVO();
		ScheduleVO schedule2=new ScheduleVO();
		
		schedule1.setSeq(scheduleForModifyVO.getSeq1());
		schedule1.setCs(scheduleForModifyVO.getCs());
		schedule1.setPosition("01");
		schedule1.setSn(scheduleForModifyVO.getSn1());
		schedule1.setSection(scheduleForModifyVO.getSection1());
		schedule1.setWeather(scheduleForModifyVO.getWeather1());
		schedule1.setPeriod(scheduleForModifyVO.getPeriod());
		schedule1.setFlight_date(flight_date);
		schedule1.setUnit_code(scheduleForModifyVO.getUnit_code());
		schedule1.setId(scheduleForModifyVO.getId());
		
		schedule2.setSeq(scheduleForModifyVO.getSeq2());
		schedule2.setCs(scheduleForModifyVO.getCs());
		schedule2.setPosition("02");
		schedule2.setSn(scheduleForModifyVO.getSn2());
		schedule2.setPeriod(scheduleForModifyVO.getPeriod());
		schedule2.setSection(scheduleForModifyVO.getSection2());
		schedule2.setWeather(scheduleForModifyVO.getWeather2());
		schedule2.setFlight_date(flight_date);
		schedule2.setUnit_code(scheduleForModifyVO.getUnit_code());
		schedule2.setId(scheduleForModifyVO.getId());
		
		if(schedule1.getSeq()==null){
			scheduleDAO.insertSchedule(schedule1);
		}else{
			scheduleDAO.updateSchedule(schedule1);
		}
		
		if(schedule2.getSeq()==null){
			scheduleDAO.insertSchedule(schedule2);
		}else{
			scheduleDAO.updateSchedule(schedule2);
		}
	}
	

	public void deleteAnswers(HashMap<String, String> p) throws SQLException {
		scheduleDAO.deleteAnswers(p);
		
	}

	public Integer getAvailNewId() throws SQLException {
		return scheduleDAO.getAvailNewId();
	}

	public List<ScheduleVO> getScheduleWithResultList(
			String sn, String start_date, String end_date) throws SQLException {
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
		parameterMap.put("snOnly", sn);
		parameterMap.put("start_date", start_date);
		parameterMap.put("end_date", end_date);
		return scheduleDAO.getScheduleWithResultList(parameterMap);
	}
	
	public List<ScheduleVO> getScheduleByDate(
			String flight_date, String unit_code) throws SQLException {
		HashMap<String,Object> parameterMap=new HashMap<String,Object>();
			
		parameterMap.put("flight_date",flight_date);
		parameterMap.put("unit_code", unit_code);
		return scheduleDAO.getScheduleByDate(parameterMap);
	}
	
	public List<SquadronStatusVO> getFlightGroupStatusList(String flightGroup,
			String squadron,String flight_date,HttpServletRequest request) throws SQLException {
		List<SquadronStatusVO> flightGroupStatusList=new ArrayList<SquadronStatusVO>();
		
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("flightGroup", flightGroup);
		parameterMap.put("squadron",squadron);
		parameterMap.put("flight_date",flight_date);
		List<ScheduleVO> allScheduleList=scheduleDAO.getAllScheduleByFlightGroup(parameterMap);
		
		if(squadron==null){ //비행단 전체
			
			List<UnitVO> squadronList=commonService.getSquadronList(flightGroup);
			int squadronSize=squadronList.size();
			for(int i=0;i<squadronSize;i++){
				UnitVO squadronVO=squadronList.get(i);
				SquadronStatusVO tempStatus=new SquadronStatusVO();
				tempStatus.setUnit_code(squadronVO.getSosokcode());
				tempStatus.setUnit_codename(squadronVO.getFullass());
				tempStatus=setCountAndOpinionFromScheduleList(tempStatus,squadronVO.getSosokcode(),allScheduleList);
				flightGroupStatusList.add(tempStatus);
			}
		}else{
			SquadronStatusVO tempStatus=new SquadronStatusVO();
			tempStatus.setUnit_code(squadron);
			tempStatus.setUnit_codename(commonService.getUnitName(squadron));
			tempStatus=setCountAndOpinionFromScheduleList(tempStatus,squadron,allScheduleList);
			flightGroupStatusList.add(tempStatus);
		}
		return flightGroupStatusList;
	}

	private SquadronStatusVO setCountAndOpinionFromScheduleList(SquadronStatusVO status, String squadron,
			List<ScheduleVO> allScheduleList) {
		//진단현황 카운트
		Integer notCreateDiagnosisCount=0;
		Integer createDiagnosisCount=0;
		
		//처리 현황 카운트
		Integer normalFlightCount=0;
		Integer cancelFlightCount=0;
		
		List<ConfirmVO> confirmList=new ArrayList<ConfirmVO>();
		
		int size=allScheduleList.size();
		for(int i=0;i<size;i++){
			ScheduleVO schedule=allScheduleList.get(i);
			if(schedule.getUnit_code().contains(squadron)){//해당 대대일시
				String result=schedule.getResult();
				if(result==null){ //미작성
					notCreateDiagnosisCount++;
				}else{
					createDiagnosisCount++; //작성
					String confirm=schedule.getConfirm_result_fix();
					if(confirm!=null){
						if(confirm.equals("1")){//비행
							normalFlightCount++;
						}else if(confirm.equals("2")){//비행 취소
							cancelFlightCount++;
							
							//비행 취소인 사유만 넣어줌
							ConfirmVO confirmVO=new ConfirmVO();
							confirmVO.setSn(schedule.getConfirm_sn());
							confirmVO.setPilot_rankname(schedule.getRankname());
							confirmVO.setConfirm_date(schedule.getConfirm_time());
							confirmVO.setOpinion(schedule.getConfirm_opinion());
							confirmVO.setResult_fix(schedule.getConfirm_result_fix());
							
							confirmList.add(confirmVO);
							
						}
						
						
					}
				}
				
			}
		}
		
		status.setNotCreateDiagnosisCount(notCreateDiagnosisCount);
		status.setCreateDiagnosisCount(createDiagnosisCount);
		status.setNormalFlightCount(normalFlightCount);
		status.setCancelFlightCount(cancelFlightCount);
		status.setConfirmList(confirmList);
		return status;
	}

	public List<ScheduleVO> getDignosisCount(
			HashMap<String, String> parameterMap) throws SQLException {
		return scheduleDAO.getDignosisCount(parameterMap);
	}

	public void insertReason(HashMap<String, String> seqAndReason) throws SQLException {
		
		scheduleDAO.insertReason(seqAndReason);
	}

	public String getLastflight_date(String gunbun) throws SQLException {
		// TODO Auto-generated method stub
		return scheduleDAO.getLastflight_date(gunbun);
	}


	public int getDiffDay(String lastFlight_date) {
		// TODO Auto-generated method stub
		/**
		 * 현재날짜 set
		 */
		if(lastFlight_date!=null){
		GregorianCalendar gc = new GregorianCalendar();
		Calendar c1 = Calendar.getInstance(); // 최근비행일 
		Calendar c2 = Calendar.getInstance(); // 현재날짜용
		final long millinday = 24*60*60*1000; // 하루 밀리초
		
		int cDay = gc.get(GregorianCalendar.DATE);
		int cMonth = gc.get(GregorianCalendar.MONTH)+1;
		int cYear = gc.get(GregorianCalendar.YEAR);
		
		String[] strDate = new String[3];
		Integer[] dateList = new Integer[3];
		
		strDate[0] = lastFlight_date.substring(0,4); // year
		strDate[1] = lastFlight_date.substring(4,6); // month
		strDate[2] = lastFlight_date.substring(6,8); // day
		
		for(int i=0;i<strDate.length;i++){
			dateList[i] = Integer.parseInt(strDate[i]);
		}
		
		
		c1.set(dateList[0], dateList[1], dateList[2]);
		c2.set(cYear, cMonth, cDay);
		
		long milliC1 = c1.getTimeInMillis();
		long milliC2 = c2.getTimeInMillis();
		
		long diffC1c2 = milliC2 - milliC1;
		int diffDay = (int) (diffC1c2 / millinday);
		
		
		return diffDay;
		}else
			return 0;
	}

	public List<ScheduleVO> getVOforFlight_date(ScheduleVO schedule) throws SQLException {
		// TODO Auto-generated method stub
		return scheduleDAO.getVOforFlight_date(schedule);
	}


}