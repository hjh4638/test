// BmpShowDoc.cpp : CBmpShowDoc Ŭ������ ����
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


// CBmpShowDoc ����/�Ҹ�

CBmpShowDoc::CBmpShowDoc()
{
	// TODO: ���⿡ ��ȸ�� ���� �ڵ带 �߰��մϴ�.

}

CBmpShowDoc::~CBmpShowDoc()
{
}

BOOL CBmpShowDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: ���⿡ ���ʱ�ȭ �ڵ带 �߰��մϴ�.
	// SDI ������ �� ������ �ٽ� ����մϴ�.

	return TRUE;
}




// CBmpShowDoc serialization

void CBmpShowDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: ���⿡ ���� �ڵ带 �߰��մϴ�.
	}
	else
	{
		// TODO: ���⿡ �ε� �ڵ带 �߰��մϴ�.
	}
}


// CBmpShowDoc ����

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


// CBmpShowDoc ���
