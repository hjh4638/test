#include <iostream>
#include <algorithm>
using namespace std;
class Point{
	int x, y;
public:
	Point(int _x = 0, int _y = 0) :x(_x), y(_y){}
	void Print() const{
		cout << x << ',' << y << endl;
	}
	int GetX() const{ return this->x; }
	int GetY() const{ return this->y; }
	/*const Point operator-(const Point& arg) const{
		return Point(x - arg.x, y - arg.y);
	}*/
};
const Point operator+(const Point& argL, const Point& argR){
	int xx = argL.GetX() + argR.GetX();
	int yy = argL.GetY() + argR.GetY();
	return Point(argL.GetX() + argR.GetX(), argL.GetY() + argR.GetY());
}
void Client();
void PrintHello(){
	cout << "Hello!" << endl;
	Client();
}
void Client(){
	cout << "난 client" << endl;
}



//콜백!!!
void For_each(int *begin, int *end, void(*pf)(int)){
	while (begin != end){
		pf(*(begin++));
	}
}

void Print1(int n){
	cout << n << ' ';
}void Print2(int n){
	cout << n*n << " ";
}
void Print3(int n){
	cout << "정수 : " << n << endl;
}

struct Functor1{
	void operator()(int n){
		cout << n << " ";
	}
};
struct Functor2{
	void operator()(int n){
		cout << n*n << " ";
	}
};
struct Functor3{
	void operator()(int n){
		cout << "정수 : "<<n << " ";
	}
};

bool pred_less(int a, int b){
	return a < b;
}
struct Less{
	bool operator()(int a, int b){
		return a < b;
	}
};
