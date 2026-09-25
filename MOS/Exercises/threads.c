#include <pthread.h>
#include <err.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define NUMBER_OF_THREADS 8

void *print_hello_world(void *tid)
{
    if(*(int*)tid%2==0)
    {
        sleep(1);
    }
    printf("Hello World, Greetings from thread %d\n", *(int*)tid);
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];

    for(int i=0; i<NUMBER_OF_THREADS; i++)
    {
        printf("Main here. Creating thread %d\n", i);
        int *ptr_i = malloc(sizeof(int));
        *ptr_i = i;
        if (pthread_create(&threads[i], NULL, &print_hello_world, ptr_i) != 0)
            err(errno, "Failed creating thread");
        pthread_join(threads[i], NULL);
    }
    exit(0);
}
