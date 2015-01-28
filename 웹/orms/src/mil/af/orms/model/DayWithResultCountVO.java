package mil.af.orms.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.service.CodeService;

public class DayWithResultCountVO {
	
	public DayWithResultCountVO(String flight_date,List<SysCodeVO> resultCodeList) throws SQLException{
		this.flight_date=flight_date;
		resultWithCountList=new ArrayList<ResultWithCountVO>();
		int size=resultCodeList.size();
		for(int i=size-1;i>-1;i--){
			SysCodeVO code=resultCodeList.get(i);
			ResultWithCountVO result=new ResultWithCountVO(code.getCode(),code.getCodename(),0);
			resultWithCountList.add(result);
		}
	}
	
	String flight_date;
	List<ResultWithCountVO> resultWithCountList;
	public String getFlight_date() {
		return flight_date;
	}
	public void setFlight_date(String flight_date) {
		this.flight_date = flight_date;
	}
	public List<ResultWithCountVO> getResultWithCountList() {
		return resultWithCountList;
	}
	public void setResultWithCountList(List<ResultWithCountVO> resultWithCountList) {
		this.resultWithCountList = resultWithCountList;
	}
	
	
}
