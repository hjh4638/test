// BmpShowView.cpp : CBmpShowView 클래스의 구현
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
	// 표준 인쇄 명령입니다.
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()

// CBmpShowView 생성/소멸

CBmpShowView::CBmpShowView()
{
	// TODO: 여기에 생성 코드를 추가합니다.

}

CBmpShowView::~CBmpShowView()
{
}

BOOL CBmpShowView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: CREATESTRUCT cs를 수정하여 여기에서
	//  Window 클래스 또는 스타일을 수정합니다.

	return CView::PreCreateWindow(cs);
}

// CBmpShowView 그리기

void CBmpShowView::OnDraw(CDC* /*pDC*/)
{
	CBmpShowDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: 여기에 원시 데이터에 대한 그리기 코드를 추가합니다.
}


// CBmpShowView 인쇄

BOOL CBmpShowView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// 기본적인 준비
	return DoPreparePrinting(pInfo);
}

void CBmpShowView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄하기 전에 추가 초기화 작업을 추가합니다.
}

void CBmpShowView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄 후 정리 작업을 추가합니다.
}


// CBmpShowView 진단

#ifdef _DEBUG
void CBmpShowView::AssertValid() const
{
	CView::AssertValid();
}

void CBmpShowView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CBmpShowDoc* CBmpShowView::GetDocument() const // 디버그되지 않은 버전은 인라인으로 지정됩니다.
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CBmpShowDoc)));
	return (CBmpShowDoc*)m_pDocument;
}
#endif //_DEBUG


// CBmpShowView 메시지 처리기

void CBmpShowView::OnLButtonDown(UINT nFlags, CPoint point)
{
	//-------------------------------------------------------------------------
	// lenna.bmp 파일로부터 DIB 구조를 읽어들인다.
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
	// 읽어들인 DIB를 화면에 출력한다.
	//-------------------------------------------------------------------------

	BITMAPINFOHEADER* lpbmih;
	BYTE* lpvBits;
	int w, h, c;

	lpbmih = (BITMAPINFOHEADER*)pDib;
	w = lpbmih->biWidth;
	h = lpbmih->biHeight;
	c = lpbmih->biBitCount;

	// 비트맵 정보 시작 위치를 계산한다.
	if( c == 24 )
		lpvBits = (BYTE*)pDib + sizeof(BITMAPINFOHEADER);
	else
		lpvBits = (BYTE*)pDib + sizeof(BITMAPINFOHEADER) 
		+ sizeof(RGBQUAD)*(1<<c);

	// DC를 얻어온다.
	CClientDC dc(this);

	::SetDIBitsToDevice(dc.m_hDC, point.x, point.y, w, h, 0, 0, 0, h,
		lpvBits, (BITMAPINFO*)pDib, DIB_RGB_COLORS);

	// 동적 할당한 메모리를 해제한다.
	delete [] pDib;

	CView::OnLButtonDown(nFlags, point);
}

