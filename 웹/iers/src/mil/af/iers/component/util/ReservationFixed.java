package mil.af.iers.component.util;

import java.net.MalformedURLException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.dao.CodeDao;
import mil.af.iers.dao.FacilitiesDao;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.VacationFacilitiesDTO;
import mil.af.iers.service.MemberService;
import mil.af.iers.service.ReservationService;

import org.junit.Test;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Administrator
 * 해당 시간에 예약 확정 시켜주는 클래스
 */
@Component
public class ReservationFixed {
	@Resource
	private CodeDao codeDao;
	@Resource
	private FacilitiesDao facilitiesDao;
	@Resource
	private ReservationSupport reserveSupport;
	@Resource
	private ReservationService reserveService;
	@Resource
	private MemberService memberService;
	
	static public String getDay(int i){
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, i);
		String day=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
	
		return day;
	}
	static public String getYear(int i){
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, i);
		String day=cal.get(cal.YEAR)+"";
	
		return day;
	}
	@Test
	public void d(){
		System.out.println(getDay(7));
	}
	@SuppressWarnings("unused")
	@Transactional
	private void reservationFix() throws SQLException{
		String date =getDay(7);
		SMSSender sms= new SMSSender();
//		String date = "2013-06-28";
		List<FacilitiesCodeDTO> facilCodeList = codeDao.getFacilCodeBySectionInclude("normal");
		for(int i=0;i<facilCodeList.size();i++)
		{			
			String type=facilCodeList.get(i).getFacilities_type();
			List<ReservationDTO> reserveList = reserveService.getWaitReserveList(date, type);
			List<VacationFacilitiesDTO> f_list=facilitiesDao.getListOfFacilitiesByType(type);
			
			int decision=reserveService.getDecisionCountOneDay(date,type);
			int size = (reserveList.size()>f_list.size()-decision)? f_list.size()-decision:reserveList.size();
			
			for(int j=0;j<size;j++){
				ReservationDTO reserve=reserveList.get(j);
				reserveSupport.setReserve(reserve);
				reserveSupport.updateAppWait();
				
				String cell=memberService.getCellPhone(reserve.getUser_id(), reserve.getUser_sosok());
				try {
					sms.SendSMS("010-7777-7777", cell, "[철매휴양소] "+reserve.getReservation_day()+ "일자 예약이 확정되었습니다. 결재바랍니다.");
				} catch (MalformedURLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}
	@Scheduled(cron="0 30 16 * * *")
	public void decideApp() throws SQLException{
		reservationFix();
		System.out.println("매일 4시 30분에 예약확정 납니다~");
	}
//	@Scheduled(fixedDelay=60000)
//	public void tt() throws SQLException{
//		System.out.println(System.currentTimeMillis()+"test");
//		reservationFix();
//	}
}
