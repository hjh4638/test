// FirstDoc.h : CFirstDoc Ŭ������ �������̽�
//


#pragma once


class CFirstDoc : public CDocument
{
protected: // serialization������ ��������ϴ�.
	CFirstDoc();
	DECLARE_DYNCREATE(CFirstDoc)

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
	virtual ~CFirstDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ������ �޽��� �� �Լ�
protected:
	DECLARE_MESSAGE_MAP()
};


