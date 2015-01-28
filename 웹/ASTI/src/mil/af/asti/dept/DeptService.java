package mil.af.asti.dept;

import java.util.List;

import javax.annotation.Resource;

import mil.af.asti.model.*;

import org.springframework.stereotype.Service;

@Service
public class DeptService {

	@Resource
	private DeptDAO deptDAO;

	public List<AstiResearchWorkerDTO> deptUserList(String code) {
		// TODO Auto-generated method stub
		return (List<AstiResearchWorkerDTO>) deptDAO.deptUserList(code);
	}
	public Integer getMaxWorkerId(){
		Integer worker_id =deptDAO.getMaxWorkerId();
		if(worker_id == null)
			return 1;
		else
			return worker_id;
	}
	public void mergeIntoWorker(AstiResearchWorkerDTO workerDTO){
		deptDAO.mergeIntoWorker(workerDTO);
	}
	public void deleteWorker(AstiBoardSearchDTO searchDTO){
		deptDAO.deleteWorker(searchDTO);
	}
	public List<AstiResearchWorkerDTO> getWorkerList(AstiBoardSearchDTO searchDTO){
		return deptDAO.getWorkerList(searchDTO);
	}
	public Integer getWorkerCount(AstiBoardSearchDTO searchDTO){
		return deptDAO.getWorkerCount(searchDTO);
	}
	public AstiResearchWorkerDTO getWorker(AstiBoardSearchDTO astiBoardSearchDTO){
		return deptDAO.getWorker(astiBoardSearchDTO);
	}
	public AstiResearchWorkerDTO getWorkerById(String worker_id) {
		return deptDAO.getWorkerById(worker_id);
	}
}
