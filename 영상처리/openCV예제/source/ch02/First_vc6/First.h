// First.h : main header file for the FIRST application
//

#if !defined(AFX_FIRST_H__115CEFAB_174D_45BA_9029_73609C0A8C9E__INCLUDED_)
#define AFX_FIRST_H__115CEFAB_174D_45BA_9029_73609C0A8C9E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CFirstApp:
// See First.cpp for the implementation of this class
//

class CFirstApp : public CWinApp
{
public:
	CFirstApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFirstApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CFirstApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FIRST_H__115CEFAB_174D_45BA_9029_73609C0A8C9E__INCLUDED_)
