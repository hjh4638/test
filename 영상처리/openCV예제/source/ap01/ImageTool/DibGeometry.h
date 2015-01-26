//////////////////////////////////////////////////////////////////////
//                                                                  //
// DibGeometry.h                                                    //
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

void DibTranslate(CDib& dib, int sx, int sy);

void DibResizeNearest(CDib& dib, int nw, int nh);
void DibResizeBilinear(CDib& dib, int nw, int nh);
void DibResizeCubic(CDib& dib, int nw, int nh);

double cubic_interpolation(double v1, double v2, double v3, double v4, double d);

void DibRotate(CDib& dib, double angle);
void DibRotate90(CDib& dib);
void DibRotate180(CDib& dib);
void DibRotate270(CDib& dib);

void DibMirror(CDib& dib);
void DibFlip(CDib& dib);
