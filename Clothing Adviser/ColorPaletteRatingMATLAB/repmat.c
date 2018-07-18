/*
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "repmat.h"

/* Function Definitions */
void repmat(real_T b[15])
{
  int32_T ib;
  int32_T jtilecol;
  int32_T ia;
  int32_T k;
  static const int16_T a[3] = { 359, 100, 100 };

  ib = 0;
  for (jtilecol = 0; jtilecol < 5; jtilecol++) {
    ia = 0;
    for (k = 0; k < 3; k++) {
      b[ib] = a[ia];
      ia++;
      ib++;
    }
  }
}

/* End of code generation (repmat.c) */
