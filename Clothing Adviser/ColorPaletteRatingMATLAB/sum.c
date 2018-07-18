/*
 * sum.c
 *
 * Code generation for function 'sum'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "sum.h"

/* Function Definitions */
void sum(const real_T x_data[15], const int32_T x_size[2], real_T y[3])
{
  int32_T ixstart;
  int32_T ix;
  int32_T iy;
  int32_T i;
  real_T s;
  if (x_size[0] == 0) {
    for (ixstart = 0; ixstart < 3; ixstart++) {
      y[ixstart] = 0.0;
    }
  } else {
    ix = -1;
    iy = -1;
    for (i = 0; i < 3; i++) {
      ixstart = ix + 1;
      ix++;
      s = x_data[ixstart];
      for (ixstart = 2; ixstart <= x_size[0]; ixstart++) {
        ix++;
        s += x_data[ix];
      }

      iy++;
      y[iy] = s;
    }
  }
}

/* End of code generation (sum.c) */
