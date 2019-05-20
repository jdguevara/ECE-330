# file: gpio_d.s

.include "macros.inc"

.include "src/gpio_regs.inc"
    
  SET_TARGET

  .text

  FUNCTION gpio_d_init,global

    // Push lr onto the stack
    push {lr}

    // Set r0 to 3 since we want to enable the clock for GPIOD
    mov r0,#3
    bl  rcc_gpio_enable

    // Load r3 with the GPIOD base address
    ldr r3,=#GPIOD_BASE

    // Initialize the pins in port D to output
    ldr r2,=#0x00000000
    str r2,[r3,#GPIO_PUPDR]
    str r2,[r3,#GPIO_OTYPER]
    str r2,[r3,#GPIO_ODR]

    ldr r2,=#0x55555555
    str r2,[r3,#GPIO_MODER]

    ldr r2,=#0xffffffff
    str r2,[r3,#GPIO_OSPEEDR]
    
    // Pop lr off the stack
    pop {lr}

    bx lr
  
  ENDFUNC gpio_d_init

  // Define function gpio_d_put 
  FUNCTION gpio_d_put,global
    
    // Load the base address of GPIOD into r3
    ldr r3,=#GPIOD_BASE

    str r0,[r3,#GPIO_ODR]

    bx  lr

  ENDFUNC gpio_d_put
  
  // Define function gpio_d_get_current 
  FUNCTION gpio_d_get_current,global
    
    // Load the base address of GPIOD into r3
    ldr r3,=#GPIOD_BASE

    ldr r0,[r3,#GPIO_ODR]

    bx  lr

  ENDFUNC gpio_d_put

  .end
