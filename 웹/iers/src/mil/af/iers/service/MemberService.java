package mil.af.iers.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.iers.dao.CodeDao;
import mil.af.iers.dao.MemberDao;
import mil.af.iers.model.CodeDTO;
import mil.af.iers.model.UserDTO;

import org.springframework.stereotype.Service;

import com.ksign.ssoapi.SSORspData;
import com.ksign.ssoapi.SSOService;
import com.ksign.ssoapi.SSOToken;

@Service
public class MemberService {

	@Resource
	private MemberDao memberDao;
	@Resource
	private CodeDao codeDao;
	
	public void mergeIntoUser(UserDTO user) throws SQLException{
		memberDao.mergeIntoUser(user);
	}
	public UserDTO getOneOfUser(UserDTO user) throws SQLException{
		return memberDao.getOneOfUser(user);
	}
	public UserDTO getOneOfUser(String user_id,String user_sosok) {
		UserDTO user = new UserDTO();
		user.setUser_id(user_id);
		user.setUser_sosok(user_sosok);
		return memberDao.getOneOfUser(user);
	}
	public List<UserDTO> getListOfUser(UserDTO user) throws SQLException{
		return memberDao.getListOfUser(user);
	}
	public void updateAuthByAdmin(String user_auth, String user_id,String user_sosok){
		UserDTO user = new UserDTO();
		user.setUser_auth(user_auth);
		user.setUser_id(user_id);
		user.setUser_sosok(user_sosok);
		memberDao.updateAuthByAdmin(user);
	}
	public UserDTO getLoginData(UserDTO user){
		return memberDao.getLoginData(user);
	}
	public UserDTO getSSOUserInfo(HttpServletRequest request){
		UserDTO user = new UserDTO();
		String initVal = "368B184727E89AB69FAF";
		String domain = "af.mil";

		SSOService ssoService = new SSOService(domain, initVal);
		SSORspData rsp = ssoService.ka_checkSSO(request,
				request.getRemoteAddr());
		SSOToken token = rsp.getSSOToken();
		if(token !=null){
			CodeDTO user_rank_code =codeDao.getOneOfCodeByName(token.getAttribute("RANKNAME"));
			user.setUser_id(token.getAttribute("USERID"));
			if(user_rank_code !=null){
				user.setUser_rank(user_rank_code.getCode_id());
			}
			user.setUser_sosok_detail(token.getAttribute("INTRASOSOKNAME"));
			user.setUser_name(token.getAttribute("NAME"));
			user.setUser_sosok("B01");
			return user;
		}
		else
			return null;
	}
	public String getFileName(String file_id){
		return memberDao.getFileName(file_id);
	}
	public void initPassword(String id,String sosok,String password){
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_id", id);
		param.put("user_sosok", sosok);
		param.put("user_password", password);
		memberDao.initPassword(param);
	}
	public void initApproveKey(String id,String sosok,String approve_key){
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_id", id);
		param.put("user_sosok", sosok);
		param.put("user_approve_key", approve_key);
		memberDao.initApproveKey(param);
	}
	public UserDTO oneUserToChangePassword(String id,String sosok,String key){
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_id", id);
		param.put("user_sosok", sosok);
		param.put("user_approve_key",key);
		
		return memberDao.oneUserToChangePassword(param);
	}
	public String getCellPhone(String user_id,String user_sosok){
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_id", user_id);
		param.put("user_sosok", user_sosok);
		return memberDao.getCellPhone(param);
	}
}
