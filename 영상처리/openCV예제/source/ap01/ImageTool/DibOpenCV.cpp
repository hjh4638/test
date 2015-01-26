//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibOpenCV.cpp                                                    //
//                                                                  //
// Copyright (c) 2007~<current> Sun-Kyoo Hwang                      //
//                              sunkyoo.ippbook@gmail.com           //
//                                                                  //
// 영상처리 프로그래밍 By Visual C++                                //
//                                                                  //
// Last modified: 11/05/2007                                        //
//                                                                  //
//////////////////////////////////////////////////////////////////////

#include <stdafx.h>
#include "Dib.h"
#include "RGBBYTE.h"

#include "DibOpenCV.h"

BOOL CDib_TO_IplImage(CDib* pDib, IplImage** pImage)
{
	register int i, j;
	BOOL ret = TRUE;

	int w = pDib->GetWidth();
	int h = pDib->GetHeight();

	if( pDib->GetBitCount() == 8 )
	{
		*pImage = cvCreateImage(cvSize(w, h), 8, 1);
		int ws = (*pImage)->widthStep;
		
		BYTE* pimg = (BYTE*)((*pImage)->imageData);
		BYTE** ptr = pDib->GetPtr();

		for( j = 0 ; j < h ; j++ )
		for( i = 0 ; i < w ; i++ )
		{
			pimg[j*ws + i] = ptr[j][i];
		}
	}
	else if( pDib->GetBitCount() == 24 )
	{
		*pImage = cvCreateImage(cvSize(w, h), 8, 3);
		int ws = (*pImage)->widthStep;

		BYTE* pimg = (BYTE*)((*pImage)->imageData);
		RGBBYTE** ptr = pDib->GetRGBPtr();

		for( j = 0 ; j < h ; j++ )
		for( i = 0 ; i < w ; i++ )
		{
			pimg[j*ws + i*3    ] = ptr[j][i].b;
			pimg[j*ws + i*3 + 1] = ptr[j][i].g;
			pimg[j*ws + i*3 + 2] = ptr[j][i].r;
		}
	}
	else
	{
		ret = FALSE;
	}

	return ret;
}

BOOL IplImage_TO_CDib(IplImage* pImage, CDib* pDib)
{
	register int i, j, y;
	BOOL ret = TRUE;

	int w = pImage->width;
	int h = pImage->height;
	int ws = pImage->widthStep;

	if( pImage->nChannels == 1 )
	{
		pDib->CreateGrayImage(w, h);
		BYTE** ptr = pDib->GetPtr();
		BYTE* pimg = (BYTE*)pImage->imageData;

		for( j = 0 ; j < h ; j++ )
		{
			if( pImage->origin == 0 ) y = j;
			else y = h - j - 1;
		
			for( i = 0 ; i < w ; i++ )
			{

				ptr[j][i] = pimg[y*ws + i];
			}
		}
	}
	else if( pImage->nChannels == 3 )
	{
		pDib->CreateRGBImage(w, h);
		RGBBYTE** ptr = pDib->GetRGBPtr();
		BYTE* pimg = (BYTE*)pImage->imageData;

		for( j = 0 ; j < h ; j++ )
		{
			if( pImage->origin == 0 ) y = j;
			else y = h - j - 1;

			for( i = 0 ; i < w ; i++ )
			{
				ptr[j][i].b = pimg[y*ws + i*3    ];
				ptr[j][i].g = pimg[y*ws + i*3 + 1];
				ptr[j][i].r = pimg[y*ws + i*3 + 2];
			}
		}
	}
	else
	{
		ret = FALSE;
	}

	return ret;
}
