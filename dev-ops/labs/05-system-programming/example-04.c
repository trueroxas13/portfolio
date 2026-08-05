#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int x = 3;
  int *y;
  y = &x;
  (*y)++;
  printf("x = %d\n", x);

  return EXIT_SUCCESS;
}