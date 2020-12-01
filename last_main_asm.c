#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int n_gram(char* str_1, int size_1, char* str_2, int size_2, int n);

int main()
{
    int numberOfArrays;
    char buffer[100] = {0};
    char buffer2[100] = {0};
    char* str_1;
    char* str_2;
    int lineCount = 1;
    int size_1 = 0,size_2 = 0;
    int i = 0, j = 0;
    int n;

    const char fileName[] = "input_tab.txt";
    FILE* file = fopen(fileName, "r");
    //  Check if file not null
    if (file == NULL)
    {
        printf("%s can not be found \n", fileName);
        return 1;
    }

    while (fscanf(file, "%d\t%s\t%s\n", &n, buffer, buffer2) != EOF)
    {
        j = 0;
        while (buffer[j] != 0)
        {
            j++;
        }
        size_1 = j;
        str_1 = malloc(size_1 * sizeof(char));
        strcpy(str_1, buffer);
        j = 0;
        while (buffer2[j] != 0)
        {
            j++;
        }
        size_2 = j;
        str_2 = malloc(size_2 * sizeof(char));
        strcpy(str_2, buffer2);
        printf("%d-) %s , %s , n = %d, ", lineCount, str_1, str_2, n);
        int result = n_gram(str_1,size_1,str_2,size_2,n);
        printf("Similarity = %d\n", result);
        lineCount++;
    }
    fclose(file);
    free(str_1);
    free(str_2);
    return 0;
}