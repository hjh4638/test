//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibOpenCV.h                                                      //
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

#include "cv.h"
#include "cxcore.h"
#include "highgui.h"

class CDib;

BOOL CDib_TO_IplImage(CDib* pDib, IplImage** pImage);
BOOL IplImage_TO_CDib(IplImage* pImage, CDib* pDib);

