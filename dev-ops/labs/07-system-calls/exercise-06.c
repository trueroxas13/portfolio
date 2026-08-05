#include <stdio.h>
#include <stdlib.h>

int main(void) {
  printf("Executing the command 'ls'...\n");
  int value = system("ls");

  printf("The returned value is: %d\n", value);
  return EXIT_SUCCESS;
}