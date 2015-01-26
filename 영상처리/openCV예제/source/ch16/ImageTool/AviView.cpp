// AviView.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "ImageTool.h"
#include "AviDoc.h"
#include "AviView.h"
#include "Avi.h"

#include "Dib.h"
#include "DibEnhancement.h"
#include "DibColor.h"
#include "DibFullSearch.h"

// CAviView

IMPLEMENT_DYNCREATE(CAviView, CScrollView)

CAviView::CAviView()
{
	m_nCurrentFrame = 0;
	m_bPlay = FALSE;

	m_nMode = ID_MODE_NORMAL;
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
	ON_COMMAND(ID_MODE_NORMAL, &CAviView::OnModeNormal)
	ON_UPDATE_COMMAND_UI(ID_MODE_NORMAL, &CAviView::OnUpdateModeNormal)
	ON_COMMAND(ID_MODE_DIFFERENCE, &CAviView::OnModeDifference)
	ON_UPDATE_COMMAND_UI(ID_MODE_DIFFERENCE, &CAviView::OnUpdateModeDifference)
	ON_COMMAND(ID_MODE_MOTION, &CAviView::OnModeMotion)
	ON_UPDATE_COMMAND_UI(ID_MODE_MOTION, &CAviView::OnUpdateModeMotion)
END_MESSAGE_MAP()


// CAviView 그리기입니다.

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
	// TODO: 여기에 그리기 코드를 추가합니다.

	if( m_Avi.IsValid() )
	{
		switch( m_nMode )
		{
		case ID_MODE_NORMAL:
			m_Avi.DrawFrame(pDC->m_hDC, m_nCurrentFrame);
			break;
		case ID_MODE_DIFFERENCE:
			if( m_nCurrentFrame > 0 )
			{
				CDib dib1, dib2, dib3;
				m_Avi.GetFrame(m_nCurrentFrame-1, dib1);
				m_Avi.GetFrame(m_nCurrentFrame, dib2);

				if( dib1.GetBitCount() == 24 ) DibGrayscale(dib1);
				if( dib2.GetBitCount() == 24 ) DibGrayscale(dib2);

				DibDif(dib1, dib2, dib3);
				dib3.Draw(pDC->m_hDC);
				break;
			}
			else
			{
				m_Avi.DrawFrame(pDC->m_hDC, m_nCurrentFrame);
			}
			break;
		case ID_MODE_MOTION:
			if( m_nCurrentFrame > 0 )
			{
				CDib dib1, dib2, dib3;
				m_Avi.GetFrame(m_nCurrentFrame-1, dib1);
				m_Avi.GetFrame(m_nCurrentFrame, dib2);

				if( dib1.GetBitCount() == 24 ) DibGrayscale(dib1);
				if( dib2.GetBitCount() == 24 ) DibGrayscale(dib2);

				CDibFullSearch fs;
				fs.SetImages(&dib1, &dib2);
				fs.FullSearch();
				fs.GetMotionImage(dib3);
				dib3.Draw(pDC->m_hDC);
				break;
			}
			else
			{
				m_Avi.DrawFrame(pDC->m_hDC, m_nCurrentFrame);
			}
			break;
		}
	}
}


// CAviView 진단입니다.

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


// CAviView 메시지 처리기입니다.

BOOL CAviView::AviFileOpen(LPCTSTR lpszPathName)
{
	// AVI 파일을 열지 못한 경우, 메시지 출력하고 그냥 리턴
	if( !m_Avi.Open(lpszPathName) )
	{
		AfxMessageBox(_T("Avi 파일을 열 수 없습니다."));
		return FALSE;
	}

	m_nCurrentFrame = 0;

	return TRUE;
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
			m_bPlay = FALSE;
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
	pCmdUI->SetCheck( !m_bPlay  && m_nCurrentFrame == 0);
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

void CAviView::OnModeNormal()
{
	m_nMode = ID_MODE_NORMAL;
	Invalidate(FALSE);
}

void CAviView::OnUpdateModeNormal(CCmdUI *pCmdUI)
{
	pCmdUI->SetCheck( m_nMode == ID_MODE_NORMAL );
}

void CAviView::OnModeDifference()
{
	m_nMode = ID_MODE_DIFFERENCE;
	Invalidate(FALSE);
}

void CAviView::OnUpdateModeDifference(CCmdUI *pCmdUI)
{
	pCmdUI->SetCheck( m_nMode == ID_MODE_DIFFERENCE );
}

void CAviView::OnModeMotion()
{
	m_nMode = ID_MODE_MOTION;
	Invalidate(FALSE);
}

void CAviView::OnUpdateModeMotion(CCmdUI *pCmdUI)
{
	pCmdUI->SetCheck( m_nMode == ID_MODE_MOTION );
}
