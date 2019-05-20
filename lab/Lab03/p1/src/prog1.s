# file: prog1.s

/* Team: W9
 * Team Members: Jaime Guevara & Lorenzo Sablan
 */

.include "macros.inc"

  SET_TARGET

  .text

  // Main executable function
  FUNCTION main,global

    push {r4,r5,r6,r7,lr} // Queue up the registers we need

    ldr  r4,=0x11223344 // Load r4 
    ldr  r5,=0x55667788 // Load r5

    add  r2,r4,r5 // Add the value of r5 to the value in r4 and store in r2

    all_done:
   
    pop {r4,r5,r6,r7,lr} // De-queue the following registers

    bx lr
  
  ENDFUNC main // End of function main

  .data

  .end
