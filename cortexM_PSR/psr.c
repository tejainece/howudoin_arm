void func() {
  asm volatile(
    "mrs     r0, PSR\n\t"
    "mrs     r0, APSR\n\t"
  );
}
