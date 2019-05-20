# file: lab06p3.s

.include "macros.inc"

  SET_TARGET

  .text

  # Set the values of our symbols to help activate GPIOD
  .equ GPIOD_BASE,0x40020c00
  .equ GPIO_MODER,0x00
  .equ GPIO_ODR,0x14

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    # Set r4 to our GPIOD base address
    ldr  r4,=GPIOD_BASE

    # Shift our wanted value to the spot we need
    ldr  r2,=(0b01<<(2*14))
    str  r2,[r4,#GPIO_MODER] 

    # Load into r5 and r6 the values needed to turn our bits on/off 
    ldr  r5,=#0
    ldr  r6,=(1<<14)

    # Start of our loop
    loop:

    # Turn on our red LED
    str  r6,[r4,#GPIO_ODR]

    # Set r0 to the value we want prior to passing it to our delay function
    ldr r0,=#1000000
    bl delay

    # Turn off our red LED
    str  r5,[r4,#GPIO_ODR]

    # Set r0 to the value we want prior to passing it to our delay function
    ldr  r0,=#1000000
    bl delay

    # Loop back to our label 'loop'
    b loop

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main
 
  # Define our function named 'delay'
  FUNCTION delay

    # Set r3 to 0
    mov r3,#0

    # Begin delay loop
    delay_loop:

        # Subtract one from the value of r0 
        # (which we should've set before calling this subroutine)
        sub r0,#1

        # Compare the values of r0 and r3 and if it's greater than, or equal,
        # loop back to beginning of this loop
        cmp r0,r3
        bge delay_loop 

    # Branch and exchange back to main
    bx lr
   
  # End function definition
  ENDFUNC delay
  
  .data

  .end
