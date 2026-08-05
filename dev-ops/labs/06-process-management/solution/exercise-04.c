#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  float array[6], product_negative = 1, count_negative = 0, count_positive = 0,
                  total_positive = 0, average_positive;

  printf("Please Enter 6 values:\n");
  for (int i = 0; i < 6; ++i) {
    scanf("%f", &array[i]);
  }

  for (int i = 0; i < 6; ++i) {
    printf("array[%d] = %.2f\n", i, array[i]);
  }

  pid_t pid = fork();
  if (pid < 0) {
    printf("fork() failed!");
  }

  if (pid) {
    printf("I am the parent\n");

    for (int i = 0; i < 6; ++i) {
      if (array[i] > 0) {
        total_positive += array[i];
        count_positive++;
      }
    }

    if (count_positive > 0) {
      average_positive = total_positive / count_positive;
      printf("Total positive = %.2f\nAverage positive = %.2f\n", total_positive,
             average_positive);
    } else {
      printf("No positive numbers\n");
    }
  } else {
    printf("I am the child\n");

    for (int i = 0; i < 6; ++i) {
      if (array[i] < 0) {
        product_negative *= array[i];
        count_negative++;
      }
    }

    if (count_negative > 0) {
      printf("Product negative = %.2f\n", product_negative);
    } else {
      printf("No negative numbers\n");
    }
  }

  return EXIT_SUCCESS;
}