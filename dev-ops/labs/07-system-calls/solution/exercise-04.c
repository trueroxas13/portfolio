#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  int count = 5;

  while (count--) {
    if (!fork()) {
      exit(0);
    }
  }

  while (wait(NULL) != -1) {
    printf("Child finished.\n");
  }

  return EXIT_SUCCESS;
}