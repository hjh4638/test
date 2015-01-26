﻿/*
 * array_util.h
 *
 * Created: 2014-01-15 오전 1:36:12
 *  Author: apple
 */ 


#ifndef ARRAY_UTIL_H_
#define ARRAY_UTIL_H_
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "uart_module.h"

void array_clear(unsigned char* array, unsigned char size){
	unsigned char i;
	for(i=0;i<size;i++){
		array[i]=0;
	}
}
void array_putch(unsigned char* array, unsigned char size){
	unsigned char i;
	for(i=0;i<size;i++){
		Uart_Putch(array[i]);
	}
}
//배열의 크기가 8의 배수여야한다. 0과 1로만 구성되어 있어야한다. 아니면 수행 안됨
void bitarray_to_byte(unsigned char* array, unsigned char size,unsigned char* target_array,unsigned char target_size){

	unsigned char a=0;
	unsigned char i =0;
	unsigned char byte=0;

	if((size % 8)==0){
		for(i=0;i<size;i++){
			byte =byte<<1;
			byte = byte | array[i];
			if( ((i%8)==7 ) && target_size>a){
				target_array[a]=byte;
				a++;
				byte=0;
			}
		}
	}
}


#endif /* ARRAY_UTIL_H_ */