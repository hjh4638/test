package mil.af.orms.exception;

@SuppressWarnings("serial")
public class NeedSSOLoginException extends Exception {
	public NeedSSOLoginException(){
		System.out.println("SSO 정보가 없습니다.");
	}
}
