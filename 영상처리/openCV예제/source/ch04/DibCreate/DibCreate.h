// DibCreate.h : DibCreate ���� ���α׷��� ���� �� ��� ����
//
#pragma once

#ifndef __AFXWIN_H__
	#error "PCH�� ���� �� ������ �����ϱ� ���� 'stdafx.h'�� �����մϴ�."
#endif

#include "resource.h"       // �� ��ȣ�Դϴ�.


// CDibCreateApp:
// �� Ŭ������ ������ ���ؼ��� DibCreate.cpp�� �����Ͻʽÿ�.
//

class CDibCreateApp : public CWinApp
{
public:
	CDibCreateApp();


// �������Դϴ�.
public:
	virtual BOOL InitInstance();

// �����Դϴ�.
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CDibCreateApp theApp;