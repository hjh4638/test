// DibCreateDoc.h : CDibCreateDoc Ŭ������ �������̽�
//


#pragma once


class CDibCreateDoc : public CDocument
{
protected: // serialization������ ��������ϴ�.
	CDibCreateDoc();
	DECLARE_DYNCREATE(CDibCreateDoc)

// Ư���Դϴ�.
public:

// �۾��Դϴ�.
public:

// �������Դϴ�.
public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);

// �����Դϴ�.
public:
	virtual ~CDibCreateDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ������ �޽��� �� �Լ�
protected:
	DECLARE_MESSAGE_MAP()
};


