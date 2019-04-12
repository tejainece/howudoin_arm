.arm

#Example of using mrs and msr instructions to enable or disable interrupts in
#Cortex-A or Cortex-R processors

I_BIT = 0x80
F_BIT = 0x40
C_BIT = 0x1F
USER_BITS = 0b10000

.global main
main:
  #Disables IRQ and FIQ interrupts
  mrs     r0, cpsr
  orr     r0, r0, #I_BIT|F_BIT
  msr     cpsr_c, r0

  #Enables IRQ and FIQ interrupts
  mrs     r0, cpsr
  bic     r0, r0, #I_BIT|F_BIT
  msr     cpsr_c, r1

  mrs     r0, cpsr
  bic     r0, #C_BIT
  orr     r0, #USER_BITS
  msr     CPSR_c, r0
