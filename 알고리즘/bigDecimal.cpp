#include <iostream>
#include <cassert>
using namespace std;

class BigDecimal{
private:
	//저장 공간의 시작 번지를 저장
	unsigned char *digit;
	//저장 공간의 크기를 저장
	int size;
	//부호 변수 (false:양수, true:음수)
	bool sign;
public:
	BigDecimal(unsigned char* str, int size){
		this->digit = new unsigned char[size];
		for (int i = 0; i < size; i++){
			//str이 숫자로 이루어져 있을때
			digit[i] = str[size - i - 1] - 48;
		}
		this->size = size;
		this->sign = false;
	}
	BigDecimal(){
		this->digit = 0;
		this->size = 0;
		this->sign = false;
	}
	void printDecimal(){
		int i = this->size -1;
		if (this->sign)
			cout << "-";

		for (; i >= 0; i--){
			unsigned char num = this->digit[i] + 48;
			cout << num ;
		}
		cout << endl;
	}
	bool operator==(BigDecimal A){
		if (A.size != this->size){
			return false;
		}
		for (int i = 0; i < A.size; i++){
			if (A.digit[i] != this->digit[i]){
				return false;
			}
		}
		return true;
	}
	void operator=(BigDecimal A){
		this->size = A.size;
		this->sign = A.sign;
		delete this->digit;

		this->digit = new unsigned char[this->size];
		for (int i = 0; i < size; i++){
			//str이 숫자로 이루어져 있을때
			this->digit[i] = A.digit[i];
		}
	}
	bool operator>(BigDecimal A){
		int i = A.size-1;

		if (A.size < this->size){
			return true;
		}
		else if (A.size > this->size){
			return false;
		}
		else{
			for (; i >= 0; i--){
				if (A.digit[i] < this->digit[i]){
					return true;
				}
				else if (A.digit[i] > this->digit[i]){
					return false;
				}
			}
		}
	}
	//꺼꾸로 연산됨
	BigDecimal operator%(BigDecimal A){
		BigDecimal result;
		int i;

		result.digit = new unsigned char[A.size];
		for (i = 0; i < A.size; i++){
			result.digit[i] = A.digit[i];
		}
		result.size = A.size;
		result.sign = 0;

		if (!(A>(*this))){
			return result;
		}

		unsigned char* ptrForOrigin = result.digit;

		result.digit += (result.size - this->size);
		result.size = this->size;
		
		i = (A.size - this->size);
		for (; i >= 0; i--){
			while (result > (*this)){
				MinusForDivide(&result, this);
			}
			result.digit--;

			if (result.digit[result.size] != 0){
				result.size++;
			}
		}
		result.digit = ptrForOrigin;

		i = A.size - 1;

		while (i > 0){
			if (result.digit[i] != 0x00)
				break;
			i--;
		}
		result.size = i + 1;

		return result;
		
	}
	
	void MinusForDivide(BigDecimal *A, BigDecimal *B){
		int i;
		unsigned char temp = 0;

		for (i = 0; i < B->size; i++){
			if (A->digit[i] >= (B->digit[i] + temp)){
				A->digit[i] = A->digit[i] - B->digit[i] - temp;
				temp = 0;
			}
			else{
				A->digit[i] = A->digit[i] + 0x0A - B->digit[i] - temp;
				temp = 0x01;
			}
		}
		for (; i < A->size; i++){
			if (A->digit[i] >= temp){
				A->digit[i] = A->digit[i] - temp;
				temp = 0;
			}
			else{
				A->digit[i] = A->digit[i] + 0x0A - temp;
				temp = 0x01;
			}
		}
		while (!A->digit[i - 1] && i>1){
			A->size--;
			i--;
		}
	}
	BigDecimal modular(BigDecimal* A, BigDecimal* B){
		BigDecimal result;
		int i;

		result.digit = new unsigned char[A->size];
		for (i = 0; i < A->size; i++){
			result.digit[i] = A->digit[i];
		}
		result.size = A->size;
		result.sign = 0;

		if (!(*A>(*this))){
			return result;
		}

		unsigned char* ptrForOrigin = result.digit;

		result.digit += (result.size - this->size);
		result.size = this->size;

		i = (A->size - this->size);
		for (; i >= 0; i--){
			while (result > (*this)){
				MinusForDivide(&result, this);
			}
			result.digit--;

			if (result.digit[result.size] != 0){
				result.size++;
			}
		}
		result.digit = ptrForOrigin;

		i = A->size - 1;

		while (i > 0){
			if (result.digit[i] != 0x00)
				break;
			i--;
		}
		result.size = i + 1;

		return result;
	}
};/*
int main(void){
	BigDecimal test1((unsigned char*)"10099",5);
	BigDecimal test2((unsigned char*)"10000", 5);

	BigDecimal test3 = test1%test2;
	test3.printDecimal();
	test3 = test2%test1;
	test3.printDecimal();
	
	test3 = test2.operator%(test1);
	test3.printDecimal();
	
	if (test1 == test2){
		cout << "test" << endl;
	}
	if (test1 > test2){
		cout << "test1이 더 크다" << endl;
	}
	
}*/