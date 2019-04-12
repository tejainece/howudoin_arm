CC= arm-eabi-gcc.exe
AS= arm-eabi-as.exe
CFLAGS= -mcpu=cortex-m4 -march=armv7e-m -mthumb -ggdb

OBJDUMP= arm-eabi-objdump.exe

all: psr.S
	${AS} ${CFLAGS} $^ -o psr.o
	${OBJDUMP} -dS psr.o

cpsi: cpsi.S
	${AS} ${CFLAGS} $^ -o cpsi.o
	${OBJDUMP} -dS cpsi.o

cc: psr.c
	${CC} ${CFLAGS} $^ -S -o psr_c.S
	${CC} ${CFLAGS} $^ -c -o psr_c.o
	${OBJDUMP} -d psr_c.o

clean:
	rm *.o psr_c.S
