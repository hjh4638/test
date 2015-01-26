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
#include <avr/wdt.h>

#define Reset_AVR() wdt_enable(WDTO_2S);


//어레이 클리어
void array_clear(unsigned char* array, unsigned char size){
	unsigned char i;
	for (i = 0; i<size; i++){
		array[i] = 0;
	}
}

//
void array_putch(unsigned char* array, unsigned char size){
	unsigned char i;
	for (i = 0; i<size; i++){
		//Uart_Putch(array[i]);
	}
}
//배열의 크기가 8의 배수여야한다. 0과 1로만 구성되어 있어야한다. 아니면 수행 안됨
//array를 byte로 변환하여 target_array에 집어넣음
void bitarray_to_byte(unsigned char* array, unsigned char size, unsigned char* target_array, unsigned char target_size){
	unsigned char a = 0;
	unsigned char i = 0;
	unsigned char byte = 0;
	//size가 8의 배수이면
	if ((size % 8) == 0){
		for (i = 0; i<size; i++){
			byte = byte << 1;
			byte = byte | array[i];
			if (((i % 8) == 7) && target_size>a){
				target_array[a] = byte;
				a++;
				byte = 0;
			}
		}
	}
}

void timer_set(){
	TCCR0 |= _BV(0);
	TCCR0 |= _BV(1);
	//64분주 4us
	TCNT0 = 231;//256-231 =25
	TIMSK = 0x01;//overflow 인터럽트 온

}

void timer1_set(){
	TCCR1B = 0x00;
	TCCR1A = 0x00;

}
void Main_Init(void);

//적외선에서 받는 비트 신호
unsigned char ir_data[32]={};
	
//비트들을 1바이트 코드로 만들어서 담는 배열
//신호처리 결과값
unsigned char code[4]={};

//타이머에서 측정하는 주기
volatile unsigned char period;
//적외선 신호에서 인터럽트 걸린 신호가 몇번째 비트인지 나타냄
volatile unsigned char ir_code_count;

volatile unsigned char uart_transmit_count=0;

void ir_data_set(){
	//주기가 700us에서 1600us이면 0으로 인식
	if((period>=7)&&(period<=16)){
		ir_data[ir_code_count]=0;
		ir_code_count++;
	}
	//주기가 1700us에서 2600us이면 1로 인식
	else if((period>=17)&&(period<=26)){
		ir_data[ir_code_count]=1;
		ir_code_count++;
	}
	//그 외는 의미없는 데이터이므로
	else
	{
		array_clear(ir_data,sizeof(ir_data));
		ir_code_count=0;
	}
}

ISR(INT0_vect){
	SREG &= ~_BV(7);
	ir_data_set();
	//적외선 신호를 전부 받으면.
	if(ir_code_count>sizeof(ir_data)-1){
		//비트로 되어있는 신호를 byte로 바꿈
		bitarray_to_byte(ir_data,sizeof(ir_data),code,sizeof(code));
		//사용한 ir_data 초기화
		array_clear(ir_data,sizeof(ir_data));
		ir_code_count=0;
		uart_transmit_count=1;
	}
	//외부인터럽트시마다 주기 초기화
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
	
	DDRC = 0xff;
	//PORTC =0xff;3
	while(1)
    {		
		//PORTC |=_BV(5);// 3+0 앞방향
		//PORTC |=_BV(4);// 5+4 뒤방향
		////
		//
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
					
					
					PORTC |=_BV(5);//왼전진
					PORTC |=_BV(4);//우전진
					_delay_ms(200);
				}
				//A4EB0BAD // 아래
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0xc0 &&code[3] == 0x3f){//후진
					//PORTB |=_BV(3);
					//PORTB |=_BV(4);
					
					PORTC |=_BV(3);//왼전진
					PORTC |=_BV(0);//우전진
					_delay_ms(200);
				}
				//9F880A37 // 왼쪽
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0x00 &&code[3] == 0xff){//좌회전
					//PORTB |=_BV(5);//왼전진
					//PORTB |=_BV(4);//우전진
					
					PORTC |=_BV(5);
					PORTC |=_BV(0);
					_delay_ms(150);
				}
				//D4CD3353//오른쪽
				if(code[0] == 0x20 && code[1] == 0xdf &&code[2] == 0x80 &&code[3] == 0x7f){//우회전
					//PORTB |=_BV(3);//왼전진
					//PORTB |=_BV(0);//우전진
					
					PORTC |=_BV(3);
					PORTC |=_BV(4);
					_delay_ms(150);
				}
			//}
			array_clear(code,sizeof(code));
			uart_transmit_count=0;
			//PORTD |= _BV(0);
			//_delay_ms(500);
			SREG |= _BV(7);
			

		}
		PORTC &= 0x06;
		
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