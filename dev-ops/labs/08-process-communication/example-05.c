#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  mkfifo("mypipe", 0644); // create a named pipe

  if (!fork()) {
    system("ls > mypipe");
  } else {
    sleep(1);
    system("wc -l < mypipe");
  }

  return EXIT_SUCCESS;
}