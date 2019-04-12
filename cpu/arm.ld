/* Entry point */
ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_estack = 0x2001FFFF; /* end of 128K RAM on AHB bus*/

/* Generate a link error if heap and stack don't fit into RAM */
_Min_Heap_Size = 0; /* required amount of heap */
_Min_Stack_Size = 0x400; /* required amount of stack */

MEMORY
{
	  FLASH_OS_IVEC (rx) : org = 0x08020000, l = 0x190
	  FLASH_OS_INFO (r) : org = 0x08020190, l = 0x20
	  FLASH_OS_TEX (rx) : org = 0x080201B0, l = 0x3FE40
	  FLASH_OS_CRC (r) : org = 0x0805FFF0, l = 0x10

	  RAM (xrw) : org = 0x20000000, l = 128K
}

SECTIONS
{
    /* The startup code goes first into FLASH */
    .isr_vector :
    {
      . = ALIGN(4);
      KEEP(*(.isr_vector)) /* Startup code */
      . = ALIGN(4);
    } >FLASH_OS_IVEC

    /* The program code and other data goes into FLASH */
    .text :
    {
      . = ALIGN(4);
      *(.text.Reset_Handler) /* .text sections (code) */
      *(.text) /* .text sections (code) */
      *(.text*) /* .text* sections (code) */
      *(.rodata) /* .rodata sections (constants, strings, etc.) */
      *(.rodata*) /* .rodata* sections (constants, strings, etc.) */
      *(.glue_7) /* glue arm to thumb code */
      *(.glue_7t) /* glue thumb to arm code */
      *(.eh_frame)

      KEEP (*(.init))
      KEEP (*(.fini))

      . = ALIGN(4);
      _etext = .; /* define a global symbols at end of code */
    } >FLASH_OS_TEX


     .ARM.extab : {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
     } >FLASH_OS_TEX

     .ARM : {
      __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
      } >FLASH_OS_TEX

    .preinit_array :
    {
      PROVIDE_HIDDEN (__preinit_array_start = .);
      KEEP (*(.preinit_array*))
      PROVIDE_HIDDEN (__preinit_array_end = .);
    } >FLASH_OS_TEX

    .init_array :
    {
      PROVIDE_HIDDEN (__init_array_start = .);
      KEEP (*(SORT(.init_array.*)))
      KEEP (*(.init_array*))
      PROVIDE_HIDDEN (__init_array_end = .);
    } >FLASH_OS_TEX

    .fini_array :
    {
      PROVIDE_HIDDEN (__fini_array_start = .);
      KEEP (*(.fini_array*))
      KEEP (*(SORT(.fini_array.*)))
      PROVIDE_HIDDEN (__fini_array_end = .);
    } >FLASH_OS_TEX

    /* used by the startup to initialize data */
    _sidata = .;

    /*                             RAM                              */
    .mydata (NOLOAD) : {
      . = ALIGN(4);
      /* NOTE: add stuff you don't want to be loaded from flash by initialization
      routines */
      . = ALIGN(4);
    } >RAM

    /* Initialized data sections goes into RAM, load LMA copy after code */
    .data : AT ( _sidata )
    {
      . = ALIGN(4);
      _sdata = .; /* create a global symbol at data start */
      *(.ramfunc) /* Functions that needs to be on RAM */

      . = ALIGN(4);
      *(.data) /* .data sections */
      *(.data*) /* .data* sections */

      . = ALIGN(4);
      _edata = .; /* define a global symbol at data end */
    } >RAM

    /* Uninitialized data section */
    . = ALIGN(4);
    .bss :
    {
      /* This is used by the startup in order to initialize the .bss secion */
      _sbss = .; /* define a global symbol at bss start */
      __bss_start__ = _sbss;
      *(.bss)
      *(.bss*)
      *(COMMON)

      . = ALIGN(4);
      _ebss = .; /* define a global symbol at bss end */
      __bss_end__ = _ebss;
    } >RAM

    /* User_heap_stack section, used to check that there is enough RAM left */
    ._user_heap_stack :
    {
      . = ALIGN(4);
      PROVIDE ( end = . );
      PROVIDE ( _end = . );
      PROVIDE ( __end__ = . );
      . = . + _Min_Heap_Size;
      KEEP (*(.ram.TOS))
      . = . + _Min_Stack_Size;
      . = ALIGN(4);
    } >RAM
    
    /* Remove information from the standard libraries */
	  /DISCARD/ :
    {
      libc.a ( * )
      libm.a ( * )
      libgcc.a ( * )
    }

	  .ARM.attributes 0 : { *(.ARM.attributes) }
}
