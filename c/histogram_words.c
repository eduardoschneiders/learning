#include <stdio.h>

int main(){
  int i, c, count;
  char word[20];
  count = 0;

  while((c = getchar()) != EOF){
    if (c == ' ' || c == '\n'){
      printf("\nCount:  %d, Word: ", count);

      for (i = 0; i < count; i++)
        printf("%c", word[i]);

      printf("\n");

      for (i = 0; i < count; i++)
        printf("=");

      count = 0;

      if(c == '\n')
        printf("\n\n");
    } else {
      word[count] = c;
      ++count;
    }
  }
}
