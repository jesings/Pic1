#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
int main(){
   int fd = open("./image.ppm",O_WRONLY|O_CREAT,077);
   dprintf(fd, "P3 512 512 255\n");
   for(int i = 0; i<512;i++){
       for(int j = 0; j<512;j++){
           dprintf(fd,"%d ", abs(i-256));
           dprintf(fd,"%d ", abs(j-256));
           dprintf(fd,"%d ", (abs(i-256)+abs(j-256))/2);
       }
       dprintf(fd,"\n");
   }
   return 0;
}
