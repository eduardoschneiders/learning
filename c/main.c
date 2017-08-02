#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
  int size;
  int duration;
  int location;
  char character;
} task;

void print_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    printf("%c", pmemory[i]);
  }
}

void print_tasks(task * tasks[], int tasks_qnt){
  int i = 0;
  printf("\n");
  while(tasks[i] != NULL){
    int j;
    for(j = 0; j < tasks[i]->size; j++){
      printf("%c", tasks[i]->character);
    }
    i++;
  }

  i = 0;
  printf("\n");
  while(tasks[i] != NULL){
    printf("location: %d ", tasks[i]->location);
    printf("size: %d ", tasks[i]->size);
    printf("char: %c\n", tasks[i]->character);
    i++;
  }
}

void fill_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    pmemory[i] = '_';
  }
}

void generate_task(task * tasks[]){
  task * t = malloc(sizeof(task));
  t->size = rand() % 10 + 1 ;
  t->character = rand() % (126-33) + 33;

  int i = 0;
  while(tasks[i] != NULL){
    i++;
  }

  tasks[i] = t;
}

void initialize_tasks(task * tasks[], int tasks_qnt){
  int i;
  for(i = 0; i < tasks_qnt; i++){
    tasks[i] = NULL;
  }
}

void locate_tasks(task * tasks[]){
  int i = 1;
  int location = 0;

  task * previous_task = NULL;
  if (tasks[0] != NULL){
    tasks[0]->location = 0;
    previous_task = tasks[0];
  }

  while (tasks[i] != NULL){
    if (previous_task != NULL){
      tasks[i]->location = previous_task->location + previous_task->size;
    }
    previous_task = tasks[i];
    i++;
  }
}


void add_tasks_to_memory(char memory[], task * tasks[]){
  printf("\n\n\n");
  int i = 0;
  while(tasks[i] != NULL){
    int j;
    for(j = tasks[i]->location; j < tasks[i]->size; j++){
      printf("%d -> %c\n", j, tasks[i]->character);
      memory[j] = tasks[i]->character;
    }
    i++;
  }
  printf("\n\n\n");
}

int main(){
  srand(time(NULL));
  int memory_size = 100;
  int tasks_qnt = 10;
  char memory[memory_size];
  task * tasks[tasks_qnt];

  /* tasks = [ */
  /*   {size: 1, duration: 2, c: '*', location: 0}, */
  /*   {size: 2, duration: 2, c: '&', location: 1} */
  /*   {size: 4, duration: 2, c: '$', location: 5} */
  /* ] */


  /* memory = ['__________'] */
  /* memory = ['*_________'] */
  /* memory = ['*&&__$$$$_'] */

  /* memory[] */

  initialize_tasks(tasks, tasks_qnt);
  fill_memory(memory, memory_size);
  generate_task(tasks);
  generate_task(tasks);
  generate_task(tasks);
  generate_task(tasks);
  generate_task(tasks);
  generate_task(tasks);

  locate_tasks(tasks);
  add_tasks_to_memory(memory, tasks);
  print_memory(memory, memory_size);
  print_tasks(tasks, tasks_qnt);

  printf("\n");
  return 0;
}
