/*
 * mean.c
 *
 * Code generation for function 'mean'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "mean.h"
#include "sum.h"

/* Function Definitions */
void b_mean(const real_T x_data[15], const int32_T x_size[2], real_T y[3])
{
  int32_T i5;
  sum(x_data, x_size, y);
  for (i5 = 0; i5 < 3; i5++) {
    y[i5] /= (real_T)x_size[0];
  }
}

real_T mean(const emxArray_real_T *x)
{
  real_T y;
  int32_T k;
  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    for (k = 2; k <= x->size[1]; k++) {
      y += x->data[k - 1];
    }
  }

  y /= (real_T)x->size[1];
  return y;
}

/* End of code generation (mean.c) */
