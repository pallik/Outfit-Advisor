/*
 * getHueProbFeatures.c
 *
 * Code generation for function 'getHueProbFeatures'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "getHueProbFeatures.h"
#include "rateColorPalette_emxutil.h"
#include "getBasicStats.h"
#include "repmat.h"
#include "rateColorPalette_rtwutil.h"

/* Function Definitions */
void getHueProbFeatures(const real_T hsv_data[15], const int32_T hsv_size[2],
  const real_T hueProbs_hueProb[360], const real_T hueProbs_hueJoint[129600],
  const real_T hueProbs_hueAdjacency[129600], real_T hueFeatures[25])
{
  int32_T b_hsv_size[2];
  int8_T outsz[2];
  int32_T i4;
  real_T visHues_data[5];
  int32_T ix;
  int32_T iy;
  int32_T i;
  real_T entropy;
  int32_T h2;
  boolean_T selectColors_data[5];
  real_T x[15];
  real_T hsv2[15];
  int32_T k;
  uint8_T indx_data[5];
  emxArray_real_T *hueJointList;
  uint8_T tmp_data[5];
  uint8_T b_tmp_data[5];
  emxArray_real_T *hueAdjList;
  real_T hueProbs_hueProb_data[5];
  int32_T c_tmp_data[5];
  int32_T hueProbs_hueProb_size[1];
  real_T hueProbFeatures[8];
  real_T hueJointProbFeatures[8];
  real_T hueAdjProbFeatures[8];
  real_T pMix[360];
  b_hsv_size[0] = 2;
  b_hsv_size[1] = hsv_size[1];
  for (i4 = 0; i4 < 2; i4++) {
    outsz[i4] = (int8_T)b_hsv_size[i4];
  }

  ix = -1;
  iy = -1;
  for (i = 1; i <= hsv_size[1]; i++) {
    ix += 2;
    entropy = hsv_data[((ix - 1) % 2 + hsv_size[0] * ((ix - 1) / 2)) + 1];
    if (ix < ix + 1) {
      for (h2 = ix; h2 + 1 <= ix + 1; h2++) {
        if (hsv_data[(h2 % 2 + hsv_size[0] * (h2 / 2)) + 1] < entropy) {
          entropy = hsv_data[(h2 % 2 + hsv_size[0] * (h2 / 2)) + 1];
        }
      }
    }

    iy++;
    visHues_data[iy] = entropy;
  }

  ix = outsz[1];
  for (i4 = 0; i4 < ix; i4++) {
    selectColors_data[i4] = (visHues_data[i4] >= 0.2);
  }

  repmat(x);
  for (i4 = 0; i4 < 15; i4++) {
    entropy = rt_roundd(hsv_data[i4] * x[i4]);
    hsv2[i4] = entropy + 1.0;
    x[i4] = entropy;
  }

  k = 0;
  for (i = 1; i <= outsz[1]; i++) {
    if (selectColors_data[i - 1]) {
      k++;
    }
  }

  ix = 0;
  for (i = 1; i <= outsz[1]; i++) {
    if (selectColors_data[i - 1]) {
      indx_data[ix] = (uint8_T)i;
      ix++;
    }
  }

  for (i4 = 0; i4 < k; i4++) {
    visHues_data[i4] = x[3 * (indx_data[i4] - 1)] + 1.0;
  }

  emxInit_real_T(&hueJointList, 2);
  i4 = hueJointList->size[0] * hueJointList->size[1];
  hueJointList->size[0] = 1;
  hueJointList->size[1] = 0;
  emxEnsureCapacity((emxArray__common *)hueJointList, i4, (int32_T)sizeof(real_T));
  for (ix = 1; ix - 1 < k; ix++) {
    i4 = k - ix;
    for (h2 = 0; h2 <= i4; h2++) {
      for (i = 0; i < k; i++) {
        tmp_data[i] = indx_data[i];
      }

      for (i = 0; i < k; i++) {
        b_tmp_data[i] = indx_data[i];
      }

      iy = hueJointList->size[1];
      i = hueJointList->size[0] * hueJointList->size[1];
      hueJointList->size[1] = iy + 1;
      emxEnsureCapacity((emxArray__common *)hueJointList, i, (int32_T)sizeof
                        (real_T));
      hueJointList->data[iy] = hueProbs_hueJoint[((int32_T)hsv2[3 * (tmp_data
        [(ix + h2) - 1] - 1)] + 360 * ((int32_T)hsv2[3 * (b_tmp_data[ix - 1] - 1)]
        - 1)) - 1];
    }
  }

  emxInit_real_T(&hueAdjList, 2);
  i4 = hueAdjList->size[0] * hueAdjList->size[1];
  hueAdjList->size[0] = 1;
  hueAdjList->size[1] = 0;
  emxEnsureCapacity((emxArray__common *)hueAdjList, i4, (int32_T)sizeof(real_T));
  for (ix = 0; ix <= k - 2; ix++) {
    for (i4 = 0; i4 < k; i4++) {
      tmp_data[i4] = indx_data[i4];
    }

    for (i4 = 0; i4 < k; i4++) {
      b_tmp_data[i4] = indx_data[i4];
    }

    iy = hueAdjList->size[1];
    i4 = hueAdjList->size[0] * hueAdjList->size[1];
    hueAdjList->size[1] = iy + 1;
    emxEnsureCapacity((emxArray__common *)hueAdjList, i4, (int32_T)sizeof(real_T));
    hueAdjList->data[iy] = hueProbs_hueAdjacency[((int32_T)hsv2[3 * (tmp_data[ix]
      - 1)] + 360 * ((int32_T)hsv2[3 * (b_tmp_data[ix + 1] - 1)] - 1)) - 1];
  }

  for (i4 = 0; i4 < k; i4++) {
    c_tmp_data[i4] = (int32_T)hsv2[3 * (indx_data[i4] - 1)];
  }

  hueProbs_hueProb_size[0] = k;
  for (i4 = 0; i4 < k; i4++) {
    hueProbs_hueProb_data[i4] = hueProbs_hueProb[c_tmp_data[i4] - 1];
  }

  getBasicStats(hueProbs_hueProb_data, hueProbs_hueProb_size, hueProbFeatures);
  b_getBasicStats(hueJointList, hueJointProbFeatures);
  b_getBasicStats(hueAdjList, hueAdjProbFeatures);
  emxFree_real_T(&hueAdjList);
  emxFree_real_T(&hueJointList);
  for (i = 0; i < 360; i++) {
    pMix[i] = 0.001;
  }

  for (ix = 0; ix < k; ix++) {
    entropy = visHues_data[ix] * 2.0 * 3.1415926535897931;

    /*  [p alpha] = circ_vmpdf(alpha, w, p) */
    /*    Computes the circular von Mises pdf with preferred direction thetahat  */
    /*    and concentration kappa at each of the angles in alpha */
    /*  */
    /*    The vmpdf is given by f(phi) = */
    /*    (1/(2pi*I0(kappa))*exp(kappa*cos(phi-thetahat) */
    /*  */
    /*    Input: */
    /*      alpha     angles to evaluate pdf at, if empty alphas are chosen to */
    /*                100 uniformly spaced points around the circle */
    /*      [thetahat preferred direction, default is 0] */
    /*      [kappa    concentration parameter, default is 1] */
    /*  */
    /*    Output: */
    /*      p         von Mises pdf evaluated at alpha */
    /*      alpha     angles at which pdf was evaluated */
    /*  */
    /*  */
    /*    References: */
    /*      Statistical analysis of circular data, Fisher */
    /*  */
    /*  Circular Statistics Toolbox for Matlab */
    /*  By Philipp Berens and Marc J. Velasco, 2009 */
    /*  velasco@ccs.fau.edu */
    /*  if no angles are supplied, 100 evenly spaced points around the circle are */
    /*  chosen */
    /*  evaluate pdf */
    /*  C = 1/(2*pi*besseli(0,kappa)); */
    /* As far as kappa = 2*pi */
    for (i4 = 0; i4 < 360; i4++) {
      pMix[i4] += 0.0018 * exp(6.2831853071795862 * cos(0.017453292519943295 *
        (real_T)i4 - entropy));
    }
  }

  entropy = pMix[0];
  for (ix = 0; ix < 359; ix++) {
    entropy += pMix[ix + 1];
  }

  for (i4 = 0; i4 < 360; i4++) {
    pMix[i4] /= entropy;
  }

  if (k != 0) {
    for (i = 0; i < 360; i++) {
      pMix[i] *= log(pMix[i]);
    }

    entropy = pMix[0];
    for (k = 0; k < 359; k++) {
      entropy += pMix[k + 1];
    }

    entropy = -entropy;
  } else {
    /* if no visible hues, set the entropy high */
    entropy = 5.9;
  }

  memcpy(&hueFeatures[0], &hueProbFeatures[0], sizeof(real_T) << 3);
  memcpy(&hueFeatures[8], &hueJointProbFeatures[0], sizeof(real_T) << 3);
  memcpy(&hueFeatures[16], &hueAdjProbFeatures[0], sizeof(real_T) << 3);
  hueFeatures[24] = entropy;
}

/* End of code generation (getHueProbFeatures.c) */
