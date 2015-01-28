package mil.af.common.util;

public abstract class ApprovalUtil {

	public static String doing = "결재대기";
	public static String done = "결재완료";
	public static String gigak = "기각";
	public static String withdrawal = "회수";
	public static String registering = "접수대기";
	public static String registered = "접수완료";
	
	public static Integer doing_state = 0;
	public static Integer done_state = 1;
	public static Integer gigak_stae = 2;
	public static Integer withdrawal_state= 3;
	public static Integer registering_state= 4;
	public static Integer registered_state= 5;
		
	public static String report_type = "S";
	public static String step_type = "step";
	public static String end_report_type = "E";
	public static String belt_type = "B";
	
	public static Integer subject_one = 1;
	public static Integer subject_two = 2;
	public static Integer subject_three = 3;
	public static Integer subject_four = 4;
	public static Integer subject_five = 5;
	public static Integer subject_six = 6;
	public static Integer subject_seven = 7;
	
	public static Integer step_d = 11;
	public static Integer step_m = 12;
	public static Integer step_a = 13;
	public static Integer step_i = 14;
	public static Integer step_c = 15;
	
	public static Integer belt = 20; 
			 
	
	public static String d="D단계";
	public static String m="M단계";
	public static String a="A단계";
	public static String i="I단계";
	public static String c="C단계";
	
	public static String one_step = "부서장(대대장)";
	public static String two_step = "군수담당";
	public static String three_step = "군수과장/처장";
	public static String four_step = "군수사 군수담당";
	public static String five_step = "군수사 군수과장/처장";
	public static String six_step = "공본담당자";
	public static String seven_step = "공본 과장/처장";
}
