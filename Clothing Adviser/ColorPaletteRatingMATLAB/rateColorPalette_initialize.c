/*
 * rateColorPalette_initialize.c
 *
 * Code generation for function 'rateColorPalette_initialize'
 *
 * C source code generated on: Sat Jan 10 16:52:50 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "rateColorPalette_initialize.h"
#include "rateColorPalette_data.h"

/* Function Definitions */
void rateColorPalette_initialize(void)
{
  uint32_T r;
  int32_T mti;
  memset(&state[0], 0, 625U * sizeof(uint32_T));
  r = 5489U;
  state[0] = 5489U;
  for (mti = 0; mti < 623; mti++) {
    r = (r ^ r >> 30U) * 1812433253U + (1 + mti);
    state[1 + mti] = r;
  }

  state[624] = 624U;
}

/* End of code generation (rateColorPalette_initialize.c) */
