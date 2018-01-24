#include <stdio.h>

void dump_memory(void *p, int len){
      int i;
      printf(" address   char  hexCh  short   integer     float      doubleFloat\n");
      for (i = 0; i < len; i++) {
        printf("%8p:", p + i);
	if((*(unsigned char *)(p + i) > 31) && (*(unsigned char *)(p + i) < 128)){
	  printf(" %c ", *(unsigned char *)(p + i));
	}
	else{
	  printf(" ? ");
	}
	printf(" %02x ", *(unsigned char *)(p + i));
	
	if(i%2 == 0){
	  printf("%hd ", *(unsigned short *)(p + i)); 
	}
	if(i%4==0){
	  printf("%d %+e ", *(unsigned int *)(p + i), *(float *)(p + i));
	}
	if(i%8==0){
	  printf("%+e ", *(double *)(p + i));
	}
	printf("\n");
	
      }
}
