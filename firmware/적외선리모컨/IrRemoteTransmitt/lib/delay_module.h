/*
 * delay_module.h
 *
 * Created: 2014-01-14 오전 12:31:55
 *  Author: apple
 */ 


#ifndef DELAY_MODULE_H_
#define DELAY_MODULE_H_
#include <avr/sfr_defs.h>
#include <avr/io.h>

void Delay_us(unsigned char time_us){
	register unsigned char i;
	
	for(i=0;i<time_us;i++){
		asm volatile("PUSH R0");
		asm volatile("POP R0");
		asm volatile("PUSH R0");
		asm volatile("POP R0");
		asm volatile("PUSH R0");
		asm volatile("POP R0");
		
	}
	
}
void Delay_ms(unsigned int time_ms){
	register unsigned int i;
	for(i=0;i<time_ms;i++){
		Delay_us(250);
		Delay_us(250);
		Delay_us(250);
		Delay_us(250);
	}
}



#endif /* DELAY_MODULE_H_ */