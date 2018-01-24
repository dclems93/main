#include <stdio.h>

int main(void){
  int i;
  for(i=2;i<100;i++){
    int x;
    for(x=2; x<=i; x++){
      if(x==i){
	printf("%d \n", x);
	break;
      }
      if(i%x==0){
        break;
      }
    }
  }
  return (0);
}
