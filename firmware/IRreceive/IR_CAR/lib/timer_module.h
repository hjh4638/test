/*
 * timer_module.h
 *
 * Created: 2014-01-27 오후 11:06:29
 *  Author: apple
 */ 


#ifndef TIMER_MODULE_H_
#define TIMER_MODULE_H_



#include <avr/sfr_defs.h>
#include <avr/io.h>

void timer_set(){
	TCCR0 |= _BV(0);
	TCCR0 |= _BV(1);
	//64분주 4us
	TCNT0=231;//256-231 =25
	TIMSK=0x01;//overflow 인터럽트 온

}

void timer1_set(){
	TCCR1B=0x00;
	TCCR1A=0x00;

}
#endif /* TIMER_MODULE_H_ */