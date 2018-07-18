/*
 * RGB2HSV.c
 *
 * Code generation for function 'RGB2HSV'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "RGB2HSV.h"

/* Function Definitions */
void RGB2HSV(const real_T r_data[15], const int32_T r_size[2], real_T h_data[15],
             int32_T h_size[2])
{
  real_T k_data[5];
  int32_T k;
  real_T u0;
  real_T u1;
  real_T v_data[5];
  int32_T idx;
  int32_T j;
  real_T b_h_data[5];
  real_T s_data[5];
  boolean_T z_data[5];
  boolean_T x_data[5];
  int32_T ii_data[5];
  boolean_T exitg5;
  boolean_T guard5 = FALSE;
  int32_T b_ii_data[5];
  real_T b_r_data[5];
  real_T c_r_data[5];
  boolean_T exitg4;
  boolean_T guard4 = FALSE;
  boolean_T exitg3;
  boolean_T guard3 = FALSE;
  boolean_T exitg2;
  boolean_T guard2 = FALSE;
  uint8_T c_ii_data[5];
  boolean_T exitg1;
  boolean_T guard1 = FALSE;

  /* RGB2HSV Convert red-green-blue colors to hue-saturation-value. */
  /*    H = RGB2HSV(M) converts an RGB color map to an HSV color map. */
  /*    Each map is a matrix with any number of rows, exactly three columns, */
  /*    and elements in the interval 0 to 1.  The columns of the input matrix, */
  /*    M, represent intensity of red, blue and green, respectively.  The */
  /*    columns of the resulting output matrix, H, represent hue, saturation */
  /*    and color value, respectively. */
  /*  */
  /*    HSV = RGB2HSV(RGB) converts the RGB image RGB (3-D array) to the */
  /*    equivalent HSV image HSV (3-D array). */
  /*   */
  /*    CLASS SUPPORT */
  /*    ------------- */
  /*    If the input is an RGB image, it can be of class uint8, uint16, or  */
  /*    double; the output image is of class double.  If the input is a  */
  /*    colormap, the input and output colormaps are both of class double. */
  /*   */
  /*    See also HSV2RGB, COLORMAP, RGBPLOT.  */
  /*    Undocumented syntaxes: */
  /*    [H,S,V] = RGB2HSV(R,G,B) converts the RGB image R,G,B to the */
  /*    equivalent HSV image H,S,V. */
  /*  */
  /*    HSV = RGB2HSV(R,G,B) converts the RGB image R,G,B to the  */
  /*    equivalent HSV image stored in the 3-D array (HSV). */
  /*  */
  /*    [H,S,V] = RGB2HSV(RGB) converts the RGB image RGB (3-D array) to */
  /*    the equivalent HSV image H,S,V. */
  /*  */
  /*    See Alvy Ray Smith, Color Gamut Transform Pairs, SIGGRAPH '78. */
  /*    Copyright 1984-2006 The MathWorks, Inc.  */
  /*    $Revision: 5.15.4.3 $  $Date: 2010/08/23 23:13:14 $ */
  /*  Determine if input includes a 3-D array */
  for (k = 0; k + 1 <= (int8_T)r_size[0]; k++) {
    u0 = r_data[k];
    u1 = r_data[k + r_size[0]];
    if (u0 >= u1) {
    } else {
      u0 = u1;
    }

    k_data[k] = u0;
  }

  for (k = 0; k + 1 <= (int8_T)r_size[0]; k++) {
    u0 = k_data[k];
    u1 = r_data[k + (r_size[0] << 1)];
    if (u0 >= u1) {
    } else {
      u0 = u1;
    }

    v_data[k] = u0;
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    b_h_data[j] = 0.0;
  }

  for (k = 0; k + 1 <= (int8_T)r_size[0]; k++) {
    u0 = r_data[k];
    u1 = r_data[k + r_size[0]];
    if (u0 <= u1) {
    } else {
      u0 = u1;
    }

    k_data[k] = u0;
  }

  for (k = 0; k + 1 <= (int8_T)r_size[0]; k++) {
    u0 = k_data[k];
    u1 = r_data[k + (r_size[0] << 1)];
    if (u0 <= u1) {
    } else {
      u0 = u1;
    }

    s_data[k] = u0;
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    s_data[j] = v_data[j] - s_data[j];
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    z_data[j] = !(s_data[j] != 0.0);
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    s_data[j] += (real_T)z_data[j];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    x_data[j] = (r_data[j] == v_data[j]);
  }

  idx = 0;
  k = r_size[0];
  j = 1;
  exitg5 = FALSE;
  while ((exitg5 == FALSE) && (j <= r_size[0])) {
    guard5 = FALSE;
    if (x_data[j - 1]) {
      idx++;
      ii_data[idx - 1] = j;
      if (idx >= r_size[0]) {
        exitg5 = TRUE;
      } else {
        guard5 = TRUE;
      }
    } else {
      guard5 = TRUE;
    }

    if (guard5 == TRUE) {
      j++;
    }
  }

  if (r_size[0] == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    if (1 > idx) {
      k = 0;
    } else {
      k = idx;
    }

    for (j = 0; j < k; j++) {
      b_ii_data[j] = ii_data[j];
    }

    for (j = 0; j < k; j++) {
      ii_data[j] = b_ii_data[j];
    }
  }

  for (j = 0; j < k; j++) {
    k_data[j] = ii_data[j];
  }

  for (j = 0; j < k; j++) {
    ii_data[j] = (int32_T)k_data[j];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    b_r_data[j] = r_data[j + r_size[0]];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    c_r_data[j] = r_data[j + (r_size[0] << 1)];
  }

  for (j = 0; j < k; j++) {
    b_h_data[ii_data[j] - 1] = (b_r_data[(int32_T)k_data[j] - 1] - c_r_data
      [(int32_T)k_data[j] - 1]) / s_data[(int32_T)k_data[j] - 1];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    x_data[j] = (r_data[j + r_size[0]] == v_data[j]);
  }

  idx = 0;
  k = r_size[0];
  j = 1;
  exitg4 = FALSE;
  while ((exitg4 == FALSE) && (j <= r_size[0])) {
    guard4 = FALSE;
    if (x_data[j - 1]) {
      idx++;
      ii_data[idx - 1] = j;
      if (idx >= r_size[0]) {
        exitg4 = TRUE;
      } else {
        guard4 = TRUE;
      }
    } else {
      guard4 = TRUE;
    }

    if (guard4 == TRUE) {
      j++;
    }
  }

  if (r_size[0] == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    if (1 > idx) {
      k = 0;
    } else {
      k = idx;
    }

    for (j = 0; j < k; j++) {
      b_ii_data[j] = ii_data[j];
    }

    for (j = 0; j < k; j++) {
      ii_data[j] = b_ii_data[j];
    }
  }

  for (j = 0; j < k; j++) {
    k_data[j] = ii_data[j];
  }

  for (j = 0; j < k; j++) {
    ii_data[j] = (int32_T)k_data[j];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    b_r_data[j] = r_data[j + (r_size[0] << 1)];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    c_r_data[j] = r_data[j];
  }

  for (j = 0; j < k; j++) {
    b_h_data[ii_data[j] - 1] = 2.0 + (b_r_data[(int32_T)k_data[j] - 1] -
      c_r_data[(int32_T)k_data[j] - 1]) / s_data[(int32_T)k_data[j] - 1];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    x_data[j] = (r_data[j + (r_size[0] << 1)] == v_data[j]);
  }

  idx = 0;
  k = r_size[0];
  j = 1;
  exitg3 = FALSE;
  while ((exitg3 == FALSE) && (j <= r_size[0])) {
    guard3 = FALSE;
    if (x_data[j - 1]) {
      idx++;
      ii_data[idx - 1] = j;
      if (idx >= r_size[0]) {
        exitg3 = TRUE;
      } else {
        guard3 = TRUE;
      }
    } else {
      guard3 = TRUE;
    }

    if (guard3 == TRUE) {
      j++;
    }
  }

  if (r_size[0] == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    if (1 > idx) {
      k = 0;
    } else {
      k = idx;
    }

    for (j = 0; j < k; j++) {
      b_ii_data[j] = ii_data[j];
    }

    for (j = 0; j < k; j++) {
      ii_data[j] = b_ii_data[j];
    }
  }

  for (j = 0; j < k; j++) {
    k_data[j] = ii_data[j];
  }

  for (j = 0; j < k; j++) {
    ii_data[j] = (int32_T)k_data[j];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    b_r_data[j] = r_data[j];
  }

  idx = r_size[0];
  for (j = 0; j < idx; j++) {
    c_r_data[j] = r_data[j + r_size[0]];
  }

  for (j = 0; j < k; j++) {
    b_h_data[ii_data[j] - 1] = 4.0 + (b_r_data[(int32_T)k_data[j] - 1] -
      c_r_data[(int32_T)k_data[j] - 1]) / s_data[(int32_T)k_data[j] - 1];
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    b_h_data[j] /= 6.0;
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    x_data[j] = (b_h_data[j] < 0.0);
  }

  idx = 0;
  k = (int8_T)r_size[0];
  j = 1;
  exitg2 = FALSE;
  while ((exitg2 == FALSE) && (j <= (int8_T)r_size[0])) {
    guard2 = FALSE;
    if (x_data[j - 1]) {
      idx++;
      ii_data[idx - 1] = j;
      if (idx >= (int8_T)r_size[0]) {
        exitg2 = TRUE;
      } else {
        guard2 = TRUE;
      }
    } else {
      guard2 = TRUE;
    }

    if (guard2 == TRUE) {
      j++;
    }
  }

  if ((int8_T)r_size[0] == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    if (1 > idx) {
      k = 0;
    } else {
      k = idx;
    }

    for (j = 0; j < k; j++) {
      c_ii_data[j] = (uint8_T)ii_data[j];
    }

    for (j = 0; j < k; j++) {
      ii_data[j] = c_ii_data[j];
    }
  }

  for (j = 0; j < k; j++) {
    k_data[j] = ii_data[j];
  }

  for (j = 0; j < k; j++) {
    ii_data[j] = (int32_T)k_data[j];
  }

  for (j = 0; j < k; j++) {
    b_r_data[j] = b_h_data[(int32_T)k_data[j] - 1] + 1.0;
  }

  for (j = 0; j < k; j++) {
    b_h_data[ii_data[j] - 1] = b_r_data[j];
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    b_h_data[j] *= (real_T)!z_data[j];
  }

  idx = 0;
  k = (int8_T)r_size[0];
  j = 1;
  exitg1 = FALSE;
  while ((exitg1 == FALSE) && (j <= (int8_T)r_size[0])) {
    guard1 = FALSE;
    if (v_data[j - 1] != 0.0) {
      idx++;
      ii_data[idx - 1] = j;
      if (idx >= (int8_T)r_size[0]) {
        exitg1 = TRUE;
      } else {
        guard1 = TRUE;
      }
    } else {
      guard1 = TRUE;
    }

    if (guard1 == TRUE) {
      j++;
    }
  }

  if ((int8_T)r_size[0] == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    if (1 > idx) {
      k = 0;
    } else {
      k = idx;
    }

    for (j = 0; j < k; j++) {
      c_ii_data[j] = (uint8_T)ii_data[j];
    }

    for (j = 0; j < k; j++) {
      ii_data[j] = c_ii_data[j];
    }
  }

  for (j = 0; j < k; j++) {
    k_data[j] = ii_data[j];
  }

  for (j = 0; j < k; j++) {
    x_data[j] = !z_data[(int32_T)k_data[j] - 1];
  }

  for (j = 0; j < k; j++) {
    ii_data[j] = (int32_T)k_data[j];
  }

  for (j = 0; j < k; j++) {
    b_r_data[j] = (real_T)x_data[j] * s_data[(int32_T)k_data[j] - 1] / v_data
      [(int32_T)k_data[j] - 1];
  }

  for (j = 0; j < k; j++) {
    s_data[ii_data[j] - 1] = b_r_data[j];
  }

  idx = (int8_T)r_size[0];
  for (j = 0; j < idx; j++) {
    x_data[j] = !(v_data[j] != 0.0);
  }

  k = 0;
  for (idx = 1; idx <= (int8_T)r_size[0]; idx++) {
    if (x_data[idx - 1]) {
      k++;
    }
  }

  j = 0;
  for (idx = 1; idx <= (int8_T)r_size[0]; idx++) {
    if (x_data[idx - 1]) {
      ii_data[j] = idx;
      j++;
    }
  }

  for (j = 0; j < k; j++) {
    s_data[ii_data[j] - 1] = 0.0;
  }

  h_size[0] = (int8_T)r_size[0];
  h_size[1] = 3;
  j = 0;
  while (j <= 0) {
    idx = (int8_T)r_size[0];
    for (j = 0; j < idx; j++) {
      h_data[j] = b_h_data[j];
    }

    j = 1;
  }

  j = 0;
  while (j <= 0) {
    idx = (int8_T)r_size[0];
    for (j = 0; j < idx; j++) {
      h_data[j + (int8_T)r_size[0]] = s_data[j];
    }

    j = 1;
  }

  j = 0;
  while (j <= 0) {
    idx = (int8_T)r_size[0];
    for (j = 0; j < idx; j++) {
      h_data[j + (int8_T)r_size[0] * 2] = v_data[j];
    }

    j = 1;
  }
}

/* End of code generation (RGB2HSV.c) */
