package mil.af.asti.test.hjh;

import java.sql.SQLException;

import mil.af.asti.model.*;

import org.junit.Test;

public class DeptTest {

	private DeptDao deptDao = new DeptDao();
	
	@Test
	public void ddd(){
		String aa = "a_emp_id=GUEST; enc_emp_id=03483896581730; sosokcode=Z10000; ReturnUrl=http://www.hq.af.mil:9999/AfPortal/mz/moveMainpage.jsp; aev20_return=http://www.hq.af.mil:9999/AfPortal/mz/moveMainpage.jsp; avs22ReturnUrl=http://www.hq.af.mil:9999/AfPortal/mz/moveMainpage.jsp; ka_sso_token=S0LlPagNj8PWPovkq3YKOX7luvRLJe%2Fwi9KVvNOsd7Kg4agOI%2F66XOtaqNOvx1VhdSFNTPvCDMRLcDnLp88AD44mjp%2BhmLTGZxFuXC7KU4LGfpOhpcwjl9LorlEm6IKcKYRnS23NId46ONQZedeGRoGEzwOCTny4%2Bja%2F61uFzqwtscLsvzMMRAt95jj6DV%2FJj6WXHH1kRV%2B2SFzQ5KxXBSItZYg3TD6XcjUGyrtWcUFv1nLyMuOCDrI4GZtaV5RnIProWjtp4%2FZ%2BqoxQknqdMWPaLrwPKGgu7uJ%2BEBuirtQi0OTvY%2BNtbJNN7kll0z02elSyJbzNVmKl%2FFQVYeZR5jflPHJ1Cq%2BaTHmtyQxsZpUSJaUahbT%2FJ03a5JvqibjFI4D4tSZClDGUHlTlb%2B394QbCIMZNHWsAe3dFOPhaXd25CUC94kwySpCEW9FrGLt7YOQwMK4SXZyF8Zv1cHZIi0gjMTMJmOCxT1OCYNIUOIDVvNidL53dCNOL35eTPQ3NqPeVDYFoPTORKHy2xP4%2FpLifhdnX0wAfKDsom4aCZYjzIbxWH9FpJb2rcsYZEKJVU3Tc7OA2LrZBuxPsHwXNoxrTSygD%2BbgUf7zgvlVBtkxt7QlTsotO%2BCZ5IHd%2Fy01mFgHoX1bgqhU5mYJqXU6cT0Z1zSaq11pxN5XiVm5YPTgeTuMaTJS6DZXy89wWueRC3QYnql99s4yKhEET5Y62U%2BKmP6ioAAnva1gFm4b49lc4bB8v0SpY36cw09sNO7I%2FRwQwxmam5Wn1ckRoApVHFG%2Fkt4aP0DjHzLb9oyFQry2ZQFcQBywzyGJ%2FdrIFLDl5Rt%2B9mVV4A1ogAEp%2FxLPtGSBtqHGltxDcKqgdU6HiU2Nuqo8joyPI1bG79uWxynPdPhg17w6ta7flQ9fuTyOTRV9FZk8CjdDNmwiTB0IFMaThATR%2FIqK4krO8sbYWr%2Fh%2B4q7AnX9gVz8URx3TqktQZRcxIknvfIandSANVmspXg7dSoPzOvoHuYBn3w6YzndpTGnXyVdCbhA513fQKjsJKWAuwP2Hjxpa5kd%2FVj6Se5Q3Zj%2F4%2FnOhh7XEM8cWVY4UD0QUDFJvDYXe1ubPtlIU8g%3D%3D; JSESSIONID=9ysPRLQPYwz51vgv6cb7kGy7qbDgyvXCQ1xywr8JghylKGvHQ8tC!411537259; WMONID=PVMLplH7Um0";
		String c[]=aa.split(";");
		for(int i=0;i<c.length;i++)
			System.out.println(c[i]);
	}
	
	
	public void typeTest(){
		String board_id = "init";
		int d =Integer.parseInt(board_id);
		System.out.println(d);
	}
	
	@Test
	public void workerInsert() throws Exception{
		Integer worker_id = deptDao.getMaxWorkerId();
		String worker_name = "함준혁테스";
		String worker_department ="C02";
		String worker_detail_info = "개발담당이당~~ㅅㄷㄴㅅㄴㅅㄴㄷㅅ";
		String worker_picture_id = "";
		String worker_picture_name = "djㄷㅅㄴㅅㄴㄷㅅ";
		
		AstiResearchWorkerDTO research = new AstiResearchWorkerDTO();
		research.setWorker_id(worker_id);
		research.setWorker_name(worker_name);
		research.setWorker_department(worker_department);
		research.setWorker_detail_info(worker_detail_info);
		research.setWorker_picture_id(worker_picture_id);
		research.setWorker_picture_name(worker_picture_name);
		
		deptDao.mergeIntoWorker(research);
	}
	
	@Test
	public void workerDelete() throws Exception{
		AstiBoardSearchDTO search = new AstiBoardSearchDTO();
		search.setWorker_id("601");
		
		deptDao.deleteWorker(search);
		
	}
}
