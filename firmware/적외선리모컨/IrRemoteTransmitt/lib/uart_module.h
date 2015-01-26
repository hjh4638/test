/*
 * uart_module.h
 *
 * Created: 2014-01-14 오전 12:28:01
 *  Author: apple
 */ 


#ifndef UART_MODULE_H_
#define UART_MODULE_H_

#include <avr/sfr_defs.h>
#include <avr/io.h>

unsigned char Uart_Getch(void){
	while(!(UCSR1A & (1<<RXC1)));
	return UDR1;
}
void Uart_Putch(unsigned char PutData){
	while(!(UCSR1A &(1<<UDRE1)));
	UDR1=PutData;
}
void uart_setting(){
	
	UBRR0H=0;
	UBRR0L=16;
	UCSR0A=(0<<RXC0) | (1<<UDRE0);
	UCSR0B=(1<<RXEN0)| (1<<TXEN0);
	UCSR0C=(3<<UCSZ00);
	DDRE &= ~_BV(0);
	DDRE |= _BV(1);
	
}
void uart1_setting(){
	UBRR1H=0; //baud 9600으로 설정
	UBRR1L=103;
	
	UCSR1A=(0<<RXC1) | (1<<UDRE1);
	UCSR1B=(1<<RXEN1)| (1<<TXEN1);
	UCSR1C=(3<<UCSZ10);
	DDRD &= ~_BV(2);
	DDRD |= _BV(3);
	
}

#endif /* UART_MODULE_H_ */