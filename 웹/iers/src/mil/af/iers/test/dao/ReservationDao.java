package mil.af.iers.test.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ReservationDao {
	private SqlMapClient sqlMapClientTemplate;
	
	public ReservationDao() {
		LocalIbatis setting = new LocalIbatis();
		try {
			this.sqlMapClientTemplate=setting.getSqlMapClient();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void mergeIntoReservation(ReservationDTO reserveDTO) throws SQLException{
		sqlMapClientTemplate.insert("ReservationSql.mergeIntoReservation",reserveDTO);
	}
	public Integer getReservation_id() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getReservation_id");
	}
	public void deleteOneApp(Integer id) throws SQLException{
		sqlMapClientTemplate.delete("ReservationSql.deleteOneApp",id);
	}
	public void updateState(ReservationDTO reserve) throws SQLException{
		sqlMapClientTemplate.update("ReservationSql.updateState",reserve);
	}
	public void resetReservation() throws SQLException{
		sqlMapClientTemplate.delete("ReservationSql.resetReservation");
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getWaitReserveList(ReservationDTO reserve) throws SQLException{
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getWaitReserveList", reserve);
	}
//test용
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getWaitReserveList(String date, String type) throws SQLException {
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(date);
		reserve.setFacilities_type(type);
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getWaitReserveList", reserve);
	}
	public Integer getDecisionCountOneDay(ReservationDTO reserve) throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getDecisionCountOneDay", reserve);
	}
	public Integer getDecisionCountOneDay(String date,String type) throws SQLException{
		ReservationDTO reserve = new ReservationDTO();
		reserve.setReservation_day(date);
		reserve.setFacilities_type(type);
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getDecisionCountOneDay", reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getDecisionListByTypeAndDate(Map map) throws SQLException{
		return (List<ReservationDTO>)sqlMapClientTemplate.queryForList("ReservationSql.getDecisionListByTypeAndDate", map);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationCalendarDTO> getDecisionListByTypeAndDate(String type/*,String date*/) throws SQLException{
		Map param = new HashMap<String, String>();
		param.put("facilities_type", type);
		
//		param.put("selectedDate", date);
		return (List<ReservationCalendarDTO>)sqlMapClientTemplate.queryForList("ReservationSql.getDecisionListByTypeAndDate", param);
	}
	public List<ReservationDTO> getMyReservation(ReservationDTO reserve) throws SQLException{
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getMyReservation", reserve);
	}
	public List<ReservationDTO> getYeardata(ReservationDTO reserve) throws SQLException {
		
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getYeardata",reserve) ;
	}
	public Integer getMyReserveCount(Map<String,String> map) throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getMyReserveCount", map);
	}
}
