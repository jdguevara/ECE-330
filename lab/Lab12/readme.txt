Jaime Guevara
Lorenzo Sablan

ECE 330L
Team W-9
Lab 12

Purpose: Program, using C, two servos and the STM32F4 board in order to allow the servos to move
based on PWM. Furthermore, the STM32F4 board would also display the angles of each servo by being 
passed the necessary hex values to the available 7-segment displays. Each servo can operate 
independent of each other using a manual mode, and together when switched over to its automatic mode.
The 7-segment displays also help the user know which way the servo is facing by displaying a left/right,
up/down, or both (L/r, U/d, btH) based on the servo's angle. In addition to this, and outside of the
requirements for the assignment, the 7-segment display will display 'Auto' when the system is in 
automatic mode.

A lot of the issues we encontered with this assignment came from trying to get the logic correct
for the motion of the servos by manipulating its pulse width. It took a while to understand that 
while the cycle of the system is 20 ms, each pulse (the time at which there's a new current
trigger) happens at intervals of 2 ms, and getting the 5% or 10% (1ms and 2ms) control is based
on when and for how long each element should be provided power. However, once we overcame this
finishing the assignment was just a matter of getting the logic for each feature (manual/auto mode,
angle display, and switches) right and passing it to the STM board.
