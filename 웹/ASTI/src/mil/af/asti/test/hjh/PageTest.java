package mil.af.asti.test.hjh;

import java.sql.SQLException;
import java.util.List;

import mil.af.asti.model.AstiPageDTO;

import org.junit.Test;

public class PageTest {
	private PageDao pageDao = new PageDao();
	
	@Test
	public void pageUpdateTest() throws SQLException{
		String page_id = "D01";
		String page_picture_id = "aa";
		String page_picture_name = "aa";
		
		AstiPageDTO page = new AstiPageDTO();
		page.setPage_id(page_id);
		page.setPage_picture_id(page_picture_id);
		page.setPage_picture_name(page_picture_name);
		
		pageDao.updatePageInfo(page);
		
		AstiPageDTO dd = pageDao.getPageInfo("D01");
		System.out.println(dd.getPage_name());
	}
}
