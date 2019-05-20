# file: exercise2.s - Author: Jaime Guevara
 
/* Final Values for Variables:
      A: 0x0c
      B: 0x8765
      C: 0xb5901579
*/
   .title Exercise_2

   .text

   .global main
main: 

    ldr  r1,=DAT            //Establish addressability to data section

    ldrb  r2,[r1,#A-DAT]    //Data Access: Load byte data from label A location
    ldrh  r3,[r1,#B-DAT]    //Data Access: Load half word data from label B location
    ldr   r4,[r1,#C-DAT]    //Data Access: Load word data from label C location

    lsl   r3,#9             //Logically shift left the half-word data 
    str   r3,[r1,#C-DAT]    //Re-store in memory

    lsr   r4,#6             //Logically shift right the word data 
    str   r4,[r1,#C-DAT]    //Re=store in memory

    add   r5,r4,r3          //Add the two shifted variables together, store in new register
    ror   r5,r2             //Rotate r5 value by the number of binary digits in byte A
    str   r5,[r1,#C-DAT]    //Store final result in word-sized variable

    b    .                  //Branch forever to this same location count
  
   .data

DAT:
   .word  0xbbbbbbbb        //Begin Coremark

A: .byte  12                //Define byte A data
   .align 1                 //Align data properly for halfword/short
B: .short 0x8765            //Define short B data
   .align 2                 //Align data properly for word
C: .word  0x12345678        //Define word C data 


   .word 0xeeeeeeee         //End Coremark
   
   .end
