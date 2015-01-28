package mil.af.L6S.component.belt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *  Register Validator
 *  				(유효성 검사)
 * @author 박민
 */
@Component
public class RegisterValidator implements Validator {

	@Autowired
	BeltDAO beltDAO;
	
	public boolean isInteger(String[] arr)
	{
		try{
			for(int i=0;i<2;i++)
			{
			System.out.println(Integer.parseInt(arr[i]));
			
			}
			return true;
		}catch(NumberFormatException ex){
			return false;
		}catch(ArrayIndexOutOfBoundsException aiob){
			return false;
			
				
		}
		
		
	}
	public boolean isInteger(String str) throws NumberFormatException
	{
		try
		{
			Integer.parseInt(str);
			return true;
		}catch(NumberFormatException ex){
			return false;
		}
		
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return ContentsVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors error) {
		ContentsVO contentsVO = (ContentsVO) target;
		int beltstate = contentsVO.getBeltstate();
		String eduStartDate = contentsVO.getEduStartDate();
		String eduEndDate = contentsVO.getEduEndDate();
		String eduNum = contentsVO.getEduNum();
		String belt = contentsVO.getBelt();
		String score = contentsVO.getScore();
		String[] eduNumCheck;
		
		
		eduNumCheck = eduNum.split("-");
		
		if(beltDAO.getCountRepeat(contentsVO)>0){
			error.rejectValue("belt", "field.contentsVO.duplication");
		}else if(beltstate==0){
			error.rejectValue("beltstate", "field.contentsVO.statenulldata");
		}else if(eduStartDate==null || eduStartDate.length()==0){
			error.rejectValue("eduStartDate", "field.contentsVO.stratnulldata");
		}else if(eduEndDate==null || eduEndDate.length()==0){
			error.rejectValue("eduEndDate", "field.contentsVO.endnulldata");
		}else if(eduNum==null || eduNum.length()==0){
			error.rejectValue("eduNum", "field.contentsVO.numnulldata");
		}else if(!isInteger(eduNumCheck) || !(eduNum.length()==5))
		{
			error.rejectValue("eduNum", "field.contentsVO.numanotherformatdata");
		}else if(belt.equals("GB"))
		{
			if(beltstate == 2)
			{
				if(score==null || score.length()==0)
				{
					error.rejectValue("score", "field.contentsVO.scorenulldata");
				}else if(score.length()>=3){
					if(!isInteger(score.substring(0, 2))||!isInteger(score.substring(3)))
					{
						error.rejectValue("score", "field.contentsVO.scoreanotherformatdata");
					}
				}else if(!isInteger(score)){
					error.rejectValue("score", "field.contentsVO.scoreanotherformatdata");
				}
			}
		}
	}
		
	}
