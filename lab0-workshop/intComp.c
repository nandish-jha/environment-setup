/*
NANDISH JHA NAJ474 11282001
*/

/* returns -1 if first < second
 * returns 0 if first == second
 * returns 1 if first > second
 */

#include <qsort.h>

int compareInt(void *first, void *second)
{

 /* fill in details of comparing 2 integers */
 /* look at complexComp.c for the idea behind this solution */

  int a = atoi((char *)first);
  int b = atoi((char *)second);

  if (a < b) return -1;
  else if (a == b) return 0;
  else if (a > b) return 1;

 return 0;  
}