/*
 * rateColorPalette_rtwutil.c
 *
 * Code generation for function 'rateColorPalette_rtwutil'
 *
 * C source code generated on: Sat Jan 10 16:52:50 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "rateColorPalette_rtwutil.h"

/* Function Definitions */
real_T rt_roundd(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

/* End of code generation (rateColorPalette_rtwutil.c) */
