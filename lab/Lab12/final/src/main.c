//Function Declarations
#include<adc.h>

//# Defines
#define reload_value (3360)                                  /* System Timer reload value */
#define LEDs_ODR_Base        (0x40020c14)                         /* LEDs Port D ODR Address */

// Global variables
unsigned int *pLEDs = (unsigned int*)LEDs_ODR_Base;               /* Create pointer to Port D - ODR Reg */
unsigned int duty = 0;
unsigned int ang_tens = 0;
unsigned int ang_ones = 0;

// Function prototypes                          Found in the following files:
int automatic(void);                            // SW.s
void gpio_d_init(void);                         // gpio_d.s
void SetSysClock(void);
void SysTick_Config(int);
void SysTick_Handler(void);
void seg7_init(void);                           // seg7.h
void seg7_put(unsigned int, unsigned int);      // seg7.h
int  sw_get_LRservo(void);                      // SW.s
int  sw_get_UDservo(void);                      // SW.s

// Arrays for 7-seg display
unsigned char SEG7HEX[11] = {0x47, 0x2f, 0x41, 0x21, 0x03, 0x07, 0x09, 0x08, 0x01, 0x03, 0x40}; // L/R, U/D, BTH, AUTO
unsigned char SEG7HEXANG[10] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10}; // angle measurements

int main()
{
    adc_init();             // Initialize ADC
    gpio_d_init();          // Initialize Port D (LEDs)
    seg7_init();            // Initialize 7-segment display
    SetSysClock();          //set system clock
  
    SysTick_Config(reload_value);       //configure SysTick System Timer

	//loop forever
    while(1) {
        adc_start();
        // Poll
        while (!adc_done()) {
        }

        uint32_t val = adc_get();
        duty = 50 + ((val * 50) / 4095);
    }

  return 0;
}

//ISR - SysTick Interrupt Service Routine
void SysTick_Handler (void)
{
    // Step counter
    static int step = 0;

    // Set the initial point to go to the middle (less strain going from extreme to the other)
    static int sim_duty = 75;

    // flag
    static int sim_flag = 0;

    // angle step offset
    static int step_ang = 0;

    // Automatic/Manual mode detection
    if (automatic()) {

        // Show that both servos are in use
        seg7_put(3, SEG7HEX[7]);
        seg7_put(2, SEG7HEX[8]);
        seg7_put(1, SEG7HEX[9]);
        seg7_put(0, SEG7HEX[10]);

        // Get angle number
        if (sim_duty == 75) {
            // This is our half-way point therefore 0 degrees
            seg7_put(7, SEG7HEXANG[0]);
            seg7_put(6, SEG7HEXANG[0]);
            seg7_put(5, SEG7HEXANG[0]);
            seg7_put(4, SEG7HEXANG[0]);
        } else if (sim_duty >= 50 && sim_duty < 75) {
            // This should give us how offset from center we are in degrees (3.6 deg/ step)
            step_ang = (75 - sim_duty) * 3.6;

            // Get each decimal for the angle so we can select the proper hex value
            ang_ones = step_ang % 10; // modulus to get the one
            ang_tens = step_ang / 10; // integer division
        } else if (sim_duty > 75 && sim_duty <= 100) {
            // This should give us how offset from center we are in degrees (3.6 deg/ step)
            step_ang = (sim_duty - 75) * 3.6;

            // Get each decimal for the angle so we can select the proper hex value
            ang_ones = step_ang % 10; // modulus to get the one
            ang_tens = step_ang / 10; // integer division
        }

        // Show the angle of the servo on 7-seg displays [7:6]
        seg7_put(7, SEG7HEXANG[ang_tens]);
        seg7_put(6, SEG7HEXANG[ang_ones]);
        seg7_put(5, SEG7HEXANG[ang_tens]);
        seg7_put(4, SEG7HEXANG[ang_ones]);

        // PWM based on our simulated duty cycle, and increment/decrement accordingly
        if (step == sim_duty) {
            *pLEDs = *pLEDs & ~(1 << 0);
            *pLEDs = *pLEDs & ~(1 << 1);
        } else if (step == 1000) {
            *pLEDs = *pLEDs | (1 << 0);
            *pLEDs = *pLEDs | (1 << 1);
            step = 0;

            // Check flags for increment or decrement
            if (sim_flag == 1) {
                sim_duty--;
            } else if (sim_flag == 0) {
                sim_duty++;
            }

            // Set flags for increment/decrement based on position
            if (sim_duty == 100) {
                sim_flag = 1;
            } else if (sim_duty == 50) {
                sim_flag = 0;
            }
        }
        step++;
    } else {
        // Check if both switches are on and display 'btH' but don't do anything
        if (sw_get_LRservo() && sw_get_UDservo()) {
            // Display to show that Both 'btH' switches are up
            seg7_put(2, SEG7HEX[4]);
            seg7_put(1, SEG7HEX[5]);
            seg7_put(0, SEG7HEX[6]);
          // Control Left/Right servo
        } else if (sw_get_LRservo()) {
            // turn off 7-seg display [2]
            seg7_put(2, 0x7f);             

            // Get angle number
            if (duty == 75) {
                // This is our half-way point therefore 0 degrees
                seg7_put(5, SEG7HEXANG[0]);
                seg7_put(4, SEG7HEXANG[0]);
            } else if (duty >= 50 && duty < 75) {
                // This should give us how offset from center we are in degrees (3.6 deg/ step)
                step_ang = (75 - duty) * 3.6;

                // Show the servo is pointing Left
                seg7_put(1, SEG7HEX[0]);                 
                
                // Get each decimal for the angle so we can select the proper hex value
                ang_ones = step_ang % 10; // modulus to get the one
                ang_tens = step_ang / 10; // integer division
            } else if (duty > 75 && duty <= 100) {
                // This should give us how offset from center we are in degrees (3.6 deg/ step)
                step_ang = (duty - 75) * 3.6;

                // Show the servo is pointing Right
                seg7_put(0, SEG7HEX[1]); 

                // Get each decimal for the angle so we can select the proper hex value
                ang_ones = step_ang % 10; // modulus to get the one
                ang_tens = step_ang / 10; // integer division
            }

            // Show the angle of the servo on 7-seg displays [5:4]
            seg7_put(5, SEG7HEXANG[ang_tens]);
            seg7_put(4, SEG7HEXANG[ang_ones]);

            // PWM based on duty cycle provided by ADC count
            if (step == duty) {
                *pLEDs = *pLEDs & ~(1 << 0);
            } else if (step == 1000) {
                *pLEDs = *pLEDs | (1 << 0);
                step = 0;
            }
            step++;
          // Control Up/Down servo
        } else if (sw_get_UDservo()) {
            // turn off 7-seg display [2]
            seg7_put(2, 0x7f); 

            // Get angle number
            if (duty == 75) {
                // This is our half-way point therefore 0 degrees
                seg7_put(5, SEG7HEXANG[0]);
                seg7_put(4, SEG7HEXANG[0]);
            } else if (duty >= 50 && duty < 75) {
                // This should give us how offset from center we are in degrees (3.6 deg/ step)
                step_ang = (75 - duty) * 3.6;

                // Show that the servo is Down
                seg7_put(0, SEG7HEX[3]);

                // Get each decimal for the angle so we can select the proper hex value
                ang_ones = step_ang % 10; // modulus to get the one
                ang_tens = step_ang / 10; // integer division
            } else if (duty > 75 && duty <= 100) {
                // This should give us how offset from center we are in degrees (3.6 deg/ step)
                step_ang = (duty - 75) * 3.6;

                // Show that the servo is Up
                seg7_put(1, SEG7HEX[2]);

                // Get each decimal for the angle so we can select the proper hex value
                ang_ones = step_ang % 10; // modulus to get the one
                ang_tens = step_ang / 10; // integer division
            }

            // Show the angle of the servo on 7-seg displays [7:6]
            seg7_put(7, SEG7HEXANG[ang_tens]);
            seg7_put(6, SEG7HEXANG[ang_ones]);

            // PWM based on duty cycle provided by ADC count
            if (step == duty) {
                *pLEDs = *pLEDs & ~(1 << 1);
            } else if (step == 1000) {
                *pLEDs = *pLEDs | (1 << 1);
                step = 0;
            }
            step++;
        } else if (!sw_get_UDservo() && !sw_get_LRservo()) {
            // if no switch is on then turn off "servo in use" displays
            seg7_put(2, 0x7f);
            seg7_put(1, 0x7f);
            seg7_put(0, 0x7f);
        }
    }
}
