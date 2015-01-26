// CamGuardDlg.cpp : 구현 파일
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

// 응용 프로그램 정보에 사용되는 CAboutDlg 대화 상자입니다.

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	// 대화 상자 데이터입니다.
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	// 구현입니다.
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


// CCamGuardDlg 대화 상자




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


// CCamGuardDlg 메시지 처리기

BOOL CCamGuardDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 시스템 메뉴에 "정보..." 메뉴 항목을 추가합니다.

	// IDM_ABOUTBOX는 시스템 명령 범위에 있어야 합니다.
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

	// 이 대화 상자의 아이콘을 설정합니다. 응용 프로그램의 주 창이 대화 상자가 아닐 경우에는
	//  프레임워크가 이 작업을 자동으로 수행합니다.
	SetIcon(m_hIcon, TRUE);			// 큰 아이콘을 설정합니다.
	SetIcon(m_hIcon, FALSE);		// 작은 아이콘을 설정합니다.

	// TODO: 여기에 추가 초기화 작업을 추가합니다.
	GetDlgItem(IDC_IMAGE_WND1)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND2)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND3)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);
	GetDlgItem(IDC_IMAGE_WND4)->SetWindowPos(NULL, 0, 0, 320, 240, SWP_NOZORDER|SWP_NOMOVE);

	GetDlgItem(IDC_REGISTER)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_STOP)->EnableWindow(FALSE);

	return TRUE;  // 포커스를 컨트롤에 설정하지 않으면 TRUE를 반환합니다.
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

// 대화 상자에 최소화 단추를 추가할 경우 아이콘을 그리려면
//  아래 코드가 필요합니다. 문서/뷰 모델을 사용하는 MFC 응용 프로그램의 경우에는
//  프레임워크에서 이 작업을 자동으로 수행합니다.

void CCamGuardDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 그리기를 위한 디바이스 컨텍스트

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 클라이언트 사각형에서 아이콘을 가운데에 맞춥니다.
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 아이콘을 그립니다.
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
		str.Format("\nCamGuard v1.0\n영상 처리 프로그래밍\nBy Visual C++");
		dc5.DrawText(str, rect, DT_CENTER);
	}
}

// 사용자가 최소화된 창을 끄는 동안에 커서가 표시되도록 시스템에서
//  이 함수를 호출합니다.
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

		// 기준 영상이 등록이 되어있는 경우, 침입자 검사 수행
		if( m_Dib2.IsValid() )
			m_bDetected = CheckDetect();

		Invalidate(FALSE);

		break;
	}
	case TIMER_TIMESPAN:
	{
		// 침입자 검출되었으면 파일로 저장한다.
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
	DibGrayscale(dib1);     // 그레이스케일 영상으로 변환

	CDib dib2 = m_Dib2;
	DibGrayscale(dib2);     // 그레이스케일 영상으로 변환

	DibDif(dib1, dib2, m_Dib3); // 카메라 입력 영상과 기준 영상의 차영상을 생성

	m_Dib4 = m_Dib3;
	DibBinarization(m_Dib4, m_nBinaryTh);
	DibMorphologyErosion(m_Dib4);
	DibMorphologyDilation(m_Dib4);

	BOOL ret = FALSE;
	int p = ObjectRatio(m_Dib4);	// 객체 픽셀의 비율을 계산
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
	// 파일의 이름은 현재 시간을 참고하여 생성한다.

	SYSTEMTIME st;
	GetLocalTime(&st);

	CString strFileName, strFullPath;
	strFileName.Format("cam_%04d%02d%02d_%02d%02d%02d_%04d.jpg", 
		st.wYear, st.wMonth, st.wDay, 
		st.wHour, st.wMinute, st.wSecond, st.wMilliseconds);
	strFullPath = m_strPathName + strFileName;

	// OpenCV 함수를 이용하여 JPG 파일 포맷으로 저장한다.

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

	// 디렉토리 선택 다이얼로그
	ITEMIDLIST*     pidlBrowse;
	char            pszPathname[MAX_PATH];

	BROWSEINFO BrInfo;
	memset(&BrInfo, 0, sizeof(BrInfo));
	BrInfo.hwndOwner = this->GetSafeHwnd();
	BrInfo.pidlRoot = NULL;
	BrInfo.pszDisplayName = pszPathname;
	BrInfo.lpszTitle = "감시 영상을 저장할 폴더를 선택하세요";
	BrInfo.ulFlags = BIF_RETURNONLYFSDIRS;

	// 다이얼로그를 띄우기
	pidlBrowse = SHBrowseForFolder(&BrInfo);

	if( pidlBrowse == NULL) return;

	// 선택한 폴더를 얻어옴
	::SHGetPathFromIDList(pidlBrowse, pszPathname);	
	m_strPathName = pszPathname;

	// 폴더 이름 맨 뒤에 항상 \\ 붙여주기
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
		AfxMessageBox("카메라가 동작하지 않습니다.");
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
		AfxMessageBox("카메라가 동작하지 않습니다.");
		return;
	}

	UpdateData(TRUE);

	GetDlgItem(IDC_CAMERA_SETUP)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_START)->EnableWindow(FALSE);
	GetDlgItem(IDC_CAPTURE_STOP)->EnableWindow(TRUE);
	GetDlgItem(IDC_REGISTER)->EnableWindow(TRUE);

	// 타이머 설정
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

