#include <stdio.h>
#include <stdlib.h>

typedef struct node {
  int val;
  struct node * next;
} node_t;

void print_nodes(node_t * head){
  node_t * current = head;

  while(current != NULL){
    printf("%d\n", current->val);
    current = current->next;
  }
}

void push_node(node_t * head, int val){
  node_t * current = head;

  node_t * next = malloc(sizeof(node_t));
  next->val = val;
  next->next = NULL;

  while(current->next != NULL){
    current = current->next;
  }

  current->next = next;
}

int pop(node_t ** head) {
  *head = (*head)->next;
  /* printf("\n"); */
  /* current = head->next; */
  /* printf("%d", current->val); */
  /* printf("%d", current->next->val); */
  /* printf("\n"); */
  return 1;
}

int main(){
  node_t * head = malloc(sizeof(node_t));
  head->val = 1;
  head->next = NULL;

  push_node(head, 2);
  push_node(head, 3);
  push_node(head, 4);

  print_nodes(head);
  pop(head);
  printf("\n");
  print_nodes(head);
  return 0;
}
