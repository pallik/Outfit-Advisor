/*
 * mean.h
 *
 * Code generation for function 'mean'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

#ifndef __MEAN_H__
#define __MEAN_H__
/* Include files */
#include <float.h>
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "rtwtypes.h"
#include "rateColorPalette_types.h"

/* Function Declarations */
extern void b_mean(const real_T x_data[15], const int32_T x_size[2], real_T y[3]);
extern real_T mean(const emxArray_real_T *x);
#endif
/* End of code generation (mean.h) */
