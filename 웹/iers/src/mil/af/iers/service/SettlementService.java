package mil.af.iers.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.dao.SettlementDao;
import mil.af.iers.model.SettlementDTO;
import mil.af.iers.model.SettlementOfReservationDTO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SettlementService {

	@Resource
	private SettlementDao settlementDao;
	
	@Transactional
	public void mergeSettlement(List<SettlementDTO> li, String settle_date) throws SQLException{
		for(int i=0;i<li.size();i++){
			li.get(i).setSettlement_day(settle_date);
			settlementDao.mergeIntoSettlement(li.get(i));
		}
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleStatistics(String year) {
		return settlementDao.getSettleStatistics(year);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleStatisticsGroup(String year) {
		return settlementDao.getSettleStatisticsGroup(year);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getDetailSettlement(String date){
		return settlementDao.getDetailSettlement(date);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementOfReservationDTO> getDetailReservationSettlement(String date){
		return settlementDao.getDetailReservationSettlement(date);
	}
}
