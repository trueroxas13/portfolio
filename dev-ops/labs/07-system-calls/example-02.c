#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  printf("Just one process so far\n");
  printf("Forking...\n");

  pid_t pid = fork();

  if (pid < 0) {
    printf("fork failed\n");
    exit(1); /* terminating with error */
  } else if (pid == 0) {
    printf("I'm the child\n");
    exit(0); /* terminating normally */
  } else {
    printf("I'm the parent with child ID = %d\n", pid);
  }

  printf("%d terminated\n", getpid());
  printf("List of processes:\n");
  system("ps -f");
  return EXIT_SUCCESS;
}