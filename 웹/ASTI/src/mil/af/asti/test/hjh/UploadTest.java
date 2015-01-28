package mil.af.asti.test.hjh;

import java.util.*;

import mil.af.asti.model.AstiBoardFileDTO;

import org.junit.Test;

public class UploadTest {

	private TestDao testDao;
	private IbatisTest ibatis;
	
	@Test
	public void upload(){
		List<String> aa = new ArrayList<String>();
		aa.add("aaaa");aa.add("bb");aa.add("cc");aa.add("dd");aa.add("ee");
		Iterator<String> keys = aa.iterator();
		Map<String,String> cc = new HashMap<String,String>();
		cc.put("aaaa", "123");
		cc.put("bb", "222");
		cc.put("cc", "333");
		cc.put("dd", "444");
		cc.put("ee", "555");
		while(keys.hasNext()){
				
			System.out.println(keys.next());
			System.out.println(cc.get(keys.next()));
	}
	}
}
