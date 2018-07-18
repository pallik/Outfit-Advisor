/*
 * getBasicStats.c
 *
 * Code generation for function 'getBasicStats'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "getBasicStats.h"
#include "rateColorPalette_emxutil.h"
#include "std.h"
#include "mean.h"

/* Function Definitions */
void b_getBasicStats(const emxArray_real_T *x, real_T features[8])
{
  emxArray_real_T *b_x;
  int32_T k;
  int32_T loop_ub;
  emxArray_real_T *log_x;
  real_T mtmp;
  real_T b_mtmp;
  real_T c_mtmp;
  real_T d_mtmp;
  real_T d2;
  real_T d3;
  real_T d4;
  real_T d5;
  if (x->size[1] > 0) {
    emxInit_real_T(&b_x, 2);
    k = b_x->size[0] * b_x->size[1];
    b_x->size[0] = 1;
    b_x->size[1] = x->size[1];
    emxEnsureCapacity((emxArray__common *)b_x, k, (int32_T)sizeof(real_T));
    loop_ub = x->size[0] * x->size[1];
    for (k = 0; k < loop_ub; k++) {
      b_x->data[k] = x->data[k] + 1.0E-6;
    }

    emxInit_real_T(&log_x, 2);
    k = log_x->size[0] * log_x->size[1];
    log_x->size[0] = 1;
    log_x->size[1] = b_x->size[1];
    emxEnsureCapacity((emxArray__common *)log_x, k, (int32_T)sizeof(real_T));
    loop_ub = b_x->size[0] * b_x->size[1];
    for (k = 0; k < loop_ub; k++) {
      log_x->data[k] = b_x->data[k];
    }

    for (k = 0; k < b_x->size[1]; k++) {
      log_x->data[k] = log(log_x->data[k]);
    }

    emxFree_real_T(&b_x);
    mtmp = x->data[0];
    if ((x->size[1] > 1) && (1 < x->size[1])) {
      for (k = 1; k + 1 <= x->size[1]; k++) {
        if (x->data[k] < mtmp) {
          mtmp = x->data[k];
        }
      }
    }

    b_mtmp = x->data[0];
    if ((x->size[1] > 1) && (1 < x->size[1])) {
      for (k = 1; k + 1 <= x->size[1]; k++) {
        if (x->data[k] > b_mtmp) {
          b_mtmp = x->data[k];
        }
      }
    }

    c_mtmp = log_x->data[0];
    if ((log_x->size[1] > 1) && (1 < log_x->size[1])) {
      for (k = 1; k + 1 <= log_x->size[1]; k++) {
        if (log_x->data[k] < c_mtmp) {
          c_mtmp = log_x->data[k];
        }
      }
    }

    d_mtmp = log_x->data[0];
    if ((log_x->size[1] > 1) && (1 < log_x->size[1])) {
      for (k = 1; k + 1 <= log_x->size[1]; k++) {
        if (log_x->data[k] > d_mtmp) {
          d_mtmp = log_x->data[k];
        }
      }
    }

    d2 = mean(x);
    d3 = c_std(x);
    d4 = mean(log_x);
    d5 = c_std(log_x);
    features[0] = d2;
    features[1] = d3;
    features[2] = mtmp;
    features[3] = b_mtmp;
    features[4] = d4;
    features[5] = d5;
    features[6] = c_mtmp;
    features[7] = d_mtmp;
    emxFree_real_T(&log_x);
  } else {
    memset(&features[0], 0, sizeof(real_T) << 3);
  }
}

void getBasicStats(const real_T x_data[5], const int32_T x_size[1], real_T
                   features[8])
{
  int32_T loop_ub;
  int32_T i2;
  real_T b_x_data[5];
  int32_T log_x_size[1];
  real_T log_x_data[5];
  real_T y;
  real_T mtmp;
  real_T b_mtmp;
  real_T b_y;
  real_T c_mtmp;
  real_T d_mtmp;
  real_T d0;
  real_T d1;
  if (x_size[0] > 0) {
    loop_ub = x_size[0];
    for (i2 = 0; i2 < loop_ub; i2++) {
      b_x_data[i2] = x_data[i2] + 1.0E-6;
    }

    log_x_size[0] = x_size[0];
    loop_ub = x_size[0];
    for (i2 = 0; i2 < loop_ub; i2++) {
      log_x_data[i2] = b_x_data[i2];
    }

    for (loop_ub = 0; loop_ub < x_size[0]; loop_ub++) {
      log_x_data[loop_ub] = log(log_x_data[loop_ub]);
    }

    y = x_data[0];
    for (loop_ub = 2; loop_ub <= x_size[0]; loop_ub++) {
      y += x_data[loop_ub - 1];
    }

    mtmp = x_data[0];
    if (x_size[0] > 1) {
      for (loop_ub = 1; loop_ub + 1 <= x_size[0]; loop_ub++) {
        if (x_data[loop_ub] < mtmp) {
          mtmp = x_data[loop_ub];
        }
      }
    }

    b_mtmp = x_data[0];
    if (x_size[0] > 1) {
      for (loop_ub = 1; loop_ub + 1 <= x_size[0]; loop_ub++) {
        if (x_data[loop_ub] > b_mtmp) {
          b_mtmp = x_data[loop_ub];
        }
      }
    }

    b_y = log_x_data[0];
    for (loop_ub = 2; loop_ub <= x_size[0]; loop_ub++) {
      b_y += log_x_data[loop_ub - 1];
    }

    c_mtmp = log_x_data[0];
    if (x_size[0] > 1) {
      for (loop_ub = 1; loop_ub + 1 <= x_size[0]; loop_ub++) {
        if (log_x_data[loop_ub] < c_mtmp) {
          c_mtmp = log_x_data[loop_ub];
        }
      }
    }

    d_mtmp = log_x_data[0];
    if (x_size[0] > 1) {
      for (loop_ub = 1; loop_ub + 1 <= x_size[0]; loop_ub++) {
        if (log_x_data[loop_ub] > d_mtmp) {
          d_mtmp = log_x_data[loop_ub];
        }
      }
    }

    d0 = b_std(x_data, x_size);
    d1 = b_std(log_x_data, log_x_size);
    features[0] = y / (real_T)x_size[0];
    features[1] = d0;
    features[2] = mtmp;
    features[3] = b_mtmp;
    features[4] = b_y / (real_T)x_size[0];
    features[5] = d1;
    features[6] = c_mtmp;
    features[7] = d_mtmp;
  } else {
    memset(&features[0], 0, sizeof(real_T) << 3);
  }
}

/* End of code generation (getBasicStats.c) */
