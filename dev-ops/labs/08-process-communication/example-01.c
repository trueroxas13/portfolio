#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define SIZE 1024

int main(void) {
  int pfd[2];
  int pid;
  char buf[SIZE];

  if (pipe(pfd) == -1) {
    perror("pipe failed");
    exit(1);
  }

  if ((pid = fork()) < 0) {
    perror("fork failed");
    exit(2);
  } else if (pid == 0) { // child
    close(pfd[1]);
    while ((read(pfd[0], buf, SIZE)) != 0) {
      printf("Child: parent sent '%s'\n", buf);
    }
    close(pfd[0]);
  } else { // parent
    close(pfd[0]);
    strcpy(buf, "hello...");
    write(pfd[1], buf, strlen(buf) + 1); // +1 to include a null terminator
    close(pfd[1]);
    wait(NULL); // to make sure that the parent will finish after the child
  }

  // exit(0);
  return EXIT_SUCCESS;
}