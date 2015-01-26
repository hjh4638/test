#pragma once



// CAviView ���Դϴ�.

class CAviView : public CScrollView
{
	DECLARE_DYNCREATE(CAviView)

protected:
	CAviView();           // ���� ����⿡ ���Ǵ� protected �������Դϴ�.
	virtual ~CAviView();

public:
#ifdef _DEBUG
	virtual void AssertValid() const;
#ifndef _WIN32_WCE
	virtual void Dump(CDumpContext& dc) const;
#endif
#endif

protected:
	virtual void OnDraw(CDC* pDC);      // �� �並 �׸��� ���� �����ǵǾ����ϴ�.
	virtual void OnInitialUpdate();     // ������ �� ó���Դϴ�.

	DECLARE_MESSAGE_MAP()

public:
	CAvi m_Avi;
	int  m_nCurrentFrame;		// ���� ��� ��ġ
	BOOL m_bPlay;

	void AviFileOpen(LPCTSTR lpszPathName);

public:
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);

	afx_msg void OnPlayPlay();
	afx_msg void OnUpdatePlayPlay(CCmdUI* pCmdUI);
	afx_msg void OnPlayPause();
	afx_msg void OnUpdatePlayPause(CCmdUI* pCmdUI);
	afx_msg void OnPlayStop();
	afx_msg void OnUpdatePlayStop(CCmdUI* pCmdUI);
	afx_msg void OnPlayStart();
	afx_msg void OnPlayEnd();
	afx_msg void OnPlayPrev();
	afx_msg void OnPlayNext();
	afx_msg void OnCapture();
};


