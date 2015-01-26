/*==============================================================================
 *
 *	Dynamixel Drive Module
 *
 *		File Name   	: motor_dx.c
 *   	Version        	: 1.4
 *    	Date           	: 2005.10.20
 *		Modified       	: 2007.01.06 By Pyo, Yoon-Seok
 *		Author         	: Pyo, Yoon-Seok  (ROBIT 1st, Kwangwoon University)
 *		MPU_Type       	: ATmega128(16MHz)
 *		Compiler		: IAR Eebedded Workbench 4.1
 *		Copyright(c) 2007 ROBIT, Kwangwoon University.
 *    	All Rights Reserved.
 *
==============================================================================*/
//------------------------------------------------------------------------------
//	===== Description =====
// 	1. DX ���� ��� ���� ���
// 	2. UART0 ����
//     	- ��żӵ� 1M bps
//		- �������ͷ�Ʈ ����
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                 			=== Include Headerfile ===
//------------------------------------------------------------------------------
#include <iom128.h>
#include "define.h"
#include "uart.c"
#include "motor_dx.h"


//------------------------------------------------------------------------------
//					===== Gloval Variable Number =====
//------------------------------------------------------------------------------
U8 RxInterruptBuffer[256];		// �������ͷ�Ʈ����
U8 RxBufferWritePointer;		// ���Ź��۾���������
U8 RxBufferReadPointer;					// ���Ź����б�������
U8 Parameter[128];						// �Ű�����
U8 RxBuffer[128]; 						// ���Ź���
U8 TxBuffer[128]; 						// �۽Ź���



//------------------------------------------------------------------------------
//									== TxPacket ==
// ��Ź�� = RS485
// �Ű����� = ID, Instruction, Length of Parameters.
//
// 0xFF -> 0xFF -> ID -> LENGTH -> Instruction -> Parameters (1 ~ N) -> CheckSum
//------------------------------------------------------------------------------
U8 TxPacket(U8 ID, U8 Instruction, U8 ParameterLength)
{
    //--------------------------------------------------------------------------
    //		===== ��Ŷ ���� =====
    //--------------------------------------------------------------------------

    U8 Count;					// ��Ŷ�� ���� ��ȣ
    U8 CheckSum;				// ��Ŷ�� ���� ���� ���
    U8 PacketLength;			// �Ű��������� �� ����
	
	TxBuffer[0] = 0xff;						// Start CODE
	TxBuffer[1] = 0xff;						// Start CODE
	TxBuffer[2] = ID;						// ����ID (0~253), BroadcastingID=0xFE
	TxBuffer[3] = ParameterLength + 2;		// Length(Instruction + ParamterLength + Checksum)
	TxBuffer[4] = Instruction;				// ��ɾ� ����(���Ͼ���,���߾���,�б� ��)
	
	for(Count = 0; Count < ParameterLength; Count++)
	{
		TxBuffer[Count+5] = Parameter[Count];			// �Ű����� ����
	}
	
    CheckSum = 0;										// CheckSum �ʱ�ȭ
	PacketLength = ParameterLength + 4 + 2;				// ��Ŷ�� ��ü ���� ����
	
	for(Count = 2; Count < PacketLength-1; Count++)  	// Except 0xFF, Checksum
	{
		CheckSum += TxBuffer[Count];
	}
	
	TxBuffer[Count] = ~CheckSum;                       	// Checksum ����

    //--------------------------------------------------------------------------
    //		===== ��Ŷ ���� =====
    //--------------------------------------------------------------------------

	RS485_TXD;                                         	// RS485 ��¸��� ����
	
    for(Count = 0; Count < PacketLength; Count++)
	{
		sbi(UCSR0A,6);						     		// �۽ſϷ� ���·� ��ȯ
		Uart_Putch( UART0,(TxBuffer[Count]) );         	// ������ ��Ŷ���� MCU->DX
	}
	
	while(!CHECK_TXD0_FINISH);                         	// �۽Ź��� �������� ��ٸ�
	RS485_RXD;                                         	// RS485 �Է¸��� ����
	
	return(PacketLength);								// ��Ŷ�� ��ü���� ����
}

//------------------------------------------------------------------------------
//									== RxPacket ==
// ��Ź�� = RS485
// �ʿ��� �Ķ���� = Total Length of Return Packet.
//------------------------------------------------------------------------------
U8 RxPacket(U8 RxPacketLength)
{
	#define RX_TIMEOUT_COUNT2   3000L
	#define RX_TIMEOUT_COUNT1  (RX_TIMEOUT_COUNT2 * 10L)

	U32 Counter;					// ���۽ð� ���� ����
	U8  Timeout;					// ���ۿ��� �ð�����

    U8  Count;						// ��Ŷ�� ���� ��ȣ
    U8 	Length;						// Length(Instruction + ParamterLength + Checksum)
    U8	Checksum;					// ��Ŷ�� ���� ���� ���


	Timeout = 0;

	for(Count = 0; Count < RxPacketLength; Count++)
	{
		Counter = 0;

        while(RxBufferReadPointer == RxBufferWritePointer)
		{
			if(Counter++ > RX_TIMEOUT_COUNT1)		
			{
				Timeout = 1;	// ���� Ÿ�̹� ���� �߻�
				break;
			}
		}

		if(Timeout)
            break;

        // ���ŵ� �����͸� ���Ź��ۿ� ����
		RxBuffer[Count] = RxInterruptBuffer[RxBufferReadPointer++];
	}

	Length = Count;
	Checksum = 0;

	if(TxBuffer[2] != BROADCASTING_ID)
	{
		if(Timeout && RxPacketLength != 255)
		{
            //----- ����01 : ���� Ÿ�̹� ����
			Uart_Print(UART1,"\r\n [Error:RxD Timeout]");
			CLEAR_BUFFER;
		}
	
		if(Length > 3)
		{
			if(RxBuffer[0] != 0xff || RxBuffer[1] != 0xff )
			{
                //----- ����02 : ��ŸƮ �ڵ�
				Uart_Print(UART1,"\r\n [Error:Wrong Header]");
				CLEAR_BUFFER;
				return 0;
			}
			if(RxBuffer[2] != TxBuffer[2] )
			{
                //----- ����03 : Ÿ�� ID
				Uart_Print(UART1,"\r\n [Error:TxID != RxID]");
				CLEAR_BUFFER;
				return 0;
			}
			if(RxBuffer[3] != Length-4)
			{
                //----- ����04 : ��Ŷ�� ����
				Uart_Print(UART1,"\r\n [Error:Wrong Length]");
				CLEAR_BUFFER;
				return 0;
			}
			
			for(Count = 2; Count < Length; Count++)
				Checksum += RxBuffer[Count];
			
			if(Checksum != 0xff)
			{
                //----- ����05 : CheckSum ����
				Uart_Print(UART1,"\r\n [Error:Wrong CheckSum]");
				CLEAR_BUFFER;
				return 0;
			}
		}
	}
	
    return Length;
}

//------------------------------------------------------------------------------
