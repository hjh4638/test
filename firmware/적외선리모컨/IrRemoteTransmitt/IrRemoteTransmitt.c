/*
 * IrRemoteTransmitt.c
 *
 * Created: 2014-01-18 오전 2:12:31
 *  Author: apple
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <util/delay.h>

void pwm1_set(){//37.9kh 26us
	SREG &= ~_BV(7);
	
	DDRB=0xff;
	PORTB=0x00;

	TCCR1A=0xaa; //fastpwm,14모드
	TCCR1B=0x1a;//8분주,500ns
	ICR1=52;
	TCNT1=0;
	OCR1A=26;
	
	
	SREG |= _BV(7);
}
void carry_freq(){
	PORTC &= ~_BV(5);
	_delay_us(13);
	PORTC |= _BV(5);
	_delay_us(13);
}
//반드시 0 혹은 1이 들어가야함
void emit_bit(unsigned char bit){
	unsigned char i;
	if(bit == 0){
		for(i=0;i<22;i++){
			carry_freq();
		}
		PORTC &= ~_BV(5);
		_delay_us(563);
	}
	else if(bit==1){
		for(i=0;i<22;i++){
			carry_freq();
		}
		PORTC &= ~_BV(5);
		_delay_us(1687);
	}
}
void emit_byte(unsigned char byte){
	
	unsigned char i;
	for(i=0;i<8;i++){
		unsigned char com=0;
		com = byte & 1<<(7-i);
		if(com == 0){
			emit_bit(0);
		}
		else{
			emit_bit(1);
		}
	}
}
void emit_remote_light(unsigned char address,unsigned char data){
	
	unsigned char i=0;
	for(i=0;i<173;i++){//lead
		carry_freq();
	}
	_delay_us(4500);
	emit_byte(address);
	emit_byte(~address);
	emit_byte(data);
	emit_byte(~data);
	
	emit_bit(1);
		
}
void port_set(){
	DDRC=0x00;
	DDRC |= _BV(5);
	PORTC &= ~_BV(5);
}
unsigned char c5,c4,c3,c2;
int main(void)
{
	port_set();
	while(1)
	{
		c5 = (PINC & 1<<5);
		c4 = (PINC & 1<<4);
		c3 = (PINC & 1<<3);
		c2 = (PINC & 1<<2);
		if( c5==0){//전진
			emit_remote_light(0x01,0x01);
		}
		else if( c4==0){//후진
			emit_remote_light(0x01,0x02);
		}
		else if( c3==0){//좌회전
			emit_remote_light(0x01,0x03);
		}
		else if( c2==0){//우회전
			emit_remote_light(0x01,0x04);
		}
		////emit_remote_light(0x01,0x04);
		PORTC &= ~_BV(5);
		//_delay_ms(20);

	}
}