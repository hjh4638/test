package mil.af.hq.orms.test.hjh;

import java.sql.SQLException;
import java.util.List;

import org.junit.Test;

public class TestTest {
	private static TestDao testDao = new TestDao();
	 
	
	public static void main(String args[]) throws SQLException{
		List<DataOfHistoryDTO> li2 =testDao.getScoreTypeCount();
		List<DataOfHistoryDTO> li =testDao.getScoreDetailData();
		
	}
	
	
}
