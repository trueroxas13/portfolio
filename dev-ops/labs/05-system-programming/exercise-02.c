#include <stdio.h>
#include <stdlib.h>

void increment(int *);

int main(void) {
  int x = 4;
  increment(x);
  printf("x = %d\n", x);

  return EXIT_SUCCESS;
}

void increment(int *n) { *n = *n + 1; }