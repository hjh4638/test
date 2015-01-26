// DibCreateView.h : CDibCreateView Ŭ������ �������̽�
//


#pragma once


class CDibCreateView : public CView
{
protected: // serialization������ ��������ϴ�.
	CDibCreateView();
	DECLARE_DYNCREATE(CDibCreateView)

// Ư���Դϴ�.
public:
	CDibCreateDoc* GetDocument() const;

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
	virtual ~CDibCreateView();
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

#ifndef _DEBUG  // DibCreateView.cpp�� ����� ����
inline CDibCreateDoc* CDibCreateView::GetDocument() const
   { return reinterpret_cast<CDibCreateDoc*>(m_pDocument); }
#endif

