package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.orms.dao.DiagnosisStatusDAO;
import mil.af.orms.dao.ScheduleDAO;
import mil.af.orms.model.DayWithResultCountVO;
import mil.af.orms.model.DiagnosisStatusParamVO;
import mil.af.orms.model.GraphByResultVO;
import mil.af.orms.model.RangeVO;
import mil.af.orms.model.ResultCountByDateAndResultVO;
import mil.af.orms.model.ResultWithCountVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.StatusByDateVO;
import mil.af.orms.model.StatusByMonthVO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;
import mil.af.orms.util.DateUtil;

import org.springframework.stereotype.Service;

@Service("DiagnosisStatusService")

public class DiagnosisStatusService {
	@Resource(name="CommonService")
	CommonService commonService;
	
	@Resource(name="CodeService")
	CodeService codeService;
	
	@Resource(name="ScheduleService")
	ScheduleService scheduleService;
	
	@Resource(name="DiagnosisStatusDAO")
	DiagnosisStatusDAO diagnosisStatusDAO;
	
	@Resource(name="ScheduleDAO")
	ScheduleDAO scheduleDAO;
	
	/**
	 * 주어진 기간의 결과 리스트를 가져온다, 모든 날짜, 모든 결과 정보 포함
	 * @param param
	 * @return
	 * @throws SQLException 
	 */
	public List<DayWithResultCountVO> getDayWithResultList(
			DiagnosisStatusParamVO param) throws SQLException {
		String start_date=getRangeStartDate(param);
		String end_date=getRangeEndDate(param);
		System.out.println("시작일!!!!!!!!!!!!"+start_date);
		System.out.println("종료일!!!!!!!!!!!!"+end_date);
		String unit_code=null;
		if(param.getSquadron()==null||param.getSquadron().equals("")){
			unit_code=param.getFlightGroup();
		}else{
			unit_code=param.getSquadron();
		}
		HashMap<String,String> parameterMap=new HashMap<String,String>();
		parameterMap.put("start_date", start_date);
		parameterMap.put("end_date", end_date);
		parameterMap.put("unit_code", unit_code);
		List<ResultCountByDateAndResultVO> resultCountList=scheduleDAO.getResultWithCountByDate(parameterMap);
		
		List<RangeVO> rangeList=getRangeList(param.getDateRangeGubun(),start_date,end_date);
		
		List<DayWithResultCountVO> resultList=new ArrayList<DayWithResultCountVO>();
		
		int rangeSize=rangeList.size();
		for(int i=0;i<rangeSize;i++){
			RangeVO range=rangeList.get(i);
			DayWithResultCountVO result=new DayWithResultCountVO(range.getName(),codeService.getResultList());
			int resultSize=resultCountList.size();
			for(int j=0;j<resultSize;j++){
				ResultCountByDateAndResultVO resultCount=resultCountList.get(j);
				if(DateUtil.isBetweenDay(resultCount.getFlight_date(), range.getStartDate(), range.getEndDate())){
					List<ResultWithCountVO> resultWithCount=result.getResultWithCountList();
					int resultWithCountSize=resultWithCount.size();
					for(int k=0;k<resultWithCountSize;k++){
						ResultWithCountVO tempCount=resultWithCount.get(k);
						if(tempCount.getResult_code().equals(resultCount.getCode())){
							tempCount.setCount(tempCount.getCount()+resultCount.getCount());
						}
						resultWithCount.set(k, tempCount);
					}
					result.setResultWithCountList(resultWithCount);
				}
			}
			resultList.add(result);
		}
		
		
		return resultList;
	}
	
	private List<RangeVO> getRangeList(Integer dateRangeGubun,
			String start_date, String end_date) {
		switch(dateRangeGubun){
		case DiagnosisStatusParamVO.GUBUN_TODAY:
			List<RangeVO> rangeList=new ArrayList<RangeVO>();
			List<String> betweenDays=DateUtil.getBetweenDays(DateUtil.getDayString(start_date,"YYYY-MM-DD"), DateUtil.getDayString(end_date,"YYYY-MM-DD"));
			int size=betweenDays.size();
			for(int i=size-1;i>-1;i--){
				String day=betweenDays.get(i).replace("-", "");
				RangeVO rangeVO=new RangeVO(DateUtil.getDayString(day, "YYYY.MM.DD"),Integer.parseInt(day),Integer.parseInt(day));
				rangeList.add(rangeVO);
			}
			return rangeList;
		case DiagnosisStatusParamVO.GUBUN_MONTH:
			int year=Integer.parseInt(DateUtil.getDayString(start_date, "YYYY"));
			int month=Integer.parseInt(DateUtil.getDayString(start_date, "MM"));
			return DateUtil.getWeekRangeList(year, month);
		default:
			return new ArrayList<RangeVO>();
		}
	}

	/**
	 * 조종사별로 날짜,시간대의 결과를 가져옴
	 * @param param
	 * @return
	 * @throws SQLException 
	 */
	public List<StatusByDateVO> getStatusByDateList(DiagnosisStatusParamVO param,List<SysCodeVO> periodList) throws SQLException {
		List<StatusByDateVO> resultList=new ArrayList<StatusByDateVO>();
		String unit_code=null;
		if(param.getSquadron()==null||param.getSquadron().equals("")){
			unit_code=param.getFlightGroup();
		}else{
			unit_code=param.getSquadron();
		}
		List<UserVO> userList;
		if(unit_code!=null&&!unit_code.equals("")){
			userList=commonService.getFormationPilotList(unit_code);// 대대원 목록
		}else{
			userList=new ArrayList<UserVO>();
		}
		 
		String start_date=getRangeStartDate(param); //기간 시작일
		String end_date=getRangeEndDate(param); // 기간 종료일
		
		String form_start_date=DateUtil.getDayString(start_date,"YYYY-MM-DD");
		String form_end_date=DateUtil.getDayString(end_date,"YYYY-MM-DD");
		List<String> dateRange=DateUtil.getBetweenDays(form_start_date, form_end_date); // 두날짜 사이 범위 전체 리스트
		
		//해당 조건에 해당하는 스케쥴 리스트
		List<ScheduleVO> scheduleWithResultByDate=scheduleService.getScheduleWithResultByDate(param.getSquadron(), start_date, end_date);
		
		if(userList!=null){
			int userListSize=userList.size();
			for(int i=0;i<userListSize;i++){
				UserVO pilot= userList.get(i);
				StatusByDateVO statusByPilot=new StatusByDateVO();
				statusByPilot.setPilot_rankname(pilot.getRankname()+" "+pilot.getName());
				statusByPilot.setPilot_sn(pilot.getUserid());
				
				statusByPilot.setResultByDateAndPeriodList(getResultByDateAndPeriodList(pilot.getUserid(),dateRange,scheduleWithResultByDate,periodList));
				resultList.add(statusByPilot);
			}
		}
		
		return resultList;
	}
	/**
	 * 월별 보고서 구현중
	 * @param param
	 * @param periodList
	 * @return
	 * @throws SQLException
	 */
	public List<StatusByMonthVO> getStatusByMonth(DiagnosisStatusParamVO param,List<SysCodeVO> periodList) throws SQLException {
		List<StatusByMonthVO> pilotList=new ArrayList<StatusByMonthVO>();
		String unit_code=null;
		if(param.getSquadron()==null||param.getSquadron().equals("")){
			unit_code=param.getFlightGroup();
		}else{
			unit_code=param.getSquadron();
		}
		List<UserVO> userList;
		if(unit_code!=null&&!unit_code.equals("")){
			userList=commonService.getFormationPilotList(unit_code);// 대대원 목록
		}else{
			userList=new ArrayList<UserVO>();
		}
		 /**
		  * squadron 어찌처리할지
		  */
		
		//scheduleWithResultByMonth : 해당 월 스케줄리스트
		if(param.getMonth().length()==1){
			String paramMonth = "0" + param.getMonth();
			param.setMonth(paramMonth);
		}
		List<ScheduleVO> scheduleWithResultByMonth=scheduleService.getScheduleWithResultByMonth(param);
		
		if(userList!=null){
			int userListSize=userList.size();
		
			for(int i=0;i<userListSize;i++){
				UserVO pilot= userList.get(i);
				StatusByMonthVO statusByPilot=new StatusByMonthVO();
				statusByPilot.setRank(pilot.getRankname());
				statusByPilot.setName(pilot.getName());
				statusByPilot.setSn(pilot.getUserid());
				
				/**
				 * 아예새로뜯어고쳐야될듯
				 * G,Y,O
				 */
				
				int[][] countOfFlight = getResultByMonthAndPeriodList(statusByPilot,scheduleWithResultByMonth,periodList);
				
				
				setStatusProperty(statusByPilot,countOfFlight);
				pilotList.add(statusByPilot);
			}
		}
		
		return pilotList;
	}
	
	private int[][] getResultByMonthAndPeriodList(StatusByMonthVO statusByPilot,
			List<ScheduleVO> scheduleWithResultByMonth,List<SysCodeVO> periodList) throws SQLException {
		
			int periodSize=periodList.size();
			int[][] countOfPeriod = new int[4][4]; // period(행:4) * G,Y,O,unChecked(열:4)
			for(int j=0;j<periodSize;j++){
				SysCodeVO period=periodList.get(j);
				int scheduleSize=scheduleWithResultByMonth.size();
				
				for(int k=0;k<scheduleSize;k++){
					
					ScheduleVO schedule=scheduleWithResultByMonth.get(k);
					String str_1 = statusByPilot.getSn();
					String str_2 = schedule.getPeriod();
					if((str_1.equals(schedule.getSn()))&&(str_2.equals(period.getCode()))){
						if(schedule.getResult() == null){
							countOfPeriod[j][3] += 1;
						}
						else{
							int result = Integer.parseInt(schedule.getResult());
						if(result == 1){
							countOfPeriod[j][0] += 1;
						}else if(result == 2){
							countOfPeriod[j][1] += 1;
						}else if(result == 3){
							countOfPeriod[j][2] += 1;
						}
					}
				}
				}
			}
		
			return countOfPeriod;
	}
	
		private void setStatusProperty(StatusByMonthVO statusByPilot,
			int[][] countOfFlight) {
		
		statusByPilot.setgCount_1st(countOfFlight[0][0]);
		statusByPilot.setyCount_1st(countOfFlight[0][1]);
		statusByPilot.setoCount_1st(countOfFlight[0][2]);
		statusByPilot.setUnChecked_1st(countOfFlight[0][3]);
		
		statusByPilot.setgCount_2nd(countOfFlight[1][0]);
		statusByPilot.setyCount_2nd(countOfFlight[1][1]);
		statusByPilot.setoCount_2nd(countOfFlight[1][2]);
		statusByPilot.setUnChecked_2nd(countOfFlight[1][3]);
		
		statusByPilot.setgCount_3rd(countOfFlight[2][0]);
		statusByPilot.setyCount_3rd(countOfFlight[2][1]);
		statusByPilot.setoCount_3rd(countOfFlight[2][2]);
		statusByPilot.setUnChecked_3rd(countOfFlight[2][3]);
		
		statusByPilot.setgCount_night(countOfFlight[3][0]);
		statusByPilot.setyCount_night(countOfFlight[3][1]);
		statusByPilot.setoCount_night(countOfFlight[3][2]);
		statusByPilot.setUnChecked_night(countOfFlight[3][3]);
	}

	/**
	 * 조종사별로 주어진 날짜, 시간대에 해당하는 결과 목록을 가져옴
	 * @param dateRange
	 * @param scheduleWithResultByDate
	 * @return
	 * @throws SQLException 
	 */
	private List<String> getResultByDateAndPeriodList(String sn,List<String> dateRange,
			List<ScheduleVO> scheduleWithResultByDate,List<SysCodeVO> periodList) throws SQLException {
		
		List<String> resultList=new ArrayList<String>();
		
		int dateSize=dateRange.size();
		for(int i=0;i<dateSize;i++){
			int periodSize=periodList.size();
			String date=dateRange.get(i).replaceAll("-", "");
			for(int j=0;j<periodSize;j++){
				SysCodeVO period=periodList.get(j);
				int scheduleSize=scheduleWithResultByDate.size();
				String result="";
				for(int k=0;k<scheduleSize;k++){
					ScheduleVO schedule=scheduleWithResultByDate.get(k);
					if(sn.equals(schedule.getSn())&&schedule.getFlight_date().equals(date)&&schedule.getPeriod().equals(period.getCode())){
						System.out.println("--------------------------------------------------------");
						System.out.println(schedule.getId()+"가 "+date+","+period.getCodename()+"에 추가");
						result=schedule.getResult();
					}
				}
				resultList.add(result);
			}
		}
		return resultList;
	}
	
	

	/**
	 * 넘어온 DiagnosisStatusParamVO를 분석해서 검색할 기간 첫날을 구한다(YYYYMMDD형식)
	 * @param param
	 * @return
	 */
	public String getRangeStartDate(DiagnosisStatusParamVO param) {
		Integer month=Integer.parseInt(param.getMonth());
		param.setMonth(DateUtil.dayIntToString(month));
		switch(param.getDateRangeGubun()){
		case DiagnosisStatusParamVO.GUBUN_TODAY:
			//전체 대대보기일시에는 오늘 날짜만 가져옴
			if(param.isAll()){
				return DateUtil.getToday("YYYYMMDD");
			}else{// 특정 대대 기준일땐 오늘 기준 5일전을 구해옴
				return DateUtil.getBeforeOrNextDay(
					Integer.parseInt(DateUtil.getToday("YYYY")), Integer.parseInt(DateUtil.getToday("MM")),
					Integer.parseInt(DateUtil.getToday("DD")), -5, "YYYYMMDD");
			}
		case DiagnosisStatusParamVO.GUBUN_MONTH:
			return param.getYear()+param.getMonth()+"01";
		case DiagnosisStatusParamVO.GUBUN_QUARTER:
			String startDate=param.getYear();
			String startMonth=DateUtil.dayIntToString(Integer.parseInt(param.getQuarter())*3-2);
			startDate=startDate+startMonth+"01";
			return startDate;
		case DiagnosisStatusParamVO.GUBUN_YEAR:
			return param.getYear()+"0101";
		case DiagnosisStatusParamVO.GUBUN_CUSTOM:
			return param.getStartDate();
		default:
			return null;
		}
	}

	/**
	 * 넘어온 DiagnosisStatusParamVO를 분석해서 검색할 기간 끝날을 구한다(YYYYMMDD형식)
	 * @param param
	 * @return
	 */
	public String getRangeEndDate(DiagnosisStatusParamVO param) {
		param.setMonth(DateUtil.dayIntToString(Integer.parseInt(param.getMonth())));//월을 2자리로 만들어줌 ex)06,07
		
		switch(param.getDateRangeGubun()){
		case DiagnosisStatusParamVO.GUBUN_TODAY:
			return DateUtil.getToday("YYYYMMDD");
		case DiagnosisStatusParamVO.GUBUN_MONTH:
			int year=Integer.parseInt(param.getYear());
			int month=Integer.parseInt(param.getMonth());
			int lastDay=DateUtil.getLastDay(year, month);
			return param.getYear()+param.getMonth()+DateUtil.dayIntToString(lastDay);
		case DiagnosisStatusParamVO.GUBUN_QUARTER:
			int thisYear=Integer.parseInt(param.getYear());
			int endMonthInt=Integer.parseInt(param.getQuarter())*3;
			int endLastDay=DateUtil.getLastDay(thisYear, endMonthInt);
			String endDate=param.getYear();
			String endMonth=DateUtil.dayIntToString(endMonthInt);
			endDate=endDate+endMonth+DateUtil.dayIntToString(endLastDay);
			return endDate;
		case DiagnosisStatusParamVO.GUBUN_YEAR:
			return param.getYear()+"1231";
		case DiagnosisStatusParamVO.GUBUN_CUSTOM:
			return param.getEndDate();
		default:
			return null;
		}
	}


	private HashMap<String, List<ScheduleVO>> getScheduleByDateHashMap(
			List<ScheduleVO> allScheduleList) {
		HashMap<String,List<ScheduleVO>> hashMap=new HashMap<String,List<ScheduleVO>>();
		int size=allScheduleList.size();
		for(int i=0;i<size;i++){
			ScheduleVO schedule=allScheduleList.get(i);
			hashMap=addScheduleToList(hashMap,schedule);
		}
		return hashMap;
	}	private HashMap<String, List<ScheduleVO>> addScheduleToList(
		HashMap<String, List<ScheduleVO>> hashMap, ScheduleVO schedule) {
		String date="date"+schedule.getFlight_date();
		System.out.println("date:"+date);
		if(hashMap.containsKey(date)){
			hashMap.get(date).add(schedule);
			System.out.println("add");
		}else{
			hashMap.put(date, new ArrayList<ScheduleVO>());
			System.out.println("newList");
		}
		return hashMap;
	}

	public List<GraphByResultVO> getByResultList(
			List<DayWithResultCountVO> resultList) {
		int size=resultList.size();
		List<GraphByResultVO> resultGraphList=new ArrayList<GraphByResultVO>();
		for(int i=0;i<size;i++){
			GraphByResultVO result= new GraphByResultVO();
			DayWithResultCountVO dayWithResult=resultList.get(i);
			result.setTitle(dayWithResult.getFlight_date());
			List<ResultWithCountVO> countList=dayWithResult.getResultWithCountList();
			if(countList.size()>2){
				result.setResult03(countList.get(0).getCount()); //countList 안의 result는 역순으로 배열되있음
				result.setResult02(countList.get(1).getCount());
				result.setResult01(countList.get(2).getCount());
				resultGraphList.add(result);
			}
		}
		return resultGraphList;
	}

	public List<DayWithResultCountVO> getAllSquadronList(
			DiagnosisStatusParamVO param,HttpServletRequest request) throws SQLException {
		param.setAll(true);
		List<UnitVO> squadronList=commonService.getSquadronList(param.getFlightGroup());
		List<DayWithResultCountVO> allSquadronList=new ArrayList<DayWithResultCountVO>();
		int squadronSize=squadronList.size();
		for(int i=0;i<squadronSize;i++){
			UnitVO squadron=squadronList.get(i);
			param.setSquadron(squadron.getSosokcode());
			List<DayWithResultCountVO> resultList=getDayWithResultList(param);
			if(resultList.size()>0){
				DayWithResultCountVO result=resultList.get(0); // 금일 특정 대대 일정을 넣어줌
				result.setFlight_date(squadron.getFullass());
				allSquadronList.add(result);
			}
		}
		return allSquadronList;
	}

	/**
	 * 시스템 관리자만 전체 부대 조회 가능
	 * @param param
	 * @param userVO
	 * @return
	 */
	public DiagnosisStatusParamVO setUserSquadron(DiagnosisStatusParamVO param,
			UserVO userVO) {
		if(userVO.getRole()!=UserRole.SYSTEMADMIN){
			param.setSquadron(userVO.getUnit_code());
		}
		return param;
	}





	

	


	
	
	

}
