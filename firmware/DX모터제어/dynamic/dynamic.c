/*
 * dynamic.c
 *
 * Created: 2014-02-05 오후 11:19:20
 *  Author: apple
 */ 

#define F_CPU 16000000UL
#include <avr/io.h>			//ATmega128 I/O Header
#include <avr/interrupt.h>		//ATmega128 INTERRUPT Header
#include <util/delay.h>			//ATmega128 delay Function Header
#include "uart.h"
#include "dynamic.h"

static U08 Parameter[128];						// 매개변수
//static U08 RxBuffer[128]; 						// 수신버퍼
static U08 TxBuffer[128];
static U08 ID, TxPacketLength, RxPacketLength;

U08 TxPacket(U08 ID, U08 Instruction, U08 ParameterLength)
{
	//--------------------------------------------------------------------------
	//		===== 패킷 생성 =====
	//--------------------------------------------------------------------------

	U08 Count;					// 패킷의 전송 번호
	U08 CheckSum;				// 패킷의 오류 검출 방법
	U08 PacketLength;			// 매개변수들의 총 갯수
	
	TxBuffer[0] = 0xFF;						// Start CODE
	TxBuffer[1] = 0xFF;						// Start CODE
	TxBuffer[2] = ID;						// 모터ID (0~253), BroadcastingID=0xFE
	TxBuffer[3] = ParameterLength + 2;		// Length(Instruction + ParamterLength + Checksum)
	TxBuffer[4] = Instruction;				// 명령어 선택(단일쓰기,다중쓰기,읽기 등)
	
	for(Count = 0; Count < ParameterLength; Count++)
	{
		TxBuffer[Count+5] = Parameter[Count];			// 매개변수 지정
	}
	
	CheckSum = 0;										// CheckSum 초기화
	PacketLength = ParameterLength + 4 + 2;				// 패킷의 전체 길이 설정
	
	for(Count = 2; Count < PacketLength-1; Count++)  	// Except 0xFF, Checksum
	{
		CheckSum += TxBuffer[Count];
	}
	
	TxBuffer[Count] = ~CheckSum;                       	// Checksum 생성


	sbi(PORTE, 2);                                         	// RS485 출력모드로 설정
	
	for(Count = 0; Count < PacketLength; Count++)
	{
		sbi(UCSR0A, 6);						     		// 송신완료 상태로 전환
		Uart_Putch( 0, TxBuffer[Count] );         	// 순차적 패킷전송 MCU->DX
	}
	
	while(!(UCSR0A & (1<<TXC0)));                         	// 송신버퍼 빌때까지 기다림
	cbi(PORTE, 2);                                          	// RS485 입력모드로 설정
	
	return PacketLength;								// 패킷의 전체길이 리턴
}
void Set_Id(U08 param_id){
	U08 ID=0xFE;
	Parameter[0] = ID_ADDR;
	Parameter[1] = param_id;				//Low 8bit at goal position
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 2);
}
void Set_Return_Delay(U08 Return_Delay){
	U08 ID=0xFE;
	Parameter[0] =RETURN_DELAY_ADDR;
	Parameter[2] = Return_Delay;
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 2);
}
void Set_Status_Return_Level(U08 status_level){
	U08 ID=0xFE;
	Parameter[0] =STATUS_RETURN_LEVEL_ADDR;
	Parameter[2] = status_level;
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 2);
}
void Set_Baud_Return_Delay(U08 Baud_Rate,U08 Return_Delay){
	U08 ID=0xFE;
	Parameter[0] = BAUD_RATE_ADDR;
	Parameter[1] = Baud_Rate;
	Parameter[2] = Return_Delay;
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 3);
}
void Set_Torque(U08 ID, U08 Torque_Limit_H,U08 Torque_Limit_L){
	Parameter[0] = TORQUE_LIMIT_L_ADDR;
	Parameter[1] = Torque_Limit_L;				//Low 8bit at goal position
	Parameter[2] = Torque_Limit_H;				//High 8bit at goal position
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 3);
	
}
void Set_Compliance(U08 ID, U08 Margin_CCW,U08 Margin_CW,U08 Slope_CCW,U08 Slope_CW)
{
	Parameter[0] = CW_COM_MARGIN_ADDR;						//goal position address : 30
	Parameter[1] = Margin_CW;				//Low 8bit at goal position
	Parameter[2] = Margin_CCW;				//High 8bit at goal position
	Parameter[3] = Slope_CW;				//Low 8bit at moving speed
	Parameter[4] = Slope_CCW;				//High 8bit at moving speed
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 5);
}
void Action_Postion_Speed(U08 ID, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L)
{
	Parameter[0] = GOAL_POSITION_L_ADDR;						//goal position address : 30
	Parameter[1] = Position_L;				//Low 8bit at goal position
	Parameter[2] = Position_H;				//High 8bit at goal position
	Parameter[3] = Speed_L;				//Low 8bit at moving speed
	Parameter[4] = Speed_H;				//High 8bit at moving speed
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 5);
}
void Action_Slope_Postion_Speed(U08 ID,U08 Slope_CCW,U08 Slope_CW, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L)
{
	Parameter[0] = CW_COM_SLOPE_ADDR;						//goal position address : 30
	Parameter[1] = Slope_CW;
	Parameter[2] = Slope_CCW;
	Parameter[3] = Position_L;				//Low 8bit at goal position
	Parameter[4] = Position_H;				//High 8bit at goal position
	Parameter[5] = Speed_L;				//Low 8bit at moving speed
	Parameter[6] = Speed_H;				//High 8bit at moving speed
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 7);
}
void Action_Margin_Slope_Postion_Speed(U08 ID,U08 Margin_CCW,U08 Margin_CW,U08 Slope_CCW,U08 Slope_CW, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L)
{
	Parameter[0] = CW_COM_MARGIN_ADDR;						//goal position address : 30
	Parameter[1] = Margin_CW;
	Parameter[2] = Margin_CCW;
	Parameter[3] = Slope_CW;
	Parameter[4] = Slope_CCW;
	Parameter[5] = Position_L;				//Low 8bit at goal position
	Parameter[6] = Position_H;				//High 8bit at goal position
	Parameter[7] = Speed_L;				//Low 8bit at moving speed
	Parameter[8] = Speed_H;				//High 8bit at moving speed
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 9);
}
void ON_OFF_Torque(U08 ID, U08 onoff)//onoff가 0이면 모터 전원차단
{
	Parameter[0] = TORQUE_EN_ADDR;
	Parameter[1] = onoff;
	TxPacketLength = TxPacket(ID, WRITE_DATA_INS, 2);
}

void RxPacket(U08 ID,U08 Data_Addr){
	U08 ParameterLength=2;
	Parameter[0] = Data_Addr;
	Parameter[1] = 1;
	TxPacket(ID, READ_DATA_INS,ParameterLength);
}

void RxPosition(U08 ID){
	U08 ParameterLength=2;
	Parameter[0] = PRESENT_POSTION_L_ADDR;
	Parameter[1] = 2;
	TxPacket(ID, READ_DATA_INS,ParameterLength);
}
