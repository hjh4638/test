package mil.af.asti.dept;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.asti.model.AstiBoardSearchDTO;
import mil.af.asti.model.AstiResearchWorkerDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DeptDAO {

	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate;

	@SuppressWarnings("unchecked")
	public List<AstiResearchWorkerDTO> deptUserList(String code) {
		// TODO Auto-generated method stub
		return (List<AstiResearchWorkerDTO>) sqlMapClientTemplate.queryForList("DeptSql.deptUserList",code);
	}
	public Integer getMaxWorkerId(){
		return (Integer) sqlMapClientTemplate.queryForObject("DeptSql.getMaxWorkerId");
	}
	public void mergeIntoWorker(AstiResearchWorkerDTO workerDTO){
		sqlMapClientTemplate.insert("DeptSql.mergeIntoWorker", workerDTO);
	}
	public void deleteWorker(AstiBoardSearchDTO searchDTO){
		sqlMapClientTemplate.delete("DeptSql.deleteWorker", searchDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiResearchWorkerDTO> getWorkerList(AstiBoardSearchDTO searchDTO){
		return sqlMapClientTemplate.queryForList("DeptSql.getWorkerList", searchDTO);
	}
	public Integer getWorkerCount(AstiBoardSearchDTO searchDTO){
		return (Integer) sqlMapClientTemplate.queryForObject("DeptSql.getWorkerCount", searchDTO);
	}
	public AstiResearchWorkerDTO getWorker(AstiBoardSearchDTO astiBoardSearchDTO){
		return (AstiResearchWorkerDTO) sqlMapClientTemplate.queryForObject("DeptSql.getWorker", astiBoardSearchDTO);
	}
	public AstiResearchWorkerDTO getWorkerById(String worker_id) {
		// TODO Auto-generated method stub
		return (AstiResearchWorkerDTO) sqlMapClientTemplate.queryForObject("DeptSql.getWorkerById", worker_id);
	}
}
