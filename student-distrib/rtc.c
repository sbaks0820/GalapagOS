#include "rtc.h"

#define ERROR -1 
#define MAX_FREQUENCY 1024
#define MIN_FREQUENCY 2
#define CHECK_LSB 0x1
#define UINT32_LENGTH 32
#define CALIBRATE_FREQUENCY 0x8000
#define MAX_SHIFT 14
#define LIMIT_RATE_TO_15 0xF
#define BYTE_MASK 0xF0
#define START_FREQUENCY 2

extern volatile uint8_t rtc_flag;
static uint8_t initialized = 0; 


int rtc_open() {
	if (initialized) return 0;
 	
 	/* initialize */
 	rtc_init();

 	/* set frequency to 2 Hz */
	uint32_t start = START_FREQUENCY;
 	if (rtc_write(0,(const void*)(&start),0) == ERROR) return ERROR;
 	initialized = 1;
 	rtc_flag = 0;
 	return 0;
 }

int rtc_read(uint32_t* ptr, int offset, int count, uint8_t * buf)
{
	/* reset rtc flag for next rtc interrupt */
	rtc_flag = 0;

	/* wait for rtc flag to become 1 due to rtc interrupt handler */
	while (!rtc_flag);
	
	return 0;
};

int rtc_write(int32_t fd, const void* buf, int32_t nbytes) {
	uint32_t frequency = *((uint32_t*)(buf));
	/* CHECK: frequency between [2, 1024 Hz] */
	if (frequency < MIN_FREQUENCY || frequency > MAX_FREQUENCY) return ERROR;

	/* CHECK: Is frequency power of 2? (does it only have a single 1?) */
	uint32_t number_ones = 0;
	int i;

	for (i = 0; i < UINT32_LENGTH; i++) {
		if ( (frequency >> i) & CHECK_LSB) number_ones++;
		if (number_ones > 1) return ERROR;
	}

	/* Calculate rate to send to RTC
	 * Equation is frequency = CALIBRATE_FREQUENCY >> (rate - 1) */
	int rate = 0;
	int j;

	for (j = 0; j <= MAX_SHIFT; j++){
		if ( (CALIBRATE_FREQUENCY >> j) == frequency ) rate = j + 1; 
	}
	rate = rate & LIMIT_RATE_TO_15;

	/* Send rate to RTC */
	if (initialized) cli();

	outb(RTC_REG_A, RTC_IDX_PORT);
	uint8_t reg_A_value = inb(RTC_WR_PORT);
	outb(RTC_REG_A, RTC_IDX_PORT);
	outb(rate | (reg_A_value & BYTE_MASK), RTC_WR_PORT);
	
	if (initialized) sti();

	return 0;
};

int rtc_close() {

	return 0;
};


/*
 *	rtc_init
 *		DESCRIPTION:  Turns on the RTC and enables periodic
 *					  interrupts.
 *		INPUTS: none
 *		OUTPUTS: none
 *		RETURN VALUE: none
 *		SIDE EFFECTS:  Turns on the RTC.
 */
void rtc_init(){
	/* Select Register B of the RTC*/
    outb(RTC_REG_B, RTC_IDX_PORT);

    /*Store current value of register B*/
    char old_regb = inb(RTC_WR_PORT);

    /*Select Register B of the RTC again to send info*/
	outb(RTC_REG_B, RTC_IDX_PORT);

	/*Set the enable bit in register B and send it back*/
    outb( old_regb | RTC_EN, RTC_WR_PORT);
    
    return;
}

