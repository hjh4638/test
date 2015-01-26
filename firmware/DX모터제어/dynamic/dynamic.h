/*
 * dynamic.h
 *
 * Created: 2014-02-05 오후 11:18:45
 *  Author: apple
 */ 


#ifndef DYNAMIC_H_
#define DYNAMIC_H_
#include "define.h"

//명령어
#define PING_INS 0x01
#define READ_DATA_INS 0x02
#define WRITE_DATA_INS 0x03
#define REG_WRITE_INS 0x04
#define ACTION_INS 0x05
#define RESET_INS 0x06
#define SYNC_WRITE_INS 0x83
#define BULK_READ_INS 0x92

//EEPROM 주소
#define ID_ADDR 0x03 //아이디
#define BAUD_RATE_ADDR 0x04 //통신속도
#define RETURN_DELAY_ADDR 0x05 //응답 지연 시간
#define STATUS_RETURN_LEVEL_ADDR 0x10

//RAM 주소
#define TORQUE_EN_ADDR 0x18 //토크 온오프
#define LED_ADDR 0x19 //LED
#define CW_COM_MARGIN_ADDR 0x1A //시계방향 유연성 마진
#define CCW_COM_MARGIN_ADDR 0x1B //반시계방향 유연성 마진
#define CW_COM_SLOPE_ADDR 0x1C //시계방향 유연성 기울기
#define CCW_COM_SLOPE_ADDR 0x1D //반시계방향 유연성 기울기
#define GOAL_POSITION_L_ADDR 0x1E //목표위치 하위
#define GOAL_POSITION_H_ADDR 0x1F //목표위치 상위
#define MOVING_SPEED_L_ADDR 0x20 // 목표 속도 하위
#define MOVING_SPEED_H_ADDR 0x21 //목표 속도 상위
#define TORQUE_LIMIT_L_ADDR 0x22 //토크 한계값 하위
#define TORQUE_LIMIT_H_ADDR 0x23 // 토크 한계값 상위
#define PRESENT_POSTION_L_ADDR 0x24 //현재 위치값 하위
#define PRESENT_POSTION_H_ADDR 0x25 //현재 위치값 상위
#define PRESENT_SPEED_L_ADDR 0x26 //현재 속도값 하위
#define PRESENT_SPEED_H_ADDR 0x27 //현재 속도값 상위
#define PRESENT_LOAD_L_ADDR 0x28 //현재 하중값 하위
#define PRESENT_LOAD_H_ADDR 0x29 //현재 하중값 상위
#define PRESENT_VOLTAGE_ADDR 0x2A //현재 전압
#define PRESENT_TEMPERATURE_ADDR 0x2B //현재 온도
#define REGISTERD_ADDR 0x2C //명령어 등록여부
#define MOVING_ADDR 0x2E //움직임 유무
#define LOCK_ADDR 0x2F //EEPROM 잠금

U08 TxPacket(U08 ID, U08 Instruction, U08 ParameterLength);
void Set_Id(U08 param_id);
void Set_Return_Delay(U08 Return_Delay);
void Set_Status_Return_Level(U08 status_level);
void Set_Baud_Return_Delay(U08 Baud_Rate,U08 Return_Delay);
void Set_Torque(U08 ID, U08 Torque_Limit_H,U08 Torque_Limit_L);
void Set_Compliance(U08 ID, U08 Margin_CCW,U08 Margin_CW,U08 Slope_CCW,U08 Slope_CW);
void Action_Postion_Speed(U08 ID, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L);
void Action_Slope_Postion_Speed(U08 ID,U08 Slope_CCW,U08 Slope_CW, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L);
void Action_Margin_Slope_Postion_Speed(U08 ID,U08 Margin_CCW,U08 Margin_CW,U08 Slope_CCW,U08 Slope_CW, U08 Position_H, U08 Position_L, U08 Speed_H, U08 Speed_L);
void ON_OFF_Torque(U08 ID, U08 onoff);
void RxPacket(U08 ID,U08 Data_Addr);
void RxPosition(U08 ID);

#endif /* DYNAMIC_H_ */