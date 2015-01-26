// AviChildFrame.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "ImageTool.h"
#include "AviChildFrame.h"


// CAviChildFrame

IMPLEMENT_DYNCREATE(CAviChildFrame, CMDIChildWnd)

CAviChildFrame::CAviChildFrame()
{

}

CAviChildFrame::~CAviChildFrame()
{
}


BEGIN_MESSAGE_MAP(CAviChildFrame, CMDIChildWnd)
	ON_WM_CREATE()
END_MESSAGE_MAP()


// CAviChildFrame 메시지 처리기입니다.

int CAviChildFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CMDIChildWnd::OnCreate(lpCreateStruct) == -1)
		return -1;

	if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_AVI_PLAY))
	{
		TRACE0("도구 모음을 만들지 못했습니다.\n");
		return -1;      // 만들지 못했습니다.
	}

	// TODO: 도구 모음을 도킹할 수 없게 하려면 이 세 줄을 삭제하십시오.
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);

	return 0;
}
