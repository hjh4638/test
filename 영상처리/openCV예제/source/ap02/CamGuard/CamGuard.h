// CamGuard.h : PROJECT_NAME ���� ���α׷��� ���� �� ��� �����Դϴ�.
//

#pragma once

#ifndef __AFXWIN_H__
	#error "PCH�� ���� �� ������ �����ϱ� ���� 'stdafx.h'�� �����մϴ�."
#endif

#include "resource.h"		// �� ��ȣ�Դϴ�.


// CCamGuardApp:
// �� Ŭ������ ������ ���ؼ��� CamGuard.cpp�� �����Ͻʽÿ�.
//

class CCamGuardApp : public CWinApp
{
public:
	CCamGuardApp();

// �������Դϴ�.
	public:
	virtual BOOL InitInstance();

// �����Դϴ�.

	DECLARE_MESSAGE_MAP()
};

extern CCamGuardApp theApp;