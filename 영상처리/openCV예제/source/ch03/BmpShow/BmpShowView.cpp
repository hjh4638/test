// BmpShowView.cpp : CBmpShowView Ŭ������ ����
//

#include "stdafx.h"
#include "BmpShow.h"

#include "BmpShowDoc.h"
#include "BmpShowView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CBmpShowView

IMPLEMENT_DYNCREATE(CBmpShowView, CView)

BEGIN_MESSAGE_MAP(CBmpShowView, CView)
	// ǥ�� �μ� ����Դϴ�.
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()

// CBmpShowView ����/�Ҹ�

CBmpShowView::CBmpShowView()
{
	// TODO: ���⿡ ���� �ڵ带 �߰��մϴ�.

}

CBmpShowView::~CBmpShowView()
{
}

BOOL CBmpShowView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: CREATESTRUCT cs�� �����Ͽ� ���⿡��
	//  Window Ŭ���� �Ǵ� ��Ÿ���� �����մϴ�.

	return CView::PreCreateWindow(cs);
}

// CBmpShowView �׸���

void CBmpShowView::OnDraw(CDC* /*pDC*/)
{
	CBmpShowDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: ���⿡ ���� �����Ϳ� ���� �׸��� �ڵ带 �߰��մϴ�.
}


// CBmpShowView �μ�

BOOL CBmpShowView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// �⺻���� �غ�
	return DoPreparePrinting(pInfo);
}

void CBmpShowView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: �μ��ϱ� ���� �߰� �ʱ�ȭ �۾��� �߰��մϴ�.
}

void CBmpShowView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: �μ� �� ���� �۾��� �߰��մϴ�.
}


// CBmpShowView ����

#ifdef _DEBUG
void CBmpShowView::AssertValid() const
{
	CView::AssertValid();
}

void CBmpShowView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CBmpShowDoc* CBmpShowView::GetDocument() const // ����׵��� ���� ������ �ζ������� �����˴ϴ�.
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CBmpShowDoc)));
	return (CBmpShowDoc*)m_pDocument;
}
#endif //_DEBUG


// CBmpShowView �޽��� ó����

void CBmpShowView::OnLButtonDown(UINT nFlags, CPoint point)
{
	//-------------------------------------------------------------------------
	// lenna.bmp ���Ϸκ��� DIB ������ �о���δ�.
	//-------------------------------------------------------------------------
	
	CFile file;
	BITMAPFILEHEADER bmfh;
	DWORD dwFileSize, dwDibSize;
	BYTE* pDib;

	file.Open(_T("lenna.bmp"), CFile::modeRead | CFile::shareDenyWrite, NULL);

	dwFileSize = (DWORD)file.GetLength();
	dwDibSize = dwFileSize - sizeof(BITMAPFILEHEADER);

	pDib = new BYTE[dwDibSize];

	file.Read(&bmfh, sizeof(BITMAPFILEHEADER));
	file.Read(pDib, dwDibSize);

	file.Close();

	//-------------------------------------------------------------------------
	// �о���� DIB�� ȭ�鿡 ����Ѵ�.
	//-------------------------------------------------------------------------

	BITMAPINFOHEADER* lpbmih;
	BYTE* lpvBits;
	int w, h, c;

	lpbmih = (BITMAPINFOHEADER*)pDib;
	w = lpbmih->biWidth;
	h = lpbmih->biHeight;
	c = lpbmih->biBitCount;

	// ��Ʈ�� ���� ���� ��ġ�� ����Ѵ�.
	if( c == 24 )
		lpvBits = (BYTE*)pDib + sizeof(BITMAPINFOHEADER);
	else
		lpvBits = (BYTE*)pDib + sizeof(BITMAPINFOHEADER) 
		+ sizeof(RGBQUAD)*(1<<c);

	// DC�� ���´�.
	CClientDC dc(this);

	::SetDIBitsToDevice(dc.m_hDC, point.x, point.y, w, h, 0, 0, 0, h,
		lpvBits, (BITMAPINFO*)pDib, DIB_RGB_COLORS);

	// ���� �Ҵ��� �޸𸮸� �����Ѵ�.
	delete [] pDib;

	CView::OnLButtonDown(nFlags, point);
}

