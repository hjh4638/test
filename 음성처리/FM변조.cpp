/*
* main.c
*
*  Created on: 2014. 4. 8.
*      Author: apple
*/


// header
#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <string.h>

//beta값에 따른 파일 생성
void assign1(float beta){
	// variable
	FILE	*fin1, *fout;  // File Pointer
	short data; // 16 bit Integer Variable
	float	x1, y;
	double var = 0;

	//float beta = 0.01;
	char f_name[80];
	sprintf(f_name, "fm_beta_%0.3f.raw", beta);
	printf(f_name);
	// file open
	fin1 = fopen("input.raw", "rb");
	fout = fopen(f_name, "wb");

	// file read
	for (;;) {
		// input read
		if (fread(&data, 2, 1, fin1) == NULL) break;
		// conversion to Floating
		x1 = (float)data; // data는 short 변수이므로 이를 Float로 바꾸어 계산한다.
		// x1과 x2를 이용하여 변조된 신호 y 계산

		//y = x1*cos(2 * M_PI * 9600 * var / 48000);
		y = 10000 * cos(2 * M_PI * 12000 * var / 48000 +
			beta * sin(2 * M_PI * 1200 * var / 48000));
	
		// output write
		data = (short)y; // 변조된 신호 y를 short 형태로 바꿈
		fwrite(&data, 2, 1, fout);
		var++;
	}
	fclose(fin1);
	fclose(fout);
}
void assgin2(){
	// variable
	FILE	*fin1, *fout;  // File Pointer
	short data; // 16 bit Integer Variable
	float	x1, y;
	double var = 0;
	float sum_x1=0;

	//float beta = 0.01;
	char f_name[80];
	sprintf(f_name, "fm_speech.raw");
	printf(f_name);
	// file open
	fin1 = fopen("input.raw", "rb");
	fout = fopen(f_name, "wb");

	// file read
	for (;;) {
		// input read
		if (fread(&data, 2, 1, fin1) == NULL) break;
		// conversion to Floating
		x1 = (float)data; // data는 short 변수이므로 이를 Float로 바꾸어 계산한다.
		// x1과 x2를 이용하여 변조된 신호 y 계산
		sum_x1 += x1;
		//y = x1*cos(2 * M_PI * 9600 * var / 48000);
		y = 10000 * cos(2 * M_PI * 12000 * var / 48000 +
			2 * M_PI * 0.1 / 48000 * sum_x1);
		// output write
		data = (short)y; // 변조된 신호 y를 short 형태로 바꿈
		fwrite(&data, 2, 1, fout);
		var++;
	}
	fclose(fin1);
	fclose(fout);
}
short getMaxMessege(){
	FILE* fin1;
	fin1= fopen("input.raw", "rb");
	short data=0;
	short max_data=0;
	// file read
	for (;;) {
		// input read
		if (fread(&data, 2, 1, fin1) == NULL) break;
		
		if (data >= max_data)
			max_data = data;

	}
	fclose(fin1);
	return max_data;
	
}
void main(){
	assign1(0.01);
	assign1(0.1);
	assign1(1.0);
	assign1(5.0);

	assgin2();
	printf("\nM(n)의 최대값은 = %hd\n", getMaxMessege());
}
