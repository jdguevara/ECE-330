# file: lab03p4.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers
    
    Left_Shift = 6 // Set this symbol with a value of 6
    Right_Rotate = 18 // Set this symbol with a value of 13

    ldr   r4,=A // Load r4 with the address of A, establish addressability

    ldrb  r5,[r4,A-A] // Load a byte into r5 using the address of r4 and the given offset
    ldrh  r6,[r4,B-A] // Load a short/half-word into r6 using the address of r4 and the given offset of B-A
    ldr   r7,[r4,C-A] // Load a word into r7 using the address of r4 and the given offset of C-A

    lsl   r5,Left_Shift // Shift the bits in r5 by the number of bits specified in Left_Shift, re-store in r5
    ror   r5,Right_Rotate // Rotate the bits in r5 by the number of bits specified by Right_Rotate, re-store in r5
    lsl   r6,Left_Shift // Shift the bits in r6 by the number of bits specified in Left_Shift, re-store in r6
    ror   r6,Right_Rotate // Rotate the bits in r6 by the number of bits specified by Right_Rotate, re-store in r6
    lsl   r7,Left_Shift // Shift the bits in r7 by the number of bits specified in Left_Shift, re-store in r7
    ror   r7,Right_Rotate // Rotate the bits in r7 by the number of bits specified by Right_Rotate, re-store in r7

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .data // Since we are using labels we need to define them in the data section
  
A: .byte  0x9 // Set label A to require a byte's worth of space and store 0x9 in it
.align 1 // Align our counter with the right amount of space/offset for a half-word
B: .short 0x9 // Set label B to require a short's/half-word/s worth of space and store 0x9 in it
.align 2 // Align our counter with the right amount of space/offset for a word
C: .word  0x9 // Set label C to require a word's worth of space and store 0x9 in it
 
  .end
