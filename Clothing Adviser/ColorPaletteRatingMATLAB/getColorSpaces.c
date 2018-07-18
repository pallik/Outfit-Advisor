/*
 * getColorSpaces.c
 *
 * Code generation for function 'getColorSpaces'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "getColorSpaces.h"
#include "getHueProbFeatures.h"
#include "RGB2HSV.h"
#include "RGB2Lab.h"
#include "rateColorPalette_rtwutil.h"

/* Function Declarations */
static real_T rt_remd(real_T u0, real_T u1);

/* Function Definitions */
static real_T rt_remd(real_T u0, real_T u1)
{
  real_T y;
  real_T tr;
  if (u1 < 0.0) {
    y = ceil(u1);
  } else {
    y = floor(u1);
  }

  if ((u1 != 0.0) && (u1 != y)) {
    tr = u0 / u1;
    if (fabs(tr - rt_roundd(tr)) <= DBL_EPSILON * fabs(tr)) {
      y = 0.0;
    } else {
      y = fmod(u0, u1);
    }
  } else {
    y = fmod(u0, u1);
  }

  return y;
}

void getColorSpaces(const real_T rgb_data[15], const int32_T rgb_size[2], real_T
                    hsv_data[15], int32_T hsv_size[2], real_T lab_data[15],
                    int32_T lab_size[2], real_T chsv_data[15], int32_T
                    chsv_size[2])
{
  int8_T iv0[2];
  int32_T iacol;
  int32_T loop_ub;
  real_T b_rgb_data[5];
  int32_T b_rgb_size[2];
  real_T c_rgb_data[5];
  int32_T c_rgb_size[2];
  real_T d_rgb_data[5];
  int32_T d_rgb_size[2];
  int32_T x_size[2];
  real_T x_data[5];
  int32_T y_size[2];
  real_T y_data[5];
  int32_T tmp_size[2];
  real_T tmp_data[5];
  int8_T mv[2];
  int8_T outsize[2];
  real_T b_data[15];
  int32_T ia;
  int32_T ib;
  int32_T itilerow;
  static const uint8_T uv0[3] = { 100U, 128U, 128U };

  real_T e_rgb_data[15];
  int32_T e_rgb_size[2];
  real_T x;
  real_T absx;
  int8_T n;

  /* lab=colorspace('rgb->cielab',rgb')'; */
  for (iacol = 0; iacol < 2; iacol++) {
    iv0[iacol] = (int8_T)rgb_size[iacol];
  }

  lab_size[1] = iv0[1];
  loop_ub = 3 * iv0[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    lab_data[iacol] = 0.0;
  }

  loop_ub = rgb_size[1];
  b_rgb_size[0] = 1;
  b_rgb_size[1] = rgb_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    b_rgb_data[iacol] = rgb_data[rgb_size[0] * iacol];
  }

  loop_ub = rgb_size[1];
  c_rgb_size[0] = 1;
  c_rgb_size[1] = rgb_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    c_rgb_data[iacol] = rgb_data[1 + rgb_size[0] * iacol];
  }

  loop_ub = rgb_size[1];
  d_rgb_size[0] = 1;
  d_rgb_size[1] = rgb_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    d_rgb_data[iacol] = rgb_data[2 + rgb_size[0] * iacol];
  }

  RGB2Lab(b_rgb_data, b_rgb_size, c_rgb_data, c_rgb_size, d_rgb_data, d_rgb_size,
          tmp_data, tmp_size, y_data, y_size, x_data, x_size);
  loop_ub = tmp_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    lab_data[3 * iacol] = tmp_data[tmp_size[0] * iacol];
  }

  loop_ub = y_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    lab_data[1 + 3 * iacol] = y_data[y_size[0] * iacol];
  }

  loop_ub = x_size[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    lab_data[2 + 3 * iacol] = x_data[x_size[0] * iacol];
  }

  mv[0] = iv0[1];
  mv[1] = 1;
  for (iacol = 0; iacol < 2; iacol++) {
    outsize[iacol] = (int8_T)((1 + (iacol << 1)) * mv[iacol]);
  }

  if (outsize[0] == 0) {
  } else {
    ia = 1;
    ib = 0;
    iacol = 1;
    for (loop_ub = 0; loop_ub < 3; loop_ub++) {
      for (itilerow = 1; itilerow <= iv0[1]; itilerow++) {
        b_data[ib] = uv0[iacol - 1];
        ia = iacol + 1;
        ib++;
      }

      iacol = ia;
    }
  }

  lab_size[0] = 3;
  loop_ub = iv0[1];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    for (ia = 0; ia < 3; ia++) {
      lab_data[ia + 3 * iacol] /= b_data[iacol + outsize[0] * ia];
    }
  }

  e_rgb_size[0] = rgb_size[1];
  e_rgb_size[1] = 3;
  for (iacol = 0; iacol < 3; iacol++) {
    loop_ub = rgb_size[1];
    for (ia = 0; ia < loop_ub; ia++) {
      e_rgb_data[ia + rgb_size[1] * iacol] = rgb_data[iacol + rgb_size[0] * ia];
    }
  }

  RGB2HSV(e_rgb_data, e_rgb_size, b_data, b_rgb_size);
  hsv_size[0] = 3;
  hsv_size[1] = b_rgb_size[0];
  loop_ub = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    for (ia = 0; ia < 3; ia++) {
      hsv_data[ia + 3 * iacol] = b_data[iacol + b_rgb_size[0] * ia];
    }
  }

  /* HSV cartesian */
  /* remap hue */
  /*  hsvRemap(1,:)= PPVAL(hueMapping,hsvRemap(1,:)); */
  loop_ub = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    y_data[iacol] = 360.0 * hsv_data[3 * iacol];
  }

  loop_ub = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    tmp_data[iacol] = y_data[iacol];
  }

  for (ia = 0; ia < b_rgb_size[0]; ia++) {
    x = rt_remd(tmp_data[ia], 360.0);
    absx = fabs(x);
    if (absx > 180.0) {
      if (x > 0.0) {
        x -= 360.0;
      } else {
        x += 360.0;
      }

      absx = fabs(x);
    }

    if (absx <= 45.0) {
      x *= 0.017453292519943295;
      n = 0;
    } else if (absx <= 135.0) {
      if (x > 0.0) {
        x = 0.017453292519943295 * (x - 90.0);
        n = 1;
      } else {
        x = 0.017453292519943295 * (x + 90.0);
        n = -1;
      }
    } else if (x > 0.0) {
      x = 0.017453292519943295 * (x - 180.0);
      n = 2;
    } else {
      x = 0.017453292519943295 * (x + 180.0);
      n = -2;
    }

    if (n == 0) {
      tmp_data[ia] = cos(x);
    } else if (n == 1) {
      tmp_data[ia] = -sin(x);
    } else if (n == -1) {
      tmp_data[ia] = sin(x);
    } else {
      tmp_data[ia] = -cos(x);
    }
  }

  loop_ub = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    y_data[iacol] = 360.0 * hsv_data[3 * iacol];
  }

  loop_ub = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    x_data[iacol] = y_data[iacol];
  }

  for (ia = 0; ia < b_rgb_size[0]; ia++) {
    x = rt_remd(x_data[ia], 360.0);
    absx = fabs(x);
    if (absx > 180.0) {
      if (x > 0.0) {
        x -= 360.0;
      } else {
        x += 360.0;
      }

      absx = fabs(x);
    }

    if (absx <= 45.0) {
      x *= 0.017453292519943295;
      n = 0;
    } else if (absx <= 135.0) {
      if (x > 0.0) {
        x = 0.017453292519943295 * (x - 90.0);
        n = 1;
      } else {
        x = 0.017453292519943295 * (x + 90.0);
        n = -1;
      }
    } else if (x > 0.0) {
      x = 0.017453292519943295 * (x - 180.0);
      n = 2;
    } else {
      x = 0.017453292519943295 * (x + 180.0);
      n = -2;
    }

    if (n == 0) {
      x_data[ia] = sin(x);
    } else if (n == 1) {
      x_data[ia] = cos(x);
    } else if (n == -1) {
      x_data[ia] = -cos(x);
    } else {
      x_data[ia] = -sin(x);
    }
  }

  loop_ub = b_rgb_size[0];
  ia = b_rgb_size[0] - 1;
  ib = b_rgb_size[0] - 1;
  chsv_size[0] = 3;
  chsv_size[1] = b_rgb_size[0];
  for (iacol = 0; iacol < loop_ub; iacol++) {
    chsv_data[3 * iacol] = hsv_data[1 + 3 * iacol] * tmp_data[iacol];
  }

  for (iacol = 0; iacol <= ia; iacol++) {
    chsv_data[1 + 3 * iacol] = hsv_data[1 + 3 * iacol] * -x_data[iacol];
  }

  for (iacol = 0; iacol <= ib; iacol++) {
    chsv_data[2 + 3 * iacol] = hsv_data[2 + 3 * iacol];
  }
}

/* End of code generation (getColorSpaces.c) */
