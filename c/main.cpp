#include <stdio.h>

typedef struct {
  int size;
  int duration;
} task;

void print_memory(char * pmemory, int memory_size){
  for (int i = 0; i < memory_size; i++){
    printf("%c", *(pmemory + i));
  }
}

void print_tasks(char * ptasks, int tasks_qnt){
  for (int i = 0; i < tasks_qnt; i++){
    printf("%c", *(ptasks + i));
  }
}

void fill_tasks(char * ptasks, int tasks_qnt){
  for (int i = 0; i < tasks_qnt; i++){
    *(ptasks + i) = '#';
  }
}

void fill_memory(char * pmemory, int memory_size){
  for (int i = 0; i < memory_size; i++){
    *(pmemory + i) = '_';
  }
}

void generate_task(char * tasks){
  *(tasks + 1) = '%';
  *(tasks + 5) = '0';
  *(tasks + 2) = '&';
}

int main(){
  int memory_size = 100;
  int tasks_qnt = 10;
  char memory[memory_size];
  char tasks[tasks_qnt];
  char * pmemory;
  char * ptasks;
  pmemory = memory;
  ptasks = tasks;

 fill_memory(pmemory, memory_size);
 fill_tasks(ptasks, tasks_qnt);
 print_memory(pmemory, memory_size);
 generate_task(ptasks);
 print_tasks(ptasks, tasks_qnt);

  printf("\n");
  return 0;
}
