// BmpShowDoc.h : CBmpShowDoc Ŭ������ �������̽�
//


#pragma once


class CBmpShowDoc : public CDocument
{
protected: // serialization������ ��������ϴ�.
	CBmpShowDoc();
	DECLARE_DYNCREATE(CBmpShowDoc)

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
	virtual ~CBmpShowDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ������ �޽��� �� �Լ�
protected:
	DECLARE_MESSAGE_MAP()
};


