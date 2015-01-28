package mil.af.L6S.component.belt;

import java.util.List;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.common.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

/**
 * BeltDAO Part
 * 
 * @author 정성모
 */
@Repository
public class BeltDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	/**
	 * @param str
	 *            (검색조건 없을 시 전체) 벨트 등급 // 이름 // 차수 // 소속 //
	 * @return List<BeltVO>
	 */
	@SuppressWarnings("unchecked")
	public List<BeltVO> beltListInquiry(SearchFilter str) {
		return sqlMapClientTemplate
				.queryForList("beltSql.beltListInquiry", str);
	}

	/**
	 * Belt Contents 입력
	 * 
	 * @param contentsVO
	 */
	public void beltInput(ContentsVO contentsVO) {
		sqlMapClientTemplate.insert("beltSql.beltInput", contentsVO);
	}

	/**
	 * 군번 중복 확인
	 * 
	 * @param sn
	 * @return int type
	 */
	public int checkSNinBase(String sn) {
		return (Integer) sqlMapClientTemplate.queryForObject(
				"beltSql.checkSNinBase", sn);
	}

	/**
	 * Belt 보유자 등록
	 * 
	 * @param beltVO
	 */
	public void beltPossessorInput(BeltVO beltVO) {
		sqlMapClientTemplate.insert("beltSql.beltPossessorInput", beltVO);
	}
	
	/**
	 *  벨트로 넘기는 Subject Data
	 * @param sn(군번)
	 * @return SubjectVO
	 */
	@SuppressWarnings("unchecked")
	public List<String> getListData(String sn) {
		return (List<String>)sqlMapClientTemplate.queryForList("beltSql.getListData",sn);
	}

	/**
	 *  벨트보유자 별 등록된 과제 수
	 * @param sn
	 * @return 과제 수
	 */
	public int getSubjectCount(String sn) {
		return (Integer) sqlMapClientTemplate.queryForObject("beltSql.getSubjectCount", sn);
	}

	/**
	 *  등록자에 따른 파일 Load
	 * @param searchFilter (file_seq : contents - files 연결 매개)
	 * @return 파일 정보
	 */
	@SuppressWarnings("unchecked")
	public List<FileVO> MatchFiles(SearchFilter searchFilter) {
		return sqlMapClientTemplate.queryForList("beltSql.MatchFiles", searchFilter);
	}

	/**
	 *  List에 보여줄 사용자들의 수
	 * @param str
	 * @return 사용자들의 수
	 */
	public int getListCount(SearchFilter str) {
		return (Integer) sqlMapClientTemplate.queryForObject("beltSql.getListCount",str);
	}

	/**
	 * 	Content 삭제
	 * @param target(file_seq)
	 */
	public void deleteContent(String target) {
		sqlMapClientTemplate.delete("beltSql.deleteContent", target);
	}

	/**
	 *  Contents 따른 파일 존재 여부 확인 
	 * @param target
	 * @return 파일 수
	 */
	public int fileCheck(String target) {
		return (Integer) sqlMapClientTemplate.queryForObject("beltSql.fileCheck", target);
	}

	/**
	 *  DB에서 파일 데이터 제거
	 * @param target
	 */
	public void deleteFiles(String target) {
		sqlMapClientTemplate.delete("beltSql.deleteFiles", target);
	}

	/**
	 *  file_seq에 따른 고유 Contents 들고 오기
	 * @param target
	 * @return Contents 관련 데이터
	 */
	public ContentsVO getContent(String target) {
		return (ContentsVO) sqlMapClientTemplate.queryForObject("beltSql.getContent", target);
	}

	/**
	 *  매칭 된 파일들 정보 들고오기
	 * @param code (file_seq
	 * @return FileVO 
	 */
	@SuppressWarnings("unchecked")
	public List<FileVO> getFiles(String code) {
		return sqlMapClientTemplate.queryForList("beltSql.getFiles", code);
	}

	/**
	 *  Belt Contents 정보 수정시 Update
	 * @param contentsVO
	 */
	public void updateContents(ContentsVO contentsVO) {
		sqlMapClientTemplate.update("beltSql.updateContents", contentsVO);
	}

	/**
	 *  순번 들고 오기
	 * @param sn
	 * @return NUM
	 */
	public int getRnum(String sn) {
		return (Integer) sqlMapClientTemplate.queryForObject("beltSql.getRnum", sn);
	}
	
	/**
	 *  벨트 필터링
	 * @param i
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BeltVO> beltFiltering(int i){
		return sqlMapClientTemplate.queryForList("beltSql.beltFiltering",i);
	}

	/**
	 *  code를 통해 sn들고오기
	 * @param code
	 * @return
	 */
	public String getSNfromCode(String code) {
		int temp = Integer.parseInt(code);	
		return (String) sqlMapClientTemplate.queryForObject("beltSql.getSNfromCode", temp);
	}
	
	
	/**
	 *  BeltState 업데이트
	 * @param str
	 */
	public void updateBeltState(String str) {
		sqlMapClientTemplate.update("beltSql.updateBeltState", str);
	}

	public int getCountRepeat(ContentsVO contentsVO) {
		return (Integer) sqlMapClientTemplate.queryForObject("beltSql.getCountRepeat", contentsVO);
	}
}
