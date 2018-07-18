/*
 * createFeaturesFromData.h
 *
 * Code generation for function 'createFeaturesFromData'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

#ifndef __CREATEFEATURESFROMDATA_H__
#define __CREATEFEATURESFROMDATA_H__
/* Include files */
#include <float.h>
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "rtwtypes.h"
#include "rateColorPalette_types.h"

/* Function Declarations */
extern void createFeaturesFromData(const real_T data[15], real_T rgbs[15], real_T b_labs[15], real_T concatenatedFeatures[334]);
extern void eml_sort_idx(const real_T x_data[5], const int32_T x_size[1], int32_T idx_data[5], int32_T idx_size[1]);
#endif
/* End of code generation (createFeaturesFromData.h) */
