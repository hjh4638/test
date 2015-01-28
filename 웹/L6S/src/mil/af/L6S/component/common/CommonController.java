package mil.af.L6S.component.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mil.af.L6S.component.common.CommonController;
import mil.af.L6S.component.common.CommonService;
import mil.af.L6S.component.common.SsoTestVO;
import mil.af.L6S.util.StringUtil;
import mil.af.L6S.component.common.User;
import mil.af.L6S.component.common.FileVO;
import mil.af.L6S.util.UploadUtil;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ksign.ssoapi.SSOService;
import com.oss.coders.Debug;

/**
 *  Main Controller
 * @author 정성모
 */
@Controller
@RequestMapping("/main")
public class CommonController {
	final Logger logger = LoggerFactory.getLogger(CommonController.class);

	private CommonService commonService;
	@Autowired
	private void config(CommonService commonService) {
		this.commonService = commonService;
	}

	/**
	 *  시작 페이지
	 * @return model(start) 
	 */
	@RequestMapping("start.do")
	public ModelAndView start(User user,
					HttpServletRequest request) {
		ModelAndView model = new ModelAndView("start");
		logger.debug("User = " + user);
		
//		HttpSession session = request.getSession();
//		User user1 = (User) session.getAttribute("login"); 
//		System.out.println("☆★☆★  : "+user1);
		return model;
	}

	/**
	 *  Lean 6 Sigma Introduction
	 * @return model(intro) 
	 */
	@RequestMapping("intro.do")
	public ModelAndView intro(User user) {
		ModelAndView model = new ModelAndView("intro/intro");
		return model;
	}
	
	/**
	 * 인트라넷 로그인이 안되있을경우 이페이지로 이동
	 * 
	 * @return
	 */
	@RequestMapping("noPermission.do")
	public ModelAndView notLogin() {
		return new ModelAndView("noPermission");
	}
	
	/**
	 * test login 페이지 접근
	 * 
	 * 권한 security 에서 처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/test/login.do", method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String clientIP = null;

		try {
			clientIP = request.getRemoteAddr(); // 사용자 IP
			logger.debug("Client Ip , 접속 Ip = " + clientIP);
		} catch (Exception e) {
			// HTTP 에러코드 404 를 보내서 URL 이 없는 것처럼 보이게 함
			if (e.getMessage() != null && e.getMessage().length() > 0) {
				System.out.println("IP 체크 중 예외 : " + e.getMessage());
			}
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		return "backdoor";
	}

	/**
	 * 테스트 로그인 페이지 포스트
	 * 
	 * @param response
	 * @param request
	 * @param userid
	 * @return
	 */
	@RequestMapping(value = "/test/login.do", method = RequestMethod.POST)
	public String loginPost(HttpServletResponse response,
			HttpServletRequest request, @RequestParam String userid) {
		String clientIP = request.getRemoteAddr();
		try {
			// 파라미터가 없는 경우, 테스트용 인덱스 페이지를 보여줌
			if (userid == null || userid.length() <= 0) {
				return "test/login";
			}

			// 쿠키 삭제
			resetCookie(response);
			// SSO 삭제
			HttpSession session = request.getSession();
			session.setAttribute("ssoInfo", null);

			// 인증 설정값
			String initVal = "368B184727E89AB69FAF";
			String domain = "af.mil";

			// SSO Service 객체 생성
			SSOService sso = new SSOService(domain, initVal);

			// 사용자 정보를 DB에서 가져옴
			SsoTestVO user = commonService.getIntraUser(userid);

			// 사용자 정보 DB 조회 결과가 NULL이면 잘못된 군번이거나 정보가 없는 사람이므로 에러처리
			if (user == null) {
				System.out
						.println("테스트 로그인 사용자 정보를 가져올 수 없음. IP = " + clientIP);
				return "redirect:/main/test/login.do";
			}

			// DB에서 가져온 정보를 기반으로 sso에 putValue를 통해 정보를 넣는다.
			// 일부 필요한 정보를 제외하면 더미값이 들어간다.
			sso.putValue("GUNBUN", encode(user.getGunbun())); // 군번
			sso.putValue("SINBUNCODE", encode(user.getSinbuncode()));
			sso.putValue("RANKCODE", encode(user.getRankcode()));
			sso.putValue("RANKNAME", encode(user.getRankname()));
			sso.putValue("INSABOJIK", encode(user.getInsabojik()));
			sso.putValue("INSASOSOKCODE", encode(user.getInsasosokcode()));
			sso.putValue("INSASOSOKNAME", encode(user.getInsasosokname()));
			sso.putValue("UNITNO", "");
			sso.putValue("SOSOKNAME", encode(user.getSosokname()));
			sso.putValue("SOSOKCODE", encode(user.getSosokcode()));
			sso.putValue("INTRASOSOKNAME", encode(user.getIntrasosokname()));
			sso.putValue("ASS", encode(user.getAss()));
			sso.putValue("FULLASS", encode(user.getFullass()));
			sso.putValue("TELIN", encode(user.getTelin()));
			sso.putValue("TELOUT", "");
			sso.putValue("MOBILEPHONE", "");
			sso.putValue("AUTHGUBUN", "10");
			sso.putValue("LOGINTYPE", "ID");
			sso.putValue("HOMEURL", "");
			sso.putValue("LOCATEGUBUN", "");
			sso.putValue("USERGUBUN", encode(user.getUsergubun()));
			sso.putValue("USERAUTHCODE", "");
			sso.putValue("ORIGIN", encode(user.getOrigin()));
			sso.putValue("KISU", encode(user.getKisu()));
			sso.putValue("MSPCCODE", encode(user.getMspccode()));
			sso.putValue("MSPCNAME", encode(user.getMspcname()));
			sso.putValue("MODIFYDATE", "");
			sso.putValue("SEX", "");
			sso.putValue("SIGNFILE1", "");
			sso.putValue("SIGNFILE2", "");
			sso.putValue("OLD_ID", "");
			sso.putValue("DOCSHIN", "");
			sso.putValue("NICKNAME", "");
			sso.putValue("USERID", encode(userid));
			sso.putValue("MAIL", "sss@ksign.com");
			sso.putValue("NAME", encode(user.getName()));
			sso.putValue("TS", getTokenToday());
			sso.putValue("AM", "form-based");
			sso.putValue("CP", clientIP);
			System.out.println(sso.getValue("CP"));

			sso.ka_generateSSOToken(response); // 토큰 생성
			System.out.println("테스트용 토큰 생성");
		} catch (Exception ex) {
			System.out.println("테스트용 토큰 생성 중 에러가 발생하였습니다. "
					+ ((ex.getMessage() != null) ? (ex.getMessage()) : ("")));
			return "redirect:/main/test/login.do";
		}
		return "redirect:/main/start.do";
	}

	/**
	 * SSO Token 삭제
	 * 
	 * @param response
	 */
	private static void resetCookie(HttpServletResponse response) {
		Cookie ssoCookie = new Cookie("ka_sso_token", "");
		ssoCookie.setMaxAge(0);
		ssoCookie.setPath("/");
		ssoCookie.setDomain("af.mil");
		response.addCookie(ssoCookie);
	}

	/**
	 * SSO 토큰에 값을 넣을 때 인코딩 변환을 위한 메소드
	 * 
	 * @param v
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private static String encode(String v) throws UnsupportedEncodingException {
		if (v == null) {
			return "";
		}
		return (new String(v.getBytes("EUC-KR"), "ISO-8859-1"));
	}

	/**
	 * SSO 토큰에 넣을 날짜시간 문자열을 생성하는 메소드
	 * 
	 * @return
	 */
	private static String getTokenToday() {
		Calendar cal = Calendar.getInstance();
		StringBuilder sb = new StringBuilder();
		sb.append(cal.get(Calendar.YEAR)).append("-")
				.append(StringUtil.getTwoDigit(cal.get(Calendar.MONTH) + 1))
				.append("-")
				.append(StringUtil.getTwoDigit(cal.get(Calendar.DAY_OF_MONTH)))
				.append(" ")
				.append(StringUtil.getTwoDigit(cal.get(Calendar.HOUR_OF_DAY)))
				.append(":")
				.append(StringUtil.getTwoDigit(cal.get(Calendar.MINUTE)))
				.append(":")
				.append(StringUtil.getTwoDigit(cal.get(Calendar.SECOND)));
		return sb.toString();
	}

	/**
	 * 파일업로드 테스트용 페이지
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping("fileUploadTest.do")
	public ModelAndView fileUploadTest(HttpSession session) {
		session.setAttribute("fileVoMap", null);

		ModelAndView model = new ModelAndView("fileUploadTest");

		model.addObject("uploadBean", new UploadVO());
		return model;
	}

	/**
	 * File Upload Controller = Flash를 통해서 Upload
	 * 
	 * @param uploadBean
	 *            Spring 에서 제공하는 UploadForm
	 * @param result
	 *            에러가 발생한경우 처리를 위해
	 * @param session
	 *            fileVoMap을 session에 저장후 출력
	 * @param request
	 *            saveDirectory를 가져옴
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/upload.do")
	public void upload(@ModelAttribute UploadVO uploadVO, BindingResult result,
			HttpSession session, HttpServletRequest request) {

		session = request.getSession();
		
		@SuppressWarnings("deprecation")
		String saveDirectory = request.getRealPath("WEB-INF/upload");
		
		if (result.hasErrors()) {
		
			for (ObjectError error : result.getAllErrors()) {
				logger.error("Error in uploading" + error.getCode() + " - "
						+ error.getDefaultMessage());
			}

		} else {
			MultipartFile multipartFile = uploadVO.getFiledata();
			String orginalName = multipartFile.getOriginalFilename();
			String saveName = System.currentTimeMillis()
					+ multipartFile.getOriginalFilename();
			String contentType = multipartFile.getContentType();
			if (UploadUtil.checkContentType(orginalName)) {

				if (multipartFile.getSize() > 0) {
					try {

						/*IOUtils.copy(multipartFile.getInputStream(),
								new FileOutputStream(new File(saveDirectory,
										saveName)));
										*/
						File toFile = new File(saveDirectory, saveName);
						System.out.println("to:" + toFile);
						multipartFile.transferTo(toFile);
						FileVO fileVO = new FileVO();

						fileVO.setName(orginalName);
						fileVO.setSaveName(saveName);
						fileVO.setType(contentType);

						List<FileVO> list = (List<FileVO>) session
								.getAttribute("fileVOList");

						if (list == null) {
							list = new LinkedList<FileVO>();
							list.add(0, fileVO);
						} else {
							list.add(list.size(), fileVO);
						}
						session.setAttribute("fileVOList", list);

						logger.debug("fileVOList = " + list);

					} catch (FileNotFoundException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			} else {
				logger.error("Error in uploading : 허용할수 없는 확장자 입니다.");
			}
		}
	}
	
	/**
	 * 파일 다운로드
	 * 
	 * @param filesn
	 *            파일 고유번호
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/download.do", method = RequestMethod.GET)
	public void promoteDownload(User user, HttpServletResponse response,
			HttpServletRequest request, @RequestParam String filesn)
			throws IOException {
		@SuppressWarnings("deprecation")
		String saveDirectory = request.getRealPath("WEB-INF/upload");
		
		System.out.println("RequestParam[Filesn] : "+filesn+"☆★");
		
		FileVO fileVO = commonService.selectFileVOOne(filesn);
		
		logger.debug("fileVO : " + commonService.selectFileVOOne(filesn));
			
		String UniqueNum = fileVO.getSn();
		
		System.out.println("UniqueNum : "+UniqueNum+"☆★");
//		boolean sn = commonService.selectUserSn(user.getSn(), UniqueNum);
//
//		String authorityChar = user.getAuthority() == null ? "" : user
//				.getAuthority();
//		boolean authority = authorityChar.equals("A")
//				|| authorityChar.equals("B") ? true : false;

		/**
		 * 비공개가 공개일경우
		 * 
		 * 비공개이면서 거기에 자신이 군번이 속해있는경우
		 * 
		 * 비공개이면서 전체관리자 또는 감사결과 등록자인 경우
		 */
//		if(sn){
//		if (!hideOption || (hideOption && sn) || (hideOption && authority)) {
			try {
				System.out.println("Try Check : ☆★");
				File file = new File(saveDirectory, fileVO.getSaveName());
				response.setBufferSize(4096);
				response.setContentType(fileVO.getType());
				response.setContentLength((int) file.length());

				response.setHeader(
						"Content-Disposition",
						"attachment;filename="
								+ URLEncoder.encode(fileVO.getName(), "UTF-8"));
				IOUtils.copy(new FileInputStream(file),
						response.getOutputStream());
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		else {
//			response.sendRedirect("noPermission.do");
// 		}
}
	
