#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  printf("Process %d with parent %d\n", getpid(), getppid());

  if (argc < 2) {
    char pid[50], ppid[50];
    sprintf(pid, "%d", getpid());
    sprintf(ppid, "%d", getppid());

    printf("Executing helper using execl()\n\n");

    execl("./exercise-04", pid, ppid, NULL);

    perror("execl failed to run helper"); /* call has failed */
  } else {
    printf("PID: %s, PPID: %s\n", argv[0], argv[1]);
  }

  return EXIT_SUCCESS;
}