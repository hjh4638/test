//////////////////////////////////////////////////////////////////////
//                                                                  //
// Avi.h: header file of the CAvi class.                            //
//                                                                  //
// Copyright (c) 2003~<current> Sun-Kyoo Hwang                      //
//                              sunkyoo.ippbook@gmail.com           //
//                                                                  //
// ����ó�� ���α׷��� By Visual C++                                //
//                                                                  //
// Last modified: 20/04/2007                                        //
//                                                                  //
//////////////////////////////////////////////////////////////////////

#pragma once

#include <vfw.h>
#include "Dib.h"

class CAvi  
{
public:
	// ������
	CAvi();
	~CAvi();

public:
	// ��� �Լ�
	BOOL    Open(LPCTSTR lpszPathName);
	void    Close();

	// �׸��� �Լ�
	void    DrawFrame(HDC hDC, int nFrame);
	void    DrawFrame(HDC hDC, int nFrame, int dx, int dy);
	void    DrawFrame(HDC hDC, int nFrame, int dx, int dy, int dw, int dh, DWORD dwRop = SRCCOPY);

	// ���� ������ ĸ�� �Լ�
	BOOL    GetFrame(int nFrame, CDib& dib);

	// AVI ���� ���� ��ȯ �Լ�
	int     GetFrameRate() { return m_nFrameRate; }
	int     GetTotalFrame() { return m_nTotalFrame; }
	int     GetHeight() { return m_nHeight; }
	int     GetWidth() { return m_nWidth; }
	int     GetBitCount() { return m_nBitCount; }
	BOOL    IsValid() { return (m_pAviFile != NULL); };

protected:
	// ��� ����
	PAVIFILE    m_pAviFile;			// AVI ���� �������̽� ������
	PAVISTREAM  m_pVideoStream;		// Video ��Ʈ�� ������
	PGETFRAME   m_pVideoFrame;		// �������� �޴� ������

    int         m_nWidth;			// ������ ȭ�� ������
	int         m_nRWidth;
	int         m_nHeight;

	int         m_nBitCount;

	int         m_nTotalFrame;      // ��ü ������ ����
	int         m_nFrameRate;       // �ʴ� ������ ����
};

