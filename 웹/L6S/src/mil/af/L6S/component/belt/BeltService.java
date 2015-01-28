package mil.af.L6S.component.belt;

import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.belt.BeltDAO;
import mil.af.L6S.component.common.FileVO;
import mil.af.L6S.util.Pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *  BeltService Part
 * @author 정성모
 */
@Service
public class BeltService {
	final Logger logger = LoggerFactory.getLogger(BeltService.class);
	
	@Autowired
	private BeltDAO beltDAO;
	
	/**
	 * 	벨트 조회(조건부)
	 * @param str
	 * @return
	 */
	public List<BeltVO> beltListInquiry(SearchFilter str, BeltVO beltVO) {
		Pagination pagination = beltVO.getPagination();
		List<BeltVO> beltList =  beltDAO.beltListInquiry(str);
		List<BeltVO> tempList = new ArrayList<BeltVO>();
		int cnt = beltDAO.getListCount(str); 
		int switchCount = 0; // 0 : off          1 : on
		pagination.setNumItems(cnt);
		/* 벨트 보유자의 대표 벨트(BeltVO.RepreBelt) 설정 */
		
//		if(str.)
//			switchCount=1;
//	}
		for(BeltVO belt: beltList){
			int count=0;
			int MaxTemp = 100;
			int Exception = 100;
			int temp=0, stat=0;
			
			for(ContentsVO contents : belt.getBeltDatum()){
				if(Exception >= contents.getLevel())
					{
					Exception = contents.getLevel();
					
					if(temp<contents.getBeltstate())
						temp=contents.getBeltstate();
					}
				
				if(contents.getBeltstate()==5){
					count+=1;
					if(MaxTemp > contents.getLevel())
						MaxTemp = contents.getLevel();
				}
			}
			if(belt.getBeltDatum().size()==0)
				MaxTemp=0;
			
			belt.setRepreBelt(MaxTemp);
			
			/* 벨트가 없는 사람들에 대한 조건 (신규등록자는 제외)*/
			/*       신규등록자들 경우 No Belt라 명명함                   */
			if(belt.getBeltDatum().size() !=0 && count == 0){
//				int temp=0, stat=0;
//				for(ContentsVO contents : belt.getBeltDatum()){
//					if(temp<contents.getBeltstate())
//						temp=contents.getBeltstate();
//				}
				if(temp<=2){
					stat=1; /* 대표 벨트를 빨강으로 표시 */
				}else if(temp>=3){
					stat=2; /* 대표 벨트를 파랑으로 표시 */
				}
				belt.setCondition(1);
				belt.setStateCondition(stat);				
				belt.setRepreBelt(Exception);
			}
			
//			System.out.println("☆★☆★ SearchBelt : "+str.getSearchBelt()+"  ☆★☆★ RepreBelt : "+belt.getRepreBelt()+"    ☆★☆★ sn : "+belt.getSn());
//			tempList.add(belt);
//			
//			if(str.getSearchBelt()!="" || str.getSearchBelt()!=null){
//				System.out.println("◆"+belt.getRepreBelt().equals(str.getSearchBelt())+"◆");
//				if(belt.getRepreBelt().equals(str.getSearchBelt())){
//					System.out.println("☆★ABCDE☆★");
//					tempList.add(belt);
//				}
//			}
//			else{
//				System.out.println("◆1234◆");
//				tempList.add(belt);
//			}
			
			List<String> subject = beltDAO.getListData(belt.getSn());
			belt.setSubjectCount(beltDAO.getSubjectCount(belt.getSn()));
			belt.setSubject(subject);		
			}
//		System.out.println("○○○"+tempList);
		return beltList;
	}

	/**
	 *  벨트 Contents 입력
	 * @param contentsVO
	 */
	public void beltInput(ContentsVO contentsVO) {
		beltDAO.beltInput(contentsVO);
	}

	/**
	 *  벨트 중복 확인
	 * @param sn
	 * @return int
	 */
	public int checkSNinBase(String sn) {
		return beltDAO.checkSNinBase(sn);
	}

	/**
	 *  벨트 보유자 등록
	 * @param beltVO
	 */
	public void beltPossessorInput(BeltVO beltVO) {
		beltDAO.beltPossessorInput(beltVO);
	}

	/**
	 *  벨트 조회(비조건) 
	 * @param searchFilter
	 * @return
	 */
	public List<BeltVO> beltInquiry(SearchFilter searchFilter) {
		List<BeltVO> beltList =  beltDAO.beltListInquiry(searchFilter);
		return beltList;
	}

	/**
	 * 파일 들고오기
	 * @param searchFilter
	 * @return
	 */
	public List<FileVO> MatchFiles(SearchFilter searchFilter) {
		List<FileVO> fileList = beltDAO.MatchFiles(searchFilter);
		return fileList;
	}

	/** 
	 *  Content 삭제
	 *  	if(하위 파일이 존재할경우, 파일 삭제후 Content삭제)
	 * @param target
	 */
	public void deleteContent(String target) {
		
		int check = beltDAO.fileCheck(target);
		if(check>0){
			beltDAO.deleteFiles(target);
		}
		beltDAO.deleteContent(target);
	}

	/**
	 *  Contents Load
	 * @param target
	 * @return ContentsVO
	 */
	public ContentsVO getContent(String target) {
		return beltDAO.getContent(target);
	}

	/**
	 *  File Datum Load
	 * @param code
	 * @return List<FileVO>
	 */
	public List<FileVO> getFiles(String code) {
		return beltDAO.getFiles(code);
	}

	/**
	 *  Contents 수정시 업데이트
	 * @param contentsVO
	 */
	public void updateContents(ContentsVO contentsVO) {
		beltDAO.updateContents(contentsVO);		
	}

	/**
	 *  순번 찾기
	 * @param sn
	 * @return 순번
	 */
	public int getRnum(String sn) {
		return beltDAO.getRnum(sn);
	}
	
	/**
	 *  엑셀에 들어갈 데이터 필터링
	 * @param i
	 * @return List<BeltVO>
	 */
	public List<BeltVO> getBeltFiltering(int i){
		return beltDAO.beltFiltering(i);
	}

	/**
	 * code를 통해 sn들고 오기
	 * @param code
	 * @return
	 */
	public String getSNfromCode(String code) {
		return beltDAO.getSNfromCode(code);
	}

	/**
	 *  BeltState 업데이트
	 * @param str
	 */
	public void updateBeltState(String str) {
		beltDAO.updateBeltState(str);
	}
}
