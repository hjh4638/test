package mil.af.asti.common;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.asti.model.*;

import org.springframework.stereotype.Service;


@Service
public class CommonService {
	
	@Resource
	private CommonDAO commonDAO;
	
	public void removeMember(AstiUserDTO userInfo){
		commonDAO.removeMember(userInfo);
	}
	
	public boolean isUserIdDup(String user_id){
		if(commonDAO.getUserInfo(user_id) == null){
			return false;
		}
		
		return true;
	}
	public boolean isValidSignIn(AstiUserDTO userInfo){
		if(commonDAO.getUserInfo(userInfo) == null){
			return false;
		}
		return true;
	}
	
	public List<AstiUserDTO> getWaitingUserList(){
		return commonDAO.getWaitingUserList();
	}
	
	public AstiUserDTO getUserInfo(String user_id){
		return commonDAO.getUserInfo(user_id);
	}
	public List<AstiCodeDTO> getAstiCodeByType(String code_type){
		return commonDAO.getAstiCodeByType(code_type);
	}
	public void mergeIntoUser(AstiUserDTO userDTO){
		commonDAO.mergeIntoUser(userDTO);
	}
	public AstiUserDTO getUser(AstiUserDTO userDTO){
		return commonDAO.getUser(userDTO);
	}
	public void deleteUser(AstiUserDTO userDTO){
		commonDAO.deleteUser(userDTO);
	}
	@SuppressWarnings("unchecked")
	public List<AstiUserDTO> getUserList(AstiUserDTO userDTO){
		return commonDAO.getUserList(userDTO);
	}
	public String isDownAuth(String file_id, String user_authority){
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_authority", user_authority);
		param.put("file_id", file_id);
		return commonDAO.isDownAuth(param);
	}
	@SuppressWarnings("unchecked")
	public AstiCodeDTO getAstiCodeById(String code_id){
		return commonDAO.getAstiCodeById(code_id);
	}
}
