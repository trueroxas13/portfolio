#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* defines fork() and pid_t */

int main(void) {
  int number = 0;
  pid_t pid = fork();

  printf("Process before: %d\n", number);

  if (pid >= 0) {
    number = pid ? 1 : -1;
    printf("Process after: %d\n", number);
  }

  return EXIT_SUCCESS;
}