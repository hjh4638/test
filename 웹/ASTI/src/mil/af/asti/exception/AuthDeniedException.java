package mil.af.asti.exception;

public class AuthDeniedException extends Exception {

	private static final long serialVersionUID = 1L;

	public AuthDeniedException(){
		super();
		System.out.println("권한 없음");
	}
}
