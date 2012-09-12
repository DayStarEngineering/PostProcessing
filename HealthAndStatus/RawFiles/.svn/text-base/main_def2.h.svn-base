// File: main_def.h
// Author: Nick Truesdale
// Date: 3/31/20122
//
// Description: This header file contains all of the defines
// used by main.c

#ifndef _MAIN_DEF_H_
#define _MAIN_DEF_H_ 1

// Include
#include <stdlib.h>
#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h> 

// ------ PORT DEFINES ------ //
// PORTS A and C are all switches
// PORTS D and F are extra IO or camera

//PORTA
#define AVDD 0
#define VTX_POS 1
#define VTX_NEG 2
#define VRST1 3
#define VRST2 4
#define DVDD3 5
#define DVDD_CK 6
#define DVDD 7

//PORTB
#define ADC1 4
#define ADC2 5
#define ADC3 6
#define ADC4 7
#define ADC5 0

//PORTC
#define VSATA5 0
#define VSATA12 1
#define VPC3 2
#define VPC5 3
#define VPC12 4
#define VPCneg12 5
#define VSB5 6
#define VCPU12 7

//PORTD
#define CS_CLK 2
#define INT_CLK 3
#define LED1 4
#define LED2 5
#define LED3 6
#define LED4 7

//PORTF
#define TMS 0
#define TRST_TP 1
#define TRST_BT 2
#define TDO 4
#define TDO_TP 3
#define TDO_BT 4
#define TCK 5
#define TDI 6
#define LATCH 7

//PORTG
#define READ 0
#define RESET 1
#define DATA_SEL 2
#define PWR 3
#define RST 4

// ------ OTHER DEFINES ------ //
// Boolean
#define TRUE 1
#define FALSE 0
#define SUCCESS 1
#define FAIL 0

// JTAG
#define NUM_STATES 16
#define JTAG_LENGTH 48
#define LEAD_BITS 4

// USART SETUP
#define FOSC 8000000
#define BAUD 38400
#define MYUBRR 25

// USART COM
#define HEADER "DAY@"
#define HEAD_LENGTH 4
#define MESSAGE_LENGTH 4
#define RESPONSE_LENGTH 1024
#define MAX_LENGTH 1024

// SYSTEM
#define CLK_COUNT 31250
#define NUM_PARAMS 19

// PARAMETERS
#define CLOCK_S  0
#define CLOCK_MS 1
#define WATCHDOG 2
#define STATUS   3
#define COMP_POW 4
#define CMOS_POW 5
#define CMOS_IMG 6
#define EXP_TIME 7
#define ROI_STRT 8
#define ROI_END  9
#define DARK_ROW 10
#define LOW_GAIN 11
#define HI_GAIN  12
#define JTAG_CLK 13
#define ADC_RATE 14 
#define USERMODE 15
#define IMGORDER 16
#define WATCH_EN 17
#define LATCH_S  18

#define LATCH_LIMIT 30

// DATA
#define NUM_BUFS 5
#define BUF_SIZE 10
#define BUF_LENGTH 10

// Computer comm. values
#define HEADER "DAY@"
#define HEAD_LENGTH 4
#define MESSAGE_LENGTH 4
#define MAX_LENGTH 1024
#define WATCHDOG_MAX 120
#define WATCHDOG_REBOOT 130

// Set and clear bit expressions
#define sbi(var, mask)   ((var) |= (uint8_t)(1 << mask))
#define cbi(var, mask)   ((var) &= (uint8_t)~(1 << mask))

//======================//
// Function Prototypes  //
//======================//

// Utilities
void delay_ms(uint16_t x); //General purpose delay
static int uart_putchar(char c, FILE *stream);
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);


uint16_t time_ms(uint16_t timer_count);
void parse_command(void);
void status(void);
void set_param(uint8_t num, uint16_t val);
void get_param(uint8_t num);
void get_data(uint8_t buffer, uint8_t amount);
void get_data_human(uint8_t buffer, uint8_t amount);
void respond(void);
void human_respond(uint8_t type, uint8_t num, uint16_t val);
void send_char(char c);

// Power
uint8_t comp_power(uint8_t state);
uint8_t cmos_power(uint8_t state);
void cmos_power_digital(void);

// Clock
void print_time(void);
void get_time(void);
void print_alarm(void);			//Jchange
void get_alarm(void); 			//Jchange
uint8_t clock_convert(uint8_t byte);
void setup_clock(void);
uint8_t clock_read(uint8_t address);
void clock_write(uint8_t address, uint8_t byte);

// ADC
void collect_data(uint8_t buf_num, uint8_t pos);
uint16_t adc_data(uint8_t port, uint8_t channel, uint8_t unipolar);
long int adc_voltage(uint16_t raw_data);
void print_voltage(uint16_t raw_data, uint8_t unipolar, double scaling);
void print_current(uint16_t raw_data);

// SPI
void iniSPIadc(void); 
void iniSPIclock(void);
void send_dummy (void);
void send_byte(uint8_t byte);

// JTAG
uint8_t cmos_program(void);
uint32_t exposure_count(uint16_t exp_time);
void jtag_on(void);
void jtag_cycle(void);
void jtag_reset(void);
void jtag_off(void);
void jtag_send(char address, long int command, char *address_reply,
	long int *command_reply);

// Initialization
void ioinit(uint8_t baud); //Initializes IO
void set_timer_rate(uint8_t timer_num, long int rate);
void rate2count(long int rate, uint8_t bits, uint8_t *ps, uint16_t *c);
void force_reset(void);


//======================//
//   Global Variables   //
//======================//

// USART
char header[] = HEADER;
char response[RESPONSE_LENGTH];
char message[MESSAGE_LENGTH];
uint16_t uart_count = 0;
uint16_t rcount = 0;
uint8_t parse_flag = 0;

// JTAG pin values and data streams
uint8_t TMS_val = 0;
uint8_t TDI_val = 0;
long long int TDO_val = 0;
long long int TMS_stream = 0x600000000E03;
long long int TDI_stream = 0x000000000000;
long long int TDO_stream = 0x000000000000;

// JTAG logical values
uint8_t jtag_flag = 0;
uint8_t jtag_count = 0;
uint8_t jtag_state = 1;
uint8_t rising_edge = 0;
uint8_t first_read = 1;

// JTAG state machine
int machine[NUM_STATES][2] = {
{1,0},{1,2},{10,3},{4,0}, // TLR, RDI, Select Scan
{5,6},{5,6},{7,9},{7,8},{5,9},{1,2}, // IR
{11,12},{11,12},{13,15},{13,14},{11,15},{1,2}}; //DR

// Time array
uint8_t time[7]; // year, month, day, hour, minute, second
uint8_t alarm[4]; // day, hour, minute, second 									//Jchange
uint8_t fakeAlarm[3]; // hr, minute, second 
uint8_t clock_set = 0; // Change to 1 if you'd like to reprogram clock time 	//Jchange


// System parameters
uint16_t params[NUM_PARAMS] = {
0,    // 0,  System Clock (seconds)
0,    // 1,  System Clock (milliseconds)
0,    // 2,  Watchdog Timer
1,    // 3,  AVR Status (0 = Happy, 1 = Sad)
0,    // 4,  Computer Power Mode (0 = OFF, 1 = ON)
0,    // 5,  Camera Power Mode (0 = OFF, 1 = Digital, 2 = ALL)
0,    // 6,  Camera Image Mode (1 = global, 0 = rolling)
300,  // 7,  Rolling Shutter Exposure Time (tenths of ms)
0,    // 8,  ROI Start (row number)
1079, // 9,  ROI End (row number)
16,   // 10, Number of dark rows to read
0,    // 11, Low gain mode (0 = 2x, 1 = 1x)
0,    // 12, High gain mode (0 = 30x, 1 = 10x)
1,    // 13, JTAG Clock speed (Hz)
1,    // 14, ADC Data Rate (Hz)
0,    // 15, User mode (0 = computer, 1 = human)								
1,    // 16, Image Readout Order (0 = prescan/dark/active, 1 = active/prescan/dark)
1,    // 17, Watchdog enable (1 = enabled, 0 = disabled)
LATCH_LIMIT + 1}; // 18, Latch Timer 
   
char * param_names[NUM_PARAMS] = {
"System Clock",
"System Clock, milliseconds",
"Watchdog",
"Status", 
"Computer Power Mode",   
"Camera Power Mode",    
"Camera Imaging Mode",  
"Exposure Time",
"ROI Start",
"ROI End",
"Dark Row Count",
"Low Gain Mode",
"High Gain Mode",
"JTAG Clock Speed",
"ADC Data Rate",    
"User Mode",
"Image Readout Order",
"Watchdog Enable"};  

char * comp_names[8] = {
"VPC3",
"VSATA5",
"VSATA12",
"VPC5",
"VPC12",
"VPC-12",
"VSB5",
"VCPU"};

char * cmos_names[8] = {
"VTX_NEG",
"AVDD",
"VTX_POS",
"VRST1",
"VRST2",
"DVDD3",
"DVDD",
"DVDD_CL"};

double comp_scaling[8] = {
1,   // VPC3 has unity gain
2.993698,
7.783239,
3.011588,
7.820677,
12.736708,
3.018146,
7.840792};

// Data Buffers
// NUM_BUFS - indices 0-4 correspond to ADCs 1-5
// BUF_SIZE - 2 shorts for timestamp, 8 for data
// BUF_LENGTH - How many spots exists in the circular buffer
uint16_t data[NUM_BUFS][BUF_SIZE][BUF_LENGTH];
uint8_t buf_pos = 0;
uint8_t buf_valid = 0;

// Interrupt enable flags
uint8_t int1_en = 1;
uint8_t int3_en = 1;

#endif /* _MAIN_DEF_H_ */
