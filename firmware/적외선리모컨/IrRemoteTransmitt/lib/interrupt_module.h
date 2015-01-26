/*
 * interrupt_module.h
 *
 * Created: 2014-01-14 오전 12:33:28
 *  Author: apple
 */ 


#ifndef INTERRUPT_MODULE_H_
#define INTERRUPT_MODULE_H_
#include <avr/sfr_defs.h>
#include <avr/io.h>

void int_set(){
	PIND &= ~_BV(2);//INT2 입력설정
	EIMSK |= _BV(2);
	EICRA &= ~_BV(4);
	EICRA |= _BV(5);
}
void int0_set(){
	PIND &= ~_BV(0);//INT2 입력설정
	EIMSK |= _BV(0);
	EICRA &= ~_BV(0);
	EICRA |= _BV(1);
}



#endif /* INTERRUPT_MODULE_H_ */