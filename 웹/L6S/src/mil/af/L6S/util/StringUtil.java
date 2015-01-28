package mil.af.L6S.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 문자열 변화 Util
 * 
 * @author 김성근
 * 
 */
public class StringUtil {

	/**
	 * 
	 * 특수문자 를 로 치환하기위한 메소드
	 * 
	 * @param srcString
	 *            변환문자열
	 * 
	 * @return 변환문자열
	 */
	public static String getSpclStrCnvr(String srcString) {

		String rtnStr = null;

		try {
			StringBuffer strTxt = new StringBuffer("");

			char chrBuff;
			int len = srcString.length();

			for (int i = 0; i < len; i++) {
				chrBuff = (char) srcString.charAt(i);

				switch (chrBuff) {
				case '<':
					strTxt.append("&lt;");
					break;
				case '>':
					strTxt.append("&gt;");
					break;
				case '&':
					strTxt.append("&amp;");
					break;
				default:
					strTxt.append(chrBuff);
				}
			}

			rtnStr = strTxt.toString();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rtnStr;
	}

	/**
	 * 문자열을 파라메터로 넘어오는 c 를 기준으로 나누어 List 를 만든다
	 * 
	 * @param s
	 * @param c
	 * @return
	 */
	public static List<String> split(String s, String c) {
		int j = 0;
		ArrayList<String> arraylist = new ArrayList<String>();
		do {
			int i = s.indexOf(c, j);
			if (i < 0) {
				arraylist.add(s.substring(j, s.length()));
				break;
			}
			arraylist.add(s.substring(j, i));
			j = ++i;
		} while (true);
		return arraylist;
	}

	/**
	 * 넘겨받은 숫자를 무조껀 2자리로 만드는 메소드 ex) 0 -> 00, 2 -> 02
	 * 
	 * @param i
	 * @return
	 */
	public static String getTwoDigit(int i) {
		if (i > 9)
			return String.valueOf(i);
		else
			return "0" + String.valueOf(i);
	}

	/**
	 * 길이가 긴 문자열을 cutLength만큼 자르고 tail 을 붙인다.(긴문자열을 앞부분만 표시할때 사용)
	 * 
	 * @param data
	 * @param cutLength
	 * @param tail
	 * @return
	 */
	public static String cutString(String data, int cutLength, String tail) {
		if (data.getBytes().length < cutLength)
			return data;
		int han = 0;
		int inx = 0;
		byte buf[] = data.getBytes();
		han = 0;
		for (inx = 0; inx < cutLength; inx++)
			if (buf[inx] < 0 || buf[inx] > 127)
				han++;

		if (han % 2 == 1)
			cutLength--;
		return new String(buf, 0, cutLength) + tail;
	}

}
