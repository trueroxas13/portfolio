#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  int pfd[2];
  if (pipe(pfd) == -1) {
    perror("Pipe failed.");
    exit(EXIT_FAILURE);
  }

  pid_t pid = fork();
  if (pid < 0) {
    perror("Fork failed.");
    exit(EXIT_FAILURE);
  }

  if (!pid) {
    close(pfd[0]);

    close(1);
    dup(pfd[1]);
    execlp("ps", "ps", "-Ao", "user", NULL);
  } else {
    close(pfd[1]);

    close(0);
    dup(pfd[0]);
    execlp("grep", "grep", "-c", getlogin(), NULL);
  }

  return EXIT_SUCCESS;
}