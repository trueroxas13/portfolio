#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

struct pargs {
  int k, *arr, *sum;
};
typedef struct pargs pargs;

void *run(void *arg) {
  pargs args = *(pargs *)arg;
  args.sum[args.k] =
      args.arr[args.k] + (args.k != 0 ? args.arr[args.k - 1] : 0);
  pthread_exit(EXIT_SUCCESS);
}

int main(int argc, char *argv[]) {
  int n = argc - 1;
  if (!n) {
    return EXIT_FAILURE;
  }

  int *arr = (int *)malloc(n * sizeof(int));
  for (int k = 0; k < n; ++k) {
    sscanf(argv[k + 1], "%d", arr + k);
  }
  int *sum = (int *)malloc(n * sizeof(int));
  pargs *args = (pargs *)malloc(n * sizeof(pargs));

  pthread_t tid[n];
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  for (int k = 0; k < n; ++k) {
    args[k].k = k;
    args[k].arr = arr;
    args[k].sum = sum;
    pthread_create(&tid[k], NULL, run, (void *)&args[k]);
  }

  for (int k = 0; k < n; ++k) {
    pthread_join(tid[k], NULL);
  }

  printf("[");
  for (int k = 0; k < n; ++k) {
    printf("%s%d", k == 0 ? "" : ", ", arr[k]);
  }
  printf("] -> [");
  for (int k = 0; k < n; ++k) {
    printf("%s%d", k == 0 ? "" : ", ", sum[k]);
  }
  printf("]\n");

  free(arr);
  free(sum);

  return EXIT_SUCCESS;
}