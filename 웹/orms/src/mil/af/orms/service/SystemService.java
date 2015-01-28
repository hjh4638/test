package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.SystemDAO;
import mil.af.orms.model.AnswerWithHeadQuestionVO;
import mil.af.orms.model.ScheduleVO;
import mil.af.orms.model.SystemVO;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Service;

@Service("SystemService")

public class SystemService {
	
	@Resource(name="SystemDAO")
	SystemDAO systemDAO;

	public List<SystemVO> getAuthSelectList() throws SQLException {
		return systemDAO.getAuthSelectList();
	}

	public List<SystemVO> getAuthViewList() throws SQLException {
		return systemDAO.getAuthViewList();
	}
	
	public void insertAuthList(HashMap<String,String> p) throws SQLException {
		
		systemDAO.insertAuthList(p);
	}
	
	public void deleteAuthList(HashMap<String,String> p) throws SQLException {
		
		systemDAO.deleteAuthList(p);
	}
	
	public List<SystemVO> searchAuthViewList(String sosokcode) throws SQLException{
		return systemDAO.searchAuthViewList(sosokcode);
	}
	
}