// ImageToolDoc.cpp : CImageToolDoc 클래스의 구현
//

#include "stdafx.h"
#include "ImageTool.h"

#include "ImageToolDoc.h"

#include "Dib.h"
#include "DibEnhancement.h"
#include "DibFilter.h"
#include "DibGeometry.h"

#include "FileNewDlg.h"
#include "BrightnessDlg.h"
#include "ContrastDlg.h"
#include "GammaCorrectionDlg.h"
#include "HistogramDlg.h"
#include "ArithmeticDlg.h"
#include "GaussianDlg.h"
#include "AddNoiseDlg.h"
#include "DiffusionDlg.h"
#include "TranslateDlg.h"
#include "ResizeDlg.h"
#include "RotateDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CImageToolDoc

IMPLEMENT_DYNCREATE(CImageToolDoc, CDocument)

BEGIN_MESSAGE_MAP(CImageToolDoc, CDocument)
	ON_COMMAND(ID_WINDOW_DUPLICATE, &CImageToolDoc::OnWindowDuplicate)
	ON_COMMAND(ID_EDIT_COPY, &CImageToolDoc::OnEditCopy)
	ON_COMMAND(ID_IMAGE_INVERSE, &CImageToolDoc::OnImageInverse)
	ON_COMMAND(ID_IMAGE_BRIGHTNESS, &CImageToolDoc::OnImageBrightness)
	ON_COMMAND(ID_IMAGE_CONTRAST, &CImageToolDoc::OnImageContrast)
	ON_COMMAND(ID_GAMMA_CORRECTION, &CImageToolDoc::OnGammaCorrection)
	ON_COMMAND(ID_VIEW_HISTOGRAM, &CImageToolDoc::OnViewHistogram)
	ON_COMMAND(ID_HISTO_EQUALIZE, &CImageToolDoc::OnHistoEqualize)
	ON_COMMAND(ID_IMAGE_ARITHMETIC, &CImageToolDoc::OnImageArithmetic)
	ON_COMMAND(ID_BITPLANE_SLICING, &CImageToolDoc::OnBitplaneSlicing)
	ON_COMMAND(ID_FILTER_MEAN, &CImageToolDoc::OnFilterMean)
	ON_COMMAND(ID_FILTER_WEIGHTED_MEAN, &CImageToolDoc::OnFilterWeightedMean)
	ON_COMMAND(ID_FILTER_GAUSSIAN, &CImageToolDoc::OnFilterGaussian)
	ON_COMMAND(ID_FILTER_UNSHARP_MASK, &CImageToolDoc::OnFilterUnsharpMask)
	ON_COMMAND(ID_ADD_NOISE, &CImageToolDoc::OnAddNoise)
	ON_COMMAND(ID_FILTER_MEDIAN, &CImageToolDoc::OnFilterMedian)
	ON_COMMAND(ID_FILTER_DIFFUSION, &CImageToolDoc::OnFilterDiffusion)
	ON_COMMAND(ID_FILTER_LAPLACIAN, &CImageToolDoc::OnFilterLaplacian)
	ON_COMMAND(ID_IMAGE_TRANSLATION, &CImageToolDoc::OnImageTranslation)
	ON_COMMAND(ID_IMAGE_RESIZE, &CImageToolDoc::OnImageResize)
	ON_COMMAND(ID_IMAGE_ROTATE, &CImageToolDoc::OnImageRotate)
	ON_COMMAND(ID_IMAGE_MIRROR, &CImageToolDoc::OnImageMirror)
	ON_COMMAND(ID_IMAGE_FLIP, &CImageToolDoc::OnImageFlip)
END_MESSAGE_MAP()


// CImageToolDoc 생성/소멸

CImageToolDoc::CImageToolDoc()
{
	// TODO: 여기에 일회성 생성 코드를 추가합니다.

}

CImageToolDoc::~CImageToolDoc()
{
}

BOOL CImageToolDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	BOOL bSuccess = TRUE;

	if( theApp.m_pNewDib != NULL )
	{
		m_Dib.Copy(theApp.m_pNewDib);
		theApp.m_pNewDib = NULL;
	}
	else
	{
		CFileNewDlg dlg;
		if( dlg.DoModal() == IDOK )
		{
			if( dlg.m_nType == 0 ) // 그레이스케일 이미지
				bSuccess = m_Dib.CreateGrayImage(dlg.m_nWidth, dlg.m_nHeight);
			else // 트루칼라 이미지
				bSuccess = m_Dib.CreateRGBImage(dlg.m_nWidth, dlg.m_nHeight);
		}
		else
		{
			bSuccess = FALSE;
		}
	}

	return bSuccess;
}

// CImageToolDoc serialization

void CImageToolDoc::Serialize(CArchive& ar)
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


// CImageToolDoc 진단

#ifdef _DEBUG
void CImageToolDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CImageToolDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CImageToolDoc 명령


BOOL CImageToolDoc::OnOpenDocument(LPCTSTR lpszPathName)
{
	if (!CDocument::OnOpenDocument(lpszPathName))
		return FALSE;

	return  m_Dib.Load(lpszPathName);
}

BOOL CImageToolDoc::OnSaveDocument(LPCTSTR lpszPathName)
{
	return  m_Dib.Save(lpszPathName);
}

void CImageToolDoc::OnWindowDuplicate()
{
	AfxNewImage(m_Dib);
}

void CImageToolDoc::OnEditCopy()
{
	if( m_Dib.IsValid() )
		m_Dib.CopyToClipboard();
}

void CImageToolDoc::OnImageInverse()
{
	CDib dib = m_Dib;
	DibInverse(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnImageBrightness()
{
	CBrightnessDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibBrightness(dib, dlg.m_nBrightness);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnImageContrast()
{
	CContrastDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibContrast(dib, dlg.m_nContrast);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnGammaCorrection()
{
	CGammaCorrectionDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibGammaCorrection(dib, dlg.m_fGamma);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnViewHistogram()
{
	CHistogramDlg dlg;
	dlg.SetImage(m_Dib);
	dlg.DoModal();
}

void CImageToolDoc::OnHistoEqualize()
{
	CDib dib = m_Dib;
	DibHistEqual(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnImageArithmetic()
{
	CArithmeticDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CImageToolDoc* pDoc1 = (CImageToolDoc*)dlg.m_pDoc1;
		CImageToolDoc* pDoc2 = (CImageToolDoc*)dlg.m_pDoc2;

		CDib dib;
		BOOL ret = FALSE;

		switch( dlg.m_nFunction )
		{
		case 0: ret = DibAdd(pDoc1->m_Dib, pDoc2->m_Dib, dib); break;
		case 1: ret = DibSub(pDoc1->m_Dib, pDoc2->m_Dib, dib); break;
		case 2: ret = DibAve(pDoc1->m_Dib, pDoc2->m_Dib, dib); break;
		case 3: ret = DibDif(pDoc1->m_Dib, pDoc2->m_Dib, dib); break;
		case 4: ret = DibAND(pDoc1->m_Dib, pDoc2->m_Dib, dib); break;
		case 5: ret = DibOR(pDoc1->m_Dib, pDoc2->m_Dib, dib);  break;
		}

		if( ret )
			AfxNewImage(dib);
		else
			AfxMessageBox(_T("영상의 크기가 다릅니다!"));
	}
}

void CImageToolDoc::OnBitplaneSlicing()
{
	register int i;

	int w = m_Dib.GetWidth();
	int h = m_Dib.GetHeight();

	CDib dib;
	dib.CreateGrayImage(w, h);

	for( i = 0 ; i < 8 ; i++ )
	{
		DibBitPlane(m_Dib, i, dib);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnFilterMean()
{
	CDib dib = m_Dib;
	DibFilterMean(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnFilterWeightedMean()
{
	CDib dib = m_Dib;
	DibFilterWeightedMean(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnFilterGaussian()
{
	CGaussianDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibFilterGaussian(dib, dlg.m_fSigma);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnFilterLaplacian()
{
	CDib dib = m_Dib;
	DibFilterLaplacian(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnFilterUnsharpMask()
{
	CDib dib = m_Dib;
	DibFilterUnsharpMask(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnAddNoise()
{
	CAddNoiseDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;

		if( dlg.m_nNoiseType == 0 )
			DibNoiseGaussian(dib, dlg.m_nAmount);
		else
			DibNoiseSaltNPepper(dib, dlg.m_nAmount);

		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnFilterMedian()
{
	CDib dib = m_Dib;
	DibFilterMedean(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnFilterDiffusion()
{
	CDiffusionDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibFilterDiffusion(dib, dlg.m_fLambda, dlg.m_fK, dlg.m_nIteration);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnImageTranslation()
{
	CTranslateDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		DibTranslate(dib, dlg.m_nNewSX, dlg.m_nNewSY);
		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnImageResize()
{
	CResizeDlg dlg;
	dlg.m_nOldWidth = m_Dib.GetWidth();
	dlg.m_nOldHeight = m_Dib.GetHeight();
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		switch( dlg.m_nInterpolation )
		{
		case 0: DibResizeNearest(dib, dlg.m_nNewWidth, dlg.m_nNewHeight); break;
		case 1: DibResizeBilinear(dib, dlg.m_nNewWidth, dlg.m_nNewHeight); break;
		case 2: DibResizeCubic(dib, dlg.m_nNewWidth, dlg.m_nNewHeight); break;
		}

		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnImageRotate()
{
	CRotateDlg dlg;
	if( dlg.DoModal() == IDOK )
	{
		CDib dib = m_Dib;
		switch( dlg.m_nRotate )
		{
		case 0: DibRotate90(dib); break;
		case 1: DibRotate180(dib); break;
		case 2: DibRotate270(dib); break;
		case 3: DibRotate(dib, (double)dlg.m_fAngle); break;
		}

		AfxNewImage(dib);
	}
}

void CImageToolDoc::OnImageMirror()
{
	CDib dib = m_Dib;
	DibMirror(dib);
	AfxNewImage(dib);
}

void CImageToolDoc::OnImageFlip()
{
	CDib dib = m_Dib;
	DibFlip(dib);
	AfxNewImage(dib);
}
