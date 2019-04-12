.arm

#Example of using mrs and msr instructions to enable or disable interrupts in
#Cortex-A or Cortex-R processors

I_BIT = 0x80
F_BIT = 0x40

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
