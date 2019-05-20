# file: lab03p2b.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers

    ldr  r4,=68 // Load r4
    ldr  r5,=45 // Load r5

    sub  r2,r4,r5 // Subtract the value in r5 from r4 and store in r2

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers
    
    bx lr
  
  ENDFUNC main // End of main

  .end
