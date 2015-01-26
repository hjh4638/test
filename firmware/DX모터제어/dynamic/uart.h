/*
 * uart.h
 *
 * Created: 2014-02-05 오후 11:18:20
 *  Author: apple
 */ 


#ifndef UART_H_
#define UART_H_
#include "define.h"
void Init_Uart(U08 Com, U32 Uart_Baud);
void Uart_Putch(U08 Com, U08 Data);
unsigned char Uart_Getch0();
unsigned char Uart_Getch1();


#endif /* UART_H_ */