/*
 * getPlaneFeatures.h
 *
 * Code generation for function 'getPlaneFeatures'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

#ifndef __GETPLANEFEATURES_H__
#define __GETPLANEFEATURES_H__
/* Include files */
#include <float.h>
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "rtwtypes.h"
#include "rateColorPalette_types.h"

/* Function Declarations */
extern void getPlaneFeatures(const real_T X_data[15], const int32_T X_size[2], real_T normal[3], real_T pctExplained_data[3], int32_T pctExplained_size[2], real_T meanX[3], real_T *sse);
#endif
/* End of code generation (getPlaneFeatures.h) */
