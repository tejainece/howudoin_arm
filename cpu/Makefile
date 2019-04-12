
AS=arm-eabi-as
ASFLAGS= -mcpu=cortex-m4 -mthumb
CC=arm-eabi-gcc
CCFLAGS= -mcpu=cortex-m4 -mthumb -mno-thumb-interwork -O0 -ffunction-sections -fdata-sections -Wl,--gc-sections -g
LD=arm-eabi-ld
LDFLAGS= ${CCFLAGS} -Tarm.ld -Wl,-Map,"exec.map"
GDB=arm-eabi-gdb

all: exec

startup.out: startup.S
	${AS} ${ASFLAGS} -o startup.out startup.S

entry.out: entry.c
	${CC} ${CCFLAGS} -S -o entry.S entry.c
	${CC} ${CCFLAGS} -c -o entry.out entry.c

exec.elf: startup.out entry.out
	${CC} ${LDFLAGS} -o $@ $^

debug: exec.elf
	qemu-system-arm.exe --machine STM32F4-Discovery --cpu  cortex-m4 -s -S exec.elf
	# qemu-system-arm -M versatilepb -m 128M -nographic -serial /dev/null -kernel exec.bin -s -S

gdb: exec.elf
	${GDB} exec

clean:
	-rm *.out *.elf *.map
	-rm entry.S
