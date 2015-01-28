package mil.af.iers.test.hjh;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.junit.Test;
import mil.af.iers.model.*;

import mil.af.iers.test.dao.CodeDao;
import mil.af.iers.test.dao.FacilitiesDao;

public class FacilitiesTest {
	private FacilitiesDao facilitiesDao = new FacilitiesDao();
	private CodeDao codeDao = new CodeDao();
	
	@Test
	public void nullTest(){
		
		Integer a =10;
		Integer c = a==null?0:a;
		Integer b=1;
		System.out.println(c+b);
		
	}
//	@Test
	public void dateTest(){
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		String today=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
		cal.add(Calendar.DATE, 5);
		String day=cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
		System.out.println(today);
		System.out.println(day);
	}
//	@Test
	public void deleteFCode() throws SQLException{
		codeDao.deleteFacilitiesCode("E08");
	}
//	@Test
	public void insertFCode() throws SQLException{
		FacilitiesCodeDTO f = new FacilitiesCodeDTO();
		f.setFacilities_type("E08");
		f.setFacilities_type_name("testttttt");
		f.setFacilities_accommodation(33);
		f.setFacilities_add_price(2000);
		
		codeDao.mergeIntoFacilitiesCode(f);
	}
//	@Test
	public void insertFacilities() throws SQLException{
		VacationFacilitiesDTO facilDTO = new VacationFacilitiesDTO();
		int size = 30;
		
		for(int i=0; i<size;i++){
//			insert 테스트시
			Integer seq = facilitiesDao.getFacilitiesId();
//			수정 테스트시
			Integer upseq = i;
			String name = "철매관"+i;
			Integer price = 100*i;
			
			facilDTO.setFacilities_id(upseq);
			facilDTO.setFacilities_name(name);
			
			
			facilitiesDao.mergeIntoFacilities(facilDTO);
		}
	}
}
