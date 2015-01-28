package mil.af.asti.admin;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.asti.board.BoardService;
import mil.af.asti.common.CommonDAO;
import mil.af.asti.exception.AuthDeniedException;
import mil.af.asti.model.AstiAdminSearchDTO;
import mil.af.asti.model.AstiBoardFileDTO;
import mil.af.asti.model.AstiCodeDTO;
import mil.af.asti.model.AstiPageDTO;
import mil.af.asti.model.AstiUserDTO;

import org.springframework.stereotype.Service;

@Service
public class AdminService {

	@Resource
	private AdminDAO adminDAO;

	
	@Resource 
	private CommonDAO commonDAO;
	
	@Resource
	private BoardService boardService;
	
	public List<AstiUserDTO> getMemberList(AstiAdminSearchDTO astiAdminSearchDTO) {
		return adminDAO.getMemberList(astiAdminSearchDTO);
	}

	public List<AstiCodeDTO> getAuthorityCodeList() {
		// TODO Auto-generated method stub
		return adminDAO.getAuthorityCodeList();
	}

	public void changeAuthority(List<AstiUserDTO> changeAuthorityDTO) {
		for(AstiUserDTO a : changeAuthorityDTO){
			if(!a.getUser_authority().equals("none")){
			adminDAO.changeAuthority(a);
			}
		}
		
	}

	public List<AstiUserDTO> removedMemberManage() {
		return adminDAO.removedMemberManage();
	}

	public List<AstiUserDTO> getNewMemberList() {
		return adminDAO.getNewMemberList();
	}

	public int getMemberCount(AstiAdminSearchDTO astiAdminSearchDTO) {
		return adminDAO.getMemberCount(astiAdminSearchDTO);
	}
	
	public String validateAuthority(String authority){
		String authorityName=adminDAO.validateAuthority(authority);
		if(authority.equals("미승인")){
			return "미승인";
		}
		return authorityName;
	}

	public void deleteMember(String id) {
		adminDAO.deleteMember(id);
	}
	public List<AstiPageDTO> getPageInfo(String page_id){
		return adminDAO.getPageInfo(page_id);
	}
	public void updatePageInfo(AstiPageDTO pageDTO){
		adminDAO.updatePageInfo(pageDTO);
	}
	public void insertPageInfo(AstiPageDTO pageDTO){
		adminDAO.insertPageInfo(pageDTO);
	}
	public void deletePage(String page_id){
		adminDAO.deletePage(page_id);
	}

	public void insertPageList(String page_id, Map<String, String> filenames) throws Exception {
		if(commonDAO.getAstiCodeById(page_id)!=null){
			/*업로드한 파일이 있을때만*/
			if(filenames.size()>0){
				deletePage(page_id);
				
				Iterator<String> keys = filenames.keySet().iterator();
				AstiPageDTO page = new AstiPageDTO();
				page.setPage_id(page_id);
				page.setPage_name(commonDAO.getAstiCodeById(page_id).getCode_name());
				
				Integer order = 0;
				while(keys.hasNext()){
					String key = keys.next();
					
					page.setPage_picture_name(key);
					page.setPage_picture_id(filenames.get(key));
					page.setPage_order(order);
					if(boardService.checkDataLength(AstiPageDTO.class, page)){
						insertPageInfo(page);
					}
					else
						System.out.println("글자수가 초과되었습니다.");
					order++;
				}
				
			}
		}
	}
	public void mergeIntoCodeUserDept(AstiCodeDTO codeDTO){
		adminDAO.mergeIntoCodeUserDept(codeDTO);
	}
	public void deleteCodeUserDept(AstiCodeDTO codeDTO){
		adminDAO.deleteCodeUserDept(codeDTO);
	}
	public List<AstiCodeDTO> getCodeUserDetp(){
		return adminDAO.getCodeUserDetp();
	}
	public void userPasswordChange(AstiUserDTO user){
		adminDAO.userPasswordChange(user);
	}
}
