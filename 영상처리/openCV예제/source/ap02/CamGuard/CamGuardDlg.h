// CamGuardDlg.h : 헤더 파일
//

#pragma once

#include "Dib.h"

// CCamGuardDlg 대화 상자
class CCamGuardDlg : public CDialog
{
// 생성입니다.
public:
	CCamGuardDlg(CWnd* pParent = NULL);	// 표준 생성자입니다.

// 대화 상자 데이터입니다.
	enum { IDD = IDD_CAMGUARD_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 지원입니다.


// 구현입니다.
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

	// 생성된 메시지 맵 함수
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
