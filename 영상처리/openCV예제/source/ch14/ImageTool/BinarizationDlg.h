#pragma once

#include "Dib.h"

// CBinarizationDlg ��ȭ �����Դϴ�.

class CBinarizationDlg : public CDialog
{
	DECLARE_DYNAMIC(CBinarizationDlg)

public:
	CBinarizationDlg(CWnd* pParent = NULL);   // ǥ�� �������Դϴ�.
	virtual ~CBinarizationDlg();

// ��ȭ ���� �������Դϴ�.
	enum { IDD = IDD_BINARIZATION };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV �����Դϴ�.

	DECLARE_MESSAGE_MAP()
public:
	CSliderCtrl m_sliderThreshold;
	int m_nThreshold;

	CDib m_DibSrc;	// �Է� ������ ��� ���纻
	CDib m_DibRes;	// ���� �Ӱ谪�� �̿��Ͽ� m_DibSrc�� ����ȭ�� ����

public:
	void SetImage(CDib& dib);

	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnEnChangeThresholdEdit();
};
