package mil.af.orms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("CommonDAO")
public class CommonDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	public UserVO getIntraUser(String userid) throws SQLException {
		return (UserVO) sqlMapClient.queryForObject("Common.getIntraUser",userid);
	}

	@SuppressWarnings("unchecked")
	public List<UnitVO> getUnitCodeList(String sosokcode) throws SQLException {
		return sqlMapClient.queryForList("Common.getUnitCodeList",sosokcode);
	}
	
	@SuppressWarnings("unchecked")
	public List<UserVO> getSearchedUserList(String searchName) throws SQLException {
		return sqlMapClient.queryForList("Common.getSearchedUserList",searchName);
	}

	@SuppressWarnings("unchecked")
	public List<UserVO> getFormationPilotList(String formationCode) throws SQLException {
		return sqlMapClient.queryForList("Common.getFormationPilotList",formationCode);
	}
	
	@SuppressWarnings("unchecked")
	public List<UnitVO> getAllFlightGroupList() throws SQLException {
		return sqlMapClient.queryForList("Common.getAllFlightGroupList");
	}
	
	public UnitVO getFlightGroup(UserVO userVO) throws SQLException{
		// TODO Auto-generated method stub
		return (UnitVO) sqlMapClient.queryForObject("Common.getFlightGroup",userVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<UnitVO> getSquadronList(String flightGroupCode) throws SQLException {
		return sqlMapClient.queryForList("Common.getSquadronList",flightGroupCode);
	}

	@SuppressWarnings("unchecked")
	public List<UnitVO> getAllSquadronList() throws SQLException {
		return sqlMapClient.queryForList("Common.getAllSquadronList");
	}

	public UserAuthVO getUserRole(String userid) throws SQLException {
		return (UserAuthVO) sqlMapClient.queryForObject("Common.getUserRole",userid);
	}

	@SuppressWarnings("unchecked")
	public List<UnitVO> getFlightGroupWithSquadronListByLevel() throws SQLException {
		return sqlMapClient.queryForList("Common.getFlightGroupWithSquadronListByLevel");
	}

	public String getUserPlane(String sosokcode) throws SQLException {
		List<String> air = sqlMapClient.queryForList("Common.getUserPlane",sosokcode);
		if(air.size()>0)
			return (String) sqlMapClient.queryForList("Common.getUserPlane",sosokcode).get(0);
		else 
			return null;
	}
	public List<String> getUserPlaneList(String sosokcode) throws SQLException {
		List<String> air = sqlMapClient.queryForList("Common.getUserPlane",sosokcode);
			return air;
	}

	public String getUnitName(String squadron) throws SQLException {
		List<String> unit_names=sqlMapClient.queryForList("Common.getUnitName",squadron);
		if(unit_names.size()>0){
			return unit_names.get(0);
		}
		else return null;
	}
	
	public String getUnitCode(String squadron) throws SQLException {
		List<String> qq = sqlMapClient.queryForList("Common.getUnitCode",squadron);
		if(qq.size()>0)
		return (String) sqlMapClient.queryForList("Common.getUnitCode",squadron).get(0);
		else
			return null;
	}

	public List<SysCodeVO> getPeriod() throws SQLException {
		return sqlMapClient.queryForList("Common.getPeriod");
	}

	public String getToday() throws SQLException {
		return (String) sqlMapClient.queryForObject("Common.getToday");
	}

	public UnitVO getSquadron(String userid) throws SQLException {
		// TODO Auto-generated method stub
		return (UnitVO)sqlMapClient.queryForObject("Common.getSquadron", userid);
	}

	
}
