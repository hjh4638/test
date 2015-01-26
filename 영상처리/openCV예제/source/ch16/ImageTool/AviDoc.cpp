// AviDoc.cpp : ���� �����Դϴ�.
//

#include "stdafx.h"
#include "ImageTool.h"
#include "AviDoc.h"
#include "AviView.h"


// CAviDoc

IMPLEMENT_DYNCREATE(CAviDoc, CDocument)

CAviDoc::CAviDoc()
{
}

CAviDoc::~CAviDoc()
{
}


BEGIN_MESSAGE_MAP(CAviDoc, CDocument)
	ON_COMMAND(ID_FILE_NEW, &CAviDoc::OnFileNew)
END_MESSAGE_MAP()


// CAviDoc �����Դϴ�.

#ifdef _DEBUG
void CAviDoc::AssertValid() const
{
	CDocument::AssertValid();
}

#ifndef _WIN32_WCE
void CAviDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif
#endif //_DEBUG

#ifndef _WIN32_WCE
// CAviDoc serialization�Դϴ�.

void CAviDoc::Serialize(CArchive& ar)
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
#endif


// CAviDoc ����Դϴ�.

BOOL CAviDoc::OnNewDocument()
{
	return FALSE;
}

BOOL CAviDoc::OnOpenDocument(LPCTSTR lpszPathName)
{
	if (!CDocument::OnOpenDocument(lpszPathName))
		return FALSE;

	// TODO:  ���⿡ Ư��ȭ�� �ۼ� �ڵ带 �߰��մϴ�.
	BOOL ret = FALSE;
	POSITION pos = GetFirstViewPosition();
	if( pos != NULL )
	{
		CAviView* pView = (CAviView*)GetNextView(pos);
		ret = pView->AviFileOpen(lpszPathName);
	}

	return ret;
}

BOOL CAviDoc::OnSaveDocument(LPCTSTR lpszPathName)
{
	return FALSE;
}

void CAviDoc::OnFileNew()
{
	theApp.m_pImageDocTemplate->OpenDocumentFile(NULL);
}
