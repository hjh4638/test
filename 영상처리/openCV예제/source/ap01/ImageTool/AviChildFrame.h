#pragma once


// CAviChildFrame �������Դϴ�.

class CAviChildFrame : public CMDIChildWnd
{
	DECLARE_DYNCREATE(CAviChildFrame)
protected:
	CAviChildFrame();           // ���� ����⿡ ���Ǵ� protected �������Դϴ�.
	virtual ~CAviChildFrame();

protected:
	DECLARE_MESSAGE_MAP()

public:
	CToolBar    m_wndToolBar;

public:
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
};


