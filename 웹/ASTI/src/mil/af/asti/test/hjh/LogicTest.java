package mil.af.asti.test.hjh;

import java.sql.SQLException;
import java.util.List;

import org.junit.Test;

import mil.af.asti.model.AstiCodeDTO;

public class LogicTest {

	private TestDao testDao = new TestDao();
	
	@Test
	public void aaaa() throws SQLException{
		String compare_type = "B00";
		
		List<AstiCodeDTO> sdd = testDao.getAstiCodeByType("board");
				
		System.out.println(typeCheck(compare_type));
		
	}
	
	public boolean typeCheck(String type) throws SQLException{
		List<AstiCodeDTO> sdd = testDao.getAstiCodeByType("board");
			
		for(int i=0;i<sdd.size();i++){
			if(sdd.get(i).getCode_id().equals(type))
				return true;
		}
		return false;
	}
}
