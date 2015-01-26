/*
 * uart.c
 *
 * Created: 2014-02-05 오후 11:19:45
 *  Author: apple
 */ 
#define F_CPU 16000000UL
#include <avr/io.h>			//ATmega128 I/O Header
#include <avr/interrupt.h>		//ATmega128 INTERRUPT Header
#include <util/delay.h>			//ATmega128 delay Function Header
#include "uart.h"

void Init_Uart(U08 Com, U32 Uart_Baud)
{
	U16 Temp_UBRR;

	Temp_UBRR = 16000000L/(16L * Uart_Baud) - 1;   	// 통신 보레이트 계산식
	// U2X = 0 일때 (일반모드)
	if( Com == 0 )
	{
		UBRR0H = (Temp_UBRR >> 8);              // 통신속도 설정
		UBRR0L = (Temp_UBRR & 0x00FF);
		
		UCSR0A = (0<<RXC0)  | (1<<UDRE0);		// 수신,송신 상태비트 초기화
		UCSR0B = (1<<RXEN0) | (1<<TXEN0) | (1<<RXCIE0);  		// 수신,송신 기능 활성화
		UCSR0C = (3<<UCSZ00);				// START 1비트/DATA 8비트/STOP 1비트
		
		cbi( DDRE, 0 );                         // RXD0 핀 입력으로 설정
		sbi( DDRE, 1 );                         // TXD0 핀 출력으로 설정
	}
	
	if( Com == 1)
	{
		UBRR1H = (Temp_UBRR >> 8);              // 통신속도 설정
		UBRR1L = (Temp_UBRR & 0x00FF);

		UCSR1A = (0<<RXC1)  | (1<<UDRE1); 	// 수신,송신 상태비트 초기화
		UCSR1B = (1<<RXEN1) | (1<<TXEN1) | (1<<RXCIE1);    	// 수신,송신 기능 활성화
		UCSR1C = (3<<UCSZ10);                   // START 1비트/DATA 8비트/STOP 1비트
		
		cbi( DDRD, 2 );                         // RXD1 핀 입력으로 설정
		sbi( DDRD, 3 );                         // TXD1 핀 출력으로 설정
	}
}

void Uart_Putch(U08 Com, U08 Data)
{
	switch(Com)
	{
		case 0:
		while(!( UCSR0A & (1<<UDRE0)) );    // 송신가능시점까지 대기
		UDR0 = Data;                     // 데이터를 전송한다
		break;
		
		case 1:
		while(!( UCSR1A & (1<<UDRE1)) );    // 송신가능시점까지 대기
		UDR1 = Data;                     // 데이터를 전송한다
		break;
	}
}
unsigned char Uart_Getch0()
{
	while(!(UCSR0A & (1<<RXC0)));
	return UDR0;                    // 데이터를 전송한다
}
unsigned char Uart_Getch1(){
	while(!(UCSR1A & (1<<RXC1)));
	return UDR1;
}
