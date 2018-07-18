/*
 * RGB2Lab.c
 *
 * Code generation for function 'RGB2Lab'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "RGB2Lab.h"
#include "power.h"
#include "pca2.h"

/* Function Definitions */
void RGB2Lab(real_T R_data[5], int32_T R_size[2], real_T G_data[5], int32_T
             G_size[2], real_T B_data[5], int32_T B_size[2], real_T L_data[5],
             int32_T L_size[2], real_T a_data[5], int32_T a_size[2], real_T
             b_data[5], int32_T b_size[2])
{
  real_T mtmp;
  int32_T ix;
  boolean_T guard1 = FALSE;
  int32_T i3;
  real_T tmp_data[5];
  real_T X_data[5];
  real_T Y3_data[5];
  real_T RGB_data[15];
  real_T XYZ_data[15];
  static const real_T dv3[9] = { 0.412453, 0.212671, 0.019334, 0.35758, 0.71516,
    0.119193, 0.180423, 0.072169, 0.950227 };

  int32_T X_size[2];
  int32_T Z_size[2];
  real_T Z_data[5];
  boolean_T XT_data[5];
  boolean_T YT_data[5];
  boolean_T ZT_data[5];
  int32_T XYZ_size[2];

  /*  function [L, a, b] = RGB2Lab(R, G, B) */
  /*  RGB2Lab takes matrices corresponding to Red, Green, and Blue, and  */
  /*  transforms them into CIELab.  This transform is based on ITU-R  */
  /*  Recommendation  BT.709 using the D65 white point reference. */
  /*  The error in transforming RGB -> Lab -> RGB is approximately */
  /*  10^-5.  RGB values can be either between 0 and 1 or between 0 and 255.   */
  /*  By Mark Ruzon from C code by Yossi Rubner, 23 September 1997. */
  /*  Updated for MATLAB 5 28 January 1998. */
  mtmp = R_data[0];
  if (R_size[1] > 1) {
    for (ix = 1; ix + 1 <= R_size[1]; ix++) {
      if (R_data[ix] > mtmp) {
        mtmp = R_data[ix];
      }
    }
  }

  guard1 = FALSE;
  if (mtmp > 1.0) {
    guard1 = TRUE;
  } else {
    mtmp = G_data[0];
    if (G_size[1] > 1) {
      for (ix = 1; ix + 1 <= G_size[1]; ix++) {
        if (G_data[ix] > mtmp) {
          mtmp = G_data[ix];
        }
      }
    }

    if (mtmp > 1.0) {
      guard1 = TRUE;
    } else {
      mtmp = B_data[0];
      if (B_size[1] > 1) {
        for (ix = 1; ix + 1 <= B_size[1]; ix++) {
          if (B_data[ix] > mtmp) {
            mtmp = B_data[ix];
          }
        }
      }

      if (mtmp > 1.0) {
        guard1 = TRUE;
      }
    }
  }

  if (guard1 == TRUE) {
    ix = R_size[1];
    for (i3 = 0; i3 < ix; i3++) {
      R_data[i3] /= 255.0;
    }

    ix = G_size[1];
    for (i3 = 0; i3 < ix; i3++) {
      G_data[i3] /= 255.0;
    }

    ix = B_size[1];
    for (i3 = 0; i3 < ix; i3++) {
      B_data[i3] /= 255.0;
    }
  }

  /*  Set a threshold */
  for (ix = 0; ix + 1 <= R_size[1]; ix++) {
    tmp_data[ix] = R_data[ix];
  }

  for (ix = 0; ix + 1 <= G_size[1]; ix++) {
    X_data[ix] = G_data[ix];
  }

  for (ix = 0; ix + 1 <= B_size[1]; ix++) {
    Y3_data[ix] = B_data[ix];
  }

  ix = R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    RGB_data[3 * i3] = tmp_data[i3];
  }

  ix = R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    RGB_data[1 + 3 * i3] = X_data[i3];
  }

  ix = R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    RGB_data[2 + 3 * i3] = Y3_data[i3];
  }

  /*  RGB to XYZ */
  ix = 3 * (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    XYZ_data[i3] = 0.0;
  }

  eml_xgemm(R_size[1], dv3, RGB_data, XYZ_data);
  ix = (int8_T)R_size[1];
  X_size[0] = 1;
  X_size[1] = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    X_data[i3] = XYZ_data[3 * i3] / 0.950456;
  }

  ix = (int8_T)R_size[1];
  Z_size[0] = 1;
  Z_size[1] = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    Z_data[i3] = XYZ_data[2 + 3 * i3] / 1.088754;
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    XT_data[i3] = (X_data[i3] > 0.008856);
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    YT_data[i3] = (XYZ_data[1 + 3 * i3] > 0.008856);
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    ZT_data[i3] = (Z_data[i3] > 0.008856);
  }

  power(X_data, X_size, a_data, a_size);

  /*  Compute L */
  ix = (int8_T)R_size[1];
  XYZ_size[0] = 1;
  XYZ_size[1] = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    tmp_data[i3] = XYZ_data[1 + 3 * i3];
  }

  power(tmp_data, XYZ_size, Y3_data, X_size);
  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    b_data[i3] = (real_T)YT_data[i3] * Y3_data[X_size[0] * i3] + (real_T)
      !YT_data[i3] * (7.787 * XYZ_data[1 + 3 * i3] + 0.13793103448275862);
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    L_data[i3] = (real_T)YT_data[i3] * (116.0 * Y3_data[X_size[0] * i3] - 16.0)
      + (real_T)!YT_data[i3] * (903.3 * XYZ_data[1 + 3 * i3]);
  }

  power(Z_data, Z_size, tmp_data, X_size);

  /*  Compute a and b */
  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    a_data[i3] = 500.0 * (((real_T)XT_data[i3] * a_data[i3] + (real_T)
      !XT_data[i3] * (7.787 * X_data[i3] + 0.13793103448275862)) - b_data[i3]);
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    b_data[i3] = 200.0 * (b_data[i3] - ((real_T)ZT_data[i3] * tmp_data[i3] +
      (real_T)!ZT_data[i3] * (7.787 * Z_data[i3] + 0.13793103448275862)));
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    X_data[i3] = L_data[i3];
  }

  L_size[0] = 1;
  L_size[1] = R_size[1];
  for (ix = 0; ix + 1 <= (int8_T)R_size[1]; ix++) {
    L_data[ix] = X_data[ix];
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    X_data[i3] = a_data[i3];
  }

  a_size[0] = 1;
  a_size[1] = R_size[1];
  for (ix = 0; ix + 1 <= (int8_T)R_size[1]; ix++) {
    a_data[ix] = X_data[ix];
  }

  ix = (int8_T)R_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    X_data[i3] = b_data[i3];
  }

  b_size[0] = 1;
  b_size[1] = R_size[1];
  for (ix = 0; ix + 1 <= (int8_T)R_size[1]; ix++) {
    b_data[ix] = X_data[ix];
  }
}

/* End of code generation (RGB2Lab.c) */
