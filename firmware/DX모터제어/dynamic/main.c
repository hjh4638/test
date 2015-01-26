/*
 * dynamic.c
 *
 * Created: 2014-02-05 오후 11:17:56
 *  Author: apple
 */ 


#define F_CPU 16000000UL
#include <avr/io.h>			//ATmega128 I/O Header
#include <avr/interrupt.h>		//ATmega128 INTERRUPT Header
#include <util/delay.h>			//ATmega128 delay Function Header
#include "uart.h"
#include "dynamic.h"

void array_clear(unsigned char* array, unsigned char size){
	unsigned char i;
	for(i=0;i<size;i++){
		array[i]=0;
	}
}
typedef struct motor_state{
	U08 id;
	U08 position_l;
	U08 position_h;
} Mortor_State;

Mortor_State mortor_list[8];
U08 rx_buffer[8];
volatile U08 flag=0; 


ISR(USART1_RX_vect){
	U08 buffer;
	Disable_ISR();
	
	buffer=UDR1;
	switch(buffer){
		case 'a':
		Set_Id(1);
		break;
		case 'b':
		Action_Postion_Speed(0xfe,1,255,3,0xff);	
		break;
		case 'c':
		Action_Postion_Speed(0xfe,0,0,3,0xff);
		break;
		case 'd':
		ON_OFF_Torque(0xfe,0);
		break;
		case 'e':
		RxPosition(1);
		break;
		case 'f':
	
		break;
		case 'g':
		Set_Return_Delay(250);
		break;
	}
	
	Enable_ISR();
}

ISR(USART0_RX_vect){
	U08 buffer;
	Disable_ISR();
	buffer=UDR0;
	rx_buffer[flag]=buffer;
	
	flag++;
	if(flag == 8){
		//param=~rx_buffer[5];
		//param-=rx_buffer[2];
		//param-=rx_buffer[3];
		//Uart_Putch(1,rx_buffer[2]);
		//Uart_Putch(1,param);
		//array_clear(rx_buffer,sizeof(rx_buffer));
		//flag=0;
		Mortor_State mo;
		mo.id=rx_buffer[2];
		mo.position_l=rx_buffer[5];
		mo.position_h=rx_buffer[6];
		
		mortor_list[mo.id-1]=mo;
		//Uart_Putch(1,mo.id);
		//Uart_Putch(1,mo.position_l);
		//Uart_Putch(1,mo.position_h);
		array_clear(rx_buffer,sizeof(rx_buffer));
		flag=0;
	}
	Enable_ISR();
}
void init_main(){
	Disable_ISR();
	sbi(DDRE,2);
	PORTE=0x00;
	Init_Uart(0, 1000000);
	Init_Uart(1, 57600);
	Enable_ISR();
}
void transmit_paket(Mortor_State mo){
	//U08 check = mo.id+11+WRITE_DATA_INS+CW_COM_MARGIN_ADDR+255+255+254+254+mo.position_l+mo.position_h;
	//check = ~check;
	
	//Uart_Putch(1,0xff);
	//Uart_Putch(1,0xff);
	Uart_Putch(1,mo.id);
	//Uart_Putch(1,11);
	//Uart_Putch(1,WRITE_DATA_INS);
	//Uart_Putch(1,CW_COM_MARGIN_ADDR);
	//Uart_Putch(1,255);
	//Uart_Putch(1,255);
	//Uart_Putch(1,254);
	//Uart_Putch(1,254);
	Uart_Putch(1,mo.position_l);
	Uart_Putch(1,mo.position_h);
	//Uart_Putch(1,0);
	//Uart_Putch(1,0);
	//Uart_Putch(1,check);
			
}
int main(void)
{
	int i,k=0;
	int mortor_size=8;
	init_main();
	
    while(1)
    {
		Uart_Putch(0,'a');
		Uart_Putch(1,'a');
		for(i=1;i<=mortor_size;i++){
			RxPosition(i);
		}
		for(k=0;k<mortor_size;k++){
			transmit_paket(mortor_list[k]);
		//transmit_paket(mortor_list[0]);
		}
		_delay_ms(500);
	}
}