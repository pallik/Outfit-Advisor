/*
 * pca2.c
 *
 * Code generation for function 'pca2'
 *
 * C source code generated on: Sat Jan 10 16:52:51 2015
 *
 */

/* Include files */
#include "rateColorPalette.h"
#include "pca2.h"

/* Function Declarations */
static void b_eml_xaxpy(int32_T n, real_T a, const real_T x_data[15], int32_T
  ix0, real_T y_data[5], int32_T iy0);
static real_T b_eml_xdotc(int32_T n, const real_T x_data[25], int32_T ix0, const
  real_T y_data[25], int32_T iy0);
static real_T b_eml_xnrm2(const real_T x[3], int32_T ix0);
static void b_eml_xrot(int32_T n, real_T x_data[25], int32_T ix0, int32_T iy0,
  real_T c, real_T s);
static void b_eml_xscal(real_T a, real_T x[3], int32_T ix0);
static void b_eml_xswap(int32_T n, real_T x_data[25], int32_T ix0, int32_T iy0);
static void c_eml_xaxpy(int32_T n, real_T a, const real_T x_data[5], int32_T ix0,
  real_T y_data[15], int32_T iy0);
static real_T c_eml_xdotc(int32_T n, const real_T x[9], int32_T ix0, const
  real_T y[9], int32_T iy0);
static void c_eml_xscal(int32_T n, real_T a, real_T x_data[25], int32_T ix0);
static void d_eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y_data[25],
  int32_T iy0);
static void d_eml_xscal(real_T a, real_T x[9], int32_T ix0);
static int32_T div_s32_floor(int32_T numerator, int32_T denominator);
static void e_eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[9], int32_T
  iy0);
static real_T eml_div(real_T x, real_T y);
static void eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y_data[15],
                      int32_T iy0);
static real_T eml_xdotc(int32_T n, const real_T x_data[15], int32_T ix0, const
  real_T y_data[15], int32_T iy0);
static void eml_xgesvd(const real_T A_data[15], const int32_T A_size[2], real_T
  U_data[25], int32_T U_size[2], real_T S_data[3], int32_T S_size[1], real_T V[9]);
static real_T eml_xnrm2(int32_T n, const real_T x_data[15], int32_T ix0);
static void eml_xrot(real_T x[9], int32_T ix0, int32_T iy0, real_T c, real_T s);
static void eml_xrotg(real_T *a, real_T *b, real_T *c, real_T *s);
static void eml_xscal(int32_T n, real_T a, real_T x_data[15], int32_T ix0);
static void eml_xswap(real_T x[9], int32_T ix0, int32_T iy0);

/* Function Definitions */
static void b_eml_xaxpy(int32_T n, real_T a, const real_T x_data[15], int32_T
  ix0, real_T y_data[5], int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  if ((n < 1) || (a == 0.0)) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      y_data[iy] += a * x_data[ix];
      ix++;
      iy++;
    }
  }
}

static real_T b_eml_xdotc(int32_T n, const real_T x_data[25], int32_T ix0, const
  real_T y_data[25], int32_T iy0)
{
  real_T d;
  int32_T ix;
  int32_T iy;
  int32_T k;
  d = 0.0;
  if (n < 1) {
  } else {
    ix = ix0;
    iy = iy0;
    for (k = 1; k <= n; k++) {
      d += x_data[ix - 1] * y_data[iy - 1];
      ix++;
      iy++;
    }
  }

  return d;
}

static real_T b_eml_xnrm2(const real_T x[3], int32_T ix0)
{
  real_T y;
  real_T scale;
  int32_T k;
  real_T absxk;
  real_T t;
  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = ix0; k <= ix0 + 1; k++) {
    absxk = fabs(x[k - 1]);
    if (absxk > scale) {
      t = scale / absxk;
      y = 1.0 + y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      y += t * t;
    }
  }

  return scale * sqrt(y);
}

static void b_eml_xrot(int32_T n, real_T x_data[25], int32_T ix0, int32_T iy0,
  real_T c, real_T s)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  real_T y;
  real_T b_y;
  if (n < 1) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 1; k <= n; k++) {
      y = c * x_data[ix];
      b_y = s * x_data[iy];
      x_data[iy] = c * x_data[iy] - s * x_data[ix];
      x_data[ix] = y + b_y;
      iy++;
      ix++;
    }
  }
}

static void b_eml_xscal(real_T a, real_T x[3], int32_T ix0)
{
  int32_T k;
  for (k = ix0; k <= ix0 + 1; k++) {
    x[k - 1] *= a;
  }
}

static void b_eml_xswap(int32_T n, real_T x_data[25], int32_T ix0, int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  real_T temp;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 1; k <= n; k++) {
    temp = x_data[ix];
    x_data[ix] = x_data[iy];
    x_data[iy] = temp;
    ix++;
    iy++;
  }
}

static void c_eml_xaxpy(int32_T n, real_T a, const real_T x_data[5], int32_T ix0,
  real_T y_data[15], int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  if ((n < 1) || (a == 0.0)) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      y_data[iy] += a * x_data[ix];
      ix++;
      iy++;
    }
  }
}

static real_T c_eml_xdotc(int32_T n, const real_T x[9], int32_T ix0, const
  real_T y[9], int32_T iy0)
{
  real_T d;
  int32_T ix;
  int32_T iy;
  int32_T k;
  d = 0.0;
  if (n < 1) {
  } else {
    ix = ix0;
    iy = iy0;
    for (k = 1; k <= n; k++) {
      d += x[ix - 1] * y[iy - 1];
      ix++;
      iy++;
    }
  }

  return d;
}

static void c_eml_xscal(int32_T n, real_T a, real_T x_data[25], int32_T ix0)
{
  int32_T i8;
  int32_T k;
  i8 = (ix0 + n) - 1;
  for (k = ix0; k <= i8; k++) {
    x_data[k - 1] *= a;
  }
}

static void d_eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y_data[25],
  int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  if ((n < 1) || (a == 0.0)) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      y_data[iy] += a * y_data[ix];
      ix++;
      iy++;
    }
  }
}

static void d_eml_xscal(real_T a, real_T x[9], int32_T ix0)
{
  int32_T k;
  for (k = ix0; k <= ix0 + 2; k++) {
    x[k - 1] *= a;
  }
}

static int32_T div_s32_floor(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  uint32_T absNumerator;
  uint32_T absDenominator;
  int32_T quotientNeedsNegation;
  uint32_T tempAbsQuotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    if (numerator >= 0) {
      absNumerator = (uint32_T)numerator;
    } else {
      absNumerator = (uint32_T)-numerator;
    }

    if (denominator >= 0) {
      absDenominator = (uint32_T)denominator;
    } else {
      absDenominator = (uint32_T)-denominator;
    }

    quotientNeedsNegation = ((numerator < 0) != (denominator < 0));
    tempAbsQuotient = absNumerator / absDenominator;
    if ((uint32_T)quotientNeedsNegation) {
      absNumerator %= absDenominator;
      if (absNumerator > (uint32_T)0) {
        tempAbsQuotient++;
      }
    }

    if ((uint32_T)quotientNeedsNegation) {
      quotient = -(int32_T)tempAbsQuotient;
    } else {
      quotient = (int32_T)tempAbsQuotient;
    }
  }

  return quotient;
}

static void e_eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y[9], int32_T
  iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  if ((n < 1) || (a == 0.0)) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      y[iy] += a * y[ix];
      ix++;
      iy++;
    }
  }
}

static real_T eml_div(real_T x, real_T y)
{
  return x / y;
}

static void eml_xaxpy(int32_T n, real_T a, int32_T ix0, real_T y_data[15],
                      int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  if ((n < 1) || (a == 0.0)) {
  } else {
    ix = ix0 - 1;
    iy = iy0 - 1;
    for (k = 0; k < n; k++) {
      y_data[iy] += a * y_data[ix];
      ix++;
      iy++;
    }
  }
}

static real_T eml_xdotc(int32_T n, const real_T x_data[15], int32_T ix0, const
  real_T y_data[15], int32_T iy0)
{
  real_T d;
  int32_T ix;
  int32_T iy;
  int32_T k;
  d = 0.0;
  if (n < 1) {
  } else {
    ix = ix0;
    iy = iy0;
    for (k = 1; k <= n; k++) {
      d += x_data[ix - 1] * y_data[iy - 1];
      ix++;
      iy++;
    }
  }

  return d;
}

static void eml_xgesvd(const real_T A_data[15], const int32_T A_size[2], real_T
  U_data[25], int32_T U_size[2], real_T S_data[3], int32_T S_size[1], real_T V[9])
{
  int32_T i;
  int32_T qs;
  real_T b_A_data[15];
  int32_T minnp;
  real_T s_data[3];
  real_T e[3];
  real_T work_data[5];
  int32_T nct;
  int32_T q;
  int32_T mm;
  int32_T iter;
  real_T ztest0;
  int32_T jj;
  int32_T m;
  real_T ztest;
  real_T snorm;
  boolean_T exitg2;
  boolean_T exitg1;
  real_T sn;
  real_T sm;
  real_T varargin_1[5];
  real_T sqds;
  real_T b;
  i = A_size[0] * A_size[1];
  for (qs = 0; qs < i; qs++) {
    b_A_data[qs] = A_data[qs];
  }

  i = A_size[0];
  if (i <= 3) {
    minnp = i;
  } else {
    minnp = 3;
  }

  i = A_size[0] + 1;
  if (i <= 3) {
  } else {
    i = 3;
  }

  i = (int8_T)i;
  for (qs = 0; qs < i; qs++) {
    s_data[qs] = 0.0;
  }

  for (i = 0; i < 3; i++) {
    e[i] = 0.0;
  }

  i = (int8_T)A_size[0];
  for (qs = 0; qs < i; qs++) {
    work_data[qs] = 0.0;
  }

  U_size[0] = (int8_T)A_size[0];
  U_size[1] = (int8_T)A_size[0];
  i = (int8_T)A_size[0] * (int8_T)A_size[0];
  for (qs = 0; qs < i; qs++) {
    U_data[qs] = 0.0;
  }

  memset(&V[0], 0, 9U * sizeof(real_T));
  if (A_size[0] == 0) {
    for (i = 0; i < 3; i++) {
      V[i + 3 * i] = 1.0;
    }
  } else {
    i = A_size[0] - 1;
    if (i <= 3) {
      nct = i;
    } else {
      nct = 3;
    }

    if (nct >= 1) {
      qs = nct;
    } else {
      qs = 1;
    }

    for (q = 0; q + 1 <= qs; q++) {
      mm = q + A_size[0] * q;
      iter = A_size[0] - q;
      if (q + 1 <= nct) {
        ztest0 = eml_xnrm2(iter, b_A_data, mm + 1);
        if (ztest0 > 0.0) {
          if (b_A_data[mm] < 0.0) {
            s_data[q] = -ztest0;
          } else {
            s_data[q] = ztest0;
          }

          eml_xscal(iter, eml_div(1.0, s_data[q]), b_A_data, mm + 1);
          b_A_data[mm]++;
          s_data[q] = -s_data[q];
        } else {
          s_data[q] = 0.0;
        }
      }

      for (jj = q + 1; jj + 1 < 4; jj++) {
        i = q + A_size[0] * jj;
        if ((q + 1 <= nct) && (s_data[q] != 0.0)) {
          ztest0 = eml_xdotc(iter, b_A_data, mm + 1, b_A_data, i + 1);
          ztest0 = -eml_div(ztest0, b_A_data[q + A_size[0] * q]);
          eml_xaxpy(iter, ztest0, mm + 1, b_A_data, i + 1);
        }

        e[jj] = b_A_data[i];
      }

      if (q + 1 <= nct) {
        for (i = q; i + 1 <= A_size[0]; i++) {
          U_data[i + (int8_T)A_size[0] * q] = b_A_data[i + A_size[0] * q];
        }
      }

      if (q + 1 <= 1) {
        ztest0 = b_eml_xnrm2(e, 2);
        if (ztest0 == 0.0) {
          e[0] = 0.0;
        } else {
          if (e[1] < 0.0) {
            ztest0 = -ztest0;
          }

          e[0] = ztest0;
          b_eml_xscal(eml_div(1.0, ztest0), e, 2);
          e[1]++;
        }

        e[0] = -e[0];
        if ((2 <= A_size[0]) && (e[0] != 0.0)) {
          for (i = 2; i <= A_size[0]; i++) {
            work_data[i - 1] = 0.0;
          }

          for (jj = 1; jj + 1 < 4; jj++) {
            b_eml_xaxpy(iter - 1, e[jj], b_A_data, 2 + A_size[0] * jj, work_data,
                        2);
          }

          for (jj = 1; jj + 1 < 4; jj++) {
            c_eml_xaxpy(iter - 1, eml_div(-e[jj], e[1]), work_data, 2, b_A_data,
                        2 + A_size[0] * jj);
          }
        }

        for (i = 1; i + 1 < 4; i++) {
          V[i] = e[i];
        }
      }
    }

    i = A_size[0] + 1;
    if (3 <= i) {
      m = 3;
    } else {
      m = i;
    }

    if (nct < 3) {
      s_data[nct] = b_A_data[nct + A_size[0] * nct];
    }

    if (A_size[0] < m) {
      s_data[m - 1] = 0.0;
    }

    if (2 < m) {
      e[1] = b_A_data[1 + (A_size[0] << 1)];
    }

    e[m - 1] = 0.0;
    if (nct + 1 <= A_size[0]) {
      for (jj = nct; jj + 1 <= A_size[0]; jj++) {
        for (i = 1; i <= A_size[0]; i++) {
          U_data[(i + (int8_T)A_size[0] * jj) - 1] = 0.0;
        }

        U_data[jj + (int8_T)A_size[0] * jj] = 1.0;
      }
    }

    for (q = nct - 1; q + 1 > 0; q--) {
      iter = A_size[0] - q;
      mm = q + A_size[0] * q;
      if (s_data[q] != 0.0) {
        for (jj = q; jj + 2 <= A_size[0]; jj++) {
          i = (q + A_size[0] * (jj + 1)) + 1;
          ztest0 = b_eml_xdotc(iter, U_data, mm + 1, U_data, i);
          ztest0 = -eml_div(ztest0, U_data[mm]);
          d_eml_xaxpy(iter, ztest0, mm + 1, U_data, i);
        }

        for (i = q; i + 1 <= A_size[0]; i++) {
          U_data[i + (int8_T)A_size[0] * q] = -U_data[i + (int8_T)A_size[0] * q];
        }

        U_data[mm]++;
        for (i = 1; i <= q; i++) {
          U_data[(i + (int8_T)A_size[0] * q) - 1] = 0.0;
        }
      } else {
        for (i = 1; i <= A_size[0]; i++) {
          U_data[(i + (int8_T)A_size[0] * q) - 1] = 0.0;
        }

        U_data[mm] = 1.0;
      }
    }

    for (q = 2; q > -1; q += -1) {
      if ((q + 1 <= 1) && (e[0] != 0.0)) {
        for (jj = 0; jj < 2; jj++) {
          i = 3 * (jj + 1);
          e_eml_xaxpy(2, -eml_div(c_eml_xdotc(2, V, 2, V, 2 + i), V[1]), 2, V, i
                      + 2);
        }
      }

      for (i = 0; i < 3; i++) {
        V[i + 3 * q] = 0.0;
      }

      V[q + 3 * q] = 1.0;
    }

    for (q = 0; q + 1 <= m; q++) {
      if (s_data[q] != 0.0) {
        ztest = fabs(s_data[q]);
        ztest0 = eml_div(s_data[q], ztest);
        s_data[q] = ztest;
        if (q + 1 < m) {
          e[q] = eml_div(e[q], ztest0);
        }

        if (q + 1 <= A_size[0]) {
          c_eml_xscal(A_size[0], ztest0, U_data, A_size[0] * q + 1);
        }
      }

      if ((q + 1 < m) && (e[q] != 0.0)) {
        ztest = fabs(e[q]);
        ztest0 = eml_div(ztest, e[q]);
        e[q] = ztest;
        s_data[q + 1] *= ztest0;
        d_eml_xscal(ztest0, V, 3 * (q + 1) + 1);
      }
    }

    mm = m;
    iter = 0;
    snorm = 0.0;
    for (i = 0; i + 1 <= m; i++) {
      ztest0 = fabs(s_data[i]);
      ztest = fabs(e[i]);
      if (ztest0 >= ztest) {
      } else {
        ztest0 = ztest;
      }

      if (snorm >= ztest0) {
      } else {
        snorm = ztest0;
      }
    }

    while ((m > 0) && (!(iter >= 75))) {
      q = m - 1;
      exitg2 = FALSE;
      while (!((exitg2 == TRUE) || (q == 0))) {
        ztest0 = fabs(e[q - 1]);
        if ((ztest0 <= 2.2204460492503131E-16 * (fabs(s_data[q - 1]) + fabs
              (s_data[q]))) || (ztest0 <= 1.0020841800044864E-292) || ((iter >
              20) && (ztest0 <= 2.2204460492503131E-16 * snorm))) {
          e[q - 1] = 0.0;
          exitg2 = TRUE;
        } else {
          q--;
        }
      }

      if (q == m - 1) {
        i = 4;
      } else {
        qs = m;
        i = m;
        exitg1 = FALSE;
        while ((exitg1 == FALSE) && (i >= q)) {
          qs = i;
          if (i == q) {
            exitg1 = TRUE;
          } else {
            ztest0 = 0.0;
            if (i < m) {
              ztest0 = fabs(e[i - 1]);
            }

            if (i > q + 1) {
              ztest0 += fabs(e[i - 2]);
            }

            ztest = fabs(s_data[i - 1]);
            if ((ztest <= 2.2204460492503131E-16 * ztest0) || (ztest <=
                 1.0020841800044864E-292)) {
              s_data[i - 1] = 0.0;
              exitg1 = TRUE;
            } else {
              i--;
            }
          }
        }

        if (qs == q) {
          i = 3;
        } else if (qs == m) {
          i = 1;
        } else {
          i = 2;
          q = qs;
        }
      }

      switch (i) {
       case 1:
        ztest = e[m - 2];
        e[m - 2] = 0.0;
        for (i = m - 2; i + 1 >= q + 1; i--) {
          ztest0 = s_data[i];
          eml_xrotg(&ztest0, &ztest, &sm, &sn);
          s_data[i] = ztest0;
          if (i + 1 > q + 1) {
            ztest = -sn * e[0];
            e[0] *= sm;
          }

          eml_xrot(V, 3 * i + 1, 3 * (m - 1) + 1, sm, sn);
        }
        break;

       case 2:
        ztest = e[q - 1];
        e[q - 1] = 0.0;
        for (i = q; i + 1 <= m; i++) {
          eml_xrotg(&s_data[i], &ztest, &sm, &sn);
          ztest = -sn * e[i];
          e[i] *= sm;
          b_eml_xrot(A_size[0], U_data, A_size[0] * i + 1, A_size[0] * (q - 1) +
                     1, sm, sn);
        }
        break;

       case 3:
        varargin_1[0] = fabs(s_data[m - 1]);
        varargin_1[1] = fabs(s_data[m - 2]);
        varargin_1[2] = fabs(e[m - 2]);
        varargin_1[3] = fabs(s_data[q]);
        varargin_1[4] = fabs(e[q]);
        sn = varargin_1[0];
        for (i = 0; i < 4; i++) {
          if (varargin_1[i + 1] > sn) {
            sn = varargin_1[i + 1];
          }
        }

        sm = eml_div(s_data[m - 1], sn);
        ztest0 = eml_div(s_data[m - 2], sn);
        ztest = eml_div(e[m - 2], sn);
        sqds = eml_div(s_data[q], sn);
        b = eml_div((ztest0 + sm) * (ztest0 - sm) + ztest * ztest, 2.0);
        ztest0 = sm * ztest;
        ztest0 *= ztest0;
        ztest = 0.0;
        if ((b != 0.0) || (ztest0 != 0.0)) {
          ztest = sqrt(b * b + ztest0);
          if (b < 0.0) {
            ztest = -ztest;
          }

          ztest = eml_div(ztest0, b + ztest);
        }

        ztest += (sqds + sm) * (sqds - sm);
        ztest0 = sqds * eml_div(e[q], sn);
        for (i = q + 1; i < m; i++) {
          eml_xrotg(&ztest, &ztest0, &sm, &sn);
          if (i > q + 1) {
            e[0] = ztest;
          }

          ztest0 = sm * s_data[i - 1];
          ztest = sn * e[i - 1];
          e[i - 1] = sm * e[i - 1] - sn * s_data[i - 1];
          b = s_data[i];
          s_data[i] *= sm;
          eml_xrot(V, 3 * (i - 1) + 1, 3 * i + 1, sm, sn);
          s_data[i - 1] = ztest0 + ztest;
          ztest0 = sn * b;
          eml_xrotg(&s_data[i - 1], &ztest0, &sm, &sn);
          ztest = sm * e[i - 1] + sn * s_data[i];
          s_data[i] = -sn * e[i - 1] + sm * s_data[i];
          ztest0 = sn * e[i];
          e[i] *= sm;
          if (i < A_size[0]) {
            b_eml_xrot(A_size[0], U_data, A_size[0] * (i - 1) + 1, A_size[0] * i
                       + 1, sm, sn);
          }
        }

        e[m - 2] = ztest;
        iter++;
        break;

       default:
        if (s_data[q] < 0.0) {
          s_data[q] = -s_data[q];
          d_eml_xscal(-1.0, V, 3 * q + 1);
        }

        i = q + 1;
        while ((q + 1 < mm) && (s_data[q] < s_data[i])) {
          ztest = s_data[q];
          s_data[q] = s_data[i];
          s_data[i] = ztest;
          eml_xswap(V, 3 * q + 1, 3 * (q + 1) + 1);
          if (q + 1 < A_size[0]) {
            b_eml_xswap(A_size[0], U_data, A_size[0] * q + 1, A_size[0] * (q + 1)
                        + 1);
          }

          q = i;
          i++;
        }

        iter = 0;
        m--;
        break;
      }
    }
  }

  S_size[0] = minnp;
  for (i = 0; i + 1 <= minnp; i++) {
    S_data[i] = s_data[i];
  }
}

static real_T eml_xnrm2(int32_T n, const real_T x_data[15], int32_T ix0)
{
  real_T y;
  real_T scale;
  int32_T kend;
  int32_T k;
  real_T absxk;
  real_T t;
  y = 0.0;
  if (n < 1) {
  } else if (n == 1) {
    y = fabs(x_data[ix0 - 1]);
  } else {
    scale = 2.2250738585072014E-308;
    kend = (ix0 + n) - 1;
    for (k = ix0; k <= kend; k++) {
      absxk = fabs(x_data[k - 1]);
      if (absxk > scale) {
        t = scale / absxk;
        y = 1.0 + y * t * t;
        scale = absxk;
      } else {
        t = absxk / scale;
        y += t * t;
      }
    }

    y = scale * sqrt(y);
  }

  return y;
}

static void eml_xrot(real_T x[9], int32_T ix0, int32_T iy0, real_T c, real_T s)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  real_T y;
  real_T b_y;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 3; k++) {
    y = c * x[ix];
    b_y = s * x[iy];
    x[iy] = c * x[iy] - s * x[ix];
    x[ix] = y + b_y;
    iy++;
    ix++;
  }
}

static void eml_xrotg(real_T *a, real_T *b, real_T *c, real_T *s)
{
  real_T roe;
  real_T absa;
  real_T absb;
  real_T scale;
  real_T ads;
  real_T bds;
  roe = *b;
  absa = fabs(*a);
  absb = fabs(*b);
  if (absa > absb) {
    roe = *a;
  }

  scale = absa + absb;
  if (scale == 0.0) {
    *s = 0.0;
    *c = 1.0;
    ads = 0.0;
    scale = 0.0;
  } else {
    ads = absa / scale;
    bds = absb / scale;
    ads = scale * sqrt(ads * ads + bds * bds);
    if (roe < 0.0) {
      ads = -ads;
    }

    *c = *a / ads;
    *s = *b / ads;
    if (absa > absb) {
      scale = *s;
    } else if (*c != 0.0) {
      scale = 1.0 / *c;
    } else {
      scale = 1.0;
    }
  }

  *a = ads;
  *b = scale;
}

static void eml_xscal(int32_T n, real_T a, real_T x_data[15], int32_T ix0)
{
  int32_T i7;
  int32_T k;
  i7 = (ix0 + n) - 1;
  for (k = ix0; k <= i7; k++) {
    x_data[k - 1] *= a;
  }
}

static void eml_xswap(real_T x[9], int32_T ix0, int32_T iy0)
{
  int32_T ix;
  int32_T iy;
  int32_T k;
  real_T temp;
  ix = ix0 - 1;
  iy = iy0 - 1;
  for (k = 0; k < 3; k++) {
    temp = x[ix];
    x[ix] = x[iy];
    x[iy] = temp;
    ix++;
    iy++;
  }
}

void eml_xgemm(int32_T n, const real_T A[9], const real_T B_data[15], real_T
               C_data[15])
{
  int32_T c;
  int32_T cr;
  int32_T ic;
  int32_T br;
  int32_T ar;
  int32_T ib;
  int32_T ia;
  if (n == 0) {
  } else {
    c = 3 * (n - 1);
    for (cr = 0; cr <= c; cr += 3) {
      for (ic = cr + 1; ic <= cr + 3; ic++) {
        C_data[ic - 1] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= c; cr += 3) {
      ar = -1;
      for (ib = br; ib + 1 <= br + 3; ib++) {
        if (B_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 3; ic++) {
            ia++;
            C_data[ic] += B_data[ib] * A[ia];
          }
        }

        ar += 3;
      }

      br += 3;
    }
  }
}

void pca2(real_T data_data[15], int32_T data_size[2], real_T signals_data[15],
          int32_T signals_size[2], real_T PC[9], real_T V_data[7], int32_T
          V_size[2])
{
  real_T mn[3];
  int32_T iy;
  int32_T ixstart;
  int32_T ia;
  int32_T ix;
  real_T s;
  int32_T k;
  int8_T mv[2];
  int8_T outsize[2];
  real_T tmp_data[15];
  int32_T Y_size[2];
  real_T Y_data[15];
  int32_T s_size[1];
  int32_T u_size[2];
  real_T u_data[25];
  int32_T b_tmp_data[7];
  int32_T c_tmp_data[7];
  real_T b_PC[9];

  /*  PCA2: Perform PCA using SVD. */
  /*  data - MxN matrix of input data */
  /*  (M dimensions, N trials) */
  /*  signals - MxN matrix of projected data */
  /*  PC - each column is a PC */
  /*  V - Mx1 matrix of variances */
  /*  subtract off the mean for each dimension */
  if (data_size[1] == 0) {
    for (iy = 0; iy < 3; iy++) {
      mn[iy] = 0.0;
    }
  } else {
    iy = -1;
    ixstart = -1;
    for (ia = 0; ia < 3; ia++) {
      ixstart++;
      ix = ixstart;
      s = data_data[ixstart];
      for (k = 2; k <= data_size[1]; k++) {
        ix += 3;
        s += data_data[ix];
      }

      iy++;
      mn[iy] = s;
    }
  }

  for (ixstart = 0; ixstart < 3; ixstart++) {
    mn[ixstart] /= (real_T)data_size[1];
  }

  mv[0] = 1;
  mv[1] = (int8_T)data_size[1];
  for (ixstart = 0; ixstart < 2; ixstart++) {
    outsize[ixstart] = (int8_T)((3 + -2 * ixstart) * mv[ixstart]);
  }

  if (outsize[1] == 0) {
  } else {
    iy = 0;
    for (ixstart = 1; ixstart <= (int8_T)data_size[1]; ixstart++) {
      ia = 0;
      for (k = 0; k < 3; k++) {
        tmp_data[iy] = mn[ia];
        ia++;
        iy++;
      }
    }
  }

  ia = 3 * data_size[1];
  for (ixstart = 0; ixstart < ia; ixstart++) {
    data_data[ixstart] -= tmp_data[ixstart];
  }

  /*  construct the matrix Y */
  s = sqrt((real_T)data_size[1] - 1.0);
  Y_size[0] = data_size[1];
  Y_size[1] = 3;
  for (ixstart = 0; ixstart < 3; ixstart++) {
    ia = data_size[1];
    for (iy = 0; iy < ia; iy++) {
      Y_data[iy + data_size[1] * ixstart] = data_data[ixstart + 3 * iy] / s;
    }
  }

  /*  SVD does it all */
  eml_xgesvd(Y_data, Y_size, u_data, u_size, mn, s_size, PC);
  for (ixstart = 0; ixstart < 2; ixstart++) {
    mv[ixstart] = (int8_T)Y_size[ixstart];
  }

  ia = mv[0] * 3;
  for (ixstart = 0; ixstart < ia; ixstart++) {
    Y_data[ixstart] = 0.0;
  }

  for (k = 0; k < s_size[0]; k++) {
    Y_data[k + mv[0] * k] = mn[k];
  }

  /*  calculate the variances */
  if (mv[0] == 0) {
    V_size[0] = 0;
    V_size[1] = 0;
  } else {
    iy = mv[0];
    if (iy <= 3) {
    } else {
      iy = 3;
    }

    iy = (mv[0] + 1) * (iy - 1);
    ix = div_s32_floor(iy, mv[0] + 1) + 1;
    ia = div_s32_floor(iy, mv[0] + 1);
    for (ixstart = 0; ixstart <= ia; ixstart++) {
      b_tmp_data[ixstart] = 1 + (mv[0] + 1) * ixstart;
    }

    for (ixstart = 0; ixstart < ix; ixstart++) {
      c_tmp_data[ixstart] = b_tmp_data[ixstart];
    }

    V_size[0] = ix;
    V_size[1] = 1;
    for (ixstart = 0; ixstart < ix; ixstart++) {
      V_data[ixstart] = Y_data[c_tmp_data[ixstart] - 1];
    }
  }

  ia = V_size[0] * V_size[1];
  for (ixstart = 0; ixstart < ia; ixstart++) {
    V_data[ixstart] *= V_data[ixstart];
  }

  /*  project the original data */
  signals_size[0] = 3;
  signals_size[1] = (int8_T)data_size[1];
  ia = 3 * (int8_T)data_size[1];
  for (ixstart = 0; ixstart < ia; ixstart++) {
    signals_data[ixstart] = 0.0;
  }

  for (ixstart = 0; ixstart < 3; ixstart++) {
    for (iy = 0; iy < 3; iy++) {
      b_PC[iy + 3 * ixstart] = PC[ixstart + 3 * iy];
    }
  }

  eml_xgemm(data_size[1], b_PC, data_data, signals_data);
}

/* End of code generation (pca2.c) */
