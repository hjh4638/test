package mil.af.iers.test.hjh;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.junit.Test;

import mil.af.iers.test.dao.*;
import mil.af.iers.component.util.ReservationFixed;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.UserDTO;
import mil.af.iers.model.VacationFacilitiesDTO;

public class ReservationTest { 
	private ReservationDao reserveService = new ReservationDao();
	private ReservationDao reserveDao = new ReservationDao();
	private CodeDao codeDao=new CodeDao();
	private ReserveSupportTest reserveSupport= new ReserveSupportTest();
	private FacilitiesDao facilitiesDao= new FacilitiesDao();
	
//	@Test
	public void ora01861test() throws SQLException{
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(ReservationFixed.getYear(0));
		reserve.setUser_id("18");
		reserve.setUser_sosok("B01");
		List<ReservationDTO> li =reserveDao.getYeardata(reserve);
		
		for(int i=0;i<li.size();i++){
			System.out.println(li.get(i).getReservation_day());
		}
	}
	
//	@Test
	public void orderTest() throws SQLException{
		ReservationDTO reserve = new ReservationDTO();
		reserve.setUser_id("a");
		reserve.setUser_sosok("B01");
		List<ReservationDTO> a = reserveDao.getMyReservation(reserve);
		for(int i=0;i<a.size();i++){
			System.out.println(a.get(i).getReservation_day());
		}
		
	}
//	@Test 
	public void insertReserve() throws SQLException{ 
		ReservationDTO reserveDTO = new ReservationDTO();
		int size=21;
				
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		for(int i=10;i<size;i++){
			Integer f_id=0;
			String u_id="11-"+i+""+i;
			String sosok="B01";
			String day = "2013-07-17";
			Integer period= 1;
			String today=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			String state = "C01";
			Integer count=4;
			Integer seq = reserveDao.getReservation_id();
			
//			reserveDTO.setFacilities_type(f_id);
//			reserveDTO.setUser_id(u_id);
//			reserveDTO.setUser_sosok(sosok);
//			reserveDTO.setReservation_day(day);
//			reserveDTO.setReservation_period(period);
//			reserveDTO.setReservation_register_date(today);
//			reserveDTO.setReservation_state(state);
//			reserveDTO.setReservation_people_count(count);
//			reserveDTO.setReservation_id(seq);
//			
//			reserveDao.mergeIntoReservation(reserveDTO);
			
		}
	}
//	@Test
	public void getDecisionList() throws SQLException{
		
		List<ReservationCalendarDTO> li =reserveDao.getDecisionListByTypeAndDate("E01");
		for(int i=0;i<li.size();i++){
			System.out.println(li.get(i).getStart()+"  "+
					li.get(i).getTitle());
		}
	}
	@Test
	public void reservationFixTest() throws SQLException{
		reservationFix();
	}
	public String getDay(int i){
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, i);
		String day=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
	
		return day;
	}
	@SuppressWarnings("unused")
	private void reservationFix() throws SQLException{
//		String date =getDay(7);
		String date = "2013-07-22";
		List<FacilitiesCodeDTO> facilCodeList = codeDao.getFacilCodeBySectionInclude("normal");
		for(int i=0;i<facilCodeList.size();i++)
		{			
			String type=facilCodeList.get(i).getFacilities_type();
			List<ReservationDTO> reserveList = reserveService.getWaitReserveList(date, type);
			List<VacationFacilitiesDTO> f_list=facilitiesDao.getListOfFacilitiesByType(type);

			int decision=reserveDao.getDecisionCountOneDay(date,type);
			int size = (reserveList.size()>f_list.size()-decision)? f_list.size()-decision:reserveList.size();
			
			for(int j=0;j<size;j++){
				reserveSupport.setReserve(reserveList.get(j));
				reserveSupport.updateAppWait();
			}
		}
		
	}
}
class ReserveSupportTest{
	private ReservationDao reserveDao = new ReservationDao();
	private FacilitiesDao facilitiesDao=new FacilitiesDao();
	private MemberDao memberDao=new MemberDao();
	private final String wait="C01";/*예약*/
	private final String app_wait="C02"; /*예약확정(결재대기)*/
	private final String app_success="C03"; /*결재완료*/
	private final String app_quit="C04"; /*결재취소*/
	
//	싱글톤이라 생성자 못쓸듯;;
//	검증된 ReservationDTO 객체를 set해야함~~
	private ReservationDTO reserve;
	public ReservationDTO getReserve() {
		return reserve;
	}
	public void setReserve(ReservationDTO reserve) {
		this.reserve = reserve;
	}
	
	//	일반인 예약추가
	public void reserveRoom() throws SQLException{
		Integer id = reserveDao.getReservation_id();
		this.reserve.setReservation_id(id);
		this.reserve.setReservation_state(this.wait);
		reserveDao.mergeIntoReservation(this.reserve);
	}
//	SR이나 VIP 예약추가
	public void reserveAdminRoom() throws SQLException{
		Integer id = reserveDao.getReservation_id();
		this.reserve.setReservation_id(id);
		this.reserve.setReservation_state(this.app_wait);
		reserveDao.mergeIntoReservation(this.reserve);
	}
//	예약수정
	public void modifyApp() throws SQLException{
		if(this.reserve.getReservation_id()==null || "".equals(this.reserve.getReservation_id())){
			System.out.println("바꿀 행의 위치(seq)가 없습니다.");
			return;
		}
		reserveDao.mergeIntoReservation(this.reserve);
	}
//	예약삭제
	public void deleteApp() throws SQLException{
		reserveDao.deleteOneApp(this.reserve.getReservation_id());
	}
//	예약확정
	public void updateAppWait() throws SQLException{
		ReservationDTO reserveDTO=new ReservationDTO();
		reserveDTO.setReservation_id(this.reserve.getReservation_id());
		reserveDTO.setReservation_state(this.app_wait);
		reserveDao.updateState(reserveDTO);
	}
//	결재완료
	public void updateAppSuccess() throws SQLException{
		ReservationDTO reserveDTO=new ReservationDTO();
		reserveDTO.setReservation_id(this.reserve.getReservation_id());
		reserveDTO.setReservation_state(this.app_success);
		reserveDao.updateState(reserveDTO);
	}
//	결재취소
	public void updateAppQuit() throws SQLException{
		ReservationDTO reserveDTO=new ReservationDTO();
		reserveDTO.setReservation_id(this.reserve.getReservation_id());
		reserveDTO.setReservation_state(this.app_quit);
		reserveDao.updateState(reserveDTO);
	}
//	예약 시설 조회
//	public VacationFacilitiesDTO getReserveFacilities(){
//		return facilitiesDao.getOneOfFacilitiesById(this.reserve.getReservation_id());
//	}
//	예약인 조회
	public UserDTO getReserveUser() throws SQLException{
		UserDTO user = new UserDTO();
		user.setUser_id(this.reserve.getUser_id());
		user.setUser_sosok(this.reserve.getUser_sosok());
		return memberDao.getOneOfUser(user);
	}
	
}

