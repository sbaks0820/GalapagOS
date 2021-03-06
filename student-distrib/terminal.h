#ifndef _TERMINAL_H
#define _TERMINAL_H

#include "lib.h"
#include "types.h"
#include "file_array.h"
#include "paging.h"

#ifndef ASM

typedef struct screen_char {
	uint8_t character : 8;
	uint8_t fore : 4;
	uint8_t back : 4;
} __attribute__((packed)) screen_char_t;

void scroll_line(int t, int user_triggered);
void put_char(char c);
void put_char_out(char c);
int terminal_open();
void clear_terminal();
int terminal_write(int32_t fd, const void* buf, int32_t nbytes);
int terminal_read(uint32_t* ptr, int offset, int count, uint8_t * buf);
int terminal_close();
void update_cursor(int row, int col);
void switch_terminals(int term);
void hist_copy_from(char* src);
int get_curr_terminal();
#endif
#endif
