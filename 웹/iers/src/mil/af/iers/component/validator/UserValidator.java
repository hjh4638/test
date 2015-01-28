package mil.af.iers.component.validator;

import javax.annotation.Resource;

import mil.af.iers.component.util.HDIdeaCipher;
import mil.af.iers.model.UserDTO;
import mil.af.iers.service.MemberService;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator{

	@Resource
	private MemberService memberService;
	
	@Override
	public boolean supports(Class<?> class1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		UserDTO user = (UserDTO) target;
		HDIdeaCipher cipher = new HDIdeaCipher();
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_id", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_sosok", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_rank", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_cellular_phone", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_service_term", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_password", "field.required");
		
		if(user.getUser_id()!=null){
			UserDTO origin = memberService.getOneOfUser(user.getUser_id(), user.getUser_sosok());
			if(user.getUser_id().length() >12){
				errors.rejectValue("user_id","field.excessLength");
				System.out.println("군번 사이즈 초과");
			}
			else if(origin!=null){
				if(!origin.getUser_password().equals(cipher.encrypt(user.getOrigin_password()))){
					errors.rejectValue("user_id","field.excessLength");
					System.out.println("기존 비번과 일치하지 않음");
				}
			}
		}
		if(user.getUser_password()!=null){
			if(user.getUser_password().length()<8){
				errors.rejectValue("user_password","field.lessLength");
				System.out.println("비번 사이즈 8자 이하임");
			}
			else if(!user.getUser_password().equals(user.getPassword_confirm())){
				errors.rejectValue("user_password","field.lessLength");
				System.out.println("패스워드와 패스워드 확인 미일치");
			}
		}
	}

}
