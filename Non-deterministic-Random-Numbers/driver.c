#include <stdio.h>

extern char* execute();

int main(){
    printf("Welcome to the Array Management System \n");
    printf("This product is maintained by Gabrielius Gintalas at gabrieliusgintalas@csu.fullerton.edu \n");
    char* Name = execute();
    printf("Oh, %s.  We hope you enjoyed your arrays.  Do come again. \n", Name);
    printf("A zero will be returned to the operating system. \n");
    return 0;   
}
