#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  printf("Process %d with parent %d\n", getpid(), getppid());
  printf("Executing 'ps' using execl()\n\n");

  execl("/bin/ps", "ps", NULL);

  perror("execl failed to run 'ps'"); /* call has failed */
  return EXIT_SUCCESS;
}