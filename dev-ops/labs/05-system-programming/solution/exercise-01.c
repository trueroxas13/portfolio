#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int array[5] = {1, 2, 3, 4, 5};

  for (int index = 0; index < 5; index += 1) {
    printf("array[%d] = %d\n", index, array[index]);
  }

  return EXIT_SUCCESS;
}