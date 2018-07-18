/*
 * pca2.h
 *
 * Code generation for function 'pca2'
 *
 * C source code generated on: Sat Jan 10 16:52:52 2015
 *
 */

#ifndef __PCA2_H__
#define __PCA2_H__
/* Include files */
#include <float.h>
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "rtwtypes.h"
#include "rateColorPalette_types.h"

/* Function Declarations */
extern void eml_xgemm(int32_T n, const real_T A[9], const real_T B_data[15], real_T C_data[15]);
extern void pca2(real_T data_data[15], int32_T data_size[2], real_T signals_data[15], int32_T signals_size[2], real_T PC[9], real_T V_data[7], int32_T V_size[2]);
#endif
/* End of code generation (pca2.h) */
