#include <stdio.h>
#include <stdlib.h>

void swap(int *, int *);

int main(void) {
  int a, b;

  printf("a = ");
  scanf("%d", &a);
  printf("b = ");
  scanf("%d", &b);

  printf("Before: a = %d, b = %d\n", a, b);
  swap(&a, &b);
  printf("After: a = %d, b = %d\n", a, b);

  return EXIT_SUCCESS;
}

void swap(int *a, int *b) {
  int c = *a;
  *a = *b;
  *b = c;
}