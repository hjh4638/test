package mil.af.iers.test.hjh;

import java.sql.SQLException;

import mil.af.iers.test.dao.FacilitiesDao;
import mil.af.iers.test.dao.MemberDao;
import mil.af.iers.test.dao.ReservationDao;
import mil.af.iers.test.dao.SettlementDao;

import org.junit.Test;

public class ResetTest {
	private FacilitiesDao facilitiesDao = new FacilitiesDao();
	private MemberDao memberDao = new MemberDao();	
	private ReservationDao reserveDao = new ReservationDao();
	private SettlementDao setDao = new SettlementDao();
	
	@Test
	public void reset() throws SQLException{
		reserveDao.resetReservation();
		setDao.resetSettlement();
		facilitiesDao.resetFacilities();
	}
	
	@Test 
	public void resetUser() throws SQLException{
		memberDao.resetUser();
	}
}
