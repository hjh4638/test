// DibCreateDoc.cpp : CDibCreateDoc Ŭ������ ����
//

#include "stdafx.h"
#include "DibCreate.h"

#include "DibCreateDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CDibCreateDoc

IMPLEMENT_DYNCREATE(CDibCreateDoc, CDocument)

BEGIN_MESSAGE_MAP(CDibCreateDoc, CDocument)
END_MESSAGE_MAP()


// CDibCreateDoc ����/�Ҹ�

CDibCreateDoc::CDibCreateDoc()
{
	// TODO: ���⿡ ��ȸ�� ���� �ڵ带 �߰��մϴ�.

}

CDibCreateDoc::~CDibCreateDoc()
{
}

BOOL CDibCreateDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: ���⿡ ���ʱ�ȭ �ڵ带 �߰��մϴ�.
	// SDI ������ �� ������ �ٽ� ����մϴ�.

	return TRUE;
}




// CDibCreateDoc serialization

void CDibCreateDoc::Serialize(CArchive& ar)
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


// CDibCreateDoc ����

#ifdef _DEBUG
void CDibCreateDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CDibCreateDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CDibCreateDoc ���
