#include <stdio.h>
#include <stdlib.h>

int main(void) {
  printf("Executing 'ls -l' using system()\n\n");
  printf("\nThe returned value is %d\n", system("ls -l"));

  printf("\nExecuting 'ts -e' using system()\n\n");
  printf("\nThe returned value is %d\n", system("ts -e"));

  return EXIT_SUCCESS;
}