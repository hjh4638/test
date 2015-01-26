#include <stdio.h>
#include <stdlib.h>
#pragma warning(disable:4996)

#define N 512

int main(){
	printf("test");
	FILE *fp_in = 0, *fp_out1 = 0, *fp_out2 = 0;
	unsigned char *idata = 0, *odata = 0;
	int temp = 0;
	int idx = 0;

	fp_in = fopen("input1.raw", "rb");
	idata = (unsigned char*)malloc(sizeof(unsigned char) * N);
	//idata에 인풋 데이터 이동
	fread(idata, sizeof(unsigned char), N, fp_in);

	odata = (unsigned char*)malloc(sizeof(unsigned char)* N);

	for (idx = 0; idx < N; idx++){
		odata[idx] = idata[idx];
	}

	fp_out1 = fopen("output1.raw", "wb");
	fwrite(odata, sizeof(unsigned char), N, fp_out1);

	fp_out2 = fopen("output1.xls", "wt");
	for (idx = 0; idx < N; idx++){
		fprintf(fp_out2, "%u\n", odata[idx]);
	}

	free(idata);
	free(odata);

	fclose(fp_in);
	fclose(fp_out1);
	fclose(fp_out2);
	return 0;
}