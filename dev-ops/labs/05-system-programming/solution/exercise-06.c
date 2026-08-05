#include <stdio.h>
#include <stdlib.h>

struct PCB {
  int pid;
  char status[10];
  int pc;
  char reg[5];
  float cpu_time;
};

void input(struct PCB *pcb) {
  printf("Process Identifier: ");
  scanf("%d", &pcb->pid);
  printf("Status: ");
  scanf("%9s", &pcb->status);
  printf("Program Counter: ");
  scanf("%x", &pcb->pc);
  printf("Reg: ");
  scanf("%4s", &pcb->reg);
  printf("CPU Time: ");
  scanf("%f", &pcb->cpu_time);
}

void print(struct PCB pcb) {
  printf("%d %s 0x%x %s %.2f", pcb.pid, pcb.status, pcb.pc, pcb.reg,
         pcb.cpu_time);
}

int main(void) {
  int size = 1;
  struct PCB pcbs[size];

  for (int index = 0; index < size; index += 1) {
    input(&pcbs[index]);
  }

  for (int index = 0; index < size; index += 1) {
    print(pcbs[index]);
  }

  return EXIT_SUCCESS;
}