// FirstDoc.cpp : CFirstDoc 클래스의 구현
//

#include "stdafx.h"
#include "First.h"

#include "FirstDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CFirstDoc

IMPLEMENT_DYNCREATE(CFirstDoc, CDocument)

BEGIN_MESSAGE_MAP(CFirstDoc, CDocument)
END_MESSAGE_MAP()


// CFirstDoc 생성/소멸

CFirstDoc::CFirstDoc()
{
	// TODO: 여기에 일회성 생성 코드를 추가합니다.

}

CFirstDoc::~CFirstDoc()
{
}

BOOL CFirstDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: 여기에 재초기화 코드를 추가합니다.
	// SDI 문서는 이 문서를 다시 사용합니다.

	return TRUE;
}




// CFirstDoc serialization

void CFirstDoc::Serialize(CArchive& ar)
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


// CFirstDoc 진단

#ifdef _DEBUG
void CFirstDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CFirstDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CFirstDoc 명령
