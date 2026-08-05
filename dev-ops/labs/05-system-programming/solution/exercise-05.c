#include <stdio.h>
#include <stdlib.h>

struct StudentRecord {
  int points;
  char grade[2];
  char name[51];
  char id[5];
};

void print(struct StudentRecord);
float average_points(struct StudentRecord[], int);

int main(void) {
  struct StudentRecord records[3] = {{12, "A", "John Doe", "1321"},
                                     {6, "C", "Dane Doe", "8765"},
                                     {9, "B", "Jane Doe", "1231"}

  };

  for (int index = 0; index < 3; index += 1) {
    print(records[index]);
  }
  printf("Average points: %.2f\n", average_points(records, 3));

  return EXIT_SUCCESS;
}

void print(struct StudentRecord record) {
  printf("%s: %s %d (%s)\n", record.id, record.name, record.points,
         record.grade);
}

float average_points(struct StudentRecord records[], int size) {
  float total = 0.0f;
  for (int index = 0; index < 3; index += 1) {
    total += records[index].points;
  }
  return total / size;
}