#include<iostream>
#include<string>
#include <vector>
#include <deque>
#include <list>
#include <algorithm>
#include <functional>
#include <stack>
#include <set>
using namespace std;

template<typename T>
class Array{
	T *buf;
	int size;
	int capacity;
public:
	explicit Array(int cap = 100) :buf(0), size(0), capacity(cap){
		buf = new T[capacity];
	}

	~Array(){ delete[] buf; }

	void Add(T data){
		buf[size++] = data;
	}
	T operator[] (int idx) const{
		return buf[idx];
	}
	int GetSize() const{
		return size;
	}
};
void vectortest(){

	vector<int> v;

	v.push_back(10);
	v.push_back(20);
	v.push_back(30);
	v.push_back(40);
	vector<int>::iterator iter = v.begin();
	cout << iter[0] << endl;
	cout << iter[1] << endl;
	cout << iter[2] << endl;
	cout << iter[3] << endl << endl;

	iter += 2;
	cout << *iter << endl;
	cout << endl;

	vector<int>::iterator iter2 = iter + 1;
	cout << *iter2 << endl;
	/*vector<int>::iterator iter;
	for (iter = v.begin(); iter != v.end(); ++iter){
	cout << *iter << endl;
	}
	for (unsigned int i = 0; i < v.size(); i++){
	cout << v[i] << endl;
	}*/
}
void dequetest(){

	deque<int> dq;

	dq.push_back(10);
	dq.push_back(20);
	dq.push_back(30);
	dq.push_back(40);
	dq.push_back(50);

	deque<int>::iterator iter = dq.begin();

	cout << iter[0] << endl;
	cout << iter[1] << endl;
	cout << iter[2] << endl;
	cout << iter[3] << endl;
	cout << iter[4] << endl << endl;

	iter += 2;
	cout << *iter << endl;
	cout << endl;

	deque<int>::iterator iter2 = iter + 2;
	cout << *iter2 << endl;
}
void findtest(){
	vector<int> v;

	v.push_back(10);
	v.push_back(20);
	v.push_back(30);
	v.push_back(40);
	v.push_back(50);

	vector<int>::iterator iter;
	iter = find(v.begin(), v.end(), 20);
	cout << *iter << endl;

	iter = find(v.begin(), v.end(), 100);
	if (iter == v.end()){
		cout << "100이 없음" << endl;
	}
}
void sorttest(){
	vector<int> v;
	v.push_back(60);
	v.push_back(20);
	v.push_back(50);
	v.push_back(40);
	v.push_back(10);

	list<int> lt;
	lt.push_back(60);
	lt.push_back(20);
	lt.push_back(50);
	lt.push_back(40);
	lt.push_back(10);

	sort(v.begin(), v.end());
	for (unsigned int i = 0; i < v.size(); i++){
		cout << v[i] << endl;
	}
}
void sortWithFun(){
	vector<int> v;
	v.push_back(50);
	v.push_back(10);
	v.push_back(20);
	v.push_back(40);
	v.push_back(30);

	sort(v.begin(), v.end(), greater<int>());
	for (vector<int>::iterator iter = v.begin(); iter != v.end(); ++iter){
		cout << *iter << " ";
	}

	sort(v.begin(), v.end(), less<int>());
	for (vector<int>::iterator iter = v.begin(); iter != v.end(); ++iter){
		cout << *iter << " ";
	}
	cout << endl;
}
void stackWithDeque(){
	stack<int> st;

	st.push(10);
	st.push(20);
	st.push(30);

	cout << st.top() << endl;
	cout << st.top() << endl;
	cout << st.top() << endl;
	st.pop();
	st.pop();
	st.pop();

	if (st.empty()){
		cout << "stack에 데이터 없음" << endl;
	}

}
void stackWithVector(){
	stack<int, vector<int>>st;

	st.push(10);
	st.push(20);
	st.push(30);

	cout << st.top() << endl;
	st.pop();
	cout << st.top() << endl;
	st.pop();
	cout << st.top() << endl;
	st.pop();
	if (st.empty()){
		cout << "stack에 데이터 없음" << endl;
	}

}
void reverse_iter(){
	vector<int> v;
	v.push_back(10);
	v.push_back(20);
	v.push_back(30);
	v.push_back(40);
	v.push_back(50);

	for (vector<int>::iterator iter = v.begin(); iter != v.end(); ++iter){
		cout << *iter << " ";
	}
	cout << endl;

	vector<int>::reverse_iterator riter = v.rbegin();
	for (; riter != v.rend(); ++riter){
		cout << *riter << " ";
	}
	cout << endl;
}
void iter_forward_reverse(){
	vector<int> v;

	v.push_back(10);
	v.push_back(20);
	v.push_back(30);
	v.push_back(40);
	v.push_back(50);

	vector<int>::iterator normal_iter = v.begin() + 3;
	vector<int>::reverse_iterator reverse_iter(normal_iter);

	cout << "정방향 반복자의 값: " << *normal_iter << endl;
	cout << "역방향 반복자의 값: " << *reverse_iter << endl;
	cout << endl;

	for (vector<int>::iterator iter = v.begin(); iter != normal_iter; ++iter){
		cout << *iter << " ";
	}
	cout << endl;

	for (vector<int>::reverse_iterator riter = reverse_iter; riter != v.rend(); ++riter){
		cout << *riter << " ";
	}
	cout << endl;
}
void notnot(){

	cout << less<int>()(10, 20) << endl;
	cout << less<int>()(20, 20) << endl;
	cout << less<int>()(20, 10) << endl;
	cout << "==========" << endl;
	cout << not2(less<int>())(20, 20) << endl;
	cout << not2(less<int>())(20, 10) << endl;
	cout << endl;

	less<int> l;
	cout << l(10, 20) << endl;
	cout << l(20, 20) << endl;
	cout << l(20, 10) << endl;
	cout << "=========" << endl;
	cout << not2(l)(10, 20) << endl;
	cout << not2(l)(20, 20) << endl;
	cout << not2(l)(20, 10) << endl;
}
void dequettest(){
	vector<int> v(4, 100);
	deque<int> dq(4, 100);

	v.push_back(200);
	dq.push_back(200);

	for (vector<int>::size_type i = 0; i < v.size(); i++){
		cout << v[i] << endl;
	}
	cout << endl;
	for (deque<int>::size_type i = 0; i < dq.size(); i++){
		cout << dq[i] << endl;
	}
	cout << endl;
}
void listAddressPrint(){
	list<int> li;
	li.push_back(10);
	li.push_back(20);
	li.push_back(30);
	li.push_back(40);
	li.push_back(50);

	list<int>::iterator iter = li.begin();
	for (; iter != li.end(); iter++){
		cout << &(*iter) << endl;
	}

	vector<int> v;
	v.push_back(10);
	v.push_back(20);
	v.push_back(30);
	v.push_back(40);
	v.push_back(50);
	vector<int>::iterator vter = v.begin();
	for (; vter != v.end(); vter++){
		cout << &(*vter) << endl;
	}
}
bool Predicate(int n){
	return 10 <= n && n <= 30;
}
void main(){
	list<int> li;
	li.push_back(10);
	li.push_back(20);
	li.push_back(30);
	li.push_back(40);
	li.push_back(50);
	li.push_back(10);

	list<int>::iterator iter;
	for (iter = li.begin(); iter != li.end(); iter++){
		cout << *iter << endl;
	}
	cout << endl;

	li.remove_if(Predicate);
	for (iter = li.begin(); iter != li.end(); iter++){
		cout << *iter << endl;
	}
	cout << endl;



}