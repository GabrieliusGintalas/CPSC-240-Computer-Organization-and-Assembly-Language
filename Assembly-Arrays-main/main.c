//main.c
#include <stdio.h>

extern double manage();

int main(){
    printf("Welcome to the Array Management System \n");
    printf("This product is maintained by Gabrielius Gintalas at gabrieliusgintalas@csu.fullerton.edu \n");
    double sum = manage();
    printf("The main function received %f and will keep it for a while. \n", sum);
    printf("Please consider buying more software from our suite of commercial program. \n");
    printf("A zero will be returned to the operating system. Bye \n");
    return 0;   
}