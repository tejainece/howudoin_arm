// Startup file for ARM cortex-M series processors
//
// Defines :
// 1. ISRs
// 2. startup routine
// 3. initializes `.bss` and `.data` sections

.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.global  g_pfnVectors
.global  Default_Handler

// start address for the initialization values of the .data section.
// defined in linker script
.word  _sidata
// start address for the .data section. defined in linker script
.word  _sdata
// end address for the .data section. defined in linker script
.word  _edata
// start address for the .bss section. defined in linker script
.word  _sbss
// end address for the .bss section. defined in linker script
.word  _ebss
// stack used for SystemInit_ExtMemCtl; always internal RAM used

/**
* @brief  This is the code that gets called when the processor first
*          starts execution following a reset event. Only the absolutely
*          necessary set is performed, after which the application
*          supplied main() routine is called.
* @param  None
* @retval : None
*/

	.section  .text.Reset_Handler
.weak  Reset_Handler
.type  Reset_Handler, %function
.align 2
Reset_Handler:
bl  c_entry
here: b  here
.size  Reset_Handler, .-Reset_Handler

/**
* @brief  This is the code that gets called when the processor receives an
*         unexpected interrupt.  This simply enters an infinite loop, preserving
*         the system state for examination by a debugger.
* @param  None
* @retval None
*/
	.section  .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
b  Infinite_Loop
.size  Default_Handler, .-Default_Handler

//ISR
 .section  .isr_vector,"a",%progbits
.type  g_pfnVectors, %object
.size  g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
.word  _estack
.word  Reset_Handler
.word  NMI_Handler
.word  HardFault_Handler
.word  MemManage_Handler
.word  BusFault_Handler
.word  UsageFault_Handler
.word  0
.word  0
.word  0
.word  0
.word  SVC_Handler
.word  DebugMon_Handler
.word  0
.word  PendSV_Handler
.word  SysTick_Handler

.weak      NMI_Handler
.thumb_set NMI_Handler,Default_Handler

.weak      HardFault_Handler
.thumb_set HardFault_Handler,Default_Handler

.weak      MemManage_Handler
.thumb_set MemManage_Handler,Default_Handler

.weak      BusFault_Handler
.thumb_set BusFault_Handler,Default_Handler

.weak      UsageFault_Handler
.thumb_set UsageFault_Handler,Default_Handler

.weak      SVC_Handler
.thumb_set SVC_Handler,Default_Handler

.weak      DebugMon_Handler
.thumb_set DebugMon_Handler,Default_Handler

.weak      PendSV_Handler
.thumb_set PendSV_Handler,Default_Handler

.weak      SysTick_Handler
.thumb_set SysTick_Handler,Default_Handler
