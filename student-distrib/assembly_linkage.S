#define ASM 1
#define MAX_SYS_CALL 10
#define MIN_SYS_CALL 1
#include "assembly_linkage.h"

.text
.globl divide_by_zero_linkage, debugger_linkage, NMI_linkage, breakpoint_linkage, overflow_linkage, bounds_linkage, invalid_opcode_linkage
.globl coprocessor_linkage, double_fault_linkage, coprocessor_segment_linkage, invalid_tss_linkage, segment_not_present_linkage, stack_segment_fault_linkage
.globl general_protection_fault_linkage, page_fault_linkage, floating_point_linkage, alignment_check_linkage, machine_check_linkage, SIMD_floating_point_linkage
.globl keyboard_int_linkage, rtc_int_linkage, system_call_linkage, pit_int_linkage
.globl halt_return, pit_ret
retval:
	.long 

 # divide_by_zero_linkage
 #   DESCRIPTION: divide by zero exception assembly linkage, pushes flags and registers before
 #					calling divide by zero expection handler, then pops flags and registers after handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler

divide_by_zero_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	divide_by_zero
	popal
	popfl
	leave
	iret		

 # debugger_linkage
 #   DESCRIPTION: debugger exception assembly linkage, pushes flags and registers before
 #					calling expection handler, then pops flags and registers after handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS: saves/restores all registers & flags, calls exception handler
debugger_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	debugger
	popal
	popfl
	leave
	iret

 # NMI_linkage
 #   DESCRIPTION: NMI interrupt
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
NMI_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	NMI
	popal
	popfl
	leave
	iret

 # breakpoint_linkage:
 #   DESCRIPTION: interrupt linkage for breakpoints
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
breakpoint_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	breakpoint
	popal
	popfl
	leave
	iret

 # overflow_linkage:
 #   DESCRIPTION: overflow exception
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
overflow_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	overflow
	popal
	popfl
	leave
	iret

 # bounds_linkage:
 #   DESCRIPTION: out of bouds exception
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
bounds_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	bounds
	popal
	popfl
	leave
	iret

 # invalid_opcode_linkage:
 #   DESCRIPTION: invalid opcode excpetion handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
invalid_opcode_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	invalid_opcode
	popal
	popfl
	leave
	iret

 # coprocessor_linkage:
 #   DESCRIPTION: coprocessor exceiption handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
coprocessor_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	coprocessor
	popal
	popfl
	leave
	iret

 # double_fault_linkage:
 #   DESCRIPTION: handler for double fault linkage
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
double_fault_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	double_fault
	popal
	popfl
	leave
	iret

 # coprocessor_segment_linkage:
 #   DESCRIPTION: coprocess segmentation exception
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
coprocessor_segment_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call	coprocessor_segment
	popal
	popfl
	leave
	iret

 # invalid_tss_linkage:
 #   DESCRIPTION: coprocessor exceiption handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
invalid_tss_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	invalid_tss
	popal
	popfl
	leave
	iret

 # segment_not_present_linkage:
 #   DESCRIPTION: segment not prsent exception handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
segment_not_present_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	segment_not_present 
	popal
	popfl
	leave
	iret

 # stack_segment_fault_linkage:
 #   DESCRIPTION: exception for stack segment exceptions
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
stack_segment_fault_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	stack_segment_fault
	popal
	popfl
	leave
	iret

 # general_protection_fault_linkage:
 #   DESCRIPTION: exception handler for general protection faults
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
general_protection_fault_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	general_protection_fault
	popal
	popfl
	leave
	iret

 # page_fault_linkage:
 #   DESCRIPTION: handler for page faults
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
page_fault_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	page_fault
	popal
	popfl
	leave
	iret

 # floating_point_linkage:
 #   DESCRIPTION: floating point exception handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
floating_point_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	floating_point
	popal
	popfl
	leave
	iret

 # alignment_check_linkage:
 #   DESCRIPTION: alignment exception handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
alignment_check_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	alignment_check
	popal
	popfl
	leave
	iret

 # machine_check_linkage:
 #   DESCRIPTION: machine check exception handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
machine_check_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	machine_check
	popal
	popfl
	leave
	iret

 # SIMD_floating_point_likage:
 #   DESCRIPTION: exception handler for multi process floating point exceptions
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
SIMD_floating_point_linkage: 
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	SIMD_floating_point
	popal
	popfl
	leave
	iret

 # keyboard_int_linkage:
 #   DESCRIPTION: interrupt handler for keyboard presses
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
keyboard_int_linkage: 
	# pushl 	%ebp
	# movl	%esp, %ebp
	pushfl
	pushal
	call 	keyboard_int
	popal
	popfl
	# leave
	iret

 # rtc_int_linkage:
 #   DESCRIPTION: rtc interrupt handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
rtc_int_linkage:
	pushl 	%ebp
	movl	%esp, %ebp
	pushfl
	pushal
	call 	rtc_int
	popal
	popfl
	leave
	iret

# system call jump table
sys_call_table:
  .long 0
  .long khalt
  .long kexecute
  .long kread
  .long kwrite
  .long kopen
  .long kclose
  .long kget_args
  .long kvidmap
  .long kset_handler
  .long ksigreturn

 # system_call_linkage:
 #   DESCRIPTION: handler for system calls
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
system_call_linkage:
  pushfl
  pushal

  cmpl $MIN_SYS_CALL,%eax              #EAX holds system call number
  jl invalid_syscall_num    #check if between 1 to 10
  cmpl $MAX_SYS_CALL,%eax
  jg invalid_syscall_num
  
  pushl %edx                #third param
  pushl %ecx                #second param
  pushl %ebx                #first param

  movw    $KERNEL_DS, %cx
  movw    %cx, %ds 

  call *sys_call_table(,%eax,4)
 
  addl $12,%esp
  # save return value from popa
  movl %eax, retval
  popal
  movl retval, %eax
  popfl
  iret

# return label for halt
halt_return:
  	leave
	ret

invalid_syscall_num:
  movl $-1, retval             
  popal
  popfl
  movl retval, %eax
  iret

 # pit_int_linkage:
 #   DESCRIPTION: PIT interrupt handler
 #   INPUTS: none
 #   OUTPUTS: none
 #   RETURN VALUE: none
 #   SIDE EFFECTS saves/restores all registers & flags, calls exception handler
pit_int_linkage:
	#save address to iret frame on kernel stack
	movl %esp,%ebx
	pushfl
	pushal
	pushl %ebx
	call pit_handler
pit_ret:	
	addl $4,%esp
	# allow PIC to start sending interrupts again
	pushl $0
	call send_eoi
	addl $4,%esp
	popal
	popfl
	iret
	

