package mil.af.iers.test.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.config.LocalIbatis;
import mil.af.iers.model.CodeDTO;
import mil.af.iers.model.FacilitiesCodeDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

public class CodeDao {
	private SqlMapClient sqlMapClientTemplate;
	
	public CodeDao() {
		LocalIbatis setting = new LocalIbatis();
		try {
			this.sqlMapClientTemplate=setting.getSqlMapClient();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@SuppressWarnings("unchecked")
	public List<CodeDTO> getListOfCodeByType(String type) throws SQLException{
		return (List<CodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getListOfCodeByType", type);
	}
	public CodeDTO getOneOfCodeByName(String code_name) throws SQLException{
		return (CodeDTO) sqlMapClientTemplate.queryForObject("CodeSql.getOneOfCodeByName", code_name);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionInclude(String section) throws SQLException{
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCodeBySectionInclude", section);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionExclude(String section) throws SQLException{
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCodeBySectionExclude", section);
	}
	public FacilitiesCodeDTO getFacilCodeById(String type_id) throws SQLException{
		return (FacilitiesCodeDTO) sqlMapClientTemplate.queryForObject("CodeSql.getFacilCodeById", type_id);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCode() throws SQLException{
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCode");
	}
	public void mergeIntoFacilitiesCode(FacilitiesCodeDTO f_code) throws SQLException{
		sqlMapClientTemplate.insert("CodeSql.mergeIntoFacilitiesCode", f_code);
	}
	public void deleteFacilitiesCode(String type) throws SQLException{
		sqlMapClientTemplate.delete("CodeSql.deleteFacilitiesCode", type);
	}
}
