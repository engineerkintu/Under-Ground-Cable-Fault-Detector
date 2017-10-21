
#line 1 "..\main.c" /0





 
 
  
#line 1 "D:\Keil_v5\C51\BIN\..\INC\reg51.h" /0






 
 
 
 
 
 
 sfr P0   = 0x80;
 sfr P1   = 0x90;
 sfr P2   = 0xA0;
 sfr P3   = 0xB0;
 sfr PSW  = 0xD0;
 sfr ACC  = 0xE0;
 sfr B    = 0xF0;
 sfr SP   = 0x81;
 sfr DPL  = 0x82;
 sfr DPH  = 0x83;
 sfr PCON = 0x87;
 sfr TCON = 0x88;
 sfr TMOD = 0x89;
 sfr TL0  = 0x8A;
 sfr TL1  = 0x8B;
 sfr TH0  = 0x8C;
 sfr TH1  = 0x8D;
 sfr IE   = 0xA8;
 sfr IP   = 0xB8;
 sfr SCON = 0x98;
 sfr SBUF = 0x99;
 
 
 
 
 sbit CY   = 0xD7;
 sbit AC   = 0xD6;
 sbit F0   = 0xD5;
 sbit RS1  = 0xD4;
 sbit RS0  = 0xD3;
 sbit OV   = 0xD2;
 sbit P    = 0xD0;
 
 
 sbit TF1  = 0x8F;
 sbit TR1  = 0x8E;
 sbit TF0  = 0x8D;
 sbit TR0  = 0x8C;
 sbit IE1  = 0x8B;
 sbit IT1  = 0x8A;
 sbit IE0  = 0x89;
 sbit IT0  = 0x88;
 
 
 sbit EA   = 0xAF;
 sbit ES   = 0xAC;
 sbit ET1  = 0xAB;
 sbit EX1  = 0xAA;
 sbit ET0  = 0xA9;
 sbit EX0  = 0xA8;
 
 
 sbit PS   = 0xBC;
 sbit PT1  = 0xBB;
 sbit PX1  = 0xBA;
 sbit PT0  = 0xB9;
 sbit PX0  = 0xB8;
 
 
 sbit RD   = 0xB7;
 sbit WR   = 0xB6;
 sbit T1   = 0xB5;
 sbit T0   = 0xB4;
 sbit INT1 = 0xB3;
 sbit INT0 = 0xB2;
 sbit TXD  = 0xB1;
 sbit RXD  = 0xB0;
 
 
 sbit SM0  = 0x9F;
 sbit SM1  = 0x9E;
 sbit SM2  = 0x9D;
 sbit REN  = 0x9C;
 sbit TB8  = 0x9B;
 sbit RB8  = 0x9A;
 sbit TI   = 0x99;
 sbit RI   = 0x98;
 
 
#line 8 "..\main.c" /0
 
  
#line 1 "D:\Keil_v5\C51\BIN\..\INC\stdio.h" /0






 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 typedef unsigned int size_t;
 
 
 #pragma SAVE
 #pragma REGPARMS
 extern char _getkey (void);
 extern char getchar (void);
 extern char ungetchar (char);
 extern char putchar (char);
 extern int printf   (const char *, ...);
 extern int sprintf  (char *, const char *, ...);
 extern int vprintf  (const char *, char *);
 extern int vsprintf (char *, const char *, char *);
 extern char *gets (char *, int n);
 extern int scanf (const char *, ...);
 extern int sscanf (char *, const char *, ...);
 extern int puts (const char *);
 
 #pragma RESTORE
 
 
 
#line 9 "..\main.c" /0
 
 
 
 
 
 
 
 
 void delay_sec(unsigned int);
 void __delay_us(unsigned int);    
 void InitLCD(void);
 void WriteCommandToLCD(int);
 void WriteDataToLCD(char);
 void WriteStringToLCD(const char*);
 void ClearLCDScreen(void);
 
 
 void InitADC(void);
 unsigned char ReadADC(unsigned char);
 void Display(unsigned char);
 
 
 
 
 
 
 
 
 
 
 
 
 sbit Add_A = P2^0;      
 sbit Add_B = P2^1;      
 sbit Add_C = P2^2;      
 sbit ALE   = P2^3;      
 sbit EOC   = P2^4;      
 sbit OE    = P2^5;      
 sbit START = P2^6;      
 sbit CLK   = P2^7;      
 
 
 sbit RS = P3^6;
 sbit E  = P1^0;
 
 
 
 
 
 sbit RELAY1 = P1^2;
 sbit RELAY2 = P1^3;
 sbit RELAY3 = P1^1;
 
 
 
 void main(void)
 { 
 
 unsigned char ADC_Value = 0;          
 unsigned char Digit[3] = { 0,0,0 };     
 
 
 
 InitADC();                             
 InitLCD();                             
 WriteStringToLCD("Starting...");     
 delay_sec(1);                         
 ClearLCDScreen();
 WriteStringToLCD("***Welcome***");
 delay_sec(2);
 ClearLCDScreen();
 WriteStringToLCD("Fault Locator 1");
 delay_sec(2);
 ClearLCDScreen();
 while(1)
 { 
 RELAY1 = 1;
 delay_sec(1);
 ADC_Value = ReadADC(1);         
 WriteStringToLCD("R: ");                 
 Display(ADC_Value);
 delay_sec(2);
 ClearLCDScreen();
 RELAY1 = 0;
 
 RELAY2 = 1;
 delay_sec(1);
 WriteStringToLCD("B: ");
 ADC_Value = ReadADC(1);
 Display(ADC_Value);
 delay_sec(2);
 ClearLCDScreen();
 RELAY2 = 0;
 
 RELAY3 = 1;
 delay_sec(1);
 WriteStringToLCD("Y: ");
 ADC_Value = ReadADC(1);
 Display(ADC_Value);
 delay_sec(2);
 ClearLCDScreen();
 RELAY3 = 0;
 
 
 } 
 
 
 }
 
 
 
 void InitADC(void)
 {
 Add_A = 0;           
 Add_B = 0;           
 Add_C = 0;           
 ALE   = 0;           
 EOC   = 1;           
 OE    = 0;           
 START = 0;           
 CLK   = 0;           
  P0 = 0xFF;     
 }
 
 unsigned char ReadADC(unsigned char Channel)
 {
 unsigned int i = 0;
 unsigned int ADC_value = 0;
 

 
 switch(Channel)
 {
 case 0: Add_C = 0;  Add_B = 0;  Add_A = 0; break;
 case 1: Add_C = 0;  Add_B = 0;  Add_A = 1; break;
 case 2: Add_C = 0;  Add_B = 1;  Add_A = 0; break;
 case 3: Add_C = 0;  Add_B = 1;  Add_A = 1; break;
 case 4: Add_C = 1;  Add_B = 0;  Add_A = 0; break;
 case 5: Add_C = 1;  Add_B = 0;  Add_A = 1; break;
 case 6: Add_C = 1;  Add_B = 1;  Add_A = 0; break;
 case 7: Add_C = 1;  Add_B = 1;  Add_A = 1; break;
 }       
 
 __delay_us(10);         
 ALE = 1;                 
 CLK = 1;                  
 __delay_us(10);         
 CLK = 0;                 
 START = 1;                 
 __delay_us(10);         
 CLK = 1;                  
 ALE = 0;                 
 __delay_us(10);         
 CLK = 0;                  
 START = 0;                 
 
 for(i=0;i<2000;i++)
 {
 CLK = !CLK;             
 __delay_us(10);     
 if(!EOC)               
 break;
 }
 
 for(i=0;i<2000;i++)
 {
 CLK = !CLK;             
 __delay_us(10);     
 if(EOC)                 
 break;
 }
 
 CLK = 0;                  
 OE = 1;                     
 __delay_us(10);         
 CLK = 1;                  
 __delay_us(10);         
 CLK = 0;                  
 __delay_us(10);         
 CLK = 1;                  
 ADC_value = P0;             
 __delay_us(10);         
 OE = 0;                     
 CLK = 0;                  
 __delay_us(10);         
 return ADC_value;                 
 }
 
 
 void delay_sec(unsigned int d)
 {
 unsigned int i;
 for(i=0;i<(d*20);i++)
 __delay_us(50000);
 }
 
 
 void __delay_us(unsigned int d)
 {
 unsigned int i, limit;
 limit = d/15;
 for(i=0;i<limit;i++);
 }
 
 void ToggleEpinOfLCD(void)
 {
 E = 1;                 
 __delay_us(250);   
 E = 0;                 
 __delay_us(250);     
 }
 
 
 void WriteDataToLCD(char t)
 {
 RS = 1;              
 
 P1 &= 0x0F;            
 P1 |= (t&0xF0);      
 ToggleEpinOfLCD();   
 
 P1 &= 0x0F;            
 P1 |= ((t<<4)&0xF0); 
 ToggleEpinOfLCD();   
 }
 
 
 void WriteCommandToLCD(int z)
 {
 RS = 0;              
 
 P1 &= 0x0F;            
 P1 |= (z&0xF0);      
 ToggleEpinOfLCD();   
 
 P1 &= 0x0F;            
 P1 |= ((z<<4)&0xF0); 
 ToggleEpinOfLCD();   
 
 
 }
 
 
 void InitLCD(void)
 {
 RS = 0;              
 E  = 0;             
 
 
 __delay_us(15000);
 
 
 
 
 P1 &= 0x0F;            
 P1 |= 0x30;            
 ToggleEpinOfLCD();     
 
 __delay_us(4500);
 
 P1 &= 0x0F;            
 P1 |= 0x30;            
 ToggleEpinOfLCD();     
 
 __delay_us(300);
 
 P1 &= 0x0F;            
 P1 |= 0x30;            
 ToggleEpinOfLCD();     
 
 __delay_us(650);
 
 P1 &= 0x0F;            
 P1 |= 0x20;            
 ToggleEpinOfLCD();     
 
 __delay_us(650);
 
 WriteCommandToLCD(0x28);     
 
 WriteCommandToLCD(0x0c);     
 WriteCommandToLCD(0x01);     
 WriteCommandToLCD(0x06);     
 }
 
 
 void WriteStringToLCD(const char *s)  
 {
 while(*s)
 WriteDataToLCD(*s++);    
 }
 
 
 void ClearLCDScreen(void)       
 {
 WriteCommandToLCD(0x01);     
 __delay_us(2000);            
 }
 
 void Display(unsigned char Data)
 {
 switch(Data)
 {
 case 170:
 WriteStringToLCD("1KM");
 break;
 
 case 204:
 WriteStringToLCD("2KM");
 break;
 
 case 219:
 WriteStringToLCD("3KM");
 break;
 
 case 227:
 WriteStringToLCD("4KM");
 break;
 
 case 255:
 WriteStringToLCD("NF");
 break;
 
 default:
 break;
 }
 }
