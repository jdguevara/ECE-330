# file: gpio_c.s

.include "./gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION gpio_c_init,global

    # Pushing lr onto the stack
    push {lr}

    # Set r0 to 2 as we want to enable the clock for port C
    mov r0,#2
    bl  rcc_gpio_enable

    # Set r3 to GPIO C base address
    ldr r3,=#GPIOC_BASE

    # Initialize all the pins to input
    ldr r2,=#0x00000000
    str r2,[r3,#GPIO_IDR]

    all_done:
    
    # Pop lr off the stack
    pop {lr}

    bx lr
  
  ENDFUNC main

  # Define our get function
  FUNCTION gpio_c_get,global

    # Load GPIOC base address in r3
    ldr r3,=#GPIOC_BASE

    # Load the input pins into r0
    ldr r0,[r3,#GPIO_IDR]

    bx  lr

  ENDFUNC gpio_c_get

  .end
