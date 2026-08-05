#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void my_handler(int sig) {
  printf("You killed me...\n");
  printf("Signal no = (%d)\n", sig);
  exit(1);
}

int main(void) {
  pid_t pid = fork();

  if (pid == 0) {
    // child process
    signal(SIGINT, my_handler);
    while (1) {
      printf("Running...\n");
    }
  } else {
    // parent will run this block
    sleep(2);
    printf("Parent will send a dispatch to terminate child...\n");
    kill(pid, SIGINT);
    exit(0);
  }

  return EXIT_SUCCESS;
}