/*
 * tasks -> size, duration
 * processor -> 
 * scheduler -> get each task, check available space on memory; If show, add task to processor
 * memory -> size
 *
 * |----------|
 * new task size: 2
 * |**--------|
 *
 * new task size: 7
 *
 * |**=======-|
 *
 * new task size: 1
 * |**=======#|
 *
 */

#include <stdio.h>

int fill(char *arr[]){
  int i;
  for(i = 0; i < 10; i++){
    arr[i] = "_";
  }

  return 1;
}

/* char * task(){ */
/*   int i; */
  /* char *name[3]; */

/*   for(i = 0; i < 3; i++){ */
    /* name[i] = "="; */
  /* } */

/*   return name; */
/* } */

void change_age(int * age){
  (*age)++;
}

int main(){
  char *memory[10];
  int i;
  /* int a = 3; */
  /* int * p; */
  /* p = &a; */
  /* *p = 5; */
  /* printf("%d", *p); */

  int age = 0;
  change_age(&age);
  printf("%d", age);
  fill(memory);

  for(i = 0; i <= 10; i++){
    printf("%s", memory[i]);
  }

  printf("\n");
  return 0;
}
