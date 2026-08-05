#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();
  if (pid < 0) {
    perror("Fork failed.");
    exit(EXIT_FAILURE);
  }

  if (!pid) {
    signal(SIGINT, SIG_IGN);
    /* signal(SIGSTOP, SIG_IGN); */
    signal(SIGKILL, SIG_IGN);

    for (int i = 1; i <= 20000000; i++) {
      if (i % 100 == 0) {
        printf("I'm still alive...\n");
      }
    }
    printf("All done! Nobody dare to stop me!\n");
  } else {
    usleep(1000);
    printf("Sending a signal to terminate child...\n");
    printf("Sending SIGINT\n");
    if (!kill(pid, SIGINT)) {
      printf("SIGINT sent\n");

      printf("Sending SIGKILL\n");
      if (!kill(pid, SIGKILL)) {
        printf("SIGKILL sent\n");
      }
    }
  }

  return EXIT_SUCCESS;
}