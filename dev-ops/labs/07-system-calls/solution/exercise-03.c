#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();

  if (!pid) {
    printf("Child: sleeping...\n");
    sleep(5);
    printf("Child: waking... and exiting\n");
    exit(0);
  } else if (pid > 0) {
    printf("Parent: waiting for child (%d)\n", pid);
    pid_t wpid = wait(NULL);
    printf("Parent: child (%d) woke up\n", wpid);
  }

  return EXIT_SUCCESS;
}