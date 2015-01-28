package mil.af.iers.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.ReservationCalendarDTO;
import mil.af.iers.model.ReservationDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
@Repository
public class ReservationDao {
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate;

//	private SqlMapClient sqlMapClientTemplate;
//	
//	public ReservationDao() {
//		LocalIbatis setting = new LocalIbatis();
//		try {
//			this.sqlMapClientTemplate=setting.getSqlMapClient();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	
	public void mergeIntoReservation(ReservationDTO reserveDTO) throws SQLException{
		sqlMapClientTemplate.insert("ReservationSql.mergeIntoReservation",reserveDTO);
	}
	public Integer getReservation_id() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getReservation_id");
	}
	public void deleteOneApp(int i) throws SQLException{
		sqlMapClientTemplate.delete("ReservationSql.deleteOneApp",i);
	}
	public void updateState(ReservationDTO reserve) throws SQLException{
		sqlMapClientTemplate.update("ReservationSql.updateState",reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getWaitReserveList(ReservationDTO reserve){
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getWaitReserveList", reserve);
	}
	public Integer getDecisionCountOneDay(ReservationDTO reserve) {
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getDecisionCountOneDay", reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationCalendarDTO> getDecisionListByTypeAndDate(Map map){
		return (List<ReservationCalendarDTO>)sqlMapClientTemplate.queryForList("ReservationSql.getDecisionListByTypeAndDate", map);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getReservationofDay(ReservationDTO reserve){
		return (List<ReservationDTO>)sqlMapClientTemplate.queryForList("ReservationSql.getReservationofDay", reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getMyReservation(ReservationDTO reserve){
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getMyReservation", reserve);
	}
	@SuppressWarnings("unchecked")
	public List<ReservationDTO> getYeardata(ReservationDTO reserve) {
		
		return (List<ReservationDTO>) sqlMapClientTemplate.queryForList("ReservationSql.getYeardata",reserve) ;
	}
	public Integer getYearCount(ReservationDTO reserve) {
		
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getYearCount",reserve) ;
	}
	public Integer getMyReserveCount(Map<String,String> map){
		return (Integer) sqlMapClientTemplate.queryForObject("ReservationSql.getMyReserveCount", map);
	}
}
