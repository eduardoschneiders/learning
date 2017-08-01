#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
  int size;
  int duration;
  char character;
} task;

void print_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    printf("%c", pmemory[i]);
  }
}

void print_tasks(task * tasks[], int tasks_qnt){
  int i;
  for (i = 0; i < tasks_qnt; i++){
    if (tasks[i] != NULL){
      int j;
      for(j = 0; j < tasks[i]->size; j++){
        printf("%c", tasks[i]->character);
      }
    }
  }
}

void fill_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    pmemory[i] = '_';
  }
}

void generate_task(task *tasks[], int p){
  task * t = malloc(sizeof(task));
  t->size = rand() % 10 + 1 ;
  t->character = rand() % (126-33) + 33;

  tasks[p] = t;
}

void initialize_tasks(task * tasks[], int tasks_qnt){
  int i;
  for(i = 0; i < tasks_qnt; i++){
    *(tasks + i) = NULL;
  }
}

int main(){
  srand(time(NULL));
  int memory_size = 100;
  int tasks_qnt = 10;
  char memory[memory_size];
  task * tasks[tasks_qnt];
  char * pmemory;
  pmemory = memory;

  initialize_tasks(tasks, tasks_qnt);
  fill_memory(pmemory, memory_size);
  generate_task(tasks, 0);
  generate_task(tasks, 1);
  generate_task(tasks, 2);
  generate_task(tasks, 4);

  print_memory(pmemory, memory_size);
  print_tasks(tasks, tasks_qnt);

  printf("\n");
  return 0;
}
