#include <stdint.h>

void c_entry() {
  asm volatile (
    "\n\t"
    "ldr r0, =#-123\n\t"
    "ldr r1, =#122\n\t"
    "adds r2, r0, r1\n\t"
    "\n\t"
    : : : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r8", "r9", "r10", "r12", "cc", "memory"
  );

  while(1);
}
