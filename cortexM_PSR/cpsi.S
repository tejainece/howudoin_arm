.syntax unified
.global main
main:
  cpsie     i
  mov       r0, #1
  msr       PRIMASK, r0
