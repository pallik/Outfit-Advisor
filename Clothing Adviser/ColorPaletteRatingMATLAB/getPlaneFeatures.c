/*
 * getPlaneFeatures.c
 *
 * Code generation for function 'getPlaneFeatures'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "getPlaneFeatures.h"
#include "sum.h"
#include "pca2.h"

/* Function Definitions */
void getPlaneFeatures(const real_T X_data[15], const int32_T X_size[2], real_T
                      normal[3], real_T pctExplained_data[3], int32_T
                      pctExplained_size[2], real_T meanX[3], real_T *sse)
{
  real_T b_X_data[15];
  int32_T b_X_size[2];
  int32_T br;
  int32_T ia;
  int32_T k;
  int32_T roots_size[2];
  real_T roots_data[7];
  real_T coeff[9];
  int32_T signals_size[2];
  real_T signals_data[15];
  int8_T sz[2];
  real_T sumRoots_data[1];
  int32_T ib;
  int32_T ix;
  real_T s;
  boolean_T x_data[1];
  boolean_T y;
  boolean_T exitg1;
  int8_T mv[2];
  real_T y_data[5];
  real_T error_data[5];
  b_X_size[0] = 3;
  b_X_size[1] = X_size[0];
  br = X_size[0];
  for (ia = 0; ia < br; ia++) {
    for (k = 0; k < 3; k++) {
      b_X_data[k + 3 * ia] = X_data[ia + X_size[0] * k];
    }
  }

  pca2(b_X_data, b_X_size, signals_data, signals_size, coeff, roots_data,
       roots_size);
  for (ia = 0; ia < 3; ia++) {
    normal[ia] = coeff[6 + ia];
  }

  if (coeff[6] < 0.0) {
    for (ia = 0; ia < 3; ia++) {
      normal[ia] = -coeff[6 + ia];
    }
  }

  for (ia = 0; ia < 2; ia++) {
    sz[ia] = (int8_T)roots_size[ia];
  }

  ib = sz[1];
  if ((roots_size[0] == 0) || (roots_size[1] == 0)) {
    ib = sz[1];
    br = sz[1];
    for (ia = 0; ia < br; ia++) {
      sumRoots_data[ia] = 0.0;
    }
  } else {
    ix = -1;
    s = roots_data[0];
    for (k = 2; k <= roots_size[0]; k++) {
      ix++;
      s += roots_data[ix + 1];
    }

    sumRoots_data[0] = s;
  }

  br = ib;
  for (ia = 0; ia < br; ia++) {
    x_data[ia] = (sumRoots_data[ia] == 0.0);
  }

  y = TRUE;
  ix = 1;
  exitg1 = FALSE;
  while ((exitg1 == FALSE) && (ix <= ib)) {
    if (x_data[0] == 0) {
      y = FALSE;
      exitg1 = TRUE;
    } else {
      ix = 2;
    }
  }

  if (y) {
    pctExplained_size[0] = 1;
    pctExplained_size[1] = 3;
    for (ia = 0; ia < 3; ia++) {
      pctExplained_data[ia] = 0.0;
    }
  } else {
    pctExplained_size[0] = roots_size[1];
    pctExplained_size[1] = roots_size[0];
    br = roots_size[0];
    for (ia = 0; ia < br; ia++) {
      ix = roots_size[1];
      for (k = 0; k < ix; k++) {
        pctExplained_data[k + roots_size[1] * ia] = roots_data[ia + roots_size[0]
          * k] / sumRoots_data[k + ia];
      }
    }
  }

  sum(X_data, X_size, meanX);
  for (ia = 0; ia < 3; ia++) {
    meanX[ia] /= (real_T)X_size[0];
  }

  mv[0] = (int8_T)X_size[0];
  mv[1] = 1;
  for (ia = 0; ia < 2; ia++) {
    sz[ia] = (int8_T)((1 + (ia << 1)) * mv[ia]);
  }

  if (sz[0] == 0) {
  } else {
    ia = 1;
    ib = 0;
    ix = 1;
    for (k = 0; k < 3; k++) {
      for (br = 1; br <= (int8_T)X_size[0]; br++) {
        b_X_data[ib] = meanX[ix - 1];
        ia = ix + 1;
        ib++;
      }

      ix = ia;
    }
  }

  br = X_size[0] * X_size[1];
  for (ia = 0; ia < br; ia++) {
    b_X_data[ia] = X_data[ia] - b_X_data[ia];
  }

  br = (int8_T)X_size[0];
  for (ia = 0; ia < br; ia++) {
    y_data[ia] = 0.0;
  }

  if (X_size[0] == 0) {
  } else {
    ix = 0;
    while ((X_size[0] > 0) && (ix <= 0)) {
      for (k = 1; k <= X_size[0]; k++) {
        y_data[k - 1] = 0.0;
      }

      ix = X_size[0];
    }

    br = 0;
    ix = 0;
    while ((X_size[0] > 0) && (ix <= 0)) {
      ix = 0;
      for (ib = br; ib + 1 <= br + 3; ib++) {
        if (normal[ib] != 0.0) {
          ia = ix;
          for (k = 0; k + 1 <= X_size[0]; k++) {
            ia++;
            y_data[k] += normal[ib] * b_X_data[ia - 1];
          }
        }

        ix += X_size[0];
      }

      br += 3;
      ix = X_size[0];
    }
  }

  for (k = 0; k < (int8_T)X_size[0]; k++) {
    error_data[k] = fabs(y_data[k]);
  }

  for (k = 0; k < (int8_T)X_size[0]; k++) {
    y_data[k] = error_data[k] * error_data[k];
  }

  if ((int8_T)X_size[0] == 0) {
    *sse = 0.0;
  } else {
    *sse = y_data[0];
    for (k = 2; k <= (int8_T)X_size[0]; k++) {
      *sse += y_data[k - 1];
    }
  }
}

/* End of code generation (getPlaneFeatures.c) */
