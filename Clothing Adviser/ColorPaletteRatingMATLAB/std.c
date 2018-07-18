/*
 * std.c
 *
 * Code generation for function 'std'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "std.h"

/* Function Definitions */
real_T b_std(const real_T varargin_1_data[5], const int32_T varargin_1_size[1])
{
  real_T y;
  int32_T ix;
  real_T xbar;
  int32_T k;
  real_T r;
  int32_T b_varargin_1_size;
  if (varargin_1_size[0] == 0) {
    y = 0.0;
  } else {
    ix = 0;
    xbar = varargin_1_data[0];
    for (k = 0; k <= varargin_1_size[0] - 2; k++) {
      ix++;
      xbar += varargin_1_data[ix];
    }

    xbar /= (real_T)varargin_1_size[0];
    ix = 0;
    r = varargin_1_data[0] - xbar;
    y = r * r;
    for (k = 0; k <= varargin_1_size[0] - 2; k++) {
      ix++;
      r = varargin_1_data[ix] - xbar;
      y += r * r;
    }

    if (varargin_1_size[0] > 1) {
      b_varargin_1_size = varargin_1_size[0] - 1;
    } else {
      b_varargin_1_size = varargin_1_size[0];
    }

    y /= (real_T)b_varargin_1_size;
  }

  return sqrt(y);
}

real_T c_std(const emxArray_real_T *varargin_1)
{
  real_T y;
  int32_T d;
  int32_T ix;
  real_T xbar;
  int32_T k;
  real_T r;
  if (varargin_1->size[1] > 1) {
    d = varargin_1->size[1] - 1;
  } else {
    d = varargin_1->size[1];
  }

  if (varargin_1->size[1] == 0) {
    y = 0.0;
  } else {
    ix = 0;
    xbar = varargin_1->data[0];
    for (k = 0; k <= varargin_1->size[1] - 2; k++) {
      ix++;
      xbar += varargin_1->data[ix];
    }

    xbar /= (real_T)varargin_1->size[1];
    ix = 0;
    r = varargin_1->data[0] - xbar;
    y = r * r;
    for (k = 0; k <= varargin_1->size[1] - 2; k++) {
      ix++;
      r = varargin_1->data[ix] - xbar;
      y += r * r;
    }

    y /= (real_T)d;
  }

  return sqrt(y);
}

void d_std(const real_T varargin_1_data[15], const int32_T varargin_1_size[2],
           real_T y[3])
{
  int32_T d;
  int32_T ix;
  int32_T iy;
  int32_T i;
  real_T b_y;
  int32_T b_ix;
  real_T xbar;
  int32_T k;
  real_T r;
  if (varargin_1_size[0] > 1) {
    d = varargin_1_size[0] - 1;
  } else {
    d = varargin_1_size[0];
  }

  ix = 0;
  iy = -1;
  for (i = 0; i < 3; i++) {
    iy++;
    if (varargin_1_size[0] == 0) {
      b_y = 0.0;
    } else {
      b_ix = ix;
      xbar = varargin_1_data[ix];
      for (k = 0; k <= varargin_1_size[0] - 2; k++) {
        b_ix++;
        xbar += varargin_1_data[b_ix];
      }

      xbar /= (real_T)varargin_1_size[0];
      b_ix = ix;
      r = varargin_1_data[ix] - xbar;
      b_y = r * r;
      for (k = 0; k <= varargin_1_size[0] - 2; k++) {
        b_ix++;
        r = varargin_1_data[b_ix] - xbar;
        b_y += r * r;
      }

      b_y /= (real_T)d;
    }

    y[iy] = b_y;
    ix += varargin_1_size[0];
  }

  for (k = 0; k < 3; k++) {
    y[k] = sqrt(y[k]);
  }
}

/* End of code generation (std.c) */
