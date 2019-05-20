# file: LEDR.s

.include "macros.inc"

.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION LEDR_Init,global

    // Pushing lr onto the stack
    push {lr}

    bl gpio_d_init

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of subroutine
    bx lr
  
  ENDFUNC LEDR_Init

  // Define our get function
  FUNCTION LEDR_Put_A,global
    
    // Push lr onto the stack
    push {lr}

    // Copy the current value we have in r0 to r1
    mov r1,r0

    // Call the gpio_d_get_current subroutine
    bl gpio_d_get_current
    
    // Save the mask we desire in r2
    ldr r2,=(~(~0<<1))

    // Clear out garbage in our desired value
    and r1,r2,r1 

    // Shift both mask and desired values by 8 bits to the left
    lsl r1,r1,#8
    lsl r2,r2,#8

    // Create an inverse mask 
    mvn r2,r2

    // Clear out space in target register
    and r0,r0,r2

    // Merge target register and desired value
    orr r0,r0,r1

    // Call the gpio_d_put subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC LEDR_Put_A

  // Define our get function
  FUNCTION LEDR_Put_B,global
    
    // Push lr onto the stack
    push {lr}

    // Copy our r0 value into r1 so we don't lose it (desired)
    mov r1,r0

    // Call the following subroutine to get the current GPIOD value
    bl gpio_d_get_current
    
    // Load our 4-bit wide mask into r2
    ldr r2,=(~(~0<<4))
    
    // Clear out garbage bits from desired value
    and r1,r2,r1 

    // Shift both the desired and mask values over by the bits we want
    lsl r1,r1,#2
    lsl r2,r2,#2

    // Make an inverse mask 
    mvn r2,r2

    // Clear out space in our target register
    and r0,r0,r2

    // Merge values into the target register
    orr r0,r0,r1

    // Put into desired GPIOD register using subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC LEDR_Put_B
  

  // Define our put function for switches [14:12]
  FUNCTION led_put_index,global
    
    // Push lr onto the stack
    push {lr}

    // Copy our r0 value into r1 so we don't lose it (desired)
    mov r1,r0

    // Call the following subroutine to get the current GPIOD value
    bl gpio_d_get_current
    
    // Load our 3-bit wide mask into r2
    ldr r2,=(~(~0<<3))
    
    // Clear out garbage bits from desired value
    and r1,r2,r1 

    // Shift both the desired and mask values over by the bits we want
    lsl r1,r1,#12
    lsl r2,r2,#12

    // Make an inverse mask 
    mvn r2,r2

    // Clear out space in our target register
    and r0,r0,r2

    // Merge values into the target register
    orr r0,r0,r1

    // Put into desired GPIOD register using subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC led_put_index
  
  
  // Define our put function for switches [6:0]
  FUNCTION led_put_segments,global
    
    // Push lr onto the stack
    push {lr}

    // Copy our r0 value into r1 so we don't lose it (desired)
    mov r1,r0

    // Call the following subroutine to get the current GPIOD value
    bl gpio_d_get_current
    
    // Load our 7-bit wide mask into r2
    ldr r2,=(~(~0<<7))
    
    // Clear out garbage bits from desired value
    and r1,r2,r1 

    // We may not even need to shift for this section, but I'll keep just in case
    /* Shift both the desired and mask values over by the bits we want
    lsl r1,r1,#12
    lsl r2,r2,#12
    */

    // Make an inverse mask 
    mvn r2,r2

    // Clear out space in our target register
    and r0,r0,r2

    // Merge values into the target register
    orr r0,r0,r1

    // Put into desired GPIOD register using subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC led_put_segments

  // Define our put function for our latch 
  FUNCTION led_put_latch,global
    
    // Push lr onto the stack
    push {lr}

    // Copy our r0 value into r1 so we don't lose it (desired)
    mov r1,r0

    // Call the following subroutine to get the current GPIOD value
    bl gpio_d_get_current
    
    // Load our 1-bit wide mask into r2
    ldr r2,=(~(~0<<1))
    
    // Clear out garbage bits from desired value
    and r1,r2,r1 

    // Make an inverse mask 
    mvn r2,r2

    // Clear out space in our target register
    and r0,r0,r2

    // Merge values into the target register
    orr r0,r0,r1

    // Put into desired GPIOD register using subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC led_put_latch
  
  // Define our put function for switches [0] to work servos
  FUNCTION led_put_LRservo,global
    
    // Push lr onto the stack
    push {lr}

    // Copy our r0 value into r1 so we don't lose it (desired)
    mov r1,r0

    // Call the following subroutine to get the current GPIOD value
    bl gpio_d_get_current
    
    // Load our 1-bit wide mask into r2
    ldr r2,=(~(~0<<1))
    
    // Clear out garbage bits from desired value
    and r1,r2,r1 

    // Make an inverse mask 
    mvn r2,r2

    // Clear out space in our target register
    and r0,r0,r2

    // Merge values into the target register
    orr r0,r0,r1

    // Put into desired GPIOD register using subroutine
    bl  gpio_d_put

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC led_put_LRservo

  // Define our put function for switches [1] to work Up/Down servos
    FUNCTION led_put_UDservo,global

      // Push lr onto the stack
      push {lr}

      // Copy our r0 value into r1 so we don't lose it (desired)
      mov r1,r0

      // Call the following subroutine to get the current GPIOD value
      bl gpio_d_get_current

      // Load our 1-bit wide mask into r2
      ldr r2,=(~(~0<<1))

      // Clear out garbage bits from desired value
      and r1,r2,r1

      // Shift both the desired and mask values over by the bits we want
      lsl r1,r1,#1
      lsl r2,r2,#1

      // Make an inverse mask
      mvn r2,r2

      // Clear out space in our target register
      and r0,r0,r2

      // Merge values into the target register
      orr r0,r0,r1

      // Put into desired GPIOD register using subroutine
      bl  gpio_d_put

      // Pop lr off the stack
      pop {lr}

      // Branch and exchange out of the subroutine
      bx  lr

    ENDFUNC led_put_UDservo
  .end
