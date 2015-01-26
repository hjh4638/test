//2010709159 «‘¡ÿ«ı

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int GaussianRV(double average, double stdev){
	int i;
	double x =0; double u=0; double N= 256;

	for(i=0;i<N;i++){
		u=((double)rand()/RAND_MAX);
		x=x+u;
	}
	x=x-N/2;
	x=x*sqrt(12/N);

	x= average + stdev * x;

	if(x>=0) return (int)(x+0.5);
	else return (int)(x-0.5);

}

void main(void){
	FILE *fp_hist;
	int *hist=NULL;
	int idx=0;

	hist = (int*)malloc(512 * sizeof(int));

	memset(hist, 0, 512*sizeof(int));

	hist +=256;

	for(idx=0;idx<512*512;idx++){
		int Gauss = GaussianRV(0,15);
		hist[Gauss]++;
	}

	fp_hist = fopen("Histogram_Gauss_0_15.txt","wt");
	fprintf(fp_hist, "Value\tFrequency\n");
	for(idx=-256;idx<256;idx++){
		fprintf(fp_hist,"%d\t%d\n",idx,hist[idx]);
	}

	hist -=256;

	fclose(fp_hist);

	memset(hist,0,512*sizeof(int));
	hist+=256;
	for(idx=0;idx<512*512;idx++){
		int Gauss = GaussianRV(100,30);
		hist[Gauss]++;
	}
	fp_hist = fopen("Histogram_Gauss_100_30.txt","wt");
	fprintf(fp_hist,"Value\tFrequency\n");
	for(idx=-256;idx<256;idx++){
		fprintf(fp_hist,"%d\t%d\n",idx,hist[idx]);
	}
	hist-=256;
	fclose(fp_hist);
	free(hist);
}
