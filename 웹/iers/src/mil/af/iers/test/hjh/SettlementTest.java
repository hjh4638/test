package mil.af.iers.test.hjh;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.junit.Test;

import mil.af.iers.test.dao.SettlementDao;
import mil.af.iers.model.SettlementDTO;

public class SettlementTest {
	private SettlementDao setDao = new SettlementDao();
	
	@Test
	public void insertSettlement() throws SQLException{
		SettlementDTO settleDTO = new SettlementDTO();
		int size=12;
		
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
				
		for(int i=1;i<size;i++){
			String today=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
			settleDTO.setFacilities_id(i);
			settleDTO.setSettlement_day(today);
			settleDTO.setSettlement_people_count(10);
			
			setDao.mergeIntoSettlement(settleDTO);
		}
	}
	@Test
	public void statistics() throws SQLException{
		List<SettlementDTO> a=setDao.getSettleStatistics("2013");
		for(int i=0;i<a.size();i++)
			System.out.println(a.get(i).getSettlement_day()+" "+a.get(i).getSettlement_people_count()+" " + a.get(i).getSettlement_total_price());
	}
}
