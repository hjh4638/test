//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibFullSearch.h                                                  //
//                                                                  //
// Copyright (c) 2007~<current> Sun-Kyoo Hwang                      //
//                              sunkyoo.ippbook@gmail.com           //
//                                                                  //
// 영상처리 프로그래밍 By Visual C++                                //
//                                                                  //
// Last modified: 11/05/2007                                        //
//                                                                  //
//////////////////////////////////////////////////////////////////////

#pragma once

typedef struct _MotionVector
{
	int x;
	int y;
} MotionVector;

class CDib;

class CDibFullSearch
{
public:
	CDibFullSearch(void);
	~CDibFullSearch(void);

public:
	CDib* m_pDib1;
	CDib* m_pDib2;

	MotionVector** m_pMotion;

	int m_nBlockRow;
	int m_nBlockCol;

public:
	void SetImages(CDib* pDib1, CDib* pDib2);
	MotionVector** GetMotionVector();
	void FullSearch();
	void GetMotionImage(CDib& dib);

protected:
	void InitMotion();
	void DeleteMotion();

	MotionVector BlockMotion(int x, int y);
	double GetMAD(int x1, int y1, int x2, int y2);
};
