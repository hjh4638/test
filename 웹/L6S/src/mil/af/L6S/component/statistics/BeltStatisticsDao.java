package mil.af.L6S.component.statistics;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.belt.BeltGraphVO;
import mil.af.L6S.component.belt.BeltTableVO;

/**
 *  벨트 통계 전용 DAO
 * @author 정성모
 */
@Repository
public class BeltStatisticsDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 *  그래프에 들어갈 수료/자격자 수 가져오기
	 * @param year
	 * @return List<BeltGraphVO>
	 */
	@SuppressWarnings("unchecked")
	public List<BeltGraphVO> belt1Count(SearchFilter searchFilter){
		return sqlMapClientTemplate.queryForList("StatisticsSql.belt1Count", searchFilter);
	}
	
	/**
	 *  Table(표)에 들어갈 조건부 데이터 들고오기
	 * @param year
	 * @return List<BeltTableVO>
	 */
	@SuppressWarnings("unchecked")
	public List<BeltTableVO> getTableDatum(SearchFilter searchFilter){
		return sqlMapClientTemplate.queryForList("StatisticsSql.getTableDatum", searchFilter);
	}
}
