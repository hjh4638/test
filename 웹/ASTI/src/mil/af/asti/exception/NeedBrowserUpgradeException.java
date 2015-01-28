package mil.af.asti.exception;

public class NeedBrowserUpgradeException extends Exception{

	private static final long serialVersionUID = 1L;
	
	public NeedBrowserUpgradeException(){
		super();
		System.out.println("브라우저 업그레이드 필요");
	}

}
