#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();

  if (pid < 0) {
    printf("fork failed\n");
    exit(1);
  } else if (pid == 0) {
    printf("Child %d is sleeping...\n", getpid());
    sleep(5);
    exit(0);
  }

  /* this is the parent side */
  int status;
  while (waitpid(pid, &status, WNOHANG) == 0) {
    printf("%d Still waiting...\n", getpid());
    sleep(1);
  }

  /* test to see how the child died */
  if (WIFEXITED(status)) {
    int exit_status = WEXITSTATUS(status);
    printf("Exit status from %d was %d \n", pid, exit_status);
  }

  return EXIT_SUCCESS;
}