#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  pid_t child_pid = fork();

  if (child_pid == 0) {
    // the child process
    signal(SIGINT, SIG_DFL);
    for (int i = 1; i <= 20000000; i++) {
      if (i % 100 == 0) {
        printf("I'm still alive.\n");
      }
    }
    printf("All done! Nobody dare to stop me! \n");
  } else {
    // the parent process
    // wait for 2 second to so that the child is executed first
    usleep(2000000);
    printf("Parent will send a dispatch to terminate child...\n");
    // send SIGINT to the child process
    kill(child_pid, SIGINT);
    printf("Dispatched!\n");
  }

  return EXIT_SUCCESS;
}