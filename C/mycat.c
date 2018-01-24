#include <stdio.h>
#include <string.h>

void mycat(int i);

char dest_buffer[100];
char str1[]="Hello";
char str2[]="World";

int main(void){
  mycat(7);                                                                 
  printf("mycat(7): %s\n",dest_buffer);
  return (0);
}

void  mycat(int i){
  char temp[100];
  strcpy(temp, strcat(str1,str2));
  int x;
  for(x = 0; x < i; x++){
    dest_buffer[x] = temp[x]; 
  }
}
