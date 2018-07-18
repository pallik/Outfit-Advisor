/*
 * rdivide.c
 *
 * Code generation for function 'rdivide'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "rdivide.h"

/* Function Definitions */
void rdivide(const real_T x[334], const real_T y[334], real_T z[334])
{
  int32_T i6;
  for (i6 = 0; i6 < 334; i6++) {
    z[i6] = x[i6] / y[i6];
  }
}

/* End of code generation (rdivide.c) */
