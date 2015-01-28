package mil.af.iers.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.VacationFacilitiesDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class FacilitiesDao {
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate; 

//	private SqlMapClient sqlMapClientTemplate;
//	
//	public FacilitiesDao() {
//		LocalIbatis setting = new LocalIbatis();
//		try {
//			this.sqlMapClientTemplate=setting.getSqlMapClient();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	public Integer getFacilitiesId() throws SQLException{
		return (Integer) sqlMapClientTemplate.queryForObject("VacationFacilitiesSql.getFacilitiesId");
	}
	public void mergeIntoFacilities(VacationFacilitiesDTO facilDTO) throws SQLException{
		sqlMapClientTemplate.insert("VacationFacilitiesSql.mergeIntoFacilities", facilDTO);
	}
	@SuppressWarnings("unchecked")
	public List<VacationFacilitiesDTO> getFacilitiesList(){
		return sqlMapClientTemplate.queryForList("VacationFacilitiesSql.getFacilitiesList");
	}
	public VacationFacilitiesDTO getOneOfFacilitiesById(Integer id){
		return (VacationFacilitiesDTO) sqlMapClientTemplate.queryForObject("VacationFacilitiesSql.getOneOfFacilitiesById", id);
	}
	public void delFacilData(Integer id){
		sqlMapClientTemplate.delete("VacationFacilitiesSql.delFacilData",id);
	}
	@SuppressWarnings("unchecked")
	public List<VacationFacilitiesDTO> getListOfFacilitiesByType(String type){
		return (List<VacationFacilitiesDTO>) sqlMapClientTemplate.queryForList("VacationFacilitiesSql.getListOfFacilitiesByType", type);
	}
}
