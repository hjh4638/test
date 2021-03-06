// ImageTool.h : ImageTool 응용 프로그램에 대한 주 헤더 파일
//
#pragma once

#ifndef __AFXWIN_H__
	#error "PCH에 대해 이 파일을 포함하기 전에 'stdafx.h'를 포함합니다."
#endif

#include "resource.h"       // 주 기호입니다.


// CImageToolApp:
// 이 클래스의 구현에 대해서는 ImageTool.cpp을 참조하십시오.
//

class CDib;
class CImageToolApp : public CWinApp
{
public:
	CImageToolApp();
	~CImageToolApp();

public:
	CMultiDocTemplate* m_pImageDocTemplate;
	CDib* m_pNewDib;

// 재정의입니다.
public:
	virtual BOOL InitInstance();

// 구현입니다.
	DECLARE_MESSAGE_MAP()

public:
	afx_msg void OnAppAbout();
	afx_msg void OnEditPaste();
	afx_msg void OnUpdateEditPaste(CCmdUI *pCmdUI);
public:
	afx_msg void OnWindowCloseall();
};

extern CImageToolApp theApp;

/////////////////////////////////////////////////////////////////////////////
// 전역 함수 선언

void AfxNewImage(CDib& dib);

