#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int *product;
struct pargs {
  int x, k;
};
typedef struct pargs pargs;

void *run(void *arg) {
  pargs args = *(pargs *)arg;
  product[args.k] = args.x * (args.k + 1);
  pthread_exit(EXIT_SUCCESS);
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    return EXIT_FAILURE;
  }

  int x, n;
  sscanf(argv[1], "%d", &x);
  sscanf(argv[2], "%d", &n);

  if (x < 0 || n <= 0) {
    return EXIT_FAILURE;
  }

  product = (int *)malloc(n * sizeof(int));
  pargs *args = (pargs *)malloc(n * sizeof(pargs));

  pthread_t tid[n];
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  for (int k = 0; k < n; ++k) {
    args[k].k = k;
    args[k].x = x;
    pthread_create(&tid[k], NULL, run, (void *)&args[k]);
  }

  for (int k = 0; k < n; ++k) {
    pthread_join(tid[k], NULL);
    printf("%d * %d = %d\n", x, k + 1, product[k]);
  }

  free(product);
  free(args);

  return EXIT_SUCCESS;
}