# file: lab03p3b.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  // Main function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue the following registers

    mov  r4,#7 // Place the value (number) seven in r4
    mov  r5,#13 // Place the value (number) thirteen in r5

    subs r6,r4,r5 // Subtract the value of r5 from r4, store in r6, update conditional flags

    all_done:
    
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of main

  .end
