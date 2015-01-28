package mil.af.L6S.component.admin;

import java.util.List;

import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.admin.AdministratorDAO;
import mil.af.L6S.component.common.User;
import mil.af.L6S.util.Pagination;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  AdministratorService Part
 * @author 정성모
 */
@Service
public class AdministratorService {
	
	@Autowired
	private AdministratorDAO administratorDAO;
	
	/**
	 * 관리자 등록
	 * @param administratorVO
	 *            sn = '군번', authoirty = '권한        
	 */
	public void insertAdministrator(AdministratorVO administratorVO) {
		
		administratorDAO.insertAdministrator(administratorVO);
	}
	
	/**
	 * 관리자 중복 체크
	 * @param administratorVO
	 * @return Integer
	 */
	public int checkUserSn(AdministratorVO administratorVO){
		int confirmCount = administratorDAO.checkUserSn(administratorVO.getSn());
		return confirmCount;
	}
	
	/**
	 * 관리자 리스트 조회
	 * @return List
	 */
	public List<AdministratorVO> selectAdministratorList(User user,
			AdministratorVO searchVO) {
		Pagination pagination = searchVO.getPagination();
		int count = administratorDAO.getAdministratorCount();
		pagination.setNumItems(count);
		List<AdministratorVO> list = administratorDAO
				.selectAdministratorList(searchVO);
		return list;
	}

	/**
	 * 관리자 DATA 삭제
	 * @param administratorVO
	 */
	public void deleteAdministrator(AdministratorVO administratorVO) {
		administratorDAO.deleteAdministrator(administratorVO.getSn());
	}

	public List<String> getConfirmedData() {
		return administratorDAO.getConfirmedData();
	}
	public List<String> getConfirmedData2() {
		return administratorDAO.getConfirmedData2();
	}

	public void upDateData(List<String> snList) {
		for(String str:snList)
			administratorDAO.upDateData(str);
	}
	public void upDateData2(List<String> snList) {
		for(String str:snList)
			administratorDAO.upDateData2(str);
	}

	/**
	 *  관리자 등록 및 변경
	 * @param administratorVO
	 */
	public void insertAdmin(AdministratorVO administratorVO) {
		administratorDAO.insertAdmin(administratorVO);
	}

	/**
	 *	부서에 해당하는 사람 호출 
	 * @param searchVO
	 * @return
	 */
	public List<User> selectAvs11u0tToQuarter(AdministratorVO searchVO) {
		Pagination pagination = searchVO.getPagination();
		int count = administratorDAO.getAdminCount(searchVO.getQuarter());

		pagination.setNumItems(count);
		return administratorDAO.selectAvs11u0tToQuarter(searchVO);
	}

	public String getMyQuarter(String sn) {
		String result;
		int check = administratorDAO.checkUserSn(sn);
		if (check>1){
			result = "false";
		}else{
			result = administratorDAO.getMyQuarter(sn);
		}
		return result; 
	}

	public String getMyAuth(String sn) {
		return administratorDAO.getMyAuth(sn);
	}
}
