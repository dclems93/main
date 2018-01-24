#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, int *argv[]){
  FILE * fPointer;
  fPointer = fopen("bacon.txt", "w");

  fprintf(fPointer, "I love cheese\n");

  fclose(fPointer);


  return 0;
}
