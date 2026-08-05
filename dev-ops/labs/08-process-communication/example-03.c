#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(void) {
  char *fname = "hellofiles";
  int fd1 = open(fname, O_WRONLY | O_CREAT, 0644);
  char *text = "Hello world!\n";
  write(fd1, text, strlen(text) + 1);
  close(fd1);

  return EXIT_SUCCESS;
}