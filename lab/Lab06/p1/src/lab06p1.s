# file: lab06p1.s
# This comment currently does nothing

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    all_done:
    
    bx lr
  
  ENDFUNC main

  .data

  .end
