// First.h : First ���� ���α׷��� ���� �� ��� ����
//
#pragma once

#ifndef __AFXWIN_H__
	#error "PCH�� ���� �� ������ �����ϱ� ���� 'stdafx.h'�� �����մϴ�."
#endif

#include "resource.h"       // �� ��ȣ�Դϴ�.


// CFirstApp:
// �� Ŭ������ ������ ���ؼ��� First.cpp�� �����Ͻʽÿ�.
//

class CFirstApp : public CWinApp
{
public:
	CFirstApp();


// �������Դϴ�.
public:
	virtual BOOL InitInstance();

// �����Դϴ�.
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CFirstApp theApp;