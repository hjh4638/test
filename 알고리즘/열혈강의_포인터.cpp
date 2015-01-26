#include <stdio.h>

void pointerOper(){
	int num1 = 100, num2 = 100;
	int * pnum;
	int * test=NULL;

	pnum = &num1;
	(*pnum) += 30;

	pnum = &num2;
	(*pnum) -= 30;

	printf("num1:%d, num2: %d\n", num1, num2);
}
void ArrayNameType(){
	int arr[3] = { 0, 1, 2 };
	printf("배열의 이름: %p\n", arr);
	printf("배열의 이름: %p\n", &arr[0]);
	printf("배열의 이름: %p\n", &arr[1]);
	printf("배열의 이름: %p\n", &arr[2]);
}
void ArrayNamePointerOperation(){
	int arr1[3] = { 1, 2, 3 };
	double arr2[3] = { 1.1, 2.2, 3.3 };

	printf("%d %g \n", *arr1, *arr2);
	*arr1 += 100;
	*arr2 += 120.5;
	printf("%d %g \n", arr1[0], arr2[0]);
}
void PointerOperationResult(){
	int a;
	double b;
	int * ptr1 = &a;
	double * ptr2 = &b;

	printf("%p %p \n", ptr1, ptr2);

	printf("%p %p \n", ptr1 + 1, ptr1 + 2);
	printf("%p %p \n", ptr2 + 1, ptr2 + 2);

	printf("%p %p \n", ptr1 , ptr2);
	ptr1++;
	ptr2++;
	printf("%p %p \n", ptr1, ptr2);
}
// arr[i] == *(arr+i)
void ShowArayElem(int * param, int len){
	int i;
	for (i = 0; i < len; i++){
		printf("%d ", param[i]);
	}
	printf("\n");
}
//매개변수에서는 int* param == int param[]
void AddArayElem(int param[], int len, int add){
	int i;
	for (i = 0; i < len; i++){
		param[i] += add;
	}
}
void ArrayParam(){
	int arr1[3] = { 1, 2, 3 };
	int arr2[5] = { 4, 5, 6, 7, 8 };
	ShowArayElem(arr1, sizeof(arr1) / sizeof(int));
	ShowArayElem(arr2, sizeof(arr2) / sizeof(int));
}
void ArrayParamAccess(){
	int arr[3] = { 1, 2, 3 };
	AddArayElem(arr, sizeof(arr) / sizeof(int), 1);
	ShowArayElem(arr, sizeof(arr) / sizeof(int));

	AddArayElem(arr, sizeof(arr) / sizeof(int), 1);
	ShowArayElem(arr, sizeof(arr) / sizeof(int));

	AddArayElem(arr, sizeof(arr) / sizeof(int), 1);
	ShowArayElem(arr, sizeof(arr) / sizeof(int));

}
//void main(){
	//pointerOper();
	//ArrayNameType();
	//ArrayNamePointerOperation();
	//PointerOperationResult();
	//ArrayParam();
	//ArrayParamAccess();

//}