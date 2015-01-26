//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibFullSearch.cpp                                                //
//                                                                  //
// Copyright (c) 2007~<current> Sun-Kyoo Hwang                      //
//                              sunkyoo.ippbook@gmail.com           //
//                                                                  //
// 영상처리 프로그래밍 By Visual C++                                //
//                                                                  //
// Last modified: 11/05/2007                                        //
//                                                                  //
//////////////////////////////////////////////////////////////////////

#include "StdAfx.h"
#include "DibFullSearch.h"
#include "Dib.h"
#include "DibFilter.h"

#define BLOCK_SIZE 16
#define WINDOW_SIZE 3

CDibFullSearch::CDibFullSearch(void)
{
	m_pDib1 = NULL;
	m_pDib2 = NULL;
	m_pMotion = NULL;
}

CDibFullSearch::~CDibFullSearch(void)
{
	DeleteMotion();
}

void CDibFullSearch::SetImages(CDib* pDib1, CDib* pDib2)
{
	int w = pDib1->GetWidth();
	int h = pDib1->GetHeight();

	ASSERT( w == pDib2->GetWidth() && h == pDib2->GetHeight() );

	m_pDib1 = pDib1;
	m_pDib2 = pDib2;

	m_nBlockCol = (int)(w / BLOCK_SIZE);
	m_nBlockRow = (int)(h / BLOCK_SIZE);
}

void CDibFullSearch::InitMotion()
{
	if( m_pMotion ) DeleteMotion();

	m_pMotion = new MotionVector*[m_nBlockRow];
	for( int i = 0 ; i < m_nBlockRow ; i++ )
	{
		m_pMotion[i] = new MotionVector[m_nBlockCol];
		memset(m_pMotion[i], 0, sizeof(MotionVector)*m_nBlockCol);
	}
}

void CDibFullSearch::DeleteMotion()
{
	if( m_pMotion != NULL )
	{
		for( register int i = 0 ; i < m_nBlockRow ; i++ ) 
			delete [] m_pMotion[i];
		delete [] m_pMotion;
		m_pMotion = NULL;
	}
}

MotionVector** CDibFullSearch::GetMotionVector()
{
	return m_pMotion;
}

void CDibFullSearch::FullSearch()
{
	// Motion vector를 저장할 공간(m_pMotion)을 할당한다.

	InitMotion();

	// 각 블럭에서 motion vector를 구하여 2차원 배열 m_pMotion에 저장한다.

	register int i, j;

	for( j = 0 ; j < m_nBlockRow ; j++ ) 
	for( i = 0 ; i < m_nBlockCol ; i++ )
	{
		// 가로로 i번째, 세로로 j번째 블럭의 모션을 구한다.
		m_pMotion[j][i] = BlockMotion(i, j);
	}
}

MotionVector CDibFullSearch::BlockMotion(int bx, int by)
{
	MotionVector motion;

	register int i, j;
	int x1, y1, x2, y2;

	double err, min_err;

	x1 = bx * BLOCK_SIZE;
	y1 = by * BLOCK_SIZE;

	min_err = GetMAD(x1, y1, x1, y1);
	motion.x = 0;
	motion.y = 0;

	for( j = -WINDOW_SIZE ; j <= WINDOW_SIZE ; j++ )
	for( i = -WINDOW_SIZE ; i <= WINDOW_SIZE ; i++ )
	{
		if( j == 0 && i == 0 ) continue;

		x2 = x1 + i;
		y2 = y1 + j;

		err = GetMAD(x1, y1, x2, y2);

		if( err < min_err )
		{
			min_err = err;
			motion.x = i;
			motion.y = j;
		}
	}

	if( min_err < 2.0 )
		motion.x = motion.y = 0;

	return motion;
}

double CDibFullSearch::GetMAD(int x1, int y1, int x2, int y2)
{
	register int i, j;

	int w = m_pDib1->GetWidth();
	int h = m_pDib1->GetHeight();

	BYTE** ptr1 = m_pDib1->GetPtr();
	BYTE** ptr2 = m_pDib2->GetPtr();

	int cnt = 0;
	int temp, sum = 0;

	for( j = 0 ; j < BLOCK_SIZE ; j++ )
	for( i = 0 ; i < BLOCK_SIZE ; i++ )
	{
		if( x1+i < 0 || x1+i >= w || y1+j < 0 || y1+j >= h ||
			x2+i < 0 || x2+i >= w || y2+j < 0 || y2+j >= h )
			continue;

		temp = ptr1[y1+j][x1+i] - ptr2[y2+j][x2+i];
		if( temp < 0 ) temp = -temp;
		sum += temp;
		cnt++;
	}

	return ((double)sum / cnt);
}

void CDibFullSearch::GetMotionImage(CDib& dib)
{
	register int i, j;

	int w = m_pDib1->GetWidth();
	int h = m_pDib1->GetHeight();

	dib.CreateGrayImage(w, h);

	int cx, cy;
	for( j = 0 ; j < m_nBlockRow ; j++ ) 
	for( i = 0 ; i < m_nBlockCol ; i++ )
	{
		if( m_pMotion[j][i].x == 0 && m_pMotion[j][i].y == 0 )
			continue;

		cx = i * BLOCK_SIZE + BLOCK_SIZE / 2;
		cy = j * BLOCK_SIZE + BLOCK_SIZE / 2;

		DibDrawLine(dib, cx, cy, cx+m_pMotion[j][i].x, cy+m_pMotion[j][i].y, 0);
	}
}
