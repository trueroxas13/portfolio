#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h> /* defines fork() and pid_t */

int main(void) {
  printf("Just one process so far\n");
  printf("Forking...\n");

  pid_t pid;
  pid = fork();

  if (pid < 0) {
    printf("fork failed\n");
  }

  if (pid == 0) {
    printf("I'm the child\n");
  }

  if (pid > 0) {
    printf("I'm the parent with child ID = %d\n", pid);
  }

  return EXIT_SUCCESS;
}