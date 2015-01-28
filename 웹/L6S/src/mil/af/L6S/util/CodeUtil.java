package mil.af.L6S.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CodeUtil {

	/**
	 * 권한 코드를 받아서 이름으로 바꾸어주는 Util
	 * 
	 * @param code
	 * @return
	 */
	public static String autorityCodeToName(String code) {

		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("A"))
			return "본부 관리자";
		else if (code.equals("B"))
			return "사령부 관리자";
		else if (code.equals("C"))
			return "부대 관리자(BB)";
		else {
			logger.error("Autority Code To Name : wrong code input");
			return null;
		}
	}
	
	/**
	 * 벨트 레벨을 받아서 이름으로 바꾸어주는 Util
	 * 
	 * @param code
	 * @return
	 */
	public static String beltLevToName(int code) {

		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);
		if (code==0)
			return "No Belt";
		else if (code==1)
			return "MBB";
		else if (code==2)
			return "BB";
		else if (code==3)
			return "GB";
		else if (code==4)
			return "FEA";
		else {
			logger.error("Belt Level To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 벨트 상태 코드를 받아서 이름으로 바꾸어주는 Util
	 * 
	 * @param code
	 * @return
	 */
	public static String beltStatToName(int code) {

		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);
		if (code==0)
			return "No Exist";
		if (code == 1) {
			return "미수료 ";
		} else if (code == 2) {
			return "수료";
		} else if (code == 3) {
			return "수료 인증";
		} else if (code == 4) {
			return "자격";
		} else if (code == 5) {
			return "자격 인증";
		}
		else {
			logger.error("Belt Level To Name : wrong code input");
			return null;
		}
	}
	
	/**
	 * 숨김옵션을 받아서 한글이름으로 바꿔주는 Util
	 * 
	 * @param code
	 *            A = 공개 , B= 비공개
	 * @return 공개, 비공개
	 */
	public static String hideOptionCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);
		if (code == null)
			return null;

		if (code.equals("A"))
			return "공개";
		else if (code.equals("B"))
			return "비공개";
		else {
			logger.error("Hide Option Code To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 상태 코드를 한글로 바꿔주는 Util
	 * 
	 * @param code
	 *            A = 진행, B = 완료
	 * @return 진행, 완료 String
	 */
	public static String measureStatueCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("A"))
			return "진행";
		else if (code.equals("B"))
			return "완료";
		else {
			logger.error("Measure Status Code To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 후속조치 결재상태에 따른 코드변환
	 * 
	 * @param code
	 *            A : 결재, R : 기각, C : 완료, X : 결재대기
	 * @return 결재, 기각, 완료, 결재대기
	 */
	public static String approvalLineCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("A"))
			return "결재";
		else if (code.equals("R"))
			return "기각";
		else if (code.equals("C"))
			return "완료";
		else if (code.equals("X"))
			return "결재대기";
		else {
			logger.error("Approval Line Code To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 확인관 확인상태에 따른 코드 변환
	 * 
	 * @param code
	 *            A=확인, B=기각, X=미확인
	 * @return 확인, 기각, 미확인
	 */
	public static String confirmMenCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("A"))
			return "확인";
		else if (code.equals("B"))
			return "기각";
		else if (code.equals("X"))
			return "미확인";
		else {
			logger.error("Confirm Men Code To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 확인관 확인상태에 따른 코드 변환
	 * 
	 * @param code
	 *            X:미접수 O:접수 A:진행 B:완료
	 * @return 미접수 접수 진행 완료
	 */
	public static String disposalStatusCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("X"))
			return "미접수";
		else if (code.equals("O"))
			return "접수";
		else if (code.equals("A"))
			return "진행";
		else if (code.equals("B"))
			return "완료";
		else {
			logger.error("Disposal Vo Code To Name : wrong code input");
			return null;
		}
	}

	/**
	 * 결재코드를 한글로 변환
	 * 
	 * @param receiptStatus
	 * @return
	 */
	public static String receiptStatusFromCodeToName(String code) {
		final Logger logger = LoggerFactory.getLogger(CodeUtil.class);

		if (code == null)
			return null;

		if (code.equals("A"))
			return "결재";
		else if (code.equals("C"))
			return "확인";
		else if (code.equals("R"))
			return "기각";
		else {
			logger.error("Autority Code To Name : wrong code input");
			return null;
		}
	}
}
