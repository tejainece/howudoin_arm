.syntax unified
.thumb
.global main
main:
  msr       PRIMASK, r0
  msr       FAULTMASK, r0

  msr       CONTROL, r0
