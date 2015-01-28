package mil.af.orms.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.orms.dao.CalDAO;
import mil.af.orms.model.CalVO;

import org.springframework.stereotype.Service;

@Service("CalService")
public class CalService {
	@Resource(name="CalDAO")
	CalDAO calDAO;

	public List<CalVO> getCalList(String airplane) throws SQLException {
		return calDAO.getCalList(airplane);
	}
}
