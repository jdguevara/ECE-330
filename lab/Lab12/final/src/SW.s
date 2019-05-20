# file: SW.s

.include "macros.inc"

.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION SW_Init,global

    // Pushing lr onto the stack
    push {lr}

    bl gpio_c_init

    // Pop lr off the stack
    pop {lr}

    bx lr
  
  ENDFUNC SW_Init


  // Define our get function
  FUNCTION SW_Get_A,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Shift value in r0 by 3 bits
    lsr r0,#3

    // Load r1 with the following normalized mask
    ldr r1,=#(~(~0<<1))

    // Clear any garbage numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC SW_Get_A


  // Define our get function for switches [11:8]
  FUNCTION SW_Get_B,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Shit the value in r0 8 bits to the right
    lsr r0,#8

    // Make a 4-bit wide mask and store in r1
    ldr r1,=#(~(~0<<4))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC SW_Get_B
 

  /* 
     Define our get function for switches [14:12]
     and puts them into r0 (normalized).
  */
  FUNCTION sw_get_index,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Shift the value in r0 12 bits to the right
    lsr r0,#12

    // Make a 3-bit wide mask and store in r1
    ldr r1,=#(~(~0<<3))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC sw_get_index
 

  // TODO: Modify this to use another set of switches for the 
  //       seven segment display. Since [1:0] will be used for
  //       the servos
  /* 
     Define our get function for switches [6:0]
     and puts them into r0 (normalized).
  */
  FUNCTION sw_get_segments,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Make a 7-bit wide mask and store in r1
    ldr r1,=#(~(~0<<7))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC sw_get_segments
 

  /* 
     Define our get function for switches [10:7]
     and puts them into r0 (normalized).
  */
  FUNCTION sw_get_hex,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Shift the value in r0 7 bits to the right
    lsr r0,#7
    
    // Make a 4-bit wide mask and store in r1
    ldr r1,=#(~(~0<<4))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC sw_get_hex
  
  /* 
     Define our get function for switch [0] our latch
     and puts them into r0 (normalized).
  */
  FUNCTION get_latch,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Make a 1-bit wide mask and store in r1
    ldr r1,=#(~(~0<<1))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC sw_get_segments
  
  /* 
     Define our get function for switch[0] (L/R servo control)
     for our servos and puts them into r0 (normalized).
  */
  FUNCTION sw_get_LRservo,global

    // Push lr onto the stack
    push {lr}

    // Call the gpio_c_get subroutine
    bl gpio_c_get

    // Make a 1-bit wide mask and store in r1
    ldr r1,=#(~(~0<<1))

    // Clear any unnecessary numbers from r0
    and r0,r1

    // Pop lr off the stack
    pop {lr}

    // Branch and exchange out of the subroutine
    bx  lr

  ENDFUNC sw_get_LRservo

  /*
       Define our get function for switch[1] (U/D servo control)
       for our servos and puts them into r0 (normalized).
    */
    FUNCTION sw_get_UDservo,global

      // Push lr onto the stack
      push {lr}

      // Call the gpio_c_get subroutine
      bl gpio_c_get

      // Shift the value in r0 1 bits to the right
      lsr r0,#1

      // Make a 1-bit wide mask and store in r1
      ldr r1,=#(~(~0<<1))

      // Clear any unnecessary numbers from r0
      and r0,r1

      // Pop lr off the stack
      pop {lr}

      // Branch and exchange out of the subroutine
      bx  lr

    ENDFUNC sw_get_UDservo

    /*
       Function for detecting automatic mode based
       on switch value from switch[3]
    */
    FUNCTION automatic,global

      // Push lr onto the stack
      push {lr}

      // Call the gpio_c_get subroutine
      bl gpio_c_get

      // Shift the value in r0 1 bits to the right
      lsr r0,#3

      // Make a 1-bit wide mask and store in r1
      ldr r1,=#(~(~0<<1))

      // Clear any unnecessary numbers from r0
      and r0,r1

      // Pop lr off the stack
      pop {lr}

      // Branch and exchange out of the subroutine
      bx  lr

    ENDFUNC automatic
  .end
