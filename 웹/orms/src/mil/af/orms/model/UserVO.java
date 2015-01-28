package mil.af.orms.model;

/**
 * 사용자 정보 VO
 */
public class UserVO {

	/**
	 * 사용자 권한(역할)값
	 */
	UserRole role;
	
	/**
	 * 사용자 권한자 중 관리하는 부대 코드
	 */
	private String unit_code;

	// AVS11U0T 의 필드 중 필요한 필드 선언
	private String userid;
	private String sosokcode;
	private String ass;
	private String fullass;
	private String rankcode;
	private String name;
	private String telin;
	private String mobilephone;
	private String usergubun;
	private String gunbun;
	private String sosokname;
	private String insasosokcode;
	private String insasosokname;
	private String insabojik;
	private String origin;
	private String kisu;
	private String mspccode;
	private String mspcname;
	private String rankname;
	private String intrasosokname;
	private String sinbuncode;
	private String airplane; // 기종
	
	// 권한 체크 함수
	
	public boolean isFormationManager(){
		return (role==UserRole.FORMATIONMANAGER);
	}
	public boolean isSquadronManager(){
		return (role==UserRole.SQUADRONMANAGER);
	}
	public boolean isCQ(){
		return (role==UserRole.CQ);
	}
	public boolean isSystemAdmin(){
		return (role==UserRole.SYSTEMADMIN);
	}



	// Getter / Setter

	// 권한부분 Get/Set
	public UserRole getRole() {
		return role;
	}
	public void setRole(UserRole role) {
		this.role = role;
	}

	// AVS11U0T 부분 Get/Set
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSosokcode() {
		return sosokcode;
	}
	public void setSosokcode(String sosokcode) {
		this.sosokcode = sosokcode;
	}
	public String getAss() {
		return ass;
	}
	public void setAss(String ass) {
		this.ass = ass;
	}
	public String getFullass() {
		return fullass;
	}
	public void setFullass(String fullass) {
		this.fullass = fullass;
	}
	public String getRankcode() {
		return rankcode;
	}
	public void setRankcode(String rankcode) {
		this.rankcode = rankcode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelin() {
		return telin;
	}
	public void setTelin(String telin) {
		this.telin = telin;
	}
	public String getUsergubun() {
		return usergubun;
	}
	public void setUsergubun(String usergubun) {
		this.usergubun = usergubun;
	}
	public String getGunbun() {
		return gunbun;
	}
	public void setGunbun(String gunbun) {
		this.gunbun = gunbun;
	}
	public String getSosokname() {
		return sosokname;
	}
	public void setSosokname(String sosokname) {
		this.sosokname = sosokname;
	}
	public String getInsasosokcode() {
		return insasosokcode;
	}
	public void setInsasosokcode(String insasosokcode) {
		this.insasosokcode = insasosokcode;
	}
	public String getInsasosokname() {
		return insasosokname;
	}
	public void setInsasosokname(String insasosokname) {
		this.insasosokname = insasosokname;
	}
	public String getInsabojik() {
		return insabojik;
	}
	public void setInsabojik(String insabojik) {
		this.insabojik = insabojik;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getKisu() {
		return kisu;
	}
	public void setKisu(String kisu) {
		this.kisu = kisu;
	}
	public String getMspccode() {
		return mspccode;
	}
	public void setMspccode(String mspccode) {
		this.mspccode = mspccode;
	}
	public String getMspcname() {
		return mspcname;
	}
	public void setMspcname(String mspcname) {
		this.mspcname = mspcname;
	}
	public String getRankname() {
		return rankname;
	}
	public void setRankname(String rankname) {
		this.rankname = rankname;
	}
	public String getIntrasosokname() {
		return intrasosokname;
	}
	public void setIntrasosokname(String intrasosokname) {
		this.intrasosokname = intrasosokname;
	}
	public String getSinbuncode() {
		return sinbuncode;
	}
	public void setSinbuncode(String sinbuncode) {
		this.sinbuncode = sinbuncode;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getUnit_code() {
		return unit_code;
	}
	public void setUnit_code(String unit_code) {
		this.unit_code = unit_code;
	}
	public String getAirplane() {
		return airplane;
	}
	public void setAirplane(String airplane) {
		this.airplane = airplane;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString() + " { " +
		unit_code + ", " +

		// AVS11U0T 의 필드 중 필요한 필드 선언
		userid + ", " +
		sosokcode + ", " +
		ass + ", " +
		fullass + ", " +
		rankcode + ", " +
		name + ", " +
		telin + ", " +
		mobilephone + ", " +
		usergubun + ", " +
		gunbun + ", " +
		sosokname + ", " +
		insasosokcode + ", " +
		insasosokname + ", " +
		insabojik + ", " +
		origin + ", " +
		kisu + ", " +
		mspccode + ", " +
		mspcname + ", " +
		rankname + ", " +
		intrasosokname + ", " +
		sinbuncode + ", " +
		airplane + ", " + // 기종
				"}";
		
	}
	
	
	
}
