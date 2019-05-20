# file: lab06p4.s

.include "macros.inc"

  SET_TARGET

  .text

  # Set our GPIO offsets
  .equ GPIOD_BASE,0x40020c00
  .equ GPIO_MODER,0x00
  .equ GPIO_ODR,0x14

  FUNCTION main,global

    # Push the registers we want onto the stack
    push {r4,r5,r6,r7,lr}

    # Put the GPIO base address into r4
    ldr  r4,=GPIOD_BASE

    # Set the bits we want for the LEDs 
    # put said bits into GPIO Mode Register
    ldr  r2,=(0b01010101<<(2*12))
    str  r2,[r4,#GPIO_MODER] 


    # r5 will turn off our registers
    ldr  r5,=#0

    # r6 - r12 turn on our desired LEDs accordingly
    ldr  r6,=(1<<15)
    ldr  r10,=(1<<14)
    ldr  r11,=(1<<13)
    ldr  r12,=(1<<12)

    # Begin the loop so we can have circular flashing 
    loop:

    # Turn on the orange LED
    str  r11,[r4,#GPIO_ODR]
    ldr r0,=#1000000
    bl delay
    
    # Turn off the orange LED
    str  r5,[r4,#GPIO_ODR]
    ldr  r0,=#1000000
    bl delay
    
    # Turn on the red LED
    str  r10,[r4,#GPIO_ODR]
    ldr r0,=#1000000
    bl delay
    
    # Turn off the red LED
    str  r5,[r4,#GPIO_ODR]
    ldr  r0,=#1000000
    bl delay
    
    # Turn on the blue LED
    str  r6,[r4,#GPIO_ODR]
    ldr r0,=#1000000
    bl delay

    # Turn off the blue LED
    str  r5,[r4,#GPIO_ODR]
    ldr  r0,=#1000000
    bl delay

    # Turn on the green LED
    str  r12,[r4,#GPIO_ODR]
    ldr r0,=#1000000
    bl delay

    # Turn off the green LED
    str  r5,[r4,#GPIO_ODR]
    ldr  r0,=#1000000
    bl delay

    # Repeat this sequence by branching back to 
    # the label 'loop'
    b loop
    
    all_done:
    
    # Pop the following register off the stack 
    pop {r4,r5,r6,r7,lr}

    bx lr

  ENDFUNC main

  # Define our delay function 
  FUNCTION delay

    # Set r3 to 0
    mov r3,#0

    # Loop implementing delay
    delay_loop:

        # Each pass subtract 1 from r0
        sub r0,#1

        # Each pass compare r0 and r3's values
        cmp r0,r3

        # Branch back to 'delay_loop' if cmp indicates
        # value of r0 is greater than or equal to r3
        bge delay_loop 

    # Exit function by branching and exchanging
    bx lr
   
  # End of function definition
  ENDFUNC delay
  
  .data

  .end
