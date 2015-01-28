package mil.af.iers.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.model.CodeDTO;
import mil.af.iers.model.FacilitiesCodeDTO;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CodeDao {
	@Resource
	private SqlMapClientTemplate sqlMapClientTemplate; 
	
	@SuppressWarnings("unchecked")
	public List<CodeDTO> getListOfCodeByType(String type){
		return (List<CodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getListOfCodeByType", type);
	}
	public CodeDTO getOneOfCodeByName(String code_name){
		return (CodeDTO) sqlMapClientTemplate.queryForObject("CodeSql.getOneOfCodeByName", code_name);
	}
	
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionInclude(String section){
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCodeBySectionInclude", section);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionExclude(String section){
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCodeBySectionExclude", section);
	}
	public FacilitiesCodeDTO getFacilCodeById(String type_id){
		return (FacilitiesCodeDTO) sqlMapClientTemplate.queryForObject("CodeSql.getFacilCodeById", type_id);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCode(){
		return (List<FacilitiesCodeDTO>) sqlMapClientTemplate.queryForList("CodeSql.getFacilCode");
	}
	public void mergeIntoFacilitiesCode(FacilitiesCodeDTO f_code){
		sqlMapClientTemplate.insert("CodeSql.mergeIntoFacilitiesCode", f_code);
	}
	public void deleteFacilitiesCode(String type){
		sqlMapClientTemplate.delete("CodeSql.deleteFacilitiesCode", type);
	}
}
