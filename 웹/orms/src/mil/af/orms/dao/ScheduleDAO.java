package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.DiagnosisStatusParamVO;
import mil.af.orms.model.ResultCountByDateAndResultVO;
import mil.af.orms.model.ScheduleForModifyVO;
import mil.af.orms.model.ScheduleVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("ScheduleDAO")
public class ScheduleDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	public ScheduleVO getScheduleBySeq(String scheduleSeq) throws SQLException {
		return (ScheduleVO) sqlMapClient.queryForObject("Schedule.getScheduleBySeq",scheduleSeq);
	}
	
	@SuppressWarnings("unchecked")
	public List<ScheduleForModifyVO> getScheduleForViewList(HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getScheduleForViewList",parameterMap);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleForModifyVO> getScheduleForModifyList(HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getScheduleForModifyList",parameterMap);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getMyUnitScheduleList(
			HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getMyUnitScheduleList",parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getMainScheduleList(
			HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getMainScheduleList",parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getScheduleWithResultList(
			HashMap<String, Object> parameterMap) throws SQLException { 
		return sqlMapClient.queryForList("Schedule.getScheduleWithResultList",parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getScheduleByDate(
			HashMap<String, Object> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getScheduleByDate",parameterMap);
	}

	
	public ScheduleVO getRecentScheduleWithResult(String userid) throws SQLException {
		return (ScheduleVO) sqlMapClient.queryForObject("Schedule.getRecentScheduleWithResult",userid);
	}

	public ScheduleVO getSchedule(String scheduleId) throws SQLException {
		return (ScheduleVO) sqlMapClient.queryForObject("Schedule.getSchedule",scheduleId);
	}

	public int setResultToSchedule(HashMap<String, Object> parameterMap) throws SQLException {
		return sqlMapClient.update("Schedule.setResultToSchedule", parameterMap);
	}

	public void deleteSchedule(HashMap<String, String> parameterMap) throws SQLException {
		sqlMapClient.delete("Schedule.deleteSchedule", parameterMap);
	}

	public void deleteAnswers(HashMap<String, String> parameterMap) throws SQLException {
		sqlMapClient.delete("Schedule.deleteAnswers", parameterMap);
		
	}

	public void insertResultToSchedule(HashMap<String, String> parameterMap) throws SQLException {
		sqlMapClient.insert("Schedule.insertResultToSchedule", parameterMap);
		
	}

	public void insertSchedule(ScheduleVO schedule) throws SQLException {
		sqlMapClient.insert("Schedule.insertResultToSchedule", schedule);
		
	}

	public void updateSchedule(ScheduleVO schedule) throws SQLException {
		sqlMapClient.insert("Schedule.updateSchedule", schedule);
		
	}
	
	/**
	 * unit_code,start_date,end_date 필요
	 * @param parameterMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ResultCountByDateAndResultVO> getResultWithCountByDate(
			HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getResultWithCountByDate",parameterMap);
	}

	public Integer getAvailNewId() throws SQLException {
		return (Integer) sqlMapClient.queryForObject("Schedule.getAvailNewId");
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getScheduleWithResultByDate(
			HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getScheduleWithResultByDate",parameterMap);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getAllScheduleByFlightGroup(
			HashMap<String, String> parameterMap) throws SQLException {
		
		return sqlMapClient.queryForList("Schedule.getAllScheduleByFlightGroup",parameterMap);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getDignosisCount(
			HashMap<String, String> parameterMap) throws SQLException {
		return sqlMapClient.queryForList("Schedule.getDignosisResultCount",parameterMap);
	}

	public void insertReason(HashMap<String, String> seqAndReason) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.update("Schedule.insertReason",seqAndReason);
	}

	public String getLastflight_date(String gunbun) throws SQLException {
		// TODO Auto-generated method stub
		return (String) sqlMapClient.queryForObject("Schedule.getLastflight_date",gunbun);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getVOforFlight_date(ScheduleVO schedule) throws SQLException {
		// TODO Auto-generated method stub
		return (List<ScheduleVO>)sqlMapClient.queryForList("Schedule.getVOforFlight_date",schedule);
	}

	@SuppressWarnings("unchecked")
	public List<ScheduleVO> getScheduleWithResultByMonth(
			DiagnosisStatusParamVO param) throws SQLException {
		// TODO Auto-generated method stub
		return (List<ScheduleVO>)sqlMapClient.queryForList("Schedule.getScheduleWithResultByMonth",param);
	}
	
	
}
