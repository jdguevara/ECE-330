# file: lab03p2d.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers

    ldr  r4,=0x1111 // Load r4 with the following value

    lsl  r4,3 // Shift the value in r4 left by 3 bits, re-store in r4

    lsr  r4,2 // Shift the value in r4 right by 2 bits, re-store in r4

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .end
