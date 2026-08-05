#include <math.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct pargs {
  int k;
  float *vals, (*f)(float), a, dx;
} pargs;

void *run(void *arg) {
  pargs args = *(pargs *)arg;
  args.vals[args.k] = args.dx * 0.5f *
                      (args.f(args.a + args.k * args.dx) +
                       args.f(args.a + (args.k + 1) * args.dx));
  pthread_exit(EXIT_SUCCESS);
}

float f(float x) { return expf(-powf(x, 2)); }

int main(int argc, char *argv[]) {
  if (argc != 4) {
    return EXIT_FAILURE;
  }

  float a, b;
  int n;
  sscanf(argv[1], "%f", &a);
  sscanf(argv[2], "%f", &b);
  sscanf(argv[3], "%d", &n);

  float *vals = (float *)malloc(n * sizeof(float));
  pargs *args = (pargs *)malloc(n * sizeof(pargs));

  pthread_t tid[n];
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  float dx = (b - a) / n;
  for (int k = 0; k < n; ++k) {
    args[k] = (pargs){k, vals, f, a, dx};
    pthread_create(&tid[k], NULL, run, (void *)&args[k]);
  }

  float result = 0.f;
  for (int k = 0; k < n; ++k) {
    pthread_join(tid[k], NULL);
    result += vals[k];
  }
  printf("%f\n", result);
  printf("%f\n", result * result); // ./exercise-03 -1000 +1000 10000

  free(vals);
  free(args);

  return EXIT_SUCCESS;
}