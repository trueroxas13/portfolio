#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid;
  int count;

  printf("Enter the number of times to fork: \n");
  scanf("%d", &count);

  for (int i = 0; i < count; ++i) {
    pid = fork();
    if (pid < 0) {
      perror("fork failed!");
      exit(1);
    }

    long rand = (random() % 255) + 1;
    if (!pid) {
      printf("Child %d is still sleeping...\n", getpid());
      sleep(2);
      exit(rand);

    } else {
      int status;
      while (!waitpid(pid, &status, WNOHANG)) {
        printf("Parent %d is still waiting for %d...\n", getpid(), pid);
        sleep(1);
      }

      if (WIFEXITED(status)) {
        printf("Exit status from child %d was %d\n", pid, WEXITSTATUS(status));
      }
    }
  }

  return EXIT_SUCCESS;
}