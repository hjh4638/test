package mil.af.orms.util;

public class StringUtil {
	public static boolean isArrayContainsValue(String[] array,String value){
		int size=array.length;
		for(int i=0;i<size;i++){
			if(value!=null){
				if(value.equals(array[i])){
					return true;
				}
			}
		}
		return false;
	}
	
	public static int getStringActualLength(String value){
		
		  int length=0;
		  int size=value.length();
		  
		  for(int i=0;i<size;i++){
			  char characterAt=value.charAt(i);
			  if(isKorean(characterAt)){
				  length+=2;
			  }else{
				  length++;
			  }
		  }
		  return length;
	}
	
	public static boolean isKorean(char character){
		if(character<=255){
			  return false;
		  }else{
			  return true;
		  }
	}
	
	public static String getCutString(String value,int cutStringLength,String dotString){
		int length=value.length();
		int actualLength=getStringActualLength(value);
		int realLength=0;
		int procLength=0;
		String resultString="";
		while(realLength<cutStringLength&&procLength<length){
			char charAt=value.charAt(procLength);
			if(isKorean(charAt)){
				realLength+=2;
			}else{
				realLength++;
			}
			procLength++;
			resultString+=charAt;
		}
		if(realLength<actualLength){
			resultString+=dotString;
		}
		return resultString;
	}
	public static void main(String[] args){
		System.out.println(getCutString("aa하호호호히",2,".."));
	}
}
