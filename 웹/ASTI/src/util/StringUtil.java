package util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class StringUtil {
	/*
	 * 아 내가 생각해도 이 코드는 정말 혁신적이다.
	 */
	public static void entityValidateAll(Object obj) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException
	{
		Class<?> c = obj.getClass();
		Method[] m = c.getDeclaredMethods();
		for(Method method : m){
			if(method.getName().substring(0,3).equals("get")
				&& method.getParameterTypes().length==0
				&& method.getReturnType().equals(String.class)
				&& method.invoke(obj) instanceof String){
				c.getMethod("set"+method.getName().substring(3),String.class).invoke(obj,(String)entityValidate((String)method.invoke(obj)));
			}
		}
	}
	public static String entityValidate(String s){
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");
//		s = s.replaceAll("&", "&amp;");
		s = s.replaceAll("'", "&#039;");
		s = s.replaceAll("\\\"","&#034");
		
		return s;
	}
}
