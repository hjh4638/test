#include"motor_ax.c"

void delay (long time);

void Main_init(void);

void main(void)
{
    char id,checksum,k;
    int time=20000;
    Main_init();
    checksum=0;
    while(1)
    {
        
        if(time==0)
        {            
            Uart_Putch(1, '.');
            continue;
        }
        RxBuffer[0]=UDR1;
        RxBuffer[1]=Uart_Getch(1);
        RxBuffer[2]=Uart_Getch(1);
        RxBuffer[3]=Uart_Getch(1);
        RxBuffer[4]=Uart_Getch(1);
        
        checksum=RxBuffer[3]+RxBuffer[4];
        checksum=checksum%0x100;
        if(checksum!=0xff)
        {
            Uart_Putch(1, '3');
            continue;
        }
        
        id=RxBuffer[3];
        k=3;
        checksum=0;
        while(checksum!=0xff)
        {
            if(k==0)
            {break;}
            Parameter[0]=0x24;
            Parameter[1]=0x02;
            TxPacket(id, INST_READ, 2);
            cbi(DDRE,2);
            sbi(DDRE,2);
            RxBuffer[0]=Uart_Getch(0);
            RxBuffer[1]=Uart_Getch(0);
            RxBuffer[2]=Uart_Getch(0);
            RxBuffer[3]=Uart_Getch(0);
            RxBuffer[4]=Uart_Getch(0);
            RxBuffer[5]=Uart_Getch(0);
            RxBuffer[6]=Uart_Getch(0);     
            RxBuffer[7]=Uart_Getch(0);
            k--;
            if(RxBuffer[2]!=id)
            {continue;}
            checksum=RxBuffer[2]+RxBuffer[3]+RxBuffer[4]+RxBuffer[5]+RxBuffer[6]+RxBuffer[7];
            checksum= checksum%0x100;
        }
        if(k==0)
        {
            continue;
        }
        
        checksum=0xff-RxBuffer[5]-RxBuffer[6];
        Uart_Putch(1, 0xff);
        Uart_Putch(1, 0xff);
        Uart_Putch(1, 0xff);
        Uart_Putch(1, RxBuffer[5]);
        Uart_Putch(1, RxBuffer[6]);
        Uart_Putch(1, checksum);
    }
}

void Main_init(void)
{
    cbi(SREG,7);
    Init_Uart(0, 1000000);
    Init_Uart(1, 57600);
    sbi(SREG,7);
}

void delay(long time)
{
    while(time--);
}
