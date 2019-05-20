# file: gpio_c.s

.include "macros.inc"

.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  // GPIOC function definition
  FUNCTION gpio_c_init,global

    // Pushing lr onto the stack
    push {lr}

    // Set r0 to 2 as we want to enable the clock for port C
    mov r0,#2
    bl  rcc_gpio_enable

    // Set r3 to GPIO C base address
    ldr r3,=#GPIOC_BASE

    // Initialize all the pins to input using the right offsets
    ldr r2,=#0x00000000
    str r2,[r3,#GPIO_PUPDR]
    str r2,[r3,#GPIO_MODER]
    str r2,[r3,#GPIO_OTYPER]

    ldr r2,=#0xffffffff
    str r2,[r3,#GPIO_OSPEEDR]

    // Pop lr off the stack
    pop {lr}

    bx lr
  
  ENDFUNC gpio_c_init

  // Define our get function
  FUNCTION gpio_c_get,global

    // Load GPIOC base address in r3
    ldr r3,=#GPIOC_BASE

    // Load the input pins into r0
    ldr r0,[r3,#GPIO_IDR]

    // Branch and exchange out of subroutine 
    bx  lr

  // End of function definition
  ENDFUNC gpio_c_get

  .end
