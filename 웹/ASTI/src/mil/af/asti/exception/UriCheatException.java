package mil.af.asti.exception;

public class UriCheatException extends Exception {

	private static final long serialVersionUID = 1L;

	public UriCheatException(){
		super();
		System.out.println("URI 부정 입력");
	}
}
