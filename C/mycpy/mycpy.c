#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
  
  FILE *ifp, *ofp;


  if(argc != 3){
    printf("Error: Wrong number of arguments.");
  }
  else{

    ifp = fopen(argv[1], "r");

    if (ifp == NULL) {
      fprintf(stderr, "Can't open input file in.list!\n");
      exit(1);
    }

    ofp = fopen(argv[2], "w");

    if (ofp == NULL) {
      fprintf(stderr, "Can't open output file");
      exit(1);
    }
    
    int cur_byte;
    while((cur_byte = fgetc(ifp)) != EOF){
      fputc(cur_byte, ofp);
      
    }
    
    fclose(ifp);
    fclose(ofp);



  }

    return 0;
  }

