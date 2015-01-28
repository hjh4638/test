package mil.af.iers.service;

import java.util.List;

import javax.annotation.Resource;

import mil.af.iers.dao.CodeDao;
import mil.af.iers.model.CodeDTO;
import mil.af.iers.model.FacilitiesCodeDTO;

import org.springframework.stereotype.Service;

@Service
public class CodeService {
	
	@Resource
	private CodeDao codeDao;
	
	@SuppressWarnings("unchecked")
	public List<CodeDTO> getListOfCodeByType(String type){
		return codeDao.getListOfCodeByType(type);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionInclude(String section){
		return codeDao.getFacilCodeBySectionInclude(section);
	}
	@SuppressWarnings("unchecked")
	public List<FacilitiesCodeDTO> getFacilCodeBySectionExclude(String section){
		return codeDao.getFacilCodeBySectionExclude(section);
	}
	public FacilitiesCodeDTO getFacilCodeById(String type_id){
		return codeDao.getFacilCodeById(type_id);
	}
	public List<FacilitiesCodeDTO> getFacilCode(){
		return codeDao.getFacilCode();
	}
	public void mergeIntoFacilitiesCode(FacilitiesCodeDTO f_code){
		codeDao.mergeIntoFacilitiesCode(f_code);
	}
	public void deleteFacilitiesCode(String type){
		codeDao.deleteFacilitiesCode(type);
	}
}
