package mil.af.iers.component.facilities;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.dao.FacilitiesDao;
import mil.af.iers.model.VacationFacilitiesDTO;

import org.springframework.stereotype.Service;

@Service
public class FacilitiesService {
	
	@Resource
	private FacilitiesDao facilitiesDao;
	
	public Integer getFacilitiesId() throws SQLException{
		return facilitiesDao.getFacilitiesId();
	}
	public void mergeIntoFacilities(VacationFacilitiesDTO facilDTO) throws SQLException{
		facilitiesDao.mergeIntoFacilities(facilDTO);
	}
	public List<VacationFacilitiesDTO> getFacilitiesList(){
		return facilitiesDao.getFacilitiesList();
	}
	public void delFacilData(Integer id)
	{
		facilitiesDao.delFacilData(id);
	}
}
