#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

void handler(int sig) {
  printf("Received signal no (%d)\n", sig);
  system("date");
  printf("Parent %d killed me\n", getppid());
  exit(EXIT_FAILURE);
}

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
    close(pfd[1]);

    int sig;
    read(pfd[0], &sig, sizeof(sig));

    if (sig == 9 || sig == 19) { // SIGKILL or SIGSTOP
      signal(sig, SIG_DFL);
    } else if (sig == 1 | sig == 15) {
      signal(sig, handler);
    } else {
      signal(sig, SIG_IGN);
    }

    while (true) {
      printf("I am child %d with parent %d\n", getpid(), getppid());
      /* fflush(stdout); */
    }
    close(pfd[0]);
  } else {
    close(pfd[0]);

    int sig;
    do {
      printf("Signal: ");
      scanf("%d", &sig);
    } while (sig < 1 || sig > 31);

    write(pfd[1], &sig, sizeof(sig));
    sleep(1);

    kill(pid, sig);
    wait(NULL);

    close(pfd[1]);
    printf("I am parent %d with child %d\n", getpid(), pid);
    exit(EXIT_SUCCESS);
  }

  return 0;
}