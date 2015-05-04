#ifndef _PAGING_H
#define _PAGING_H

#include "types.h"
#include "lib.h"

#define KERNEL_START 0x00400000
#define NUM_ENT 1024
#define PROTECTED_MASK 0x00000001
#define PAGE_MASK 0x80000000
#define PSE_MASK 0x00000010
#define NUM_TASKS 7
#define ERROR (-1)
#define KB4 4096

#ifndef ASM
/* Defines 32 bit packed struct representing table entries for 4kB pages */
typedef struct page_table_entry {
            uint32_t present : 1;
            uint32_t r_w : 1;
            uint32_t usr_su : 1;
            uint32_t wr_thr : 1;
            uint32_t cache_dis : 1;
            uint32_t accessed : 1;
            uint32_t dirty : 1;
            uint32_t attr_idx : 1;
            uint32_t glo_page : 1;
            uint32_t avail : 3;
            uint32_t base_31_12 : 20;
} __attribute__((packed)) page_table_entry_t;

/* 32-bit entries in direcotry pointing to 4kB page tables */
typedef struct page_dir_entry_small {
            uint32_t present : 1;
            uint32_t read_write : 1;
            uint32_t super : 1;
            uint32_t write_through : 1;
            uint32_t cache_disable : 1;
            uint32_t accessed : 1;
            uint32_t reserved : 1;
            uint32_t page_size : 1;
            uint32_t global_page : 1;
            uint32_t available : 3;
            uint32_t table_base : 20;
} __attribute__((packed)) page_dir_entry_small_t;

/* 32-bit struct for 4MB page entries in directory */
typedef struct page_dir_entry_big {
            uint32_t present : 1;
            uint32_t read_write : 1;
            uint32_t super : 1;
            uint32_t write_through : 1;
            uint32_t cache_disable : 1;
            uint32_t accessed : 1;
            uint32_t dirty : 1;
            uint32_t page_size : 1;
            uint32_t global_page : 1;
            uint32_t available : 3;
            uint32_t PAT : 1;
            uint32_t reserved : 9;
            uint32_t table_base : 10;
} __attribute__((packed)) page_dir_entry_big_t;

typedef struct page_directory {

    uint32_t directory[NUM_ENT] __attribute__((aligned (KB4)));

} __attribute__((packed)) page_directory_t;

typedef struct page_table {

    uint32_t table[NUM_ENT] __attribute__((aligned(KB4)));

} __attribute__((packed)) page_table_t;

typedef struct vid_mem_table {

    uint32_t table[NUM_ENT] __attribute__((aligned(KB4)));

} __attribute__((packed)) vid_mem_table_t;

/* Intialize paging */
void paging_init(void);
void new_init(void);
int paging_init_per_processor(uint32_t pid);
page_dir_entry_big_t * pid_to_dir_entry(int pid);
int switch_paging(uint32_t pid);
int address_mapped(int32_t vaddr, int pid);
int address_in_user(int32_t vaddr, int pid);
int map_vid_memory(int pid);
int unmap_vid_memory(int pid);
int32_t switch_vid_mem_out(int pid, int term, int curr_pid);
int32_t switch_vid_mem_in(int pid, int curr_pid);
uint32_t* get_process_directory(int pid);
uint32_t* get_page_table(int pid);
int new_paging(uint32_t pid, uint32_t parent_pid);
/* Set PG bit in CR0 */
#define page_enable(void)           \
do {                                \
    uint32_t cr0_temp;              \
    asm volatile(                   \
        "movl %%cr0, %0"            \
        : "=r" (cr0_temp)           \
         );                         \
    cr0_temp |= PAGE_MASK;          \
    asm volatile(                   \
        "movl %0, %%cr0"            \
        :                           \
        : "r" (cr0_temp)            \
        );                          \
} while(0)

/* Set protected mode bit */
#define protect_enable(void)        \
do {                                \
    uint32_t cr0_temp;              \
    asm volatile(                   \
        "movl %%cr0, %0"            \
        : "=r" (cr0_temp)           \
        );              \
    cr0_temp |= PROTECTED_MASK;     \
    asm volatile(                   \
        "movl %0, %%cr0"            \
        :                           \
        : "r" (cr0_temp)            \
         );                         \
} while(0)

/* Set PSE bit, to allow 4kB and 4MB pages */
#define pse_enable(void)            \
do {                                \
    uint32_t cr4_temp;              \
    asm volatile(                   \
        "movl %%cr4, %0"            \
        : "=r" (cr4_temp)           \
         );                         \
    cr4_temp |= PSE_MASK;           \
    asm volatile(                   \
        "movl %0, %%cr4"            \
        :                           \
        : "r" (cr4_temp)            \
         );                         \
} while(0)

/* Set the CR3 with address of page directory */
#define set_cr3(dir_addr)           \
do {                                \
    asm volatile(                   \
        "movl %0, %%cr3"            \
        :                           \
        : "r" (dir_addr)            \
         );                         \
} while(0)

#endif
#endif
