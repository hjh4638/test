package mil.af.iers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LayoutController {

	@RequestMapping(value="admin.do")
	public ModelAndView admin(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/adminMain.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=appList")
	public ModelAndView appList(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/appList.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=changeFacilites")
	public ModelAndView changeFacilites(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/changeFacilites.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=memberManage")
	public ModelAndView memberManage(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/memberManage.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=reserve")
	public ModelAndView reserve(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/reserve.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=reserveView")
	public ModelAndView reserveView(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/reserveView.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=settlement")
	public ModelAndView settlement(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/settlement.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=settlementView")
	public ModelAndView settlementView(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/settlementView.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="admin.do",params="type=settlementViewDetail")
	public ModelAndView settlementViewDetail(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="admin/settlementViewDetail.do";
		mav.addObject("url", url);
		return mav;
	}
	
	@RequestMapping(value="main.do")
	public ModelAndView nomal(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="index.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=member")
	public ModelAndView member(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="member.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=reserve")
	public ModelAndView reserveNomal(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="reserve.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=reserveView")
	public ModelAndView reserveViewNormal(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="reserveView.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=myReserve")
	public ModelAndView myReserve(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="myReserve.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=usingInfo")
	public ModelAndView usingInfo(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="usingInfo.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=roomInfo")
	public ModelAndView roomInfo(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="roomInfo.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=mapInfo")
	public ModelAndView mapInfo(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="mapInfo.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=declareBoard")
	public ModelAndView declareBoard(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="declareBoard.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=qnaBoard")
	public ModelAndView qnaBoard(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="qnaBoard.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="fail.do")
	public ModelAndView fail(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="loginFail.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="find.do")
	public ModelAndView find(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="findPassword.do";
		mav.addObject("url", url);
		return mav;
	}
	@RequestMapping(value="main.do",params="type=login")
	public ModelAndView login(){
		ModelAndView mav = new ModelAndView("/layout/layout");
		String url="login.do";
		mav.addObject("url", url);
		return mav;
	}
	
	
}
