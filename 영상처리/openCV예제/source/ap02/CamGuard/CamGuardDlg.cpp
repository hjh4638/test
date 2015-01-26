// CamGuardDlg.cpp : ���� ����
//

#include "stdafx.h"
#include "CamGuard.h"
#include "CamGuardDlg.h"

#include "Dib.h"
#include "DibColor.h"
#include "DibEnhancement.h"
#include "DibSegment.h"
#include "DibOpenCV.h"

#include <vfw.h>

#define TIMER_FRAMERATE 1
#define TIMER_TIMESPAN  2

CvCapture* capture = NULL;

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// ���� ���α׷� ������ ���Ǵ� CAboutDlg ��ȭ �����Դϴ�.

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	// ��ȭ ���� �������Դϴ�.
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV �����Դϴ�.

	// �����Դϴ�.
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CCamGuardDlg ��ȭ ����




CCamGuardDlg::CCamGuardDlg(CWnd* pParent /*=NULL*/)
: CDialog(CCamGuardDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	m_nBinaryTh = 20;
	m_nDetectTh = 10;
	m_nTimeSpan = 1000;
	m_strPathName = "C:\\";
	m_bDetected = FALSE;
}

void CCamGuardDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_BINARY_TH, m_nBinaryTh);
	DDX_Text(pDX, IDC_DETECT_TH, m_nDetectTh);
	DDX_Text(pDX, IDC_TIME_SPAN, m_nTimeSpan);
	DDX_Text(pDX, IDC_PATH_NAME, m_strPathName);
}

BEGIN_MESSAGE_MAP(CCamGuardDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_WM_DESTROY()
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_CAMERA_SETUP, &CCamGuardDlg::OnBnClickedCaptureSetup)
	ON_BN_CLICKED(IDC_CAPTURE_START, &CCamGuardDlg::OnBnClickedCaptureStart)
	ON_BN_CLICKED(IDC_CAPTURE_STOP, &CCamGuardDlg::OnBnClickedCaptureStop)
	ON_BN_CLICKED(IDC_REGISTER, &CCamGuardDlg::OnBnClickedRegister)
	ON_BN_CLICKED(IDC_BROWSE, &CCamGuardDlg::OnBnClickedBrowse)
END_MESSAGE_MAP()


// CCamGuardDlg �޽��� ó����

BOOL CCamGuardDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// �ý��� �޴��� "����..." �޴� �׸��� �߰��մϴ�.

	// IDM_ABOUTBOX�� �ý��� ��� ������ �־�� �մϴ�.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// �� ��ȭ ������ �������� �����մϴ�. ���� ���α׷��� �� â�� ��ȭ ���ڰ� �ƴ� ��쿡��
	//  �����ӿ�ũ�� �� �۾��� �ڵ����� �����մϴ�.
	SetIcon(m_hIcon, TRUE);			// ū �������� �����մϴ�.
	SetIcon(m_hIcon, FALSE);		// ���� �������� �����մϴ�.

	// TODO: ���⿡ �߰� �ʱ�ȭ �۾��� �߰��մϴ�.
	GetDlgItem(IDC_IMAGE_WND1)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND2)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND3)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND4)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);

	GetDlgItem(IDC_REGISTER)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_STOP)->EnableWindow(FALSE);

	return TRUE;  // ��Ŀ���� ��Ʈ�ѿ� �������� ������ TRUE�� ��ȯ�մϴ�.
}

void CCamGuardDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// ��ȭ ���ڿ� �ּ�ȭ ���߸� �߰��� ��� �������� �׸�����
//  �Ʒ� �ڵ尡 �ʿ��մϴ�. ����/�� ���� ����ϴ� MFC ���� ���α׷��� ��쿡��
//  �����ӿ�ũ���� �� �۾��� �ڵ����� �����մϴ�.

void CCamGuardDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // �׸��⸦ ���� ����̽� ���ؽ�Ʈ

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Ŭ���̾�Ʈ �簢������ �������� ����� ����ϴ�.
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// �������� �׸��ϴ�.
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();

		if( m_Dib1.IsValid() )
		{
			CClientDC dc1(GetDlgItem(IDC_IMAGE_WND1));
			m_Dib1.Draw(dc1.m_hDC);
		}

		if( m_Dib2.IsValid() )
		{
			CClientDC dc2(GetDlgItem(IDC_IMAGE_WND2));
			m_Dib2.Draw(dc2.m_hDC);
		}

		if( m_Dib3.IsValid() )
		{
			CClientDC dc3(GetDlgItem(IDC_IMAGE_WND3));
			m_Dib3.Draw(dc3.m_hDC);
		}

		if( m_Dib4.IsValid() )
		{
			CClientDC dc4(GetDlgItem(IDC_IMAGE_WND4));
			m_Dib4.Draw(dc4.m_hDC);
		}

		CRect rect;
		GetDlgItem(IDC_DISPLAY)->GetClientRect(rect);

		CClientDC dc5(GetDlgItem(IDC_DISPLAY));
		if( m_bDetected )
			dc5.FillSolidRect(rect, RGB(255, 0, 0));
		else
			dc5.FillSolidRect(rect, RGB(0, 255, 0));

		CString str;
		str.Format("\nCamGuard v1.0\n���� ó�� ���α׷���\nBy Visual C++");
		dc5.DrawText(str, rect, DT_CENTER);
	}
}

// ����ڰ� �ּ�ȭ�� â�� ���� ���ȿ� Ŀ���� ǥ�õǵ��� �ý��ۿ���
//  �� �Լ��� ȣ���մϴ�.
HCURSOR CCamGuardDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void CCamGuardDlg::OnTimer(UINT_PTR nIDEvent)
{
	switch( nIDEvent )
	{
	case TIMER_FRAMERATE:
	{
		IplImage* frame = cvQueryFrame(capture);
		IplImage_TO_CDib(frame, &m_Dib1);

		// ���� ������ ����� �Ǿ��ִ� ���, ħ���� �˻� ����
		if( m_Dib2.IsValid() )
			m_bDetected = CheckDetect();

		Invalidate(FALSE);

		break;
	}
	case TIMER_TIMESPAN:
	{
		// ħ���� ����Ǿ����� ���Ϸ� �����Ѵ�.
		if( m_bDetected )
			SaveDetectImage();

		break;
	}
	default:
		break;
	}

	CDialog::OnTimer(nIDEvent);
}

BOOL CCamGuardDlg::CheckDetect()
{
	CDib dib1 = m_Dib1;
	DibGrayscale(dib1);     // �׷��̽����� �������� ��ȯ

	CDib dib2 = m_Dib2;
	DibGrayscale(dib2);     // �׷��̽����� �������� ��ȯ

	DibDif(dib1, dib2, m_Dib3); // ī�޶� �Է� ����� ���� ������ �������� ����

	m_Dib4 = m_Dib3;
	DibBinarization(m_Dib4, m_nBinaryTh);
	DibMorphologyErosion(m_Dib4);
	DibMorphologyDilation(m_Dib4);

	BOOL ret = FALSE;
	int p = ObjectRatio(m_Dib4);	// ��ü �ȼ��� ������ ���
	if( p > m_nDetectTh ) 
		ret = TRUE;

	return ret;
}

int CCamGuardDlg::ObjectRatio(CDib& dib)
{
	register int i, j;

	int w = dib.GetWidth();
	int h = dib.GetHeight();

	BYTE** ptr = dib.GetPtr();

	int cnt = 0;
	for( j = 0 ; j < h ; j++ )
	for( i = 0 ; i < w ; i++ )
	{
		if( ptr[j][i] > 128 ) cnt++;
	}

	return (cnt*100/(w*h));
}

void CCamGuardDlg::SaveDetectImage()
{
	// ������ �̸��� ���� �ð��� �����Ͽ� �����Ѵ�.

	SYSTEMTIME st;
	GetLocalTime(&st);

	CString strFileName, strFullPath;
	strFileName.Format("cam_%04d%02d%02d_%02d%02d%02d_%04d.jpg", 
		st.wYear, st.wMonth, st.wDay, 
		st.wHour, st.wMinute, st.wSecond, st.wMilliseconds);
	strFullPath = m_strPathName + strFileName;

	// OpenCV �Լ��� �̿��Ͽ� JPG ���� �������� �����Ѵ�.

	IplImage* image;
	CDib_TO_IplImage(&m_Dib1, &image);
	cvSaveImage(strFullPath, image);
}

void CCamGuardDlg::OnDestroy()
{
	KillTimer(TIMER_FRAMERATE);
	KillTimer(TIMER_TIMESPAN);
	cvReleaseCapture(&capture);

	CDialog::OnDestroy();
}

void CCamGuardDlg::OnBnClickedBrowse()
{
	UpdateData(TRUE);

	// ���丮 ���� ���̾�α�
	ITEMIDLIST*     pidlBrowse;
	char            pszPathname[MAX_PATH];

	BROWSEINFO BrInfo;
	memset(&BrInfo, 0, sizeof(BrInfo));
	BrInfo.hwndOwner = this->GetSafeHwnd();
	BrInfo.pidlRoot = NULL;
	BrInfo.pszDisplayName = pszPathname;
	BrInfo.lpszTitle = "���� ������ ������ ������ �����ϼ���";
	BrInfo.ulFlags = BIF_RETURNONLYFSDIRS;

	// ���̾�α׸� ����
	pidlBrowse = SHBrowseForFolder(&BrInfo);

	if( pidlBrowse == NULL) return;

	// ������ ������ ����
	::SHGetPathFromIDList(pidlBrowse, pszPathname);	
	m_strPathName = pszPathname;

	// ���� �̸� �� �ڿ� �׻� \\ �ٿ��ֱ�
	CString strRight = m_strPathName.Right(1);
	if( strRight != "\\" )
		m_strPathName.Append("\\");

	UpdateData(FALSE);
}

void CCamGuardDlg::OnBnClickedCaptureSetup()
{
	HWND hwnd = capCreateCaptureWindow("Capture Window", 
		WS_CHILD, 0, 0, 320, 240, GetSafeHwnd(), 0);

	BOOL ret = capDriverConnect(hwnd, 0);

	if( ret == FALSE )
	{
		AfxMessageBox("ī�޶� �������� �ʽ��ϴ�.");
		return;
	}

	capDlgVideoSource(hwnd);
	capDlgVideoFormat(hwnd);
	capDriverDisconnect(hwnd);
}

void CCamGuardDlg::OnBnClickedCaptureStart()
{
	capture = cvCreateCameraCapture(0);

	if( capture == NULL )
	{
		AfxMessageBox("ī�޶� �������� �ʽ��ϴ�.");
		return;
	}

	UpdateData(TRUE);

	GetDlgItem(IDC_CAMERA_SETUP)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_START)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_STOP)->EnableWindow(TRUE);
	GetDlgItem(IDC_REGISTER)->EnableWindow(TRUE);

	// Ÿ�̸� ����
	SetTimer(TIMER_FRAMERATE, 30, NULL);
	SetTimer(TIMER_TIMESPAN, m_nTimeSpan, NULL);
}

void CCamGuardDlg::OnBnClickedCaptureStop()
{
	cvReleaseCapture(&capture);
	capture = NULL;

	m_Dib2.Destroy();
	m_Dib3.Destroy();
	m_Dib4.Destroy();

	Invalidate(TRUE);

	GetDlgItem(IDC_CAMERA_SETUP)->EnableWindow(TRUE);
	GetDlgItem(IDC_CAPTURE_START)->EnableWindow(TRUE);
	GetDlgItem(IDC_CAPTURE_STOP)->EnableWindow(FALSE);
	GetDlgItem(IDC_REGISTER)->EnableWindow(FALSE);

	KillTimer(TIMER_FRAMERATE);
	KillTimer(TIMER_TIMESPAN);
}

void CCamGuardDlg::OnBnClickedRegister()
{
	m_Dib2 = m_Dib1;
	Invalidate(FALSE);
}

