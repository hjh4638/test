/*==============================================================================
 *
 *   USART Communication Module
 *
 *   	File Name   	: uart.c
 *  	Version        	: 1.5
 *    	Date           	: 2005.10.10
 *		Modified       	: 2007.02.10 By Pyo, Yoon-Seok
 *		Author         	: Pyo, Yoon-Seok  (ROBIT 1st, Kwangwoon University)
 *		MPU_Type       	: ATmega128(16MHz)
 *		Compiler		: IAR Eebedded Workbench 4.1
 *		Copyright(c) 2007 ROBIT, Kwangwoon University.
 *    	All Rights Reserved.
 *
==============================================================================*/

#include <iom128.h>
#include "define.h"
#include "uart.h"

#define UART0_RX_INT_ENABLE				// �������ͷ�Ʈ0 Ȱ��ȭ
//#define UART1_RX_INT_ENABLE			// �������ͷ�Ʈ1 Ȱ��ȭ

//------------------------------------------------------------------------------
//     				===== Uart_Init =====
//             		: ����ϴ� �ӵ��� �ø��� ����� �ʱ�ȭ �Ѵ�.
//------------------------------------------------------------------------------
void Init_Uart(U08 Com, U32 Uart_Baud)
{
	U16 Temp_UBRR;

	Temp_UBRR = AVR_CLK/(16L * Uart_Baud) - 1;   	// ��� ������Ʈ ����
													// U2X = 0 �϶� (�Ϲݸ��)
	
    //---------------------------- UART0 �ʱ�ȭ --------------------------------
	if( Com == UART0 )                           	
	{
		UBRR0H = (Temp_UBRR >> 8);              // ��żӵ� ����
		UBRR0L = (Temp_UBRR & 0x00FF);
		
		UCSR0A = (0<<RXC0)  | (1<<UDRE0);		// ����,�۽� ���º�Ʈ �ʱ�ȭ
        UCSR0B = (1<<RXEN0) | (1<<TXEN0);  		// ����,�۽� ��� Ȱ��ȭ
		UCSR0C = (3<<UCSZ00);					// START 1��Ʈ/DATA 8��Ʈ/STOP 1��Ʈ
		
		cbi( DDRE, 0 );                         // RXD0 �� �Է����� ����
		sbi( DDRE, 1 );                         // TXD0 �� ������� ����
		
		#ifdef UART0_RX_INT_ENABLE				// UART0_RX_INT_ENABLE �����ø�
			sbi(UCSR0B, RXCIE0);              	// �������ͷ�Ʈ0 Ȱ��ȭ
		#endif
	}
	
    //---------------------------- UART1 �ʱ�ȭ --------------------------------
	if( Com == UART1)
	{
		UBRR1H = (Temp_UBRR >> 8);              // ��żӵ� ����
		UBRR1L = (Temp_UBRR & 0x00FF);

		UCSR1A = (0<<RXC1)  | (1<<UDRE1); 		// ����,�۽� ���º�Ʈ �ʱ�ȭ
		UCSR1B = (1<<RXEN1) | (1<<TXEN1);    	// ����,�۽� ��� Ȱ��ȭ
		UCSR1C = (3<<UCSZ10);                   // START 1��Ʈ/DATA 8��Ʈ/STOP 1��Ʈ
		
		cbi( DDRD, 2 );                         // RXD1 �� �Է����� ����
		sbi( DDRD, 3 );                         // TXD1 �� ������� ����
		
		#ifdef UART1_RX_INT_ENABLE				// UART1_RX_INT_ENABLE �����ø�
			sbi(UCSR1B, RXCIE1);              	// �������ͷ�Ʈ1 Ȱ��ȭ
		#endif
	}

}

//----------------------------------------------------------------------------
//       			===== Uart_Getch =====
//              	: �ø��� ��Ʈ�� ���� 1����Ʈ �����͸� �޴´�.
//----------------------------------------------------------------------------
U08 Uart_Getch(U08 Com)
{
    long time;
	switch( Com )
	{
		case UART0:
			while(!( UCSR0A & (1<<RXC0)) )    // ���ſϷ���� ���
            {
                if(time==0)
                {
                    return time;                    // �����ð��̻� ����� ����
                }
                time--;
            }
			return UDR0;                       // ���ŵ����� ��ȯ
		
		case UART1:
			while(!( UCSR1A & (1<<RXC1)) )    // ���ſϷ���� ���
            {
                if(time==0)
                {
                    return time;                    // �����ð��̻� ����� ����
                }
                time--;
            }
			return UDR1;                       // ���ŵ����� ��ȯ
		
        default:
			return 0;
	}
}

//----------------------------------------------------------------------------
//   				===== Uart_Putch =====
//             		: �ø��� ��Ʈ�� 1����Ʈ ������.
//----------------------------------------------------------------------------
void Uart_Putch(U08 Com, U08 PutData)
{
	switch(Com)
	{
		case UART0:
			while(!( UCSR0A & (1<<UDRE0)) );    // �۽Ű��ɽ������� ���
			UDR0 = PutData;                     // �����͸� �����Ѵ�
			break;
		
		case UART1:
			while(!( UCSR1A & (1<<UDRE1)) );    // �۽Ű��ɽ������� ���
			UDR1 = PutData;                     // �����͸� �����Ѵ�
			break;
	}
}

//----------------------------------------------------------------------------
//          		===== Uart_Print =====
//             		: �ø���� ���ڿ��� ������.
//----------------------------------------------------------------------------
void Uart_Print(U08 Com, char *UartPrintData)
{
	while(*UartPrintData != '\0')				// NULL���� ������ �ݺ�
	{
		Uart_Putch( Com, *UartPrintData );		// 1����Ʈ�� ����
		
		if(*UartPrintData == 0x0A)  			// LF �� CR�� ���Ĵ�
			Uart_Putch( Com, 0x0D );
		
		UartPrintData++;
	}
}

//----------------------------------------------------------------------------
//        			===== Uart_U08Bit_PutNum =====
//             		: �ø���� unsigned char �� ���ڸ� ���
//----------------------------------------------------------------------------
void Uart_U08Bit_PutNum(U08 Com, U08 NumData)
{
	U08 TempData;

	TempData =  NumData/100;
	Uart_Putch(Com, TempData+48);			// 100 �ڸ� ������ ���
	
	TempData = (NumData%100)/10;
	Uart_Putch(Com, TempData+48);      		// 10  �ڸ� ������ ���
	
	TempData =  NumData%10;
	Uart_Putch(Com, TempData+48);     	 	// 1   �ڸ� ������ ���
}

//----------------------------------------------------------------------------
//        			===== Uart_U08Bit_PutNum_Substance =====
//              	: �ø���� unsigned char �� ���ڸ� ���(�������� ����)
//----------------------------------------------------------------------------
void Uart_U08Bit_PutNum_Substance(U08 Com, U08 NumData)
{
	U08 TempData100;
	U08 TempData10;
	U08 TempData1;

	TempData100 =  NumData/100;
	if(TempData100 > 0)							// 100 �ڸ��� 0���� ũ�� ���
		Uart_Putch(Com, TempData100+48);   		// 100 �ڸ� ���
	
	TempData10 = (NumData%100)/10;
	if(TempData10 > 0)							// 10  �ڸ��� 0���� ũ�� ���
		Uart_Putch(Com, TempData10+48);   		
    else 										// 10  �ڸ��� 0�̸�
    {
        if(TempData100 > 0)						// 100 �ڸ��� �����ϸ� 0���
	        Uart_Putch(Com, TempData10+48);   	// 100 �ڸ��� �������� ������ ������� ����
    }

	TempData1 = NumData%10;
	Uart_Putch(Com, TempData1+48);      		// 1   �ڸ��� ������ ���
}



//----------------------------------------------------------------------------
//        			===== Uart_U10Bit_PutNum =====
//             		: �ø���� unsigned char �� ���ڸ� ���
// * �ӽ����� *
//----------------------------------------------------------------------------
void Uart_U10Bit_PutNum(U08 Com, U16 NumData)
{
	U16 TempData;

	TempData =  NumData/1000;
	Uart_Putch(Com, TempData+48);			// 1000 �ڸ� ������ ���
	
	TempData = (NumData%1000)/100;
	Uart_Putch(Com, TempData+48);			// 100  �ڸ� ������ ���
	
	TempData = (NumData%100)/10;
	Uart_Putch(Com, TempData+48);      		// 10   �ڸ� ������ ���
	
	TempData =  NumData%10;
	Uart_Putch(Com, TempData+48);      		// 1    �ڸ� ������ ���
}

//----------------------------------------------------------------------------
//        			===== Uart_U10Bit_PutNum =====
//             		: �ø���� unsigned char �� ���ڸ� ���
// * �ӽ����� *
//----------------------------------------------------------------------------
void Uart_U10Bit_PutNum3(U08 Com, U16 NumData)
{
	U16 TempData;
	
	TempData = (NumData%1000)/100;
	Uart_Putch(Com, TempData+48);			// 100  �ڸ� ������ ���
	
	TempData = (NumData%100)/10;
	Uart_Putch(Com, TempData+48);      		// 10   �ڸ� ������ ���
	
	TempData =  NumData%10;
	Uart_Putch(Com, TempData+48);      		// 1    �ڸ� ������ ���
}

//----------------------------------------------------------------------------
//          		===== Uart_U16Bit_PutNum =====
//          		: �ø���� unsigned char �� ���ڸ� ���
//----------------------------------------------------------------------------
void Uart_U16Bit_PutNum(U08 Com, U16 NumData)
{
	U16 TempData;

	TempData = NumData/10000;
	Uart_Putch(Com, TempData+48);      // 10000 	�ڸ� ������ ���
	
	TempData = (NumData%10000)/1000;
	Uart_Putch(Com, TempData+48);      // 1000 	�ڸ� ������ ���
	
	TempData = (NumData%1000)/100;
	Uart_Putch(Com, TempData+48);      // 100  	�ڸ� ������ ���
	
	TempData = (NumData%100)/10;
	Uart_Putch(Com, TempData+48);      // 10   	�ڸ� ������ ���
	
	TempData =  NumData%10;
	Uart_Putch(Com, TempData+48);      // 1   	�ڸ� ������ ���
}

//----------------------------------------------------------------------------
//        			===== Uart_U16Bit_PutNum_Substance =====
//              	: �ø���� unsigned int �� ���ڸ� ���(�������� ����)
//----------------------------------------------------------------------------
void Uart_U16Bit_PutNum_Substance(U08 Com, U16 NumData)	// 0~65535
{
    U16 TempData10000;
    U16 TempData1000;
    U16 TempData100;
    U16 TempData10;
    U16 TempData1;

    TempData10000 = (NumData/10000);
    if(TempData10000 > 0)							// 10000 �ڸ��� 0���� ũ�� ���
        Uart_Putch(Com, TempData10000+48);
													// 10000 �ڸ��� 0�̸� ������� ����

    TempData1000 = ((NumData%10000)/1000);			
    if(TempData1000 > 0)							// 1000  �ڸ��� 0���� ũ�� ���
        Uart_Putch(Com, TempData1000+48);
    else											// 1000  �ڸ��� 0�̸�
    {
        if(TempData10000 > 0)						// 10000 �ڸ��� �����ϸ� 0���
            Uart_Putch(Com, TempData1000+48);	    // 10000 �ڸ��� �������� ������ ������� ����
    }

    TempData100 = ((NumData%1000)/100);				
    if(TempData100 > 0)								// 100   �ڸ��� 0���� ũ�� ���
        Uart_Putch(Com, TempData100+48);
    else											// 100   �ڸ��� 0�̸�
    {
        if(TempData1000 > 0)						// 1000  �ڸ��� �����ϸ� 0���
            Uart_Putch(Com, TempData100+48);
        else										// 1000  �ڸ��� �������� ������						
        {
            if(TempData10000 > 0)					// 10000 �ڸ��� �����ϸ� 0���
                Uart_Putch(Com, TempData100+48);	// 10000 �ڸ��� �������� ������ ������� ����
        }											
    }

    TempData10 = ((NumData%100)/10);
    if(TempData10 > 0)								// 10    �ڸ��� 0���� ũ�� ���
        Uart_Putch(Com, TempData10+48);			
    else											// 10    �ڸ��� 0�̸�
    {
        if(TempData100 > 0)							// 100   �ڸ��� �����ϸ� 0���
            Uart_Putch(Com, TempData10+48);
        else										// 100   �ڸ��� �������� ������
        {
            if(TempData1000 > 0)					// 1000  �ڸ��� �����ϸ� 0���
                Uart_Putch(Com, TempData10+48);	
            else									// 1000  �ڸ��� �������� ������	
            {
                if(TempData10000 > 0)				// 10000 �ڸ��� �����ϸ� 0���
                    Uart_Putch(Com, TempData10+48);	// 10000 �ڸ��� �������� ������ ������� ����
            }
        }
    }
	TempData1 = NumData%10;
	Uart_Putch(Com, TempData1+48);      // 1�ڸ��� ���� 0�̶� �׳� ��´�.
 }

//----------------------------------------------------------------------------
//         			===== Uart_ByteToHexPutch =====
//         			:8��Ʈ ����Ÿ�� ���� ����Ѵ�.
//----------------------------------------------------------------------------
void Uart_ByteToHexPutch(U08 Com, U08 ByteData)
{
	U08 HexData;
	U08 Hex_Table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	
	HexData = Hex_Table[ByteData>>4];
	Uart_Putch(Com, HexData);            // ���� ��Ʈ�� ���
	
	HexData = Hex_Table[ByteData&0x0F];
	Uart_Putch(Com, HexData);            // ���� ��Ʈ�� ���
}

//----------------------------------------------------------------------------
//         			===== Uart_WordToHexPutch =====
//         			:16��Ʈ ����Ÿ�� ���� ����Ѵ�.
//	*** ���� : 3�ڸ��� ���
//----------------------------------------------------------------------------
void Uart_WordToHexPutch(U08 Com, U16 WordData)
{
	U08 HexData;
	U08 Hex_Table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	

	HexData = Hex_Table[(WordData>>8) & 0x000F];
	Uart_Putch(Com, HexData);            // ���� ��Ʈ�� ���

	HexData = Hex_Table[(WordData>>4) & 0x000F];
	Uart_Putch(Com, HexData);            // ���� ��Ʈ�� ���

    HexData = Hex_Table[WordData & 0x000F];
	Uart_Putch(Com, HexData);            // ���� ��Ʈ�� ���
}


