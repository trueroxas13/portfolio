#include <stdio.h>
#include <stdlib.h>

int main(void) {
  char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
  printf("Greeting message: %s\n", greeting);
  return EXIT_SUCCESS;
}