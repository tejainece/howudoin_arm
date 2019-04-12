AS=arm-eabi-as
ASFLAGS=-g -o
CC=arm-eabi-gcc
CCFLAGS=-g -c -nostdlib -o
LD=arm-eabi-ld
LDFLAGS=-Tarm.ld -o
GDB=arm-eabi-gdb

all: exec

startup.out: startup.S
	${AS} ${ASFLAGS} startup.out startup.S

#entry.out: entry.c
#	${CC} ${CCFLAGS} entry.out entry.c

exec: startup.out #entry.out
	${LD} ${LDFLAGS} $@ $^

debug: exec
	qemu-system-arm -M versatilepb -m 128M -nographic -serial /dev/null -kernel exec -s -S

gdb: exec
	${GDB} exec

clean:
	rm *.out exec *.o
