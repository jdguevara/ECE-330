# file: SysTick_Config.s

    .syntax unified
    .thumb
    .file	"SysTick_Config.s"

.include "src/periph_regs.inc"
      
    .text
    .align	2
    .global	SysTick_Config
    .thumb_func
    .type	SysTick_Config, %function

SysTick_Config:

  push {r4,r5,r6,r7,lr}
 

/* set reload register */

    mov r4,r0

    ldr r7,=#SYST_BASE
    
    ldr r5,=#SYST_RVR_MASK
    and r4,r5
    sub r4,#1
    str r4,[r7,#SYST_RVR]

/* Load the SysTick Counter Value */

    mov r4,#0
    str r4,[r7,SYST_CVR]

/* Use processor clock as clock source, Enable SysTick IRQ, and enable SysTick Timer */
    
    ldr r4,=#(SYST_CSR_CLKSOURCE | SYST_CSR_TICKINT | SYST_CSR_ENABLE)
    str r4,[r7,SYST_CSR]

//   return (0);                                                  /* Function successful */

  SysTick_Config_End:

    pop {r4,r5,r6,r7,lr}
    
    bx lr
// }
  .end
