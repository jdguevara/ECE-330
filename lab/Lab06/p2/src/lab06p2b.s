# file: lab06p2b.s

.include "macros.inc"

  SET_TARGET

  .text

  .equ GPIOD_BASE,0x40020c00
  .equ GPIO_MODER,0x00
  .equ GPIO_ODR,0x14

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    # Load our registers with the necessary offsets
    ldr  r4,=GPIOD_BASE
    ldr  r2,=(0b01<<(2*12))
    str  r2,[r4,#GPIO_MODER]

    # Load r5 and r6 with the values to turn our bits on/off
    ldr  r5,=#0
    ldr  r6,=(1<<12)

    # Set a continuous loop for the following operations
    loop:

    # Turn on the red LED
    str  r6,[r4,#GPIO_ODR]

    # Turn off the red LED
    str  r5,[r4,#GPIO_ODR]

    # call back to loop label (essentially 'loop' back)
    b loop

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

  .end
