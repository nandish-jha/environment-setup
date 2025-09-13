/*
NANDISH JHA NAJ474 11282001
*/

#include <qsort.h>

/* returns -1 if first < second
 * returns 0 if first == second
 * returns 1 if first > second
 */
int compareDouble(void *first, void *second)
{
  /* fill in the details of comparing 2 doubles */
  double a = atof((char *)first);
  double b = atof((char *)second);
  
  if (a < b) return -1;
  else if (a == b) return 0;
  else if (a > b) return 1;

  return 0;
}
