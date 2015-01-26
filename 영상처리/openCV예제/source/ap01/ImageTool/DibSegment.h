//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibSegment.h                                                     //
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

#define MAX_LABEL 10000

#define MAX_CONTOUR 5000

typedef struct _ContourPoints
{
	int num;
	int x[MAX_CONTOUR];
	int y[MAX_CONTOUR];
} ContourPoints;

void DibBinarization(CDib& dib, int th);
int DibBinarizationIterative(CDib& dib);

int  DibLabeling(CDib& dib);

ContourPoints DibContourTracing(CDib& dib);

void DibMorphologyErosion(CDib& dib);
void DibMorphologyDilation(CDib& dib);

void DibMorphologyGrayErosion(CDib& dib);
void DibMorphologyGrayDilation(CDib& dib);

ContourPoints DibFourierDescriptor(CDib& dib, int nPercent);
void DibInvariantMoments(CDib& dib, double m[7]);
double DibGeometricMoment(CDib& dib, int p, int q);
