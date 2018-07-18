/*
 * rateColorPalette_types.h
 *
 * Code generation for function 'rateColorPalette'
 *
 * C source code generated on: Sat Jan 10 16:52:50 2015
 *
 */

#ifndef __RATECOLORPALETTE_TYPES_H__
#define __RATECOLORPALETTE_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_struct_T
#define typedef_struct_T
typedef struct
{
    real_T hueProb[360];
    real_T hueJoint[129600];
    real_T hueAdjacency[129600];
    real_T hueSaturation[129600];
    real_T hueValue[129600];
    real_T hueJointRating[129600];
    real_T hueAdjacencyRating[129600];
    real_T hueSaturationRating[36000];
    real_T hueValueRating[36000];
    real_T hueRatingFactor[360];
} struct_T;
#endif /*typedef_struct_T*/
#ifndef typedef_b_struct_T
#define typedef_b_struct_T
typedef struct
{
    struct_T hueProbs;
} b_struct_T;
#endif /*typedef_b_struct_T*/
#ifndef typedef_c_struct_T
#define typedef_c_struct_T
typedef struct
{
    char_T form[2];
    real_T breaks[361];
    real_T coefs[1440];
    real_T pieces;
    real_T order;
    real_T dim;
} c_struct_T;
#endif /*typedef_c_struct_T*/
#ifndef typedef_d_struct_T
#define typedef_d_struct_T
typedef struct
{
    real_T x[361];
    c_struct_T mapping;
} d_struct_T;
#endif /*typedef_d_struct_T*/
#ifndef typedef_e_struct_T
#define typedef_e_struct_T
typedef struct
{
    real_T weights[334];
    real_T offsets[334];
    real_T scales[334];
} e_struct_T;
#endif /*typedef_e_struct_T*/
#ifndef struct_emxArray__common
#define struct_emxArray__common
struct emxArray__common
{
    void *data;
    int32_T *size;
    int32_T allocatedSize;
    int32_T numDimensions;
    boolean_T canFreeData;
};
#endif /*struct_emxArray__common*/
#ifndef typedef_emxArray__common
#define typedef_emxArray__common
typedef struct emxArray__common emxArray__common;
#endif /*typedef_emxArray__common*/
#ifndef struct_emxArray_int32_T
#define struct_emxArray_int32_T
struct emxArray_int32_T
{
    int32_T *data;
    int32_T *size;
    int32_T allocatedSize;
    int32_T numDimensions;
    boolean_T canFreeData;
};
#endif /*struct_emxArray_int32_T*/
#ifndef typedef_emxArray_int32_T
#define typedef_emxArray_int32_T
typedef struct emxArray_int32_T emxArray_int32_T;
#endif /*typedef_emxArray_int32_T*/
#ifndef struct_emxArray_int32_T_1x1
#define struct_emxArray_int32_T_1x1
struct emxArray_int32_T_1x1
{
    int32_T data[1];
    int32_T size[2];
};
#endif /*struct_emxArray_int32_T_1x1*/
#ifndef typedef_emxArray_int32_T_1x1
#define typedef_emxArray_int32_T_1x1
typedef struct emxArray_int32_T_1x1 emxArray_int32_T_1x1;
#endif /*typedef_emxArray_int32_T_1x1*/
#ifndef struct_emxArray_int32_T_1x5
#define struct_emxArray_int32_T_1x5
struct emxArray_int32_T_1x5
{
    int32_T data[5];
    int32_T size[2];
};
#endif /*struct_emxArray_int32_T_1x5*/
#ifndef typedef_emxArray_int32_T_1x5
#define typedef_emxArray_int32_T_1x5
typedef struct emxArray_int32_T_1x5 emxArray_int32_T_1x5;
#endif /*typedef_emxArray_int32_T_1x5*/
#ifndef struct_emxArray_int32_T_5
#define struct_emxArray_int32_T_5
struct emxArray_int32_T_5
{
    int32_T data[5];
    int32_T size[1];
};
#endif /*struct_emxArray_int32_T_5*/
#ifndef typedef_emxArray_int32_T_5
#define typedef_emxArray_int32_T_5
typedef struct emxArray_int32_T_5 emxArray_int32_T_5;
#endif /*typedef_emxArray_int32_T_5*/
#ifndef struct_emxArray_int32_T_7
#define struct_emxArray_int32_T_7
struct emxArray_int32_T_7
{
    int32_T data[7];
    int32_T size[1];
};
#endif /*struct_emxArray_int32_T_7*/
#ifndef typedef_emxArray_int32_T_7
#define typedef_emxArray_int32_T_7
typedef struct emxArray_int32_T_7 emxArray_int32_T_7;
#endif /*typedef_emxArray_int32_T_7*/
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T
struct emxArray_real_T
{
    real_T *data;
    int32_T *size;
    int32_T allocatedSize;
    int32_T numDimensions;
    boolean_T canFreeData;
};
#endif /*struct_emxArray_real_T*/
#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T
typedef struct emxArray_real_T emxArray_real_T;
#endif /*typedef_emxArray_real_T*/
#ifndef struct_emxArray_real_T_15
#define struct_emxArray_real_T_15
struct emxArray_real_T_15
{
    real_T data[15];
    int32_T size[1];
};
#endif /*struct_emxArray_real_T_15*/
#ifndef typedef_emxArray_real_T_15
#define typedef_emxArray_real_T_15
typedef struct emxArray_real_T_15 emxArray_real_T_15;
#endif /*typedef_emxArray_real_T_15*/
#ifndef struct_emxArray_real_T_1x1
#define struct_emxArray_real_T_1x1
struct emxArray_real_T_1x1
{
    real_T data[1];
    int32_T size[2];
};
#endif /*struct_emxArray_real_T_1x1*/
#ifndef typedef_emxArray_real_T_1x1
#define typedef_emxArray_real_T_1x1
typedef struct emxArray_real_T_1x1 emxArray_real_T_1x1;
#endif /*typedef_emxArray_real_T_1x1*/
#ifndef struct_emxArray_real_T_1x5
#define struct_emxArray_real_T_1x5
struct emxArray_real_T_1x5
{
    real_T data[5];
    int32_T size[2];
};
#endif /*struct_emxArray_real_T_1x5*/
#ifndef typedef_emxArray_real_T_1x5
#define typedef_emxArray_real_T_1x5
typedef struct emxArray_real_T_1x5 emxArray_real_T_1x5;
#endif /*typedef_emxArray_real_T_1x5*/
#ifndef struct_emxArray_real_T_3
#define struct_emxArray_real_T_3
struct emxArray_real_T_3
{
    real_T data[3];
    int32_T size[1];
};
#endif /*struct_emxArray_real_T_3*/
#ifndef typedef_emxArray_real_T_3
#define typedef_emxArray_real_T_3
typedef struct emxArray_real_T_3 emxArray_real_T_3;
#endif /*typedef_emxArray_real_T_3*/
#ifndef struct_emxArray_real_T_3x5
#define struct_emxArray_real_T_3x5
struct emxArray_real_T_3x5
{
    real_T data[15];
    int32_T size[2];
};
#endif /*struct_emxArray_real_T_3x5*/
#ifndef typedef_emxArray_real_T_3x5
#define typedef_emxArray_real_T_3x5
typedef struct emxArray_real_T_3x5 emxArray_real_T_3x5;
#endif /*typedef_emxArray_real_T_3x5*/
#ifndef struct_emxArray_real_T_5
#define struct_emxArray_real_T_5
struct emxArray_real_T_5
{
    real_T data[5];
    int32_T size[1];
};
#endif /*struct_emxArray_real_T_5*/
#ifndef typedef_emxArray_real_T_5
#define typedef_emxArray_real_T_5
typedef struct emxArray_real_T_5 emxArray_real_T_5;
#endif /*typedef_emxArray_real_T_5*/
#ifndef struct_emxArray_real_T_5x3
#define struct_emxArray_real_T_5x3
struct emxArray_real_T_5x3
{
    real_T data[15];
    int32_T size[2];
};
#endif /*struct_emxArray_real_T_5x3*/
#ifndef typedef_emxArray_real_T_5x3
#define typedef_emxArray_real_T_5x3
typedef struct emxArray_real_T_5x3 emxArray_real_T_5x3;
#endif /*typedef_emxArray_real_T_5x3*/

#endif
/* End of code generation (rateColorPalette_types.h) */
