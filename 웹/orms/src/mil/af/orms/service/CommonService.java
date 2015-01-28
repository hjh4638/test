package mil.af.orms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mil.af.hq.aem00.common.util.HDIdeaCipher;
import mil.af.orms.dao.CommonDAO;
import mil.af.orms.model.SysCodeVO;
import mil.af.orms.model.UnitVO;
import mil.af.orms.model.UserAuthVO;
import mil.af.orms.model.UserRole;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Service;

@Service("CommonService")
public class CommonService {

	@Resource(name="CommonDAO")
	CommonDAO commonDAO;
	
	public UserVO getUserInfoFromSession(HttpServletRequest request){
		return (UserVO) request.getAttribute("UserVO");
	}
	
	public UserVO getIntraUser(String userid) throws SQLException {
		return commonDAO.getIntraUser(userid);
	}
	
	
	
	public List<UserVO> getSearchedUserList(String searchName) throws SQLException{
		return commonDAO.getSearchedUserList(searchName);
	}
	
	public List<UnitVO> getUnitCodeList(UserVO userVO) throws SQLException {

		String unitCode;
		
		if(userVO.getRole()==UserRole.SYSTEMADMIN){
			unitCode="";
		}else{
			unitCode=userVO.getUnit_code();
		}
		return commonDAO.getUnitCodeList(unitCode);
	}
	public List<UnitVO> getAllFlightGroupList() throws SQLException{
		return commonDAO.getAllFlightGroupList();
	}
	
	public UnitVO getFlightGroup(UserVO userVO) throws SQLException {
		// TODO Auto-generated method stub
		return commonDAO.getFlightGroup(userVO);
	}
	
	public List<UnitVO> getSquadronList(String flightGroupCode) throws SQLException{
		
		return commonDAO.getSquadronList(flightGroupCode);
	}
	
	public List<UserVO> getFormationPilotList(String sosokcode) throws SQLException {
		if(sosokcode.contains("-")){
			sosokcode=getFormationCode(sosokcode);
		}
		return commonDAO.getFormationPilotList(sosokcode);
	}
	
	public List<UnitVO> getFlightGroupWithSquadronListByLevel() throws SQLException{
		return commonDAO.getFlightGroupWithSquadronListByLevel();
	}
	
	public List<UnitVO> getUnitListByLevelTree(List<UnitVO> unitList){
		List<UnitVO> unitByLevelTree=new ArrayList<UnitVO>();
		int size=unitList.size();
		for(int i=0;i<size;i++){
			UnitVO tempUnitVO=unitList.get(i);
			if(tempUnitVO.getUpper_id()==null){
				unitByLevelTree.add(getUnitVOWithChild(tempUnitVO, unitList));
			}
		}
		return unitByLevelTree;
	}
	public UnitVO getUnitVOWithChild(UnitVO unitVO,List<UnitVO> unitByLevel){
		int size=unitByLevel.size();
		List<UnitVO> childList=new ArrayList<UnitVO>();
		for(int i=0;i<size;i++){
			UnitVO childUnitVO=unitByLevel.get(i);
			if(unitVO.getId().equals(childUnitVO.getUpper_id())){
				childList.add(getUnitVOWithChild(childUnitVO,unitByLevel));
			}
		}
		unitVO.setChildren(childList);
		return unitVO;
	}
	
	public String getUserSquadron(String userSosokcode) throws SQLException{
		
		List<UnitVO> allSquadronList=commonDAO.getAllSquadronList();
		
		int listSize=allSquadronList.size();
		String resultSosokcode=null;
		for(int i=0;i<listSize;i++){
			UnitVO unitVO=allSquadronList.get(i);
			if(userSosokcode.contains(unitVO.getSosokcode())){
				resultSosokcode=unitVO.getSosokcode();
			}
		}
		return resultSosokcode;
	}
	
	public String getFormationCode(String sosokcode) {
		return sosokcode.substring(0,sosokcode.lastIndexOf("-"));
	}

	public UserAuthVO getUserAuth(UserVO userVO) throws SQLException{
		UserAuthVO userAuthVO=commonDAO.getUserRole(userVO.getUserid());
		return userAuthVO;
	}
	
	public UserRole getUserRole(UserAuthVO userAuthVO, UserVO userVO) throws SQLException {
		
		if(userAuthVO!=null){
			String role_code=userAuthVO.getRole_code();
			if(role_code.equals(UserAuthVO.FORMATION_MANAGER)){
				return UserRole.FORMATIONMANAGER;
			}else if(role_code.equals(UserAuthVO.SQUADRON_MANAGER)){
				return UserRole.SQUADRONMANAGER;
			}else if(role_code.equals(UserAuthVO.GROUP_MANAGER)){
				return UserRole.GROUPMANAGER;
			}else if(role_code.equals(UserAuthVO.CQ) && userVO.getSinbuncode().equals("A")){
				return UserRole.SCHEDULEOFFICER;
			}else if(role_code.equals(UserAuthVO.CQ)){
				return UserRole.CQ;
			}else if(role_code.equals(UserAuthVO.SYSTEM_ADMIN)){
				return UserRole.SYSTEMADMIN;
			//스케줄장교 권한 리턴
			}
			
		}
		return UserRole.NORMAL;
	}

	public boolean isUserInServiceSquadron(UserVO userVO) throws SQLException {
		String userSquadron=getUserSquadron(userVO.getSosokcode());
		if(userSquadron!=null){
			return true;
		}else{
			return false;
		}
	}
	public boolean isPilot(UserVO userVO) {
		String mspcRealCode=userVO.getMspccode();
		StringBuffer mspcCode = new StringBuffer(userVO.getMspccode());
		String mspcCodeToString;
		mspcCodeToString=mspcCode.substring(0,2);
				
		//장군(0002) , 조종교육(0003), 조종(14) 특기코드를 제외한 나머지 특기 접속 제한
		//if(userVO.getMspccode().equals("0002") || userVO.getMspccode().equals("0003") || userVO.getMspccode().substring(0,2).equals("14")){
		/*if(userVO.getMspccode().substring(0,2)=="14" || userVO.getMspccode()=="0002" || userVO.getMspccode()=="0003"){*/
	 	if(mspcCodeToString.equals("14") || mspcRealCode.equals("0002") || mspcRealCode.equals("0003")
	 			|| mspcRealCode.equals("91A02")|| mspcRealCode.equals("91C02")|| mspcRealCode.equals("91D02"))
	 			
	 	{
		return true;			
		}
		else{ 
			return false;
		} 
	}
	
	// 교육훈련기, 특수임무기 확대적용 12.10.11
	public String getUserPlane(String sosokcode) throws SQLException {
		String changedSosokcode;
		StringBuffer sosok= new StringBuffer(sosokcode);
		List<String> str = new ArrayList<String>();
		str.add("A10505");
		str.add("A20115");
		str.add("A21605");
		str.add("A11515");	
		str.add("A22005");	
		str.add("A20815");
		for(int i = 0;i<str.size();i++){
			if(sosokcode.contains(str.get(i))){
			sosok.delete(7, 20);
			sosok.append("%");
			changedSosokcode=sosok.toString();
			return commonDAO.getUserPlane(changedSosokcode);
			}
		}
		sosok.delete(6, 20);
		sosok.append("%");
		changedSosokcode=sosok.toString();
		return commonDAO.getUserPlane(changedSosokcode);
	}
	// 교육훈련기, 특수임무기 확대적용 12.10.11
		public List<String> getUserPlaneList(String sosokcode) throws SQLException {
			String changedSosokcode;
			StringBuffer sosok= new StringBuffer(sosokcode);
			List<String> str = new ArrayList<String>();
			str.add("A10505");
			str.add("A20115");
			str.add("A21605");
			str.add("A11515");	
			str.add("A22005");	
			for(int i = 0;i<str.size();i++){
				if(sosokcode.contains(str.get(i))){
				sosok.delete(7, 20);
				sosok.append("%");
				changedSosokcode=sosok.toString();
				return commonDAO.getUserPlaneList(changedSosokcode);
				}
			}
			sosok.delete(6, 20);
			sosok.append("%");
			changedSosokcode=sosok.toString();
			return commonDAO.getUserPlaneList(changedSosokcode);
		}

	public String getUnitName(String squadron) throws SQLException {
		return commonDAO.getUnitName(squadron);
	}
	
	public String getUnitCode(String squadron) throws SQLException {
		return commonDAO.getUnitCode(squadron);
	}
	
	public String getEncryptSn(String userid) {
		HDIdeaCipher cipher = new HDIdeaCipher();
		return HDIdeaCipher.replace(cipher.encrypt(userid),"\\","\\\\");
	}
	
	public List<UnitVO> getUnitCodeList(String sosokcode) throws SQLException {
		return commonDAO.getUnitCodeList(sosokcode);
	}

	public List<SysCodeVO> getPeriod() throws SQLException {
		List<SysCodeVO> period=new ArrayList<SysCodeVO>();
		List<SysCodeVO> sysVO=commonDAO.getPeriod();
		int size = sysVO.size();
		for(int i=0;i<size;i++)
		{
			SysCodeVO li_period=sysVO.get(i);
			period.add(li_period);
				}
		return period;
	}

	public String getToday() throws SQLException {
		return commonDAO.getToday();
	}

	public UnitVO getSquadron(String userid) throws SQLException {
		// TODO Auto-generated method stub
		return commonDAO.getSquadron(userid);
	}

	
}
