package mil.af.orms.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.TestDAO;

import org.springframework.stereotype.Service;

@Service("TestService")
public class TestService {

	@Resource(name="TestDAO")
	TestDAO testDAO;
	
	public List getTestList() throws SQLException {
		return testDAO.getTestList();
	}
	
}
