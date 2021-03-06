# file: lab03p2f.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers

    ldr  r4,=0xFFFFFFFF // Load r4
    ldr  r5,=0x12345678 // Load r5

    orr  r6,r4,r5 // Carry out a bitwise OR operation on r4 and r5, store the result in r6

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .end
