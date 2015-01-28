package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.CodeDAO;
import mil.af.orms.model.SysCodeVO;

import org.springframework.stereotype.Service;

@Service("CodeService")
public class CodeService {
	@Resource(name="CodeDAO")
	CodeDAO codeDAO;
	
	List<SysCodeVO> resultList=null;

	public List<SysCodeVO> getTimePeriodList() throws SQLException {
		return codeDAO.getTimePeriodList();
	}
	
	public List<SysCodeVO> getPositionList() throws SQLException{
		return codeDAO.getPositionList();
	}
	
	public List<SysCodeVO> getResultList() throws SQLException{
		if(resultList==null){
			resultList=codeDAO.getResultList();
		}
		return resultList;
	}
	
	public List<SysCodeVO> getSectionList(String position, String squadron, String airplane) throws SQLException{
		if("01".equals(position)){
			return codeDAO.getSectionList("ORM004",squadron,airplane);
		}else if("02".equals(position)){
			return codeDAO.getSectionList("ORM005",squadron,airplane);
		}else{
			return null;
		}
	}
	
	public List<String> getWeatherConditionList(){
		List<String> weatherConditionList=new ArrayList<String>();
		weatherConditionList.add("A");
		weatherConditionList.add("B");
		weatherConditionList.add("C");
		return weatherConditionList;
	}

	public String getDayPeriod(String period) {
		if("04".equals(period)){ //Night일때만 야간
			return "02";//야간
		}else{ // 01,02,03(1st,2st,3st) 일때는 주간
			return "01";
		}
	}
	
}
