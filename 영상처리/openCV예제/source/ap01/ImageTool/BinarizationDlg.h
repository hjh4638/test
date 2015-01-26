#pragma once

#include "Dib.h"

// CBinarizationDlg 대화 상자입니다.

class CBinarizationDlg : public CDialog
{
	DECLARE_DYNAMIC(CBinarizationDlg)

public:
	CBinarizationDlg(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CBinarizationDlg();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_BINARIZATION };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	CSliderCtrl m_sliderThreshold;
	int m_nThreshold;

	CDib m_DibSrc;	// 입력 영상의 축소 복사본
	CDib m_DibRes;	// 현재 임계값을 이용하여 m_DibSrc를 이진화한 영상

public:
	void SetImage(CDib& dib);

	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnEnChangeThresholdEdit();
};
