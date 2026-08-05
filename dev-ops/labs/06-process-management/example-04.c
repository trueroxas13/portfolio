#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  printf("Original process ID = %d\n", getpid());
  printf("Forking...\n");

  pid_t pid = fork();

  if (pid != 0) {
    printf("I am the parent process with PID = %d and my child's PID = %d\n",
           getpid(), pid);
  } else {
    /* pid is zero, so child process is running this part */
    printf("I am the child process with PID = %d and PPID = %d\n", getpid(),
           getppid());
    sleep(5); /* allows the parent to execute first */
  }

  /* both processes are running this part */
  printf("PID = %d terminated\n", getpid());
  return EXIT_SUCCESS;
}