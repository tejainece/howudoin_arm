ENTRY(_start)
SECTIONS
{
 . = 0x0;
 .startup . : { startup.out(.text) }
 .text : { *(.text) }
 .data : { *(.data) }
 .rodata : { *(.rodata) }
 .bss : { *(.bss) }
 . = . + 0x1000; /* 4kB of stack memory */
 stack_top = .;
}
