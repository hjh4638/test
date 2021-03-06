// ImageToolDoc.h : CImageToolDoc 클래스의 인터페이스
//


#pragma once
#include "dib.h"


class CImageToolDoc : public CDocument
{
protected: // serialization에서만 만들어집니다.
	CImageToolDoc();
	DECLARE_DYNCREATE(CImageToolDoc)

// 특성입니다.
public:

// 작업입니다.
public:

// 재정의입니다.
public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);

// 구현입니다.
public:
	virtual ~CImageToolDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 생성된 메시지 맵 함수
protected:
	DECLARE_MESSAGE_MAP()

public:
	// 이미지 객체
	CDib m_Dib;

	// 파일 불러오기 & 저장하기
	virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
	virtual BOOL OnSaveDocument(LPCTSTR lpszPathName);

public:
	// 5장에서 추가한 함수
	afx_msg void OnWindowDuplicate();
	afx_msg void OnEditCopy();

	// 6장에서 추가한 함수
	afx_msg void OnImageInverse();
	afx_msg void OnImageBrightness();
	afx_msg void OnImageContrast();
	afx_msg void OnGammaCorrection();
	afx_msg void OnViewHistogram();
	afx_msg void OnHistoEqualize();

	// 7장에서 추가한 함수
	afx_msg void OnImageArithmetic();
	afx_msg void OnBitplaneSlicing();

	// 8장에서 추가한 함수
	afx_msg void OnFilterMean();
	afx_msg void OnFilterWeightedMean();
	afx_msg void OnFilterGaussian();
	afx_msg void OnFilterLaplacian();
	afx_msg void OnFilterUnsharpMask();
	afx_msg void OnAddNoise();
	afx_msg void OnFilterMedian();
	afx_msg void OnFilterDiffusion();

	// 9장에서 추가한 함수
	afx_msg void OnImageTranslation();
	afx_msg void OnImageResize();
	afx_msg void OnImageRotate();
	afx_msg void OnImageMirror();
	afx_msg void OnImageFlip();

	// 10장에서 추가한 함수
	afx_msg void OnFourierDft();
	afx_msg void OnFourierDftrc();
	afx_msg void OnFourierFft();
	afx_msg void OnIdealLowpass();
	afx_msg void OnIdealHighpass();
	afx_msg void OnGaussianLowpass();
	afx_msg void OnGaussianHighpass();

	// 11장에서 추가한 함수
	afx_msg void OnEdgeRoberts();
	afx_msg void OnEdgePrewitt();
	afx_msg void OnEdgeSobel();
	afx_msg void OnHoughLine();
	afx_msg void OnHarrisCorner();

	// 12장에서 추가한 함수
	afx_msg void OnColorGrayscale();
	afx_msg void OnUpdateColorGrayscale(CCmdUI *pCmdUI);
	afx_msg void OnColorSplitRgb();
	afx_msg void OnUpdateColorSplitRgb(CCmdUI *pCmdUI);
	afx_msg void OnColorSplitHsi();
	afx_msg void OnUpdateColorSplitHsi(CCmdUI *pCmdUI);
	afx_msg void OnColorSplitYuv();
	afx_msg void OnUpdateColorSplitYuv(CCmdUI *pCmdUI);
	afx_msg void OnColorCombineRgb();
	afx_msg void OnColorCombineHsi();
	afx_msg void OnColorCombineYuv();
	afx_msg void OnColorEdge();
	afx_msg void OnUpdateColorEdge(CCmdUI *pCmdUI);
	afx_msg void OnColorEqualize();
	afx_msg void OnUpdateColorEqualize(CCmdUI *pCmdUI);

	// 13장에서 추가한 함수
	afx_msg void OnSegmentBinarization();
	afx_msg void OnBinarizationIterative();
	afx_msg void OnSegmentLabeling();
	afx_msg void OnContourTracing();
};
