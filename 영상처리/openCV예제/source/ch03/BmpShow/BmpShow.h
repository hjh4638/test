// BmpShow.h : BmpShow ���� ���α׷��� ���� �� ��� ����
//
#pragma once

#ifndef __AFXWIN_H__
	#error "PCH�� ���� �� ������ �����ϱ� ���� 'stdafx.h'�� �����մϴ�."
#endif

#include "resource.h"       // �� ��ȣ�Դϴ�.


// CBmpShowApp:
// �� Ŭ������ ������ ���ؼ��� BmpShow.cpp�� �����Ͻʽÿ�.
//

class CBmpShowApp : public CWinApp
{
public:
	CBmpShowApp();


// �������Դϴ�.
public:
	virtual BOOL InitInstance();

// �����Դϴ�.
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CBmpShowApp theApp;