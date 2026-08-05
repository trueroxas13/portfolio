#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  char str1[13] = "Hello";
  char str2[13] = " world!";
  char str3[13];
  int len;

  /* copy str1 into str3 */
  strcpy(str3, str1);
  printf("strcpy(str3, str1): %s\n", str3);

  /* concatenates str1 and str2 */
  strcat(str1, str2);
  printf("strcat(str1, str2): %s\n", str1);

  /* total length of str1 after concatenation */
  len = strlen(str1);
  printf("strlen(str1): %d\n", len);

  return EXIT_SUCCESS;
}