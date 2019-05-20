# file: lab06p2.s

.include "macros.inc"

  SET_TARGET

  .text

  # Set the values for our symbols
  .equ GPIOD_BASE,0x40020c00
  .equ GPIO_MODER,0x00
  .equ GPIO_ODR,0x14

  FUNCTION main,global

    # Push the registers onto the stack
    push {r4,r5,r6,r7,lr}

    # Load registers we want with the offsets we need
    ldr  r4,=GPIOD_BASE
    ldr  r2,=(0b01<<(2*13))
    str  r2,[r4,#GPIO_MODER]

    # Set r5 and r6 with the values to turn our bits on/off
    ldr  r5,=#0
    ldr  r6,=(1<<13)

    # Turn on the orange LED
    str  r6,[r4,#GPIO_ODR]

    # Turn off the orange LED
    str  r5,[r4,#GPIO_ODR]

    all_done:
    
    # Pop our the following registers off the stack
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

  .end
