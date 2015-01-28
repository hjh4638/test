package mil.af.L6S.test.subject;

import mil.af.L6S.component.subject.SubjectFormAndDataVO;

public class SubjectStep extends SubjectFormAndDataVO{
	
	private Integer subject_code;
	private String register_day;
	private String step;
	public Integer getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(Integer subject_code) {
		this.subject_code = subject_code;
	}
	public String getRegister_day() {
		return register_day;
	}
	public void setRegister_day(String register_day) {
		this.register_day = register_day;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}

}
