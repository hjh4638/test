// BmpShowView.h : CBmpShowView Ŭ������ �������̽�
//


#pragma once


class CBmpShowView : public CView
{
protected: // serialization������ ��������ϴ�.
	CBmpShowView();
	DECLARE_DYNCREATE(CBmpShowView)

// Ư���Դϴ�.
public:
	CBmpShowDoc* GetDocument() const;

// �۾��Դϴ�.
public:

// �������Դϴ�.
public:
	virtual void OnDraw(CDC* pDC);  // �� �並 �׸��� ���� �����ǵǾ����ϴ�.
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// �����Դϴ�.
public:
	virtual ~CBmpShowView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ������ �޽��� �� �Լ�
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
};

#ifndef _DEBUG  // BmpShowView.cpp�� ����� ����
inline CBmpShowDoc* CBmpShowView::GetDocument() const
   { return reinterpret_cast<CBmpShowDoc*>(m_pDocument); }
#endif

