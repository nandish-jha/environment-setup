/*
NANDISH JHA NAJ474 11282001
*/
#ifndef QSORT_H
#define QSORT_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
  double real;
  double imag;
} Complex;

typedef int (*Comparator)(void*, void*);
void myQsort(void *v[], int left, int right, Comparator comp);
void swap(void *v[], int, int);

int compareInt(void *first, void *second);
int compareDouble(void *first, void *second);
int compareComplex(void *first, void *second);

int readlines(char *lineptr[], int maxlines);
void writelines(char *lineptr[], int nlines);

#endif