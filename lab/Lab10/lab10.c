//file: lab10.c

// Include necessary header files
#include<adc.h>
#include<seg7.h>

// Call our function prototype
void gpio_d_init(void);

// Start of main 
int main(void)
{
  adc_init();                   // Initialize the ADC hardware
  seg7_init();                  // Initialize the 7 segment display
  gpio_d_init();                // Initialize the GPIO Port D as outputs (output(15-0) = off)
  char seg7_array[] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10};     // set up array of 7 segment data to display decimal digits 

  // Start of continuous loop
  while(1) {
    uint32_t q = 0;             // Initialize any variables needed
    float adc_res = (3.0/4096); // ADC resolution value
    float v_adc = 0;            // ADC voltage value, set to 0	   
 
    adc_start();                // Start ADC
   
    while (!adc_done()) {
      q = q +1;                 // Wait in a tight loop for ADC conversion to finish
    }
    uint32_t val = adc_get();   // ADC is done; get ADC value (12 bits right justified)
    v_adc = val * adc_res;	    // ADC voltage is the product of our val and ADC resolution

    int val_thousands = val / 1000;     // Save the thousands digit of our ADC value in its own variable
    int val_hundreds = (val/100)%10;    // Save the hundreds digit of our ADC value in its own variable
    int val_tens = (val/10)%10;         // Save the tens digit of our ADC value in its own variable
    int val_ones = val%10;              // Save the ones digit of our ADC value in its own variable

                            
    // call seg7_put() for each digit in 7 segment display
    seg7_put(7,0x7f);                                    // HEX7 is always blank (i.e. all ones necessary for the display)
    seg7_put(6,seg7_array[((int)(v_adc*100))/100]);      // HEX6 is volts
    seg7_put(5,seg7_array[((int)((v_adc*100))%100)/10]); // HEX5 is tenths of volts
    seg7_put(4,seg7_array[((int)((v_adc*100))%10)]);     // HEX4 is hundredths of volts
                              
    seg7_put(3, seg7_array[val_thousands]);     // HEX3 is thousands digit of decimal ADC count
    seg7_put(2, seg7_array[val_hundreds]);      // HEX2 is hundreds digit of decimal ADC count
    seg7_put(1, seg7_array[val_tens]);          // HEX1 is tens digit of decimal ADC count
    seg7_put(0, seg7_array[val_ones]);          // HEX0 is ones digit of decimal ADC count
  }

  return 0;                     // main function always returns 0 to indicate success
}
