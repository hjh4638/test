package mil.af.L6S.util;

/**
 * 파일업로드 Util
 * 
 * @author 정성모
 * 
 */
public class UploadUtil {

	/**
	 * 확장자 체크
	 * 
	 * 제한 확장자 실행불가능하게함
	 * 
	 * @param fileName
	 *            사용하는 현재 파일이름
	 * @return 허용되지 않는 확장자 boolean =false
	 * 
	 *         허용확장자 boolean =true
	 */
	public static boolean checkContentType(String fileName) {

		String type = fileName.substring(fileName.lastIndexOf(".") + 1,
				fileName.length());

		boolean result = true;
		
		if (type.toLowerCase().equals("jsp") || type.toLowerCase().equals("php") || type.toLowerCase().equals("html")
				|| type.toLowerCase().equals("sqljsp")) {
			result = false;
		} else if (type.toLowerCase().equals("hwp") || type.toLowerCase().equals("doc")
				|| type.toLowerCase().equals("docx") || type.toLowerCase().equals("ppt")
				|| type.toLowerCase().equals("pptx") || type.toLowerCase().equals("xls")
				|| type.toLowerCase().equals("pdf") || type.toLowerCase().equals("txt")
				|| type.toLowerCase().equals("jpg") || type.toLowerCase().equals("gif")
				|| type.toLowerCase().equals("gux") || type.toLowerCase().equals("hox")
				|| type.toLowerCase().equals("xlsx") || type.toLowerCase().equals("nxl")
				|| type.toLowerCase().equals("hpt") || type.toLowerCase().equals("vsd")) {
			result = true;
		} else {
			result = false;
		}

		return result;
	}
}
