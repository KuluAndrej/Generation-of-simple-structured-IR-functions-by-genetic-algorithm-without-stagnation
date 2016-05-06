#include <math.h>
#include "mex.h"
#include <stdlib.h>
#include <stdio.h>
#define B_OUT plhs[0]
#define A_IN prhs[0]
#define P_IN prhs[1]

  
int  _mergeSort(double arr[], double temp[], int left, int right);
int merge(double arr[], double temp[], int left, int mid, int right);
int mergeSort(double arr[], int array_size)
{
    double *temp = (double *)malloc(sizeof(double)*array_size);
    return _mergeSort(arr, temp, 0, array_size - 1);
}
  
int _mergeSort(double arr[], double temp[], int left, int right) {
  int mid, inv_count = 0;
  if (right > left) {
    mid = (right + left)/2;
    inv_count  = _mergeSort(arr, temp, left, mid);
    inv_count += _mergeSort(arr, temp, mid+1, right);
  
    inv_count += merge(arr, temp, left, mid+1, right);
  }
  return inv_count;
}
 
int merge(double arr[], double temp[], int left, int mid, int right) {
  int i, j, k;
  int inv_count = 0;
  
  i = left; 
  j = mid;  
  k = left; 
  while ((i <= mid - 1) && (j <= right)) {
    if (arr[i] <= arr[j]) {
      temp[k++] = arr[i++];
    }
    else {
      temp[k++] = arr[j++];
  
      inv_count = inv_count + (mid - i);
    }
  }
  
  while (i <= mid - 1)
    temp[k++] = arr[i++];
  
  while (j <= right)
    temp[k++] = arr[j++];
  
  for (i=left; i <= right; i++)
    arr[i] = temp[i];
  
  return inv_count;
}
  
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  /*
  //declare variables   
  mxArray *a_in_m, *b_in_m, *c_out_m, *d_out_m;   
  const mwSize *dims;   
  double *a, *b, *c, *d;   
  int dimx, dimy, numdims;      
  //associate inputs   
  a_in_m = mxDuplicateArray(prhs[0]);   
  b_in_m = mxDuplicateArray(prhs[1]);      
  //figure out dimensions   
  dims = mxGetDimensions(prhs[0]);   
  numdims = mxGetNumberOfDimensions(prhs[0]);   
  dimy = (int)dims[0]; 
  dimx = (int)dims[1];      
  //associate outputs   
  c_out_m = plhs[0] = mxCreateDoubleMatrix(dimy,dimx,mxREAL);   
  d_out_m = plhs[1] = mxCreateDoubleMatrix(dimy,dimx,mxREAL); 
  */
  
  double * y, *P;
  int mrows,ncols, n;
  
  mrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[0]);
  n = mrows>ncols?mrows:ncols;
  P = mxGetPr(prhs[0]);
  plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);
  y = mxGetPr(plhs[0]);
  *y = mergeSort(P, n); 

  return;
}
