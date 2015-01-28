package mil.af.orms.dao;

import java.sql.SQLException;

import javax.annotation.Resource;

import mil.af.orms.model.ConfirmVO;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("ConfirmDAO")
public class ConfirmDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapClient;

	public void insertConfirm(ConfirmVO confirmVO) throws SQLException {
		sqlMapClient.insert("Confirm.insertConfirm",confirmVO);
	}

	public Integer getConfirmCount(Integer scheduleId) throws SQLException {
		return (Integer) sqlMapClient.queryForObject("Confirm.getConfirmCount",scheduleId);
	}
	/*2012.5.9  일병 함준혁*/
	public void updateConfirm(ConfirmVO confirmVO) throws SQLException {
		// TODO Auto-generated method stub
		sqlMapClient.insert("Confirm.updateConfirm",confirmVO);
	}

	public String getConfirmDateToCompare(String scheduleSeq) throws SQLException {
		return (String) sqlMapClient.queryForObject("Confirm.getConfirmDateToCompare",scheduleSeq);
	}
	
}
