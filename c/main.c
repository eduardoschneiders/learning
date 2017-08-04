#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>


typedef struct {
  int size;
  int duration;
  int location;
  int allocated;
  char character;
} task;

void print_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    printf("%c", pmemory[i]);
  }
}

int memory_empty(char memory[], int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    if (memory[i] != '_'){
      return 0;
      break;
    }
  }

  return 1;
}

void print_tasks(task * tasks[], int tasks_qnt){
  int i = 0;
  printf("\n\n");

  while(tasks[i] != NULL){
    printf("location: %d ", tasks[i]->location);
    printf("size: %d ", tasks[i]->size);
    printf("char: %c ", tasks[i]->character);
    printf("duration: %d ", tasks[i]->duration);
    printf("allocated: %d\n", tasks[i]->allocated);
    i++;
  }
}

void fill_memory(char * pmemory, int memory_size){
  int i;
  for (i = 0; i < memory_size; i++){
    pmemory[i] = '_';
  }
}

int unique_char(task * tasks[]){
  int character = rand() % (126-33) + 33;
  int i = 0;

  int available = 1;
  while(tasks[i] != NULL){
    if(character == tasks[i]->character){
      available = 0;
      break;
    }

    i++;
  }

  if (!available || character == 95){
    return unique_char(tasks);
  } else {
    return character;
  }
}

void generate_task(task * tasks[], int tasks_qnt, char character, int location, int size, int duration){
  task * t = malloc(sizeof(task));

  t->size = rand() % 100 + 15;
  t->duration = rand() % 10 + 25;
  t->character = unique_char(tasks);
  t->allocated = 0;

  if (size != 0)
    t->size = size;

  if (duration != 0)
    t->duration = duration;

  if (character != '0')
    t->character = character;

  if (location != 0) {
    t->location = location;
    t->allocated = 1;
  }

  int i = 0;
  while(tasks[i] != NULL){
    i++;
  }

  if (i < tasks_qnt - 1){
    tasks[i] = t;
  }
}

void initialize_tasks(task * tasks[], int tasks_qnt){
  int i;
  for(i = 0; i < tasks_qnt; i++){
    tasks[i] = NULL;
  }
}

int find_memory_location(int initial_position, int size, char memory[], int memory_size){
  int current_position = initial_position;
  while(memory[current_position] != '_' && current_position < memory_size){
    current_position++;
  }

  int is_memory_available = 1;
  int offset_position = current_position;

  for (offset_position = current_position; offset_position < current_position + size; offset_position++){
    if (offset_position >= (memory_size - 1) || memory[offset_position] != '_'){
      is_memory_available = 0;
      break;
    }
  }

  if (is_memory_available != 0){
    return current_position;
  } else {
    if (offset_position >= (memory_size - 1)){
      return -1;
    } else {
      return find_memory_location(offset_position, size, memory, memory_size);
    }
  }
}

void add_task_to_memory(char memory[], task *task){
  int i = 0;
  for (i = task->location; i < task->location + task->size; i++){
    memory[i] = task->character;
  }
}

void remove_task_from_memory(char memory[], int location, int size){
  int i = 0;
  for (i = location; i < location + size; i++){
    memory[i] = '_';
  }
}

void remove_offset_on_tasks(int current, task * tasks[]){
  while(tasks[current + 1] != NULL){
    tasks[current] = tasks[current + 1];
    current++;
  }

  tasks[current] = NULL;
}

void try_to_allocate_task(task * task, char memory[], int memory_size){
  int location = find_memory_location(0, task->size, memory, memory_size);
  if (location != -1){
    task->location = location;
    task->allocated = 1;
  }
}

void allocate_tasks(task * tasks[], char memory[], int memory_size, int tasks_qnt){
  int i = 0;
  while (tasks[i] != NULL){
    if (tasks[i]->allocated == 0){
     try_to_allocate_task(tasks[i], memory, memory_size);
    } else {
      tasks[i]->duration--;
    }

    if (tasks[i]->duration == 0){
      remove_task_from_memory(memory, tasks[i]->location, tasks[i]->size);
      remove_offset_on_tasks(i, tasks);
    }


    if (tasks[i] != NULL && tasks[i]->allocated){
      add_task_to_memory(memory, tasks[i]);
    }

    i++;
  }
}

int main(){
  srand(time(NULL));
  int total_tasks = 0;
  int keep_running = 1;
  int memory_size = 636;
  int tasks_qnt = 15;
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

  while (keep_running && 1){
    system("clear");

    if (total_tasks < 20)
      generate_task(tasks, tasks_qnt, '0', 0, 0, 0);

    allocate_tasks(tasks, memory, memory_size, tasks_qnt);
    print_memory(memory, memory_size);
    print_tasks(tasks, tasks_qnt);

    sleep(1);
    total_tasks++;
    keep_running = !memory_empty(memory, memory_size);
  }

  printf("\n");
  return 0;
}
