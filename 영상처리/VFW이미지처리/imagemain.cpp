#include <windows.h>
#include <Vfw.h>
#pragma comment (lib,"vfw32.lib")  //lib추가 하기 위해서 사용(수동방식) 
#define CONVERT565(r,g,b) ( ((r>>3)<<11) | ((g>>3)<<5) | (b>>3))
#define CLIP(x) (((x) <0)?0:(((x)>255)?255:(x)))
#define RED  2
#define GREEN 1
#define BLUE 0
HDC hdc;
HWND hVfw;
HWND hwnd;
BITMAPINFO m_bitmapInfo;
BITMAPINFO BInfo;
unsigned char* buffer;

LRESULT CALLBACK WndProc(HWND hwnd, UINT message,
	WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK  Emb_Draw(HWND hWnd, LPVIDEOHDR lp);
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow)
{
	WNDCLASS wndclass;//윈도우 클래스 운영체제 등록
	//createWindow 리턴값 저장
	MSG msg;//처리할 메세지

	// 윈도우 클래스를 초기화하고 운영체제에 등록한다.
	wndclass.style = CS_HREDRAW | CS_VREDRAW; // 스타일 지정
	wndclass.lpfnWndProc = WndProc; // 윈도우 프로시저 이름
	//이 부분이 중요! WndProc 함수를 등록해줌.

	wndclass.cbClsExtra = 0; // 여분 메모리(0바이트)
	wndclass.cbWndExtra = 0; // 여분 메모리(0바이트)
	wndclass.hInstance = hInstance; // 인스턴스 핸들
	wndclass.hIcon = LoadIcon(NULL, IDI_APPLICATION); // 아이콘 모양
	wndclass.hCursor = LoadCursor(NULL, IDC_ARROW); // 커서 모양
	wndclass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH); // 배경(흰색)
	wndclass.lpszMenuName = NULL; // 메뉴(NULL->메뉴 없음)
	wndclass.lpszClassName = TEXT("HelloClass"); // 윈도우 클래스 이름
	if (!RegisterClass(&wndclass)) return 1;
	memset(&m_bitmapInfo, 0, sizeof(BITMAPINFO));
	// 윈도우를 생성하고 화면에 보이게 한다.
	//클래스 이름, 윈도우 이름, 윈도우 스타일, x좌표, y좌표, 폭 , 높이, 부모 윈도핸들, 메뉴핸들, 인스턴스 핸들,옵션데이터
	hwnd = CreateWindow(TEXT("HelloClass"), TEXT("hello"),
		WS_OVERLAPPEDWINDOW, 100, 0,
		1300, 500, NULL, NULL, hInstance, NULL);
	ShowWindow(hwnd, nCmdShow);

	// 메시지 큐에서 메시지를 하나씩 꺼내서 처리한다.
	while (GetMessage(&msg, NULL, 0, 0) > 0){
		TranslateMessage(&msg);//키보드 메시지 들어오면 문자를 만듬
		DispatchMessage(&msg);//윈도우 프로시저로 보냄
	}

	return msg.wParam;
}

//hwnd : 어느 윈도우에서 메시지가 발생했나 구분
LRESULT CALLBACK WndProc(HWND hwnd, UINT message,
	WPARAM wParam, LPARAM lParam)
{
	PAINTSTRUCT ps;
	TCHAR *str = TEXT("Hello, SDK");
	int size;
	// 발생한 메시지의 종류에 따라 적절히 처리한다.
	switch (message){
	case WM_CREATE:

		return 0;
	case WM_LBUTTONDOWN:
		hdc = GetDC(hwnd);
		//윈도우 생성
		hVfw = capCreateCaptureWindow(TEXT("동영상"), WS_CHILD | WS_VISIBLE, 0, 0,
			640, 480, hwnd, 0);
		//USB장치연결 
		// Camera Driver와 Capture Window 연결
		if (capDriverConnect(hVfw, 0) == FALSE) return FALSE;

		//화면에 보이는 속도 (두번째 인자로 조절)
		capPreviewRate(hVfw, 1);
		//capGetVideoFormat(hVfw, &m_bitmapInfo, sizeof(BITMAPINFO));
		//가로 세로 길이 변경 
		m_bitmapInfo.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
		m_bitmapInfo.bmiHeader.biWidth = 640;
		m_bitmapInfo.bmiHeader.biHeight = 480; // top-down bitmap, negative height
		m_bitmapInfo.bmiHeader.biPlanes = 1;
		m_bitmapInfo.bmiHeader.biBitCount = 24;
		m_bitmapInfo.bmiHeader.biCompression = BI_RGB;
		m_bitmapInfo.bmiHeader.biSizeImage = 640 * 480 * 3;
		m_bitmapInfo.bmiHeader.biXPelsPerMeter = 100;
		m_bitmapInfo.bmiHeader.biYPelsPerMeter = 100;
		m_bitmapInfo.bmiHeader.biClrUsed = 0;
		m_bitmapInfo.bmiHeader.biClrImportant = 0;
		capSetVideoFormat(hVfw, &m_bitmapInfo, sizeof(BITMAPINFO));
		//영상화면 출력 
		capSetCallbackOnFrame(hVfw, Emb_Draw);
		capGrabFrameNoStop(hVfw);
		capOverlay(hVfw, TRUE);
		capPreview(hVfw, FALSE);
		//capGetVideoFormat(hVfw, &m_bitmapInfo, sizeof(BITMAPINFO));
		return 0;
	case WM_PAINT:
		hdc = BeginPaint(hwnd, &ps);
		EndPaint(hwnd, &ps);
		return 0;
	case WM_DESTROY:

		PostQuitMessage(0);
		return 0;
	}

	// 응용 프로그램이 처리하지 않은 메시지는 운영체제가 처리한다.
	return DefWindowProc(hwnd, message, wParam, lParam);
}
LRESULT CALLBACK  Emb_Draw(HWND hWnd, LPVIDEOHDR lpVHdr)
{

	unsigned int uiBuflen = lpVHdr->dwBufferLength;
	BYTE RGB[480][640][3] = { 0, };
	BYTE* origin_img= new BYTE[480*640*3];
	BYTE* reflect_img = new BYTE[480 * 640 * 3];
	unsigned int nWidth, nHeight;
	unsigned int i, j;
	int Y0, U, Y1, V;
	nWidth = 640;
	nHeight = 480;
	
	int i_bitmap=0,j_bitmap=0;
	/////////////////////////////////////////////////////////////////////////
	// YUY2 ---> RGB
	for (j = 0; j < nHeight; j++) { // height
		for (i = 0; i < nWidth; i += 2) { //width
			Y0 = lpVHdr->lpData[(nWidth*j + i) * 2];
			U = lpVHdr->lpData[(nWidth*j + i) * 2 + 1];
			Y1 = lpVHdr->lpData[(nWidth*j + i) * 2 + 2];
			V = lpVHdr->lpData[(nWidth*j + i) * 2 + 3];

			RGB[j][i][RED] = (int)CLIP(Y0 + (1.4075*(V - 128)));
			RGB[j][i][GREEN] = (int)CLIP(Y0 - 0.3455*(U - 128) - 0.7169*(V - 128));
			RGB[j][i][BLUE] = (int)CLIP(Y0 + 1.7790*(U - 128));
			RGB[j][i + 1][RED] = (int)CLIP(Y1 + (1.4075*(V - 128)));
			RGB[j][i + 1][GREEN] = (int)CLIP(Y1 - 0.3455*(U - 128) - 0.7169*(V - 128));
			RGB[j][i + 1][BLUE] = (int)CLIP(Y1 + 1.7790*(U - 128));
		}
	}
	for (j = nHeight; j > 0; j--){
		for (i = 0; i < nWidth; i++){
			origin_img[i_bitmap] = RGB[j][i][BLUE];
			origin_img[i_bitmap + 1] = RGB[j][i][GREEN];
			origin_img[i_bitmap + 2] = RGB[j][i][RED];
			i_bitmap += 3;
		}
		j_bitmap += 1;
		i_bitmap = 3 * nWidth*j_bitmap;
	}
	i_bitmap = 0, j_bitmap = 0;
	for (j = nHeight; j > 0; j--){
		for (i = nWidth; i > 0; i--){
			reflect_img[i_bitmap] = RGB[j][i][BLUE];
			reflect_img[i_bitmap + 1] = RGB[j][i][GREEN];
			reflect_img[i_bitmap + 2] = RGB[j][i][RED];
			i_bitmap += 3;
		}
		j_bitmap += 1;
		i_bitmap = 3 * nWidth*j_bitmap;
	}
	::SetDIBitsToDevice(
		hdc,
		0,
		0,
		640,
		480,
		0,
		0,
		0,
		480,
		origin_img,
		&m_bitmapInfo,
		DIB_RGB_COLORS);
	::SetDIBitsToDevice(
		hdc,
		650,
		0,
		640,
		480,
		0,
		0,
		0,
		480,
		reflect_img,
		&m_bitmapInfo,
		DIB_RGB_COLORS);

	return  0;
}
//#include <windows.h>
//#include <Vfw.h>
//#pragma comment (lib,"vfw32.lib")  //lib추가 하기 위해서 사용(수동방식) 
//LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
//LRESULT CALLBACK FramInfo(HWND, LPVIDEOHDR);
//HINSTANCE g_hInst;
//HWND HWndMain;
//LPCTSTR lpszClass = TEXT("Mecha");
//HWND vfw;
//BITMAPINFO Bm;
//int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance
//	, LPSTR lpszCmdParam, int nCmdShow)
//{
//	HWND hWnd;
//	MSG Message;
//	WNDCLASS WndClass;
//	g_hInst = hInstance;
//	WndClass.cbClsExtra = 0;
//	WndClass.cbWndExtra = 0;
//	WndClass.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
//	WndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
//	WndClass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
//	WndClass.hInstance = hInstance;
//	WndClass.lpfnWndProc = WndProc;
//	WndClass.lpszClassName = lpszClass;
//	WndClass.lpszMenuName = NULL;
//	WndClass.style = CS_HREDRAW | CS_VREDRAW;
//	RegisterClass(&WndClass);
//	hWnd = CreateWindow(lpszClass, lpszClass, WS_OVERLAPPEDWINDOW,
//		CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
//		NULL, (HMENU)NULL, hInstance, NULL);
//	ShowWindow(hWnd, nCmdShow);
//	while (GetMessage(&Message, NULL, 0, 0)){
//		TranslateMessage(&Message);
//		DispatchMessage(&Message);
//	}
//	return (int)Message.wParam;
//}
//HDC hdc;
//LRESULT CALLBACK WndProc(HWND hWnd, UINT iMessage, WPARAM wParam, LPARAM lParam)
//{
//	PAINTSTRUCT ps;
//	switch (iMessage)
//	{
//	case WM_CREATE:
//		HWndMain = hWnd;
//		vfw = capCreateCaptureWindow(TEXT("CAM") //카메라에 들어온 데이터를 캡처하는 함수
//			, WS_CHILD | WS_VISIBLE
//			, 0
//			, 0
//			, 400
//			, 300
//			, hWnd
//			, NULL);
//		capDriverConnect(vfw, 0);
//		capGetVideoFormat(vfw, &Bm, sizeof(Bm));
//		capSetCallbackOnFrame(vfw, FramInfo); //캡쳐되는 데이터의 정보를 가져온다.
//		capPreviewRate(vfw, 33);
//		capPreview(vfw, TRUE);
//		return 0;
//	case WM_LBUTTONDOWN:
//		MessageBox(hWnd, TEXT("사진캡쳐를 했습니다."), TEXT("알림"), MB_OK); //왼쪽버튼을 클릭하면 BMP파일로 저장한다. 한화면만...
//		capFileSaveDIB(vfw, TEXT("cap.bmp")); //캡쳐화면을 저장하는 함수
//		return 0;
//	case WM_PAINT:
//		hdc = BeginPaint(hWnd, &ps);
//		EndPaint(hWnd, &ps);
//		return 0;
//	case WM_DESTROY:
//		PostQuitMessage(0);
//		return 0;
//	}
//	return(DefWindowProc(hWnd, iMessage, wParam, lParam));
//}
//LRESULT CALLBACK FramInfo(HWND hWnd, LPVIDEOHDR lpData) //화면을 캡쳐하는 콜백함수. 캡쳐되는 데이터를 연속적으로 받는다.
//{
	/*hdc = GetDC(HWndMain);
	StretchDIBits(hdc, 0
		, Bm.bmiHeader.biHeight + 20
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, 0
		, 0
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, lpData->lpData
		, &Bm
		, DIB_RGB_COLORS
		, SRCCOPY);*/
	/*StretchDIBits(hdc, Bm.bmiHeader.biWidth + 20
		, 0
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, 0
		, 0
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, lpData->lpData
		, &Bm
		, DIB_RGB_COLORS
		, SRCCOPY);
	StretchDIBits(hdc, Bm.bmiHeader.biWidth + 20
		, Bm.bmiHeader.biHeight + 20
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, 0
		, 0
		, Bm.bmiHeader.biWidth
		, Bm.bmiHeader.biHeight
		, lpData->lpData
		, &Bm
		, DIB_RGB_COLORS
		, SRCCOPY);*/
	//ReleaseDC(HWndMain, hdc);

	
////}
//#include "windows.h"
//#include "Vfw.h"
//#pragma comment (lib,"vfw32.lib")
//LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
//LRESULT CALLBACK FramInfo(HWND hVFW, LPVIDEOHDR VideoHdr);
//HINSTANCE g_hInst;
//HWND hWndMain;
//HBITMAP hBit;
//BITMAPINFO Bm;
//LPCWSTR lpszClass = TEXT("Class");
////WinMain 시작
//int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance
//	, LPSTR lpszCmdParam, int nCmdShow)
//{
//	HWND hWnd;
//	MSG Message;
//	WNDCLASS WndClass;
//	g_hInst = hInstance;
//	//1. 윈도우 속성값 등록
//	WndClass.cbClsExtra = 0;
//	WndClass.cbWndExtra = 0;
//	WndClass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
//	WndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
//	WndClass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
//	WndClass.hInstance = hInstance;
//	WndClass.lpfnWndProc = WndProc;
//	WndClass.lpszClassName = lpszClass;
//	WndClass.lpszMenuName = NULL;
//	WndClass.style = CS_HREDRAW | CS_VREDRAW;
//	RegisterClass(&WndClass);  //주소에 Write
//
//	//2. 윈도우 생성
//	hWnd = CreateWindow(lpszClass, lpszClass, WS_OVERLAPPEDWINDOW,
//		CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
//		NULL, (HMENU)NULL, hInstance, NULL);
//	ShowWindow(hWnd, nCmdShow); //화면에 뿌려줌
//
//	//3. 메시지 처리(무한 반복)
//	while (GetMessage(&Message, NULL, 0, 0))
//	{
//		TranslateMessage(&Message);
//		DispatchMessage(&Message);
//	}
//	return (int)Message.wParam;
//}
//LRESULT CALLBACK WndProc(HWND hWnd, UINT iMessage, WPARAM wParam, LPARAM lParam)
//{
//	HDC hdc;
//	HWND hVFW;
//	PAINTSTRUCT ps;
//	switch (iMessage)
//	{
//	case WM_CREATE:
//		hWndMain = hWnd;
//		hdc = GetDC(hWndMain);
//		hVFW = capCreateCaptureWindow(TEXT("VFW"), WS_CHILD | WS_VISIBLE, 0, 0, 1, 1, hWnd, 0);
//		capDriverConnect(hVFW, 0);
//		capPreviewRate(hVFW, 1);
//		capPreview(hVFW, TRUE);
//		capGetVideoFormat(hVFW, &Bm, sizeof(Bm));
//		hBit = CreateCompatibleBitmap(hdc, Bm.bmiHeader.biWidth, Bm.bmiHeader.biHeight);
//		if (capSetCallbackOnFrame(hVFW, FramInfo) == FALSE)
//		{
//			return FALSE;
//		}
//		ReleaseDC(hWndMain, hdc);
//		return 0;
//	case WM_PAINT:
//		hdc = BeginPaint(hWnd, &ps);
//		EndPaint(hWnd, &ps);
//		return 0;
//	case WM_DESTROY:
//		PostQuitMessage(0);
//		return 0;
//	}
//	return(DefWindowProc(hWnd, iMessage, wParam, lParam));
//}
//LRESULT CALLBACK FramInfo(HWND hVFW, LPVIDEOHDR VideoHdr)
//{
//	HDC hdc;
//	HDC hMemDC;
//	HBITMAP OldBitmap;
//	int iCntX;
//	int iCntY;
//	int Jump;
//
//	hdc = GetDC(hWndMain);
//	hMemDC = CreateCompatibleDC(hdc);
//	OldBitmap = (HBITMAP)SelectObject(hMemDC, hBit);
//
//	Jump = 0;
//	for (iCntY = 0; iCntY < Bm.bmiHeader.biHeight; ++iCntY)
//	{
//		for (iCntX = 0; iCntX < Bm.bmiHeader.biWidth; ++iCntX)
//		{
//			//원영상
//			SetPixel(hMemDC, iCntX, (Bm.bmiHeader.biHeight - iCntY) - 1, RGB(VideoHdr->lpData[Jump + 2], VideoHdr->lpData[Jump + 1], VideoHdr->lpData[Jump]));
//			Jump += 3;
//		}
//	}
//	BitBlt(hdc, 0, 0, Bm.bmiHeader.biWidth, Bm.bmiHeader.biHeight, hMemDC, 0, 0, SRCCOPY);
//	SelectObject(hMemDC, OldBitmap);
//	ReleaseDC(hWndMain, hdc);
//	return 0;
//}