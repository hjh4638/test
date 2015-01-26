// BmpShowDoc.cpp : CBmpShowDoc 클래스의 구현
//

#include "stdafx.h"
#include "BmpShow.h"

#include "BmpShowDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CBmpShowDoc

IMPLEMENT_DYNCREATE(CBmpShowDoc, CDocument)

BEGIN_MESSAGE_MAP(CBmpShowDoc, CDocument)
END_MESSAGE_MAP()


// CBmpShowDoc 생성/소멸

CBmpShowDoc::CBmpShowDoc()
{
	// TODO: 여기에 일회성 생성 코드를 추가합니다.

}

CBmpShowDoc::~CBmpShowDoc()
{
}

BOOL CBmpShowDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: 여기에 재초기화 코드를 추가합니다.
	// SDI 문서는 이 문서를 다시 사용합니다.

	return TRUE;
}




// CBmpShowDoc serialization

void CBmpShowDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: 여기에 저장 코드를 추가합니다.
	}
	else
	{
		// TODO: 여기에 로딩 코드를 추가합니다.
	}
}


// CBmpShowDoc 진단

#ifdef _DEBUG
void CBmpShowDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CBmpShowDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CBmpShowDoc 명령
