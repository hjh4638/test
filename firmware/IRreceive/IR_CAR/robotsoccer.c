/*
 * IR_CAR.c
 *
 * Created: 2014-01-27 오후 9:55:10
 *  Author: apple
 */ 
#define F_CPU 16000000UL


#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sfr_defs.h>
#include <util/delay.h>
#include "lib/array_util.h"
#include "lib/timer_module.h"
#include <avr/wdt.h>

#define Reset_AVR() wdt_enable(WDTO_2S);

void Main_Init(void);

//적외선에서 받는 비트 신호
unsigned char ir_data[32]={};
	
//비트들을 1바이트 코드로 만들어서 담는 배열
unsigned char code[4]={};

volatile unsigned char period;
volatile unsigned char ir_code_count;
volatile unsigned char uart_transmit_count=0;

void ir_data_set(){
	if((period>=7)&&(period<=16)){
		ir_data[ir_code_count]=0;
		ir_code_count++;
	}
	else if((period>=17)&&(period<=26)){
		ir_data[ir_code_count]=1;
		ir_code_count++;
	}
	else
	{
		array_clear(ir_data,sizeof(ir_data));
		ir_code_count=0;
	}
}

ISR(INT0_vect){
	SREG &= ~_BV(7);
	ir_data_set();
	if(ir_code_count>sizeof(ir_data)-1){
		bitarray_to_byte(ir_data,sizeof(ir_data),code,sizeof(code));
		array_clear(ir_data,sizeof(ir_data));
		ir_code_count=0;
		uart_transmit_count=1;
	}
	period=0;	
	SREG |= _BV(7);
}
ISR(TIMER0_OVF_vect){
	SREG &= ~_BV(7);
	period+=1;
	TCNT0=231;
	SREG |= _BV(7);
}

void int0_set(){
	PIND &= ~_BV(2);//INT0 입력설정
	MCUCR |= _BV(1);
	MCUCR &= ~_BV(0);
	GICR |= _BV(6);
}

void pwm1_set(){//37.9kh 26us
	SREG &= ~_BV(7);
		
	TCCR1A=0xaa; //fastpwm,14모드
	TCCR1B=0x1d;//1024분주s
	ICR1=52;
	TCNT1=0;
	OCR1A=26;
	OCR1B=26;
	
	SREG |= _BV(7);
}
int main(void)
{
	Main_Init();
	//Reset_AVR();
    while(1)
    {		
		if(uart_transmit_count == 1){
			PORTD |= _BV(0);
			//_delay_ms(1000);
			SREG &= ~_BV(7);
			
			//616A6996//위
			//616AE916//아래
			//616AB946//왼쪽
			//616A7986//오른쪽
			
			//20DF40BF
			//20DFC03F
			//20DF00FF
			//20DF807F
			
				//DA3034C9// 위
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0x40 &&code[3] == 0xbf){//전진
					//PORTB |=_BV(5);
					//PORTB |=_BV(0);
					
					PORTB |=_BV(5);//왼전진
					PORTB |=_BV(4);//우전진
				}
				//A4EB0BAD // 아래
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0xc0 &&code[3] == 0x3f){//후진
					//PORTB |=_BV(3);
					//PORTB |=_BV(4);
					
					PORTB |=_BV(3);//왼전진
					PORTB |=_BV(0);//우전진
				}
				//9F880A37 // 왼쪽
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0x00 &&code[3] == 0xff){//좌회전
					//PORTB |=_BV(5);//왼전진
					//PORTB |=_BV(4);//우전진
					
					PORTB |=_BV(3);
					PORTB |=_BV(4);
				}
				//D4CD3353//오른쪽
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0x80 &&code[3] == 0x7f){//우회전
					//PORTB |=_BV(3);//왼전진
					//PORTB |=_BV(0);//우전진
					
					PORTB |=_BV(5);
					PORTB |=_BV(0);
				}
			//}
			array_clear(code,sizeof(code));
			uart_transmit_count=0;
			//PORTD |= _BV(0);
			_delay_ms(200);
			SREG |= _BV(7);
			

		}
		PORTB &= 0x06;
		
		PORTD &= ~_BV(0);
	   // TODO:: Please write your application code 
    }
}
void Main_Init(void){
	SREG &= ~_BV(7);
	int0_set();
	//pwm1_set();
	timer_set();
	DDRD |= _BV(0);
	DDRB=0xff;
	PORTB=0x00;
	
	PORTB |= _BV(1);
	PORTB |= _BV(2);
	
	period=0;
	ir_code_count=0;
	SREG |= _BV(7);
}