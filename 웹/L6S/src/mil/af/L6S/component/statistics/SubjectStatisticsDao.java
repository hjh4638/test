package mil.af.L6S.component.statistics;

import java.util.List;
import java.util.Map;

import mil.af.L6S.component.belt.BeltTableVO;
import mil.af.L6S.component.subject.SubjectFormAndDataVO;
import mil.af.L6S.component.subject.SubjectVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SubjectStatisticsDao {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	@SuppressWarnings("unchecked")
	public Map<String, SubjectFormAndDataVO> getStepCount(String year){
		return sqlMapClientTemplate.queryForMap("StatisticsSql.getStepCount", year, "step_view");
		
	}
	@SuppressWarnings("unchecked")
	public Map<String, SubjectVO> getSubjectSectionCount(String year){
		return sqlMapClientTemplate.queryForMap("StatisticsSql.getSubjectSectionCount",year, "subject_section");
		
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> getSubjectFieldCount(String year){
		return sqlMapClientTemplate.queryForList("StatisticsSql.getSubjectFieldCount",year);
	}
	@SuppressWarnings("unchecked")
	public List<SubjectVO> getEachBaseCount(String year){
		return sqlMapClientTemplate.queryForList("StatisticsSql.getEachBaseCount",year);
	}
		
	@SuppressWarnings("unchecked")
	public List<BeltTableVO>  getTableDatum(String year){
		return sqlMapClientTemplate.queryForList("StatisticsSql.getTableDatum", year);
	}
	public Integer getFinishSubjectCount(String year){
		return (Integer) sqlMapClientTemplate.queryForObject("StatisticsSql.getFinishSubjectCount", year);
	}
}
