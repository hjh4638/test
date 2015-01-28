package mil.af.asti.model;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mil.af.asti.board.BoardDAO;
import mil.af.asti.common.CommonService;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import util.HDIdeaCipher;

@Component
public class AstiValidator implements Validator{

	@Resource
	private BoardDAO boardDAO;
	
	@Resource
	private CommonService commonService;
	
	private String[] prohibit={"," , "<" , ">" , "[" , "]" , "{" , "}"};
	
	@Override
	public boolean supports(Class<?> class1) {
		return false;
	}

	@Override
	public void validate(Object obj, Errors errors) {
	}
	public void boardValidate(Object target, Errors errors) throws Exception {
		AstiBoardDTO astiBoardDTO = (AstiBoardDTO) target;
		String lengthCheck = checkDataLength(AstiBoardDTO.class, astiBoardDTO);
		if(!(lengthCheck.equals("success"))){
			System.out.println("글자수가 초과되었습니다.");
			errors.rejectValue(lengthCheck, "field.excessLength");
		}
				
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_title", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_content", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_writer", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_register_date", "field.required");
	}
	
	public void researchWorkerValidate(Object target, Errors errors) throws Exception {
		AstiResearchWorkerDTO research = (AstiResearchWorkerDTO) target;
		String lengthCheck = checkDataLength(AstiResearchWorkerDTO.class, research);
		if(!(lengthCheck.equals("success"))){
			System.out.println("글자수가 초과되었습니다.");
			errors.rejectValue(lengthCheck, "field.excessLength");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "worker_name", "field.required");
	}
	
	public void userValidate(Object target, Errors errors) throws Exception{
		AstiUserDTO userDTO = (AstiUserDTO) target;
		String lengthCheck = checkDataLength(AstiUserDTO.class, userDTO);
		if(!(lengthCheck.equals("success"))){
			System.out.println("글자수가 초과되었습니다.");
			errors.rejectValue(lengthCheck, "field.excessLength");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_id", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_password", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirm_password", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_sex", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_birth_date", "field.required");
		
		if(userDTO.getUser_id() !=null){
			List<AstiUserDTO> userList =commonService.getUserList(null);
			String user_id = userDTO.getUser_id();
			/*계정 형식체크*/
			if(user_id.indexOf("@") ==0 || user_id.lastIndexOf("@") == user_id.length()-1
					||  !user_id.contains("@"))
				errors.rejectValue("user_id", "field.illegalFomatId");
			else if(containProhibitedChar(user_id)){
				errors.rejectValue("user_id", "field.notAcceptedCharecter");
			}
			/*계정 중복체크*/
			else if(userList.size()>0){
				/*origin_password가 null일때(회원가입할때)*/
				if(userDTO.getOrigin_password() ==null){
					for(int i=0 ;i<userList.size();i++){
						AstiUserDTO user = userList.get(i);
						if(user!=null){
							if(user_id.equals(user.getUser_id())){
								errors.rejectValue("user_id", "field.overlapUserId");
							}
						}
					}
				}
			}
			
			/*한글,한자 같은거 포함되어있나 체크*/
			boolean containKorean = true;
			char[] cha = user_id.toCharArray();
			for(int i=0;i<cha.length;i++){
				String cc = cha[i]+"";
				int byteLength =cc.getBytes("euc-kr").length;
				if(byteLength != 1){
					containKorean =false;
				}
			}
			if(!containKorean){
				errors.rejectValue("user_id", "field.containKorean");
			}
		}
		HDIdeaCipher cipher = new HDIdeaCipher();
		/*origin_password는 로그인 되어있을때만 전송할수 있게 만들어졌다.(회원정보수정할때)*/
		if(userDTO.getOrigin_password() !=null){
			if(commonService.getUser(userDTO)!=null){
				String origin_password=commonService.getUser(userDTO).getUser_password();
				if(!cipher.encrypt(userDTO.getOrigin_password()).equals(origin_password))
					errors.rejectValue("origin_password", "field.notMatcedWithOriginPassword");
			}
		}
		if(userDTO.getUser_password() != null){
			String user_password = userDTO.getUser_password();
			/*비번 길이체크*/
			if(user_password.length() <8)
				errors.rejectValue("user_password", "field.lengthUnderEight");
			/*비번과 확인비번 같은지 체크*/
			else if(!user_password.equals(userDTO.getConfirm_password()))
				errors.rejectValue("user_password", "field.notMatchedWithConfirmPassword");
		}
		
	}

	public void userDeptValidate(Object target, Errors errors) throws Exception {
		// TODO Auto-generated method stub
		AstiCodeDTO codeDTO = (AstiCodeDTO) target;
		String lengthCheck = checkDataLength(AstiCodeDTO.class, codeDTO);
		if(!(lengthCheck.equals("success"))){
			System.out.println("글자수가 초과되었습니다.");
			errors.rejectValue(lengthCheck, "field.excessLength");
		}
	}
	/**
	 * 해당 DTO와 DTO.class를 보내주면 DTO field와 DB 테이블 컬럼 데이터 length와 비교하여 값 반환
	 * 프로퍼티 타입이 Sring인것만 해당
	 * @param tagetClass
	 * @param dto
	 * @return
	 * 
	 */
	public String checkDataLength(Class<?> tagetClass, Object dto) throws Exception{
		/*reflect를 이용하여 DTO를 fieldname를 키로 그 값을 value로 하는 map객체 생성*/
		Map<String,String> dtoMap = new HashMap<String,String>();
		
		Field[] field =tagetClass.getDeclaredFields();
		
		for(int i=0;i<field.length;i++){
			if(field[i].getType().getName().equals("java.lang.String")){
				String property = field[i].getName().substring(0, 1).toUpperCase()+field[i].getName().substring(1);
				Method me = tagetClass.getDeclaredMethod("get"+property);
				String pro = (String) me.invoke(dto);
				dtoMap.put(field[i].getName(),pro);
			}
		}
		/*dba_tab_columns에서 가져온 제약데이터길이로 길이체크*/
		List<AstiCodeDTO> code = boardDAO.getColumnLength();
		for(int i=0;i<code.size();i++){
			AstiCodeDTO coco = code.get(i);
			String zxc =coco.getCode_id().toLowerCase(); 
			if(dtoMap.get(zxc) !=null){
				if(dtoMap.get(zxc).getBytes("euc-kr").length >Integer.parseInt(coco.getCode_name())){
					return zxc;
				}
			}
		}
		return "success";
	}
	/*금지된 문자들을 ,로 연결해서 출력*/
	public String getProhibit(){
		String prohibitText = new String();
		for(int i=0;i<prohibit.length;i++){
			if(i==0)
				prohibitText=prohibitText+prohibit[i];
			else 
				prohibitText=prohibitText+","+prohibit[i];
		}
		return prohibitText;
	}
	/*금지된 문자 혹은 문자열이 포함되어 있는지 확인*/
	public boolean containProhibitedChar(String str){
		for(int i=0;i<prohibit.length;i++){
			if(str.contains(prohibit[i])){
				return true;
			}			
		}
		return false;
	}


}
