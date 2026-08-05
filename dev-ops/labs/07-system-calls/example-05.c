#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();

  if (pid != 0) {
    printf("Parent will never stop\n");
    while (1) {
      sleep(1000);
    }
    /* never terminate and never execute a wait() */
    wait(NULL);
  } else {
    printf("Child is waiting for the parent \n");
    exit(42);
  }

  return EXIT_SUCCESS;
}