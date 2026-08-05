#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  char input[1024];
  char *commands[3];

  printf("Three piped commands: ");
  // scanf("%1023[^\n]", input);
  fgets(input, 1024, stdin); // for example: ls | wc | tee
  input[strcspn(input, "\n")] = '\0';
  // input[strcspn(input, "\r\n")] = '\0'; // works for LF, CR, CRLF, and LFCR
  // input[strlen(input) - 1] = '\0';
  printf("%s\n", input);

  char *token = strtok(input, " |");
  int index = 0;
  while (token) {
    printf("Command #%d: %s\n", index, token);
    commands[index] = token;
    token = strtok(NULL, " |");
    ++index;
  }

  pid_t pid = fork();
  if (pid < 0) {
    perror("Fork failed.");
    exit(EXIT_FAILURE);
  } else if (pid) {
    int fd1 = open("pipe1", O_WRONLY | O_CREAT, 0644);
    dup2(fd1, 1);
    execlp(commands[0], commands[0], NULL);
  } else {
    pid_t pid = fork();
    if (pid < 0) {
      perror("Fork failed.");
      exit(EXIT_FAILURE);
    } else if (pid) {
      int fd1 = open("pipe1", O_RDONLY);
      dup2(fd1, 0);
      int fd2 = open("pipe2", O_WRONLY | O_CREAT, 0644);
      dup2(fd2, 1);
      execlp(commands[1], commands[1], NULL);
    } else {
      wait(NULL);
      int fd2 = open("pipe2", O_RDONLY);
      dup2(fd2, 0);
      execlp(commands[1], commands[2], NULL);
    }
  }

  return EXIT_SUCCESS;
}