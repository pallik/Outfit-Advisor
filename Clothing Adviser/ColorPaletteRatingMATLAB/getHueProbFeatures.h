/*
 * getHueProbFeatures.h
 *
 * Code generation for function 'getHueProbFeatures'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

#ifndef __GETHUEPROBFEATURES_H__
#define __GETHUEPROBFEATURES_H__
/* Include files */
#include <float.h>
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "rtwtypes.h"
#include "rateColorPalette_types.h"

/* Function Declarations */
extern void getHueProbFeatures(const real_T hsv_data[15], const int32_T hsv_size[2], const real_T hueProbs_hueProb[360], const real_T hueProbs_hueJoint[129600], const real_T hueProbs_hueAdjacency[129600], real_T hueFeatures[25]);
#endif
/* End of code generation (getHueProbFeatures.h) */
