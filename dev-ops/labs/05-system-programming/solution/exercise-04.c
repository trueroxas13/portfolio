#include <stdio.h>
#include <stdlib.h>

struct StudentRecord {
  float points;
  char grade[2];
  char name[51];
  char id[5];
};

void print(struct StudentRecord);

int main(void) {
  struct StudentRecord record1 = {12, "A", "John Doe", "1321"},
                       record2 = {6, "C", "Dane Doe", "8765"},
                       record3 = {9, "B", "Jane Doe", "1231"};
  print(record1);
  print(record2);
  print(record3);

  return EXIT_SUCCESS;
}

void print(struct StudentRecord record) {
  printf("%s: %s %.2f (%s)\n", record.id, record.name, record.points,
         record.grade);
}