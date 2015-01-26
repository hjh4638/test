// DibCreateView.cpp : CDibCreateView 클래스의 구현
//

#include "stdafx.h"
#include "DibCreate.h"

#include "DibCreateDoc.h"
#include "DibCreateView.h"

#include "Dib.h"

//#include "Dib.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CDibCreateView

IMPLEMENT_DYNCREATE(CDibCreateView, CView)

BEGIN_MESSAGE_MAP(CDibCreateView, CView)
	// 표준 인쇄 명령입니다.
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()

// CDibCreateView 생성/소멸

CDibCreateView::CDibCreateView()
{
	// TODO: 여기에 생성 코드를 추가합니다.

}

CDibCreateView::~CDibCreateView()
{
}

BOOL CDibCreateView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: CREATESTRUCT cs를 수정하여 여기에서
	//  Window 클래스 또는 스타일을 수정합니다.

	return CView::PreCreateWindow(cs);
}

// CDibCreateView 그리기

void CDibCreateView::OnDraw(CDC* /*pDC*/)
{
	CDibCreateDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: 여기에 원시 데이터에 대한 그리기 코드를 추가합니다.
}


// CDibCreateView 인쇄

BOOL CDibCreateView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// 기본적인 준비
	return DoPreparePrinting(pInfo);
}

void CDibCreateView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄하기 전에 추가 초기화 작업을 추가합니다.
}

void CDibCreateView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄 후 정리 작업을 추가합니다.
}


// CDibCreateView 진단

#ifdef _DEBUG
void CDibCreateView::AssertValid() const
{
	CView::AssertValid();
}

void CDibCreateView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CDibCreateDoc* CDibCreateView::GetDocument() const // 디버그되지 않은 버전은 인라인으로 지정됩니다.
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CDibCreateDoc)));
	return (CDibCreateDoc*)m_pDocument;
}
#endif //_DEBUG


// CDibCreateView 메시지 처리기

void CDibCreateView::OnLButtonDown(UINT nFlags, CPoint point)
{
	//-------------------------------------------------------------------------
	// lenna.bmp 파일로부터 DIB 구조를 읽어들인다.
	//-------------------------------------------------------------------------

	CDib dib;
	dib.Load(_T("lenna.bmp"));

	//-------------------------------------------------------------------------
	// 읽어들인 DIB를 화면에 출력한다.
	//-------------------------------------------------------------------------

	CClientDC dc(this);
	dib.Draw(dc.m_hDC, point.x, point.y);

	CView::OnLButtonDown(nFlags, point);
}
