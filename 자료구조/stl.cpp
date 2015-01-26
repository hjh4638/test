
#include <iostream>

using namespace std;
// ���ø� �Ķ������ int Size�� non-type  �Ķ�����Դϴ�.
template<typename T, int Size>
class Stack
{
public:
	Stack()
	{
		Clear();
	}

	// �ʱ�ȭ �Ѵ�.
	void Clear()
	{
		m_Count = 0;
	}

	// ���ÿ� ����� ����
	int Count()
	{
		return m_Count;
	}

	// ����� �����Ͱ� ���°�?
	bool IsEmpty()
	{
		return 0 == m_Count ? true : false;
	}

	// �����͸� ������ �ִ� �ִ� ����
	int GetStackSize()
	{
		return Size;
	}

	// �����͸� �����Ѵ�.
	bool push(T data)
	{
		// ������ �� �ִ� ������ �Ѵ��� �����Ѵ�.
		if (m_Count >= Size)
		{
			return false;
		}

		// ���� �� ������ �ϳ� �ø���.
		m_aData[m_Count] = data;
		++m_Count;

		return true;
	}

	// ���ÿ��� ������.
	T pop()
	{
		// ����� ���� ���ٸ� 0�� ��ȯ�Ѵ�.
		if (m_Count  < 1)
		{
			return 0;
		}

		// ������ �ϳ� ���� �� ��ȯ�Ѵ�.
		--m_Count;
		return m_aData[m_Count];
	}

private:
	T  m_aData[Size];
	int  m_Count;
};
