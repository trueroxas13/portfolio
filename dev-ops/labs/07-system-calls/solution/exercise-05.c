#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  int count;
  printf("# children: ");
  scanf("%d", &count);

  while (count) {
    pid_t child = fork();
    if (!child) {
      srand(getpid());
      sleep(rand() % 5);
      exit(rand() % 128);
    }
    count -= 1;
  }

  int status;
  pid_t child = wait(&status);
  while (child != -1) {
    if (WIFEXITED(status)) {
      printf("%d %d\n", child, WEXITSTATUS(status));
    }
    child = wait(&status);
  }

  return EXIT_SUCCESS;
}