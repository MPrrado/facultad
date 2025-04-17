#include<stdio.h>

int main()
{
    FILE* ptr;
    ptr = fopen("e6.txt", "r");
    // char texto[201];
    // getchar();
    // while(fgets(texto,201, ptr))
    // {
    //     printf("%s", texto);
    //     getchar();
    // }
    char* line = NULL;
    size_t len = 0;
    ssize_t read;
    while((read = getline(&line, &len, ptr) != -1))
    {
        printf("%s", line);
    }
    fclose(ptr);
    // for (int i = 0; i < 1000; i++)
    // {
    //     printf("%c", texto[i]);
    // }
    
    return 0;
}

