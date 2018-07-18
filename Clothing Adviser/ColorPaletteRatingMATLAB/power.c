/*
 * power.c
 *
 * Code generation for function 'power'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "power.h"

/* Function Definitions */
void power(const real_T a_data[5], const int32_T a_size[2], real_T y_data[5],
           int32_T y_size[2])
{
  int8_T iv1[2];
  int32_T k;
  real_T u0;
  for (k = 0; k < 2; k++) {
    iv1[k] = (int8_T)a_size[k];
  }

  y_size[0] = 1;
  y_size[1] = iv1[1];
  for (k = 0; k < iv1[1]; k++) {
    u0 = a_data[k];
    u0 = pow(u0, 0.33333333333333331);
    y_data[k] = u0;
  }
}

/* End of code generation (power.c) */
