# file: lab03p2c.s

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

    mvn  r6,r5 // Move/copy the value in r5, and then negate it, to r6 

    add  r6,1 // Add 1 to the value in r6 and update r6 with the new value

    add  r2,r4,r6 // Add the value in r6 to the value in r4 and store in r2

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .end
