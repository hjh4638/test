package mil.af.asti.test.hjh;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mil.af.asti.model.*;

import org.junit.Test;

public class UserTest {

	private UserDao userDao = new UserDao();
	
	private String[] prohibit={"," , "<" , ">" , "[" , "]" , "{" , "}"};
	
	@Test
	public void changeCode() throws SQLException{
		AstiCodeDTO code = new AstiCodeDTO();
		code.setCode_id("1");
		code.setCode_name("테스");
		
		userDao.deleteCodeUserDept(code);
		
		List<AstiCodeDTO> codes = userDao.getCodeUserDetp();
		System.out.println(codes.size());
		
		
	}
	
	public void containProhibitChar(){
		String user_id = "sdfsfsd,fsdf";
		
		if(containProhibitedChar(user_id)){
			System.out.println("특수기호 포함됨");
		}
		System.out.println(getProhibit());
		
	}
	public String getProhibit(){
		String prohibitText = new String();
		for(int i=0;i<prohibit.length;i++){
			if(i==0)
				prohibitText=prohibitText+prohibit[i];
			else 
				prohibitText=prohibitText+","+prohibit[i];
		}
		return prohibitText;
	}
	public boolean containProhibitedChar(String str){
		for(int i=0;i<prohibit.length;i++){
			if(str.contains(prohibit[i])){
				return true;
			}			
		}
		return false;
	}
	
	
	public void isKorean() throws UnsupportedEncodingException{
		String user_id = "     ";
		
		char[] cha = user_id.toCharArray();
		for(int i=0;i<cha.length;i++){
			String cc = cha[i]+"";
			int byteLength =cc.getBytes("euc-kr").length;
			System.out.println(byteLength);
			if(byteLength != 1)
				System.out.println("false");
		}
		
		
		
	}
	
	public void userAuth() throws SQLException{
		Map<String,String> param = new HashMap<String,String>();
		param.put("user_authority", "A00");
		param.put("file_id", "547249065541590983124");
		System.out.println(userDao.isDownAuth(param));
	}
	
	
	/*@Test*/
	public void validate(){
		String user_idf = "aslfksjkf";
		String user_idt = "adf@dfa";
		/*user_id.indexOf("@")가 0이 아니어야하고,@가 맨 앞에 없고,
		 * user_id.length보다 작아야함 같을수는 없으니*/
		System.out.println(user_idf.indexOf("@"));
		System.out.println(user_idt.indexOf("@"));
		System.out.println(user_idt.length());
		System.out.println(user_idt.lastIndexOf("@"));
		
		if(user_idt.indexOf("@") !=0 && user_idt.lastIndexOf("@") != user_idt.length()-1
				&& user_idt.contains("@"))
			System.out.println("성공");
		System.out.println("ddd".equals(null));
	}
	
	
	public void getTest() throws SQLException{
		String user_id = "sfsf";
		AstiUserDTO userDTO = new AstiUserDTO();
		userDTO.setUser_id(user_id);
		
		AstiUserDTO ddd = userDao.getUserInfo(userDTO);
		
		List<AstiUserDTO> aaa= userDao.getUserList(userDTO);
		
		System.out.println(ddd);
		System.out.println(aaa);
	}

	
	public void deleteTest() throws SQLException{
		String user_id = "sfsf";
		AstiUserDTO userDTO = new AstiUserDTO();
		userDTO.setUser_id(user_id);
		
		userDao.deleteUser(userDTO);
	}
	
	public void mergeTest() throws SQLException{
		String user_id = "sfsf";
		String user_password = "sadfsdf";
		String user_name = "test";
		String user_sex = "M";
		String user_birth_date = "1991-06-22";
		
		AstiUserDTO userDTO = new AstiUserDTO();
		userDTO.setUser_id(user_id);
		userDTO.setUser_password(user_password);
		userDTO.setUser_name(user_name);
		userDTO.setUser_sex(user_sex);
		userDTO.setUser_birth_date(user_birth_date);
		
		userDao.mergeIntoUser(userDTO);
	}
	
	
}