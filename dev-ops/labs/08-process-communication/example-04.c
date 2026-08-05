#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

char *phrase = "Write this in your pipe and read it";

int main(void) {
  if (!fork()) {
    int fd = open("mypipe", O_WRONLY | O_CREAT, 0600);
    write(fd, phrase, strlen(phrase) + 1);
    close(fd);
  } else {
    wait(NULL);
    char buf[100];
    int fd = open("mypipe", O_RDONLY);
    read(fd, buf, 100);
    printf("%s\n", buf);
    close(fd);
  }

  return EXIT_SUCCESS;
}