// 2010709159_������

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define HEIGHT 512
#define WIDTH 512

typedef unsigned char BYTE;
void main(){

	FILE *fp_in;
	FILE *fp_out;
	BYTE** img_in;
	BYTE** img_out;

	int temp,i,j;

	fp_in = fopen("Lena(512x512).raw","rb");
	if(fp_in == NULL){
		printf("File open failed\n");
		return;
	}

	img_in = (BYTE**)malloc(sizeof(BYTE*) * (HEIGHT+1));
	img_out=(BYTE**)malloc(sizeof(BYTE*) * HEIGHT);

	//temp = img_in[i][j] - img_in[i][j+1];���� j+1�� �������� ��� �ϳ� �� �Ҵ�
	for(i=0;i<HEIGHT+1;i++){
		img_in[i]=(BYTE*)malloc(sizeof(BYTE)*(WIDTH +1));
	}
	for(i=0;i<HEIGHT;i++){
		img_out[i]=(BYTE*)malloc(sizeof(BYTE)*(WIDTH));
	}

	//img_in�� ������ ����
	for(i=0;i<HEIGHT;i++){
		fread(img_in[i],sizeof(BYTE),WIDTH,fp_in);
	}

	//���̿� �ʺ� 1�ڸ��� �� �Ҵ������Ƿ� ���� �κ� ä�������
	for(i=0;i<HEIGHT;i++){
		img_in[i][WIDTH]=img_in[i][WIDTH-1];
	}
	for(i=0;i<WIDTH+1;i++){
		img_in[HEIGHT][i]=img_in[HEIGHT-1][i];
	}

	//���ο� �̹��� ������
	for(i=0; i<HEIGHT; i++){
		for(j=0;j<WIDTH;j++){
			temp = img_in[i][j] - img_in[i][j+1];//������ �ٸ��κ�...
			img_out[i][j]=(BYTE)floor((((temp+255)/2.0)+0.5));
		}
	}

	fp_out = fopen("[OUT]Lena(512X512).raw","wb");
	for(i=0;i<HEIGHT;i++){
		fwrite(img_out[i],sizeof(BYTE),WIDTH,fp_out);
	}
	return;
}
