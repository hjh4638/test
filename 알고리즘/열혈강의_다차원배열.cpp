#include <stdio.h>

void TwoDimArraySize(){
	int arr1[3][4];
	int arr2[7][9];
	printf("세로3, 가로4: %d \n", sizeof(arr1));
	printf("세로7, 가로9: %d \n", sizeof(arr2));
}
void PopuResarch(){
	int villa[4][2];
	int popu, i, j;

	for (i = 0; i < 4; i++){
		for (j = 0; j < 2; j++){
			printf("%d층 %d호 인구수: ", i + 1, j + 1);
			scanf_s("%d", &villa[i][j]);
		}
	}

	for (i = 0; i < 4; i++){
		popu = 0;
		popu += villa[i][0];
		popu += villa[i][1];
		printf("%d층 인구수: %d \n", i + 1, popu);
	}
}
void TwoDimArrayAddr(){
	int arr[3][2];
	int i, j;
	for (i = 0; i < 3; i++){
		for (j = 0; j < 2; j++){
			printf("%p \n", &arr[i][j]);
		}
	}
}
void swap(int* a, int* b){
	int temp;
	temp = *a;
	*a = *b;
	*b = temp;
}
void exam(){
	int arr[] = { 1, 2, 3, 4, 5 };
	int *p = arr;
	int i;
	for (i = 0; i < 5; i++){
		*(p + i) = *(p + i) + 2;
	}
	for (i = 0; i < 5; i++){
		printf("%d\n", arr[i]);
	}
}
void exam3(){
	int table[3][3];
	int i,j;
	for (i = 0; i < sizeof(table) / sizeof(int); i++){
		//scanf(&table[);

	}
}
void main(){
	int table[3][3] = {};
	char* col[3] = { "철수", "영희", "과목" };
	char* row[3] = { "국어", "영어", "학생" };
	int col_size = sizeof(table[0]) / sizeof(int);
	int row_size = sizeof(table) / col_size / sizeof(int);
	int i, j,sum=0;
	for (i = 0; i < row_size-1;i++){
		for (j = 0; j < col_size-1;j++){
			printf("%s의 %s 점수를 입려하세요 : ", col[i], row[j]);
			scanf_s("%d", &table[i][j]);
		}
	}
	for (int i = 0; i < row_size - 1; i++){
		for (int j = 0; j < col_size - 1; j++){
			table[i][col_size-1] += table[i][j];
		}
	}
	for (int j = 0; j < col_size - 1; j++){
		for (int i = 0; i < row_size - 1; i++){
			table[row_size-1][j] += table[i][j];
		}
	}

	for (j = 0; j < col_size; j++){
		printf("        %s ", row[j]);
	}
	printf("\n");
	for (i = 0; i < row_size; i++){
		printf("%s ", col[i]);
		for (j = 0; j < col_size; j++){
			printf("        %d", table[i][j]);
		}
		printf("\n");
	}
}