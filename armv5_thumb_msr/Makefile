CC= arm-eabi-gcc.exe
AS= arm-eabi-as.exe
CFLAGS= -mcpu=arm9tdmi -march=armv5t -mthumb -ggdb
CFLAGSARM= -mcpu=arm9tdmi -march=armv5t -ggdb
CFLAGSTHUMB2= -mcpu=cortex-m4 -mthumb -ggdb

OBJDUMP= arm-eabi-objdump.exe

all: armv5_thumb_msr.S
	${AS} ${CFLAGS} $^ -o armv5_thumb_msr.o
	${OBJDUMP} -dS armv5_thumb_msr.o

arm_interrupt: arm_interrupt.S
	${AS} ${CFLAGSARM} $^ -o arm_interrupt.o
	${OBJDUMP} -dS arm_interrupt.o

thumb2_interrupt: thumb2_interrupt.S
	${AS} ${CFLAGSTHUMB2} $^ -o thumb2_interrupt.o
	${OBJDUMP} -dS thumb2_interrupt.o
