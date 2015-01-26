/*
 * timer_module.h
 *
 * Created: 2014-01-14 오전 12:32:46
 *  Author: apple
 */ 


#ifndef TIMER_MODULE_H_
#define TIMER_MODULE_H_

#include <avr/sfr_defs.h>
#include <avr/io.h>

void timer_set(){
	
	TCCR0 |= _BV(2);//64분주 4us
	TCNT0=231;//256-231 =25
	TIMSK=0x01;//overflow 인터럽트 온

}

void timer1_set(){
	TCCR1B=0x00;
	TCCR1A=0x00;

}
void pwm2_set(){//37.9kh 26us
	TCCR2=0x69;//16mh / 8, 500ns
	TCNT2=0;//256- x = 52
	OCR2=128;
	TIMSK = 0x02;
	
}



#endif /* TIMER_MODULE_H_ */