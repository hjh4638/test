package mil.af.iers.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.SettlementDTO;
import mil.af.iers.model.SettlementOfReservationDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
@Repository
public class SettlementDao {
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate; 

//	private SqlMapClient sqlMapClientTemplate;
//	
//	public SettlementDao() {
//		LocalIbatis setting = new LocalIbatis();
//		try {
//			this.sqlMapClientTemplate=setting.getSqlMapClient();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
//	
	public void mergeIntoSettlement(SettlementDTO settleDTO) throws SQLException{
		sqlMapClientTemplate.insert("SettlementSql.mergeIntoSettlement",settleDTO);
	}
	
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleData()throws SQLException
	{
		return sqlMapClientTemplate.queryForList("SettlementSql.getSettleData");
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleStatistics(String year) {
		return (List<SettlementDTO>) sqlMapClientTemplate.queryForList("SettlementSql.getSettleStatistics", year);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleStatisticsGroup(String year) {
		return (List<SettlementDTO>) sqlMapClientTemplate.queryForList("SettlementSql.getSettleStatisticsGroup", year);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getDetailSettlement(String date){
		return (List<SettlementDTO>) sqlMapClientTemplate.queryForList("SettlementSql.getDetailSettlement", date);
	}
	@SuppressWarnings("unchecked")
	public List<SettlementOfReservationDTO> getDetailReservationSettlement(String date){
		return (List<SettlementOfReservationDTO>) sqlMapClientTemplate.queryForList("SettlementSql.getDetailReservationSettlement", date);
	}
	
}
