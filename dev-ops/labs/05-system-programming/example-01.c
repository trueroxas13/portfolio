#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int num1, num2, sum;
  printf("Enter the first number: ");
  scanf("%d", &num1);

  /* %d means the type of the identifier, which is an integer */
  /* &num1 means the address of the integer in memory */

  printf("Enter the second number: ");
  scanf("%d", &num2);

  sum = num1 + num2;
  printf("Sum is %d\n", sum);

  return EXIT_SUCCESS;
}