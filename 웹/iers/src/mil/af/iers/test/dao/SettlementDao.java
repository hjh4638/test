package mil.af.iers.test.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.SettlementDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

public class SettlementDao {
	private SqlMapClient sqlMapClientTemplate;
	
	public SettlementDao() {
		LocalIbatis setting = new LocalIbatis();
		try {
			this.sqlMapClientTemplate=setting.getSqlMapClient();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void mergeIntoSettlement(SettlementDTO settleDTO) throws SQLException{
		sqlMapClientTemplate.insert("SettlementSql.mergeIntoSettlement",settleDTO);
	}
	public void resetSettlement() throws SQLException{
		sqlMapClientTemplate.delete("SettlementSql.resetSettlement");
	}
	@SuppressWarnings("unchecked")
	public List<SettlementDTO> getSettleStatistics(String year) throws SQLException{
		return (List<SettlementDTO>) sqlMapClientTemplate.queryForList("SettlementSql.getSettleStatistics", year);
	}
}
