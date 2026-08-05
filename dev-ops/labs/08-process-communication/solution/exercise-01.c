#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

const int BUFFER_SIZE = 4096;

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

  char buffer[BUFFER_SIZE];
  if (pid) {
    close(pfd[0]);

    printf("Input: ");
    while (fgets(buffer, BUFFER_SIZE, stdin)) { // ^D for EOF
      write(pfd[1], buffer, strlen(buffer) + 1);
      sleep(1);
      printf("Input: ");
    }

    close(pfd[1]);
    wait(NULL);
  } else {
    close(pfd[1]);

    while (read(pfd[0], buffer, BUFFER_SIZE)) {
      printf("Output: %s", buffer);
      fflush(stdout);
    }

    close(pfd[0]);
  }

  return EXIT_SUCCESS;
}