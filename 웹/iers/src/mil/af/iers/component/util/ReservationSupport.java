package mil.af.iers.component.util;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import mil.af.iers.dao.CodeDao;
import mil.af.iers.dao.FacilitiesDao;
import mil.af.iers.dao.MemberDao;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.UserDTO;
import mil.af.iers.model.VacationFacilitiesDTO;
import mil.af.iers.service.ReservationService;
import mil.af.iers.dao.ReservationDao;

@Component
public class ReservationSupport {
	@Resource
	private ReservationDao reserveDao;
	@Resource
	private ReservationService reserveService;
	@Resource
	private FacilitiesDao facilitiesDao;
	@Resource
	private MemberDao memberDao;
		
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
		String date = this.reserve.getReservation_day();
		String type = this.reserve.getFacilities_type();
		
		List<VacationFacilitiesDTO> f_list=facilitiesDao.getListOfFacilitiesByType(type);
		int decision=reserveService.getDecisionCountOneDay(date,type);
		
//		확정된 사람 빼고 자리 남으면 등록!
		if(f_list.size()-decision>0){
			Integer id = reserveDao.getReservation_id();
			this.reserve.setReservation_id(id);
			this.reserve.setReservation_state(this.app_wait);
			reserveDao.mergeIntoReservation(this.reserve);
		}
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
	public VacationFacilitiesDTO getReserveFacilities(){
		return facilitiesDao.getOneOfFacilitiesById(this.reserve.getReservation_id());
	}
//	예약인 조회
	public UserDTO getReserveUser() throws SQLException{
		UserDTO user = new UserDTO();
		user.setUser_id(this.reserve.getUser_id());
		user.setUser_sosok(this.reserve.getUser_sosok());
		return memberDao.getOneOfUser(user);
	}
	
	
//	select a.*,
//    (
//    select  	    
//            (SELECT code_score FROM iers_code WHERE code_id = user_rank)+
//            (SELECT code_score FROM iers_code WHERE code_id = user_sosok)+
//            TO_CHAR(sysdate,'yyyy')-TO_CHAR(user_service_term,'yyyy')+
//            NVL((SELECT 3 FROM avs11u0t WHERE userid =user_id AND sosokcode LIKE 'A250%'),0) 
//    from iers_user
//    where user_id = a.user_id
//    ) user_score,
//     (
//    select  	    
//            (SELECT code_order FROM iers_code WHERE code_id = user_rank)
//    from iers_user
//    where user_id = a.user_id
//    ) code_order,
//    decode(instr(a.user_id,'-'),0,substr(a.user_id,0,2)+1000,
//        decode(substr(a.user_id,0,1), 9, substr(a.user_id,0,2)+1900, substr(a.user_id,0,2)+2000)) rank_score
//   
//from OJT.IERS_RESERVATION a
//where to_char(reservation_day,'yyyy-mm-dd')='2013-06-29'
//and facilities_type ='E01'
//order by user_score desc,code_order,rank_score
//
//;
	 
//	 select to_char(reservation_day,'yyyy-mm-dd'),count(*)+
//	(
//	select count(*)
//	from iers_reservation 
//	where reservation_day < a.reservation_day
//	and
//	    a.reservation_day between reservation_day and reservation_day+reservation_period-1
//	 ) absf
//	 from iers_reservation a
//	 group by reservation_day

//	@Scheduled(fixedDelay=1000)
//	public void tt(){
//		System.out.println(System.currentTimeMillis()+"test");
//	}
	
}
