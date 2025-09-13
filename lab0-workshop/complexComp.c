/*
NANDISH JHA NAJ474 11282001
*/

#include <qsort.h>

/* returns -1 if first < second
 * returns 0 if first == second
 * returns 1 if first > second

 * Note that these void pointers as input are strings. That's 
 * why strtol is being used to get the right values in the
 * structure.

 * a complex number is composed of 2 fields: real and imaginary, which are 
 * both doubles
 */
int compareComplex(void *first, void *second)
{
  Complex cFirst;
  char *index;
  Complex cSnd;

  int sizeFirst, sizeSecond;

  cFirst.real = strtod(first, &index);
  cFirst.imag = strtod(index, NULL);
  cSnd.real = strtod(second, &index);
  cSnd.imag = strtod(index, NULL);

  sizeFirst = sqrt(cFirst.real * cFirst.real + cFirst.imag * cFirst.imag);
  sizeSecond = sqrt(cSnd.real * cSnd.real + cSnd.imag * cSnd.imag);

  if (sizeFirst < sizeSecond)
    return(-1);
  else if (sizeFirst > sizeSecond)
    return(1);
  else
    return (0);
}
