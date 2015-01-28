package mil.af.iers.component.validator;

import javax.annotation.Resource;

import mil.af.iers.component.util.ReservationFixed;
import mil.af.iers.dao.CodeDao;
import mil.af.iers.model.FacilitiesCodeDTO;
import mil.af.iers.model.ReservationDTO;
import mil.af.iers.model.UserDTO;
import mil.af.iers.service.ReservationService;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.List;

@Component
public class ReservationValidator implements Validator{

	@Resource
	private CodeDao codeDao;
	@Resource
	private ReservationService reservationService;
	@Override
	public boolean supports(Class<?> class1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void validate(Object obj, Errors errors) {
		
		ReservationDTO reserve = (ReservationDTO) obj;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "facilities_type", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_day", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_period", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_people_count", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_price", "field.required");
		
		if(reserve!=null){
			FacilitiesCodeDTO facil=codeDao.getFacilCodeById(reserve.getFacilities_type());
			if(facil!=null){
				Integer day_price=facil.getFacilities_price()==null?0:facil.getFacilities_price();
				Integer add_price=facil.getFacilities_add_price()==null?0:facil.getFacilities_add_price();
				Integer reserve_count = reserve.getReservation_period()==null?0:reserve.getReservation_period();
				Integer people_count=reserve.getReservation_people_count()==null?0:reserve.getReservation_people_count();
				Integer standard_people_count=facil.getFacilities_accommodation()==null?0:facil.getFacilities_accommodation();
				Integer add_people_count=0;
				
				if(people_count>standard_people_count){
					add_people_count=people_count-standard_people_count;
				}
				Integer sum=(day_price+(add_price*add_people_count))*reserve_count;
				if(!(sum.equals(reserve.getReservation_price()))){
					
					System.out.println("값 불일치");
					errors.rejectValue("reservation_price", "field.required");
				}
			}
		}
	}
public void validateToAdmin(Object obj, Errors errors) {
		
		ReservationDTO reserve = (ReservationDTO) obj;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "facilities_type", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_day", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_period", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_people_count", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "reservation_price", "field.required");
		
		if(reserve!=null){
			FacilitiesCodeDTO facil=codeDao.getFacilCodeById(reserve.getFacilities_type());
			if(facil!=null){
				Integer day_price=facil.getFacilities_price()==null?0:facil.getFacilities_price();
				Integer add_price=facil.getFacilities_add_price()==null?0:facil.getFacilities_add_price();
				Integer reserve_count = reserve.getReservation_period()==null?0:reserve.getReservation_period();
				Integer people_count=reserve.getReservation_people_count()==null?0:reserve.getReservation_people_count();
				Integer standard_people_count=facil.getFacilities_accommodation()==null?0:facil.getFacilities_accommodation();
				Integer add_people_count=0;
				
				if(people_count>standard_people_count)
					add_people_count=people_count-standard_people_count;
				
				Integer sum=(day_price+(add_price*add_people_count))*reserve_count;
				if(!(sum.equals(reserve.getReservation_price()))){
					
					System.out.println("값 불일치");
					errors.rejectValue("reservation_price", "field.required");
				}
			}
		}
	
	}

}
