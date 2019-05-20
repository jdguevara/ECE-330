# file: lab03p3a.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers

    ldr  r4,=(1<<31)-1 // Load r4 with the following value (i.e. 1 shifted 31 bits to the left and subtracted by 1)

    mov  r5,4 // Copy/Place the value 4 into register 5

    adds r2,r4,r5 // Add the value in r5 to r4 and store in r2, update conditional flags based on result

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .end
