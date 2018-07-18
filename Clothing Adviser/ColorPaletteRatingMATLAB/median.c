/*
 * median.c
 *
 * Code generation for function 'median'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "median.h"
#include "createFeaturesFromData.h"

/* Function Definitions */
void median(const real_T x_data[15], const int32_T x_size[2], real_T y[3])
{
  int32_T i1;
  real_T vwork_data[5];
  int32_T vwork_size[1];
  int32_T i2;
  int32_T iy;
  int32_T i;
  int32_T k;
  int32_T idx_size[1];
  int32_T idx_data[5];
  real_T m;
  if (x_size[0] == 0) {
    for (i1 = 0; i1 < 3; i1++) {
      y[i1] = 0.0;
    }
  } else {
    vwork_size[0] = (int8_T)x_size[0];
    i2 = 0;
    iy = -1;
    for (i = 0; i < 3; i++) {
      i1 = i2;
      i2 += x_size[0];
      for (k = 0; k < x_size[0]; k++) {
        vwork_data[k] = x_data[i1];
        i1++;
      }

      iy++;
      i1 = (int8_T)x_size[0];
      i1 /= 2;
      eml_sort_idx(vwork_data, vwork_size, idx_data, idx_size);
      if (i1 << 1 == (int8_T)x_size[0]) {
        if ((vwork_data[idx_data[i1 - 1] - 1] < 0.0) && (vwork_data[idx_data[i1]
             - 1] >= 0.0)) {
          m = (vwork_data[idx_data[i1 - 1] - 1] + vwork_data[idx_data[i1] - 1]) /
            2.0;
        } else {
          m = vwork_data[idx_data[i1 - 1] - 1] + (vwork_data[idx_data[i1] - 1] -
            vwork_data[idx_data[i1 - 1] - 1]) / 2.0;
        }
      } else {
        m = vwork_data[idx_data[i1] - 1];
      }

      y[iy] = m;
    }
  }
}

/* End of code generation (median.c) */
