#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int fact = 1;            // this data is shared by thread(s)
void *runp(void *param); // the thread function

int main(int argc, char *argv[]) {
  if (argc != 2) { // check number of arguments
    printf("usage: %s <integer value>\n", argv[0]);
    return -1;
  }

  if (atoi(argv[1]) < 0) { // check second passed argument
    printf("%d Must be >= 0\n", atoi(argv[1]));
    return -1;
  }

  pthread_t tid;            // the thread identifier
  pthread_attr_t attr;      // set of thread attributes
  pthread_attr_init(&attr); // get the default thread attributes
  pthread_create(&tid, &attr, runp, argv[1]); // create the thread
  pthread_join(tid, NULL);                    // wait for the thread to exit

  printf("%d! = %d\n", atoi(argv[1]), fact);
  return EXIT_SUCCESS;
}

void *runp(void *param) { // the thread will begin control in this function
  int i, num = atoi(param);
  for (i = num; i > 0; i--) {
    fact *= i;
  }
  pthread_exit(0); // thread exit
}