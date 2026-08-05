#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();

  if (pid == 0) {
    /* child */
    printf("Child: sleeping...\n");
    sleep(5);
    printf("Child: waking... and exiting\n");
    exit(0);
  } else if (pid > 0) {
    printf("Parent: waiting for child\n");
    wait(NULL);
    printf("Parent: child woke up\n");
  }

  return EXIT_SUCCESS;
}