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

    char path[1024];
    printf("Path: ");
    scanf("%1023s", path);

    dup2(pfd[1], 1);
    execlp("ls", "ls", "-aF", path, NULL);
  } else {
    close(pfd[1]);
    dup2(pfd[0], 0);
    execlp("grep", "grep", "/", NULL);
  }

  return EXIT_SUCCESS;
}