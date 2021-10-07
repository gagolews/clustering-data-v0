/* Copyright (C) 2015 Marek Gagolewski
 *
 * ------------------------------------------------------------------------
 *
 * This is Rcpp code - for use within the R environment.
 *
 * ------------------------------------------------------------------------
 *
 * hausdorff_dist(X, Y) - computes the Hausdorff (Euclidean-based)
 * distance between two sets of points in R^2, each represented as 2-column
 * numeric matrix.
 *
 * hausdorff_distmatrix(P) - given a list of 2-column matrices,
 * representing a number of sets of points in R^2,
 * computes the distance matrix between each set of points.
 *
 * ------------------------------------------------------------------------
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#include <Rcpp.h>
using namespace Rcpp;
#include <omp.h>
// [[Rcpp::plugins(openmp)]]

inline double dist(double x1, double x2, double y1, double y2) {
   return sqrt((x1-y1)*(x1-y1)+(x2-y2)*(x2-y2));
   // return fabs(x1-y1)+fabs(x2-y2);
}


double hausdorff_distinternal(double* X, int nx, double* Y, int ny) {
   double maxXY = 0.0;
   for (int i=0; i<nx; ++i) { // for all x in X
      double min = INFINITY;
      for (int j=0; j<ny; ++j) { // for all y in Y
         double cur = dist(X[i], X[i+nx], Y[j], Y[j+ny]);
         if (cur < min) min = cur;
      }
      if (min > maxXY) maxXY = min;
   }

   double maxYX = 0.0;
   for (int j=0; j<ny; ++j) { // for all y in Y
      double min = INFINITY;
      for (int i=0; i<nx; ++i) {  // for all x in X
         double cur = dist(Y[j], Y[j+ny], X[i], X[i+nx]);
         if (cur < min) min = cur;
      }
      if (min > maxYX) maxYX = min;
   }

   return (maxXY>maxYX)?(maxXY):(maxYX);
}


// [[Rcpp::export]]
double hausdorff_dist(NumericMatrix X, NumericMatrix Y) {
   if (X.ncol() != 2 || Y.ncol() != 2) stop("wrong # of columns!");
   int nx = X.nrow();
   int ny = Y.nrow();
   return hausdorff_distinternal(REAL((SEXP)X), nx, REAL((SEXP)Y), ny);
}


// [[Rcpp::export]]
NumericMatrix hausdorff_distmatrix(List P) {
   int n = P.size();
   NumericMatrix out(n, n);

   std::vector<double*> ptr(n);
   std::vector<int> nrow(n);
   for (int i=0; i<n; ++i) {
      ptr[i] = REAL((SEXP)P[i]);
      nrow[i] = LENGTH((SEXP)P[i])/2;
   }

#pragma omp parallel for schedule(dynamic)
   for (int j=0; j<n-1; ++j) {
      for (int i=j+1; i<n; ++i) {
         out(i, j) =  hausdorff_distinternal(ptr[i], nrow[i], ptr[j], nrow[j]);
      }
   }
   return out;
}
