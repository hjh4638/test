// AviView.cpp : ���� �����Դϴ�.
//

#include "stdafx.h"
#include "ImageTool.h"
#include "AviDoc.h"
#include "AviView.h"
#include "Avi.h"

// CAviView

IMPLEMENT_DYNCREATE(CAviView, CScrollView)

CAviView::CAviView()
{
	m_nCurrentFrame = 0;
	m_bPlay = FALSE;
}

CAviView::~CAviView()
{
}


BEGIN_MESSAGE_MAP(CAviView, CScrollView)
	ON_WM_TIMER()
	ON_WM_ERASEBKGND()
	ON_COMMAND(ID_PLAY_PLAY, OnPlayPlay)
	ON_UPDATE_COMMAND_UI(ID_PLAY_PLAY, OnUpdatePlayPlay)
	ON_COMMAND(ID_PLAY_PAUSE, OnPlayPause)
	ON_UPDATE_COMMAND_UI(ID_PLAY_PAUSE, OnUpdatePlayPause)
	ON_COMMAND(ID_PLAY_STOP, OnPlayStop)
	ON_UPDATE_COMMAND_UI(ID_PLAY_STOP, OnUpdatePlayStop)
	ON_COMMAND(ID_PLAY_START, OnPlayStart)
	ON_COMMAND(ID_PLAY_END, OnPlayEnd)
	ON_COMMAND(ID_PLAY_PREV, OnPlayPrev)
	ON_COMMAND(ID_PLAY_NEXT, OnPlayNext)
	ON_COMMAND(ID_CAPTURE, OnCapture)
END_MESSAGE_MAP()


// CAviView �׸����Դϴ�.

void CAviView::OnInitialUpdate()
{
	CScrollView::OnInitialUpdate();

	CSize sizeTotal;

	if( m_Avi.IsValid() )
	{
		sizeTotal.cx = m_Avi.GetWidth();
		sizeTotal.cy = m_Avi.GetHeight();
	}
	else
	{
		sizeTotal.cx = sizeTotal.cy = 100;
	}

	SetScrollSizes(MM_TEXT, sizeTotal);

	ResizeParentToFit(TRUE);
}

void CAviView::OnDraw(CDC* pDC)
{
	CDocument* pDoc = GetDocument();
	// TODO: ���⿡ �׸��� �ڵ带 �߰��մϴ�.

	if( m_Avi.IsValid() )
	{
		m_Avi.DrawFrame(pDC->m_hDC, m_nCurrentFrame, 0, 0);
	}
}


// CAviView �����Դϴ�.

#ifdef _DEBUG
void CAviView::AssertValid() const
{
	CScrollView::AssertValid();
}

#ifndef _WIN32_WCE
void CAviView::Dump(CDumpContext& dc) const
{
	CScrollView::Dump(dc);
}
#endif
#endif //_DEBUG


// CAviView �޽��� ó�����Դϴ�.

void CAviView::AviFileOpen(LPCTSTR lpszPathName)
{
	// AVI ������ ���� ���� ���, �޽��� ����ϰ� �׳� ����
	if( !m_Avi.Open(lpszPathName) )
	{
		AfxMessageBox(_T("Avi ������ �� �� �����ϴ�."));
		return;
	}

	m_nCurrentFrame = 0;
}

void CAviView::OnTimer(UINT_PTR nIDEvent)
{
	if( nIDEvent == 1 )
	{
		m_nCurrentFrame++;

		if( m_nCurrentFrame >=  m_Avi.GetTotalFrame() )
		{
			m_nCurrentFrame = m_Avi.GetTotalFrame() - 1;
			KillTimer(1);
		}

		Invalidate(FALSE);
	}

	CScrollView::OnTimer(nIDEvent);
}

BOOL CAviView::OnEraseBkgnd(CDC* pDC)
{
	CBrush br;
	br.CreateHatchBrush(HS_DIAGCROSS, RGB(200, 200, 200));
	FillOutsideRect(pDC, &br);

	return TRUE;       // Erased
}

void CAviView::OnPlayPlay() 
{
	if( m_Avi.IsValid() )
	{
		m_bPlay = TRUE;
		SetTimer(1 , 1000/m_Avi.GetFrameRate() , NULL);
	}
}

void CAviView::OnUpdatePlayPlay(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable( m_Avi.IsValid() );
	pCmdUI->SetCheck( m_bPlay );
}

void CAviView::OnPlayPause() 
{
	m_bPlay = FALSE;
	KillTimer(1);
}

void CAviView::OnUpdatePlayPause(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck( !m_bPlay && m_nCurrentFrame != 0 );
}

void CAviView::OnPlayStop() 
{
	m_bPlay = FALSE;
	KillTimer(1);
	m_nCurrentFrame = 0;
	Invalidate(FALSE);
}

void CAviView::OnUpdatePlayStop(CCmdUI* pCmdUI) 
{
	// TODO: Add your command update UI handler code here

}

void CAviView::OnPlayStart() 
{
	m_nCurrentFrame = 0;
	Invalidate(FALSE);
}

void CAviView::OnPlayEnd() 
{
	m_nCurrentFrame = m_Avi.GetTotalFrame() - 1;
	Invalidate(FALSE);
}

void CAviView::OnPlayPrev() 
{
	if( m_nCurrentFrame > 0 )
		m_nCurrentFrame--;
	Invalidate(FALSE);
}

void CAviView::OnPlayNext() 
{
	if( m_nCurrentFrame < m_Avi.GetTotalFrame() - 1 )
		m_nCurrentFrame++;
	Invalidate(FALSE);
}

void CAviView::OnCapture() 
{
	CDib dib;
	m_Avi.GetFrame(m_nCurrentFrame, dib);
	AfxNewImage(dib);
}

