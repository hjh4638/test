package util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public class ListVOUtil {
	/**
	 * request 객체에서 타겟클래스(자바빈) 항목에 데이터 뽑아 리스트로 반환
	 * @param request
	 * @param targetClass
	 * @return
	 */
	public static List<?> getVOList(HttpServletRequest request, Class<?> targetClass) {
			
		ArrayList<Object> list = new ArrayList<Object>();
		
		HashMap<String, Object[]> val = new HashMap<String, Object[]>();
		
		Field fields[] = targetClass.getDeclaredFields();
		
		for (Field field : fields) {
			String key = field.getName();
			if (request.getParameter(key) != null) {
				val.put(key, request.getParameterValues(key));
			}
		}
		
		int minSize = Integer.MAX_VALUE;
		
		Iterator<String> fieldNames = val.keySet().iterator();
		while (fieldNames.hasNext()) {
			String name = fieldNames.next();
			minSize = Math.min(minSize, val.get(name).length);
		}
		
		if (minSize != Integer.MAX_VALUE) {
			for (int i = 0; i < minSize; i++) {
				try {
					Object vo = targetClass.newInstance();
					for (Field field : fields) {
						Object[] values = val.get(field.getName());
						if (values != null) {
							field.setAccessible(true);
							field.set(vo, values[i]);
						}
					}
					list.add(vo);
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InstantiationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}	
		
		return list;
	}
	/**
	 * getVOList를 멀티파트전송에서 사용
	 * @param request
	 * @param targetClass
	 * @return
	 */
	public static List<?> getVOListWhenMultipart(HttpServletRequest request, Class<?> targetClass) {
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
				
		ArrayList<Object> list = new ArrayList<Object>();
		
		HashMap<String, Object[]> val = new HashMap<String, Object[]>();
		
		Field fields[] = targetClass.getDeclaredFields();
		
		for (Field field : fields) {
			String key = field.getName();
			if (mhsr.getParameter(key) != null) {
				val.put(key, mhsr.getParameterValues(key));
			}
		}
		
		int minSize = Integer.MAX_VALUE;
		
		Iterator<String> fieldNames = val.keySet().iterator();
		while (fieldNames.hasNext()) {
			String name = fieldNames.next();
			minSize = Math.min(minSize, val.get(name).length);
		}
		
		if (minSize != Integer.MAX_VALUE) {
			for (int i = 0; i < minSize; i++) {
				try {
					Object vo = targetClass.newInstance();
					for (Field field : fields) {
						Object[] values = val.get(field.getName());
						if (values != null) {
							field.setAccessible(true);
							field.set(vo, values[i]);
						}
					}
					list.add(vo);
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InstantiationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}	
		
		return list;
	}
	
}

