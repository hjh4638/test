package mil.af.iers.test.hjh;

import java.sql.SQLException;
import java.util.List;

import mil.af.iers.test.dao.MemberDao;
import mil.af.iers.model.*;

import org.junit.Test;


public class MemberTest {
	private MemberDao memberDao = new MemberDao();	
	
//	입력 수정 테스트
	@Test
	public void insertTest() throws SQLException{
		UserDTO user = new UserDTO();
		int size=21;
		
		for(int i=10;i<size;i++){
			String id="11-"+i+""+i;
			String sosok="B01";
			String rank="A"+i;
			String name="소쌈쌈dd";
			String cellular_phone="010-5265-4073";
			String service_term="2011-01-01";
			String password = "gsngsndg";
			
			user.setUser_id(id);
			user.setUser_sosok(sosok);
			user.setUser_rank(rank);
			user.setUser_name(name);
			user.setUser_cellular_phone(cellular_phone);
			user.setUser_service_term(service_term);
			user.setUser_password(password);
			memberDao.mergeIntoUser(user);
		}
	}
	@Test
	public void selectTest() throws SQLException{
		UserDTO user = new UserDTO();
		user.setUser_id("11-1");
		user.setUser_sosok("B01");
//		UserDTO a =memberDao.getOneOfUser(user);
//		System.out.println(a);
		
		List<UserDTO> uu=memberDao.getListOfUser(user);
		System.out.println(uu.get(0));
	}
}
