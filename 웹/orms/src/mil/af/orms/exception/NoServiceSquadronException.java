package mil.af.orms.exception;

@SuppressWarnings("serial")
public class NoServiceSquadronException extends Exception{
	public NoServiceSquadronException(){
		System.out.println("체계에 대한 접근 권한이 없습니다.");
	}
}
