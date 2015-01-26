// CamGuardDlg.h : ��� ����
//

#pragma once

#include "Dib.h"

// CCamGuardDlg ��ȭ ����
class CCamGuardDlg : public CDialog
{
// �����Դϴ�.
public:
	CCamGuardDlg(CWnd* pParent = NULL);	// ǥ�� �������Դϴ�.

// ��ȭ ���� �������Դϴ�.
	enum { IDD = IDD_CAMGUARD_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV �����Դϴ�.


// �����Դϴ�.
protected:
	HICON m_hIcon;

public:
	CDib m_Dib1;
	CDib m_Dib2;
	CDib m_Dib3;
	CDib m_Dib4;

	BOOL m_bDetected;

	int m_nBinaryTh;
	int m_nDetectTh;
	int m_nTimeSpan;
	CString m_strPathName;

	BOOL CheckDetect();
	int  ObjectRatio(CDib& dib);
	void SaveDetectImage();

	// ������ �޽��� �� �Լ�
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()

	afx_msg void OnTimer(UINT_PTR nIDEvent);
	afx_msg void OnDestroy();
	afx_msg void OnBnClickedBrowse();
	afx_msg void OnBnClickedCaptureSetup();
	afx_msg void OnBnClickedCaptureStart();
	afx_msg void OnBnClickedCaptureStop();
	afx_msg void OnBnClickedRegister();
};
