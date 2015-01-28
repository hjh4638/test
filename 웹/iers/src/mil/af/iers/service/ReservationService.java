package mil.af.iers.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.iers.dao.ReservationDao;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;

import org.junit.Test;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {
	@Resource
	private ReservationDao reserveDao;
	
	public List<ReservationDTO> getWaitReserveList(ReservationDTO reserve){
		return reserveDao.getWaitReserveList(reserve);
	}
	public List<ReservationDTO> getWaitReserveList(String reservation_day,String facilities_type){
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(reservation_day);
		reserve.setFacilities_type(facilities_type);
		return reserveDao.getWaitReserveList(reserve);
	}
	public Integer getDecisionCountOneDay(String date,String type) throws SQLException{
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(date);
		reserve.setFacilities_type(type);
		return reserveDao.getDecisionCountOneDay(reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationCalendarDTO> getDecisionListByTypeAndDate(String type/*,String date*/) {
		Map param = new HashMap<String, String>();
		param.put("facilities_type", type);
//		param.put("selectedDate", date);
		return reserveDao.getDecisionListByTypeAndDate(param);
	}
	public List<ReservationDTO> getReservationofDay(ReservationDTO reserve) {
		// TODO Auto-generated method stub
		return reserveDao.getReservationofDay(reserve);
	}
	public List<ReservationCalendarDTO> sortCalList(List<FacilitiesCodeDTO> f_code,	List<ReservationCalendarDTO> calList) {
		List<ReservationCalendarDTO> compareList=getDecisionListByTypeAndDate(f_code.get(0).getFacilities_type());
		List<ReservationCalendarDTO> resultList=new ArrayList<ReservationCalendarDTO>();
		
		for(int j=0;j<compareList.size();j++){
			for(int i=0;i<calList.size();i++){
				ReservationCalendarDTO cal=calList.get(i);
				if(compareList.get(j).getStart().equals(cal.getStart())){
					resultList.add(cal);
				}
			}
		}
		
		return resultList;
	}
	public void updateState(ReservationDTO reserve) throws SQLException{
		reserveDao.updateState(reserve);
	}
	public List<ReservationCalendarDTO> compressCalList(List<FacilitiesCodeDTO> f_code,	List<ReservationCalendarDTO> calList){
		List<ReservationCalendarDTO> compareList=getDecisionListByTypeAndDate(f_code.get(0).getFacilities_type());
//		List<ReservationCalendarDTO> resultList=new ArrayList<ReservationCalendarDTO>();
		
		for(int j=0;j<compareList.size();j++){
			
			ReservationCalendarDTO com=compareList.get(j);
			String title="";
			
			for(int i=0;i<calList.size();i++){
				ReservationCalendarDTO cal=calList.get(i);
				if(compareList.get(j).getStart().equals(cal.getStart())){
					title+="<font class=\'"+cal.getClassName()+ "\'>"+cal.getTitle()+"</font><br>";
				}
			}
			if(title.lastIndexOf("<br>")!=-1){
				if(j>=compareList.size()-3 && j<=compareList.size()-1)
					title+="<a href=\'main.do?type=reserve&date="+com.getStart()+"\'><img src='./images/common/reserve_btn.gif'></a>";
				else{
					title=title.substring(0, title.lastIndexOf("<br>"));
				}
				com.setTitle(title);
			}
		}
		
		return compareList;
	}
	public List<ReservationCalendarDTO> compressCalListToAdmin(List<FacilitiesCodeDTO> f_code,	List<ReservationCalendarDTO> calList){
		List<ReservationCalendarDTO> compareList=getDecisionListByTypeAndDate(f_code.get(0).getFacilities_type());
//		List<ReservationCalendarDTO> resultList=new ArrayList<ReservationCalendarDTO>();
		
		for(int j=0;j<compareList.size();j++){
			
			ReservationCalendarDTO com=compareList.get(j);
			String title="";
			
			for(int i=0;i<calList.size();i++){
				ReservationCalendarDTO cal=calList.get(i);
				if(compareList.get(j).getStart().equals(cal.getStart())){
					title+="<font class=\'"+cal.getClassName()+ "\'>"+cal.getTitle()+"</font><br>";
				}
			}
			if(title.lastIndexOf("<br>")!=-1){
				title+="<a href=\'admin.do?type=reserve&date="+com.getStart()+"\'><img src='./images/common/reserve_btn.gif'></a>";
				com.setTitle(title);
			}
		}
		
		return compareList;
	}
	public List<ReservationDTO> getMyReservation(ReservationDTO reserve){
		return reserveDao.getMyReservation(reserve);
	}
	public List<ReservationDTO> getMyReservation(String user_id,String user_sosok){
		ReservationDTO reserve = new ReservationDTO();
		reserve.setUser_id(user_id);
		reserve.setUser_sosok(user_sosok);
		return reserveDao.getMyReservation(reserve);
	}
	public List<ReservationDTO> getYeardata(ReservationDTO reserve){
		return reserveDao.getYeardata(reserve);
	}
	public List<ReservationDTO> getYeardata(String day,String user_id,String user_sosok){
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(day);
		reserve.setUser_id(user_id);
		reserve.setUser_sosok(user_sosok);
		return reserveDao.getYeardata(reserve);
	}
	public Integer getYearCount(ReservationDTO reserve) {
		
		return reserveDao.getYearCount(reserve); 
	}
	public Integer getYearCount(String user_id,String user_sosok){
		ReservationDTO reserve = new ReservationDTO();
		reserve.setUser_id(user_id);
		reserve.setUser_sosok(user_sosok);
		return reserveDao.getYearCount(reserve);
	}
	public void deleteOneAPP(int i) throws SQLException{
		reserveDao.deleteOneApp(i);
	}
	public Integer getMyReserveCount(Map<String,String> map){
		return reserveDao.getMyReserveCount(map);
	}
	public Integer getMyReserveCount(String user_id,String user_sosok){
		Map<String,String> map = new HashMap<String,String>();
		map.put("user_id", user_id);
		map.put("user_sosok", user_sosok);
		return reserveDao.getMyReserveCount(map);
	}
	
	
	
	
	@Test
	public void test(){
		String s = "dkdkdkdk<br>asdfasd<br>asfa<br>";
		s.lastIndexOf("<");
		s.substring(0, s.lastIndexOf("<br>"));
		System.out.println(s.substring(0, s.lastIndexOf("<")));
		
	}
}
