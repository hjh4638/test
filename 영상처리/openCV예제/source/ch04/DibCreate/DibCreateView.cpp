// DibCreateView.cpp : CDibCreateView Ŭ������ ����
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
	// ǥ�� �μ� ����Դϴ�.
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()

// CDibCreateView ����/�Ҹ�

CDibCreateView::CDibCreateView()
{
	// TODO: ���⿡ ���� �ڵ带 �߰��մϴ�.

}

CDibCreateView::~CDibCreateView()
{
}

BOOL CDibCreateView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: CREATESTRUCT cs�� �����Ͽ� ���⿡��
	//  Window Ŭ���� �Ǵ� ��Ÿ���� �����մϴ�.

	return CView::PreCreateWindow(cs);
}

// CDibCreateView �׸���

void CDibCreateView::OnDraw(CDC* /*pDC*/)
{
	CDibCreateDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: ���⿡ ���� �����Ϳ� ���� �׸��� �ڵ带 �߰��մϴ�.
}


// CDibCreateView �μ�

BOOL CDibCreateView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// �⺻���� �غ�
	return DoPreparePrinting(pInfo);
}

void CDibCreateView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: �μ��ϱ� ���� �߰� �ʱ�ȭ �۾��� �߰��մϴ�.
}

void CDibCreateView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: �μ� �� ���� �۾��� �߰��մϴ�.
}


// CDibCreateView ����

#ifdef _DEBUG
void CDibCreateView::AssertValid() const
{
	CView::AssertValid();
}

void CDibCreateView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CDibCreateDoc* CDibCreateView::GetDocument() const // ����׵��� ���� ������ �ζ������� �����˴ϴ�.
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CDibCreateDoc)));
	return (CDibCreateDoc*)m_pDocument;
}
#endif //_DEBUG


// CDibCreateView �޽��� ó����

void CDibCreateView::OnLButtonDown(UINT nFlags, CPoint point)
{
	//-------------------------------------------------------------------------
	// lenna.bmp ���Ϸκ��� DIB ������ �о���δ�.
	//-------------------------------------------------------------------------

	CDib dib;
	dib.Load(_T("lenna.bmp"));

	//-------------------------------------------------------------------------
	// �о���� DIB�� ȭ�鿡 ����Ѵ�.
	//-------------------------------------------------------------------------

	CClientDC dc(this);
	dib.Draw(dc.m_hDC, point.x, point.y);

	CView::OnLButtonDown(nFlags, point);
}
