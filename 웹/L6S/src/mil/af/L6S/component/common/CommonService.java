package mil.af.L6S.component.common;

import java.util.HashMap;
import java.util.List;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.common.SsoTestVO;
import mil.af.L6S.component.common.User;
import mil.af.L6S.component.admin.AdministratorVO;
import mil.af.L6S.component.common.FileVO;
import mil.af.L6S.util.Pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Service;

@Service
public class CommonService {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * SSO Token 생성용 Test
	 * @param userid
	 * @return
	 */
	public SsoTestVO getIntraUser(String userid) {
		return (SsoTestVO) sqlMapClientTemplate.queryForObject(
				"commonSql.getIntraUser", userid);
	}
	
	/**
	 *  avs11uot에서 이름에 따른 사람 조회
	 * @param name(이름)
	 * @return User List
	 *         personPositionName = 인사소속이름
	 *         sn = 군번
	 *         rank = 계급
	 *         name = 이름
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectAvs11u0tToName(AdministratorVO searchVO) {
		Pagination pagination = searchVO.getPagination();
		pagination.setNumItems(getAvs11u0tToName(searchVO.getSearchName()));
		List<User> user = sqlMapClientTemplate.queryForList(
				"commonSql.selectAvs11u0tToName", searchVO);

		return user;
	}
	
	/**
	 *  avs11u0t에서 이름을 통한 사람 조회
	 * @param searchVO(검색 조건에 따른)
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> selectAvs11u0tToName(SearchFilter searchVO) {
		Pagination pagination = searchVO.getPagination();
		pagination.setNumItems(getAvs11u0tToName(searchVO.getSearchName()));
		List<User> user = sqlMapClientTemplate.queryForList(
				"commonSql.selectAvs11u0tToName", searchVO);

		return user;
	}
	
	/**
	 * avs11u0t에서 이름에 따른 사람 개수 구함
	 * @param name 이름
	 * @return 개수
	 */
	public int getAvs11u0tToName(String name) {
		return (Integer) sqlMapClientTemplate.queryForObject(
				"commonSql.getAvs11u0tToName", name);
	}
	
	/**
	 * 사용자 정보 조회
	 * @param sn(군번)
	 * @return
	 */
	public User selectUserData(String sn) {
		return (User) sqlMapClientTemplate.queryForObject(
				"commonSql.selectUserData", sn);
	}
	
	/**
	 * 군번을 통해 사용자 권한 조회
	 * 
	 * @param sn
	 *            군번
	 * @return
	 */
	public AdministratorVO getAuthority(String sn) {
		AdministratorVO administratorVO = (AdministratorVO) sqlMapClientTemplate.queryForObject("commonSql.getAuthority", sn);
		if (administratorVO == null) {
			administratorVO = new AdministratorVO();
			if (sn == null || sn.equals("")) {
				administratorVO.setLevel(0);
				return administratorVO;
			}
		}

		administratorVO.calculateLevel();

		return administratorVO;
	}
	
	/**
	 * 파일업로드
	 * 
	 * @param fileVOs
	 *            saveName, originalName, contentType
	 * @param user
	 * @param uniqueNum
	 *            고유번호
	 */
	public void insertFileUpload(List<FileVO> fileVOs, String code) {
		if (fileVOs != null) {
			for (FileVO fileVO : fileVOs) {
				fileVO.setSeq(code);
				sqlMapClientTemplate.insert("commonSql.insertFileUpload",
						fileVO);
			}
		}
	}
	
	/**
	 * 파일하나만 선택
	 * 
	 * @param fileUniqueNum
	 * @return
	 */
	public FileVO selectFileVOOne(String sn) {
		return (FileVO) sqlMapClientTemplate.queryForObject(
				"commonSql.selectFileVOOne", sn);
	}
	
	/**
	 * 군번이 해당사용자 / 관리자 인지 확인
	 * 
	 * @param sn
	 * @return 있는경우 true, 없는경우 false
	 */
	public boolean selectUserSn(String sn, String UniqueNum) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sn", sn);
		map.put("UniqueNum", UniqueNum);
		int count = (Integer) sqlMapClientTemplate.queryForObject(
				"commonSql.selectUserSn", map);
		return count > 0 ? true : false;
	}

	/**
	 * 파일 삭제
	 * 
	 * @param fileUniqueNum
	 *            파일 고유번호
	 */
	public void deleteFileData(String fileSN) {
		sqlMapClientTemplate.delete("commonSql.deleteFileData", fileSN);
	}
}
