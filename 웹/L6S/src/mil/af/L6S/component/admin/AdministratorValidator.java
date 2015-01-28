package mil.af.L6S.component.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *  Administrator Validator
 *  				(유효성 검사)
 *  군번 중복 or Null or 빈칸 검사
 * @author 정성모
 */
@Component
public class AdministratorValidator implements Validator{

	@Autowired
	private AdministratorDAO administratorDAO;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return AdministratorVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors error) {
		AdministratorVO administratorVO = (AdministratorVO) target;
		String sn = administratorVO.getSn();
		
		if (sn == null) {
			error.rejectValue("sn", "field.administratorVO.empty");
		} else {
			if (sn.equals("")) {
				error.rejectValue("sn", "field.administratorVO.empty");
			} else {
				int vo = administratorDAO
						.checkUserSn(administratorVO.getSn());
				if (vo >= 1) {
					error.rejectValue("sn", "field.administratorVO.exist");
				}
			}
		}
		
	}

}
